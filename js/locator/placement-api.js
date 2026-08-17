/**
 * Main-thread facade for Locator recommended placement Calculate.
 * Always uses a Web Worker so the UI can paint a real progress bar.
 * Never runs exhaustive search on the main thread (that freezes the page).
 *
 * global.LocatorPlacement.calculateRecommendedPlacement(opts) → Promise
 */
(function (global) {
  "use strict";
  var NS = (global.LocatorPlacement = global.LocatorPlacement || {});
  var nextId = 1;
  var worker = null;
  var workerFailed = false;

  function scriptBaseUrl() {
    var loc = global.location;
    var origin = (loc && loc.href) || "";
    try {
      return new URL("js/locator/", origin).href;
    } catch (e) {
      return "js/locator/";
    }
  }

  function workerUrl() {
    return scriptBaseUrl() + "placement-worker.js";
  }

  function geometricFallback(opts) {
    var vessel = opts.vessel || {};
    var n = opts.numScanners || 1;
    var diam =
      vessel.centerD ||
      vessel.CenterShapeDiameterMeter ||
      vessel.CenterShapeDiameter ||
      9;
    var zAt = function (x, y) {
      if (NS.autoCalculateZFromVesselBottom) {
        try {
          var v = vessel.CenterShapeType ? vessel : NS.createVessel(vessel);
          return NS.autoCalculateZFromVesselBottom(v, x, y);
        } catch (e) {
          return 0;
        }
      }
      return 0;
    };
    var scanners = NS.geometricRecommendedScanners
      ? NS.geometricRecommendedScanners(n, diam, zAt)
      : [{ x: diam / 3, y: 0, z: zAt(diam / 3, 0) }];
    if (opts.onProgress) {
      opts.onProgress({
        stage: n,
        maxStages: n,
        current: 1,
        total: 1,
        overall: 1,
      });
    }
    return {
      scanners: scanners,
      maxError: NaN,
      numScanners: scanners.length,
      stages: [],
      fallback: true,
    };
  }

  function getWorker() {
    if (workerFailed) return null;
    if (worker) return worker;
    if (typeof Worker === "undefined") {
      workerFailed = true;
      return null;
    }
    try {
      worker = new Worker(workerUrl());
      worker.onerror = function () {
        workerFailed = true;
        try {
          worker.terminate();
        } catch (e) {
          /* ignore */
        }
        worker = null;
      };
      return worker;
    } catch (e) {
      workerFailed = true;
      return null;
    }
  }

  function runWorker(opts) {
    var w = getWorker();
    if (!w) {
      return Promise.resolve(geometricFallback(opts));
    }
    var id = nextId++;
    return new Promise(function (resolve, reject) {
      var settled = false;
      var lastUi = 0;
      function cleanup() {
        w.removeEventListener("message", onMsg);
        if (opts.signal) opts.signal.removeEventListener("abort", onAbort);
      }
      function finish(fn, arg) {
        if (settled) return;
        settled = true;
        cleanup();
        fn(arg);
      }
      function onAbort() {
        try {
          w.postMessage({ type: "cancel", id: id });
        } catch (e) {
          /* ignore */
        }
        finish(reject, Object.assign(new Error("cancelled"), { cancelled: true }));
      }
      function onMsg(ev) {
        var msg = ev.data || {};
        if (msg.id !== id) return;
        if (msg.type === "progress") {
          if (opts.onProgress) {
            var now = Date.now();
            if (now - lastUi < 80 && msg.overall < 0.99) return;
            lastUi = now;
            opts.onProgress({
              stage: msg.stage,
              maxStages: msg.maxStages,
              current: msg.current,
              total: msg.total,
              maxError: msg.maxError,
              overall: msg.overall,
            });
          }
          return;
        }
        if (msg.type === "done") {
          finish(resolve, {
            scanners: msg.scanners,
            maxError: msg.maxError,
            numScanners: msg.numScanners,
            stages: msg.stages,
          });
          return;
        }
        if (msg.type === "cancelled") {
          finish(reject, Object.assign(new Error("cancelled"), { cancelled: true }));
          return;
        }
        finish(reject, new Error(msg.message || "Placement failed"));
      }
      w.addEventListener("message", onMsg);
      if (opts.signal) {
        if (opts.signal.aborted) {
          onAbort();
          return;
        }
        opts.signal.addEventListener("abort", onAbort);
      }
      try {
        w.postMessage({
          id: id,
          type: "calculate",
          vessel: opts.vessel,
          fillPoints: opts.fillPoints || [],
          emptyPoints: opts.emptyPoints || [],
          numScanners: opts.numScanners || 1,
          maxScanners: opts.maxScanners != null ? opts.maxScanners : opts.numScanners || 1,
          allSteps: opts.allSteps !== false,
        });
      } catch (err) {
        workerFailed = true;
        cleanup();
        resolve(geometricFallback(opts));
      }
    });
  }

  function calculateRecommendedPlacement(opts) {
    opts = opts || {};
    return runWorker(opts).catch(function (err) {
      if (err && err.cancelled) throw err;
      workerFailed = true;
      try {
        if (worker) worker.terminate();
      } catch (e) {
        /* ignore */
      }
      worker = null;
      return geometricFallback(opts);
    });
  }

  NS.calculateRecommendedPlacement = calculateRecommendedPlacement;
  NS._placementWorkerUrl = workerUrl;
  NS._placementScriptBase = scriptBaseUrl;
})(typeof self !== "undefined" ? self : window);
