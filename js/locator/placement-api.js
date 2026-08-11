/**
 * Main-thread facade for Locator recommended placement Calculate.
 * Prefers a Web Worker; falls back to sync full-flow on the main thread.
 *
 * global.LocatorPlacement.calculateRecommendedPlacement(opts) → Promise
 * opts: { vessel, fillPoints, emptyPoints, numScanners, maxScanners, onProgress, signal }
 */
(function (global) {
  "use strict";
  var NS = (global.LocatorPlacement = global.LocatorPlacement || {});
  var nextId = 1;
  var worker = null;
  var workerFailed = false;

  function workerUrl() {
    try {
      var scripts = document.getElementsByTagName("script");
      var i;
      for (i = scripts.length - 1; i >= 0; i--) {
        var src = scripts[i].src || "";
        if (/placement-api\.js/i.test(src)) {
          return src.replace(/placement-api\.js.*/i, "placement-worker.js");
        }
        if (/locator\//i.test(src)) {
          return src.replace(/[^/]+$/, "placement-worker.js");
        }
      }
    } catch (e) {
      /* ignore */
    }
    return "js/locator/placement-worker.js";
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

  function runSync(opts) {
    if (!NS.runPlacementFullFlow) {
      return Promise.reject(new Error("Locator placement not loaded"));
    }
    var cancelled = false;
    if (opts.signal) {
      if (opts.signal.aborted) cancelled = true;
      else {
        opts.signal.addEventListener("abort", function () {
          cancelled = true;
        });
      }
    }
    return new Promise(function (resolve, reject) {
      try {
        var result = NS.runPlacementFullFlow({
          vessel: opts.vessel,
          fillPoints: opts.fillPoints,
          emptyPoints: opts.emptyPoints,
          numScanners: opts.numScanners || 1,
          maxScanners: opts.maxScanners != null ? opts.maxScanners : 3,
          allSteps: opts.allSteps !== false,
          shouldCancel: function () {
            return cancelled;
          },
          onProgress: opts.onProgress,
        });
        if (cancelled) {
          reject(Object.assign(new Error("cancelled"), { cancelled: true }));
          return;
        }
        resolve(result);
      } catch (err) {
        reject(err);
      }
    });
  }

  function runWorker(opts) {
    var w = getWorker();
    if (!w) return runSync(opts);
    var id = nextId++;
    return new Promise(function (resolve, reject) {
      function cleanup() {
        w.removeEventListener("message", onMsg);
        if (opts.signal) opts.signal.removeEventListener("abort", onAbort);
      }
      function onAbort() {
        try {
          w.postMessage({ type: "cancel", id: id });
        } catch (e) {
          /* ignore */
        }
        cleanup();
        reject(Object.assign(new Error("cancelled"), { cancelled: true }));
      }
      function onMsg(ev) {
        var msg = ev.data || {};
        if (msg.id !== id) return;
        if (msg.type === "progress") {
          if (opts.onProgress) {
            opts.onProgress({
              stage: msg.stage,
              current: msg.current,
              total: msg.total,
              maxError: msg.maxError,
            });
          }
          return;
        }
        cleanup();
        if (msg.type === "done") {
          resolve({
            scanners: msg.scanners,
            maxError: msg.maxError,
            numScanners: msg.numScanners,
            stages: msg.stages,
          });
          return;
        }
        if (msg.type === "cancelled") {
          reject(Object.assign(new Error("cancelled"), { cancelled: true }));
          return;
        }
        reject(new Error(msg.message || "Placement failed"));
      }
      w.addEventListener("message", onMsg);
      if (opts.signal) {
        if (opts.signal.aborted) {
          onAbort();
          return;
        }
        opts.signal.addEventListener("abort", onAbort);
      }
      w.postMessage({
        id: id,
        type: "calculate",
        vessel: opts.vessel,
        fillPoints: opts.fillPoints || [],
        emptyPoints: opts.emptyPoints || [],
        numScanners: opts.numScanners || 1,
        maxScanners: opts.maxScanners != null ? opts.maxScanners : 3,
        allSteps: opts.allSteps !== false,
      });
    });
  }

  /**
   * @returns {Promise<{scanners:[{x,y,z}], maxError:number, numScanners:number}>}
   */
  function calculateRecommendedPlacement(opts) {
    opts = opts || {};
    return runWorker(opts).catch(function (err) {
      if (err && err.cancelled) throw err;
      // Worker failed to start or crashed — try sync once.
      if (!workerFailed) {
        workerFailed = true;
        return runSync(opts);
      }
      throw err;
    });
  }

  NS.calculateRecommendedPlacement = calculateRecommendedPlacement;
  NS._placementWorkerUrl = workerUrl;
})(typeof self !== "undefined" ? self : window);
