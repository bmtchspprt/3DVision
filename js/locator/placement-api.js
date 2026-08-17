/**
 * Locator recommended placement — Web Worker only.
 * Runs Fuzzy tables + error estimation + exhaustive search off the UI thread.
 * Never guesses positions. Never runs the search on the main thread.
 */
(function (global) {
  "use strict";
  var NS = (global.LocatorPlacement = global.LocatorPlacement || {});
  var nextId = 1;
  var worker = null;
  var workerReady = false;
  var readyWaiters = [];
  var jobs = {};

  function scriptBaseUrl() {
    try {
      return new URL("js/locator/", global.location.href).href;
    } catch (e) {
      return "js/locator/";
    }
  }

  function workerUrl() {
    return scriptBaseUrl() + "placement-worker.js";
  }

  function failJob(id, err) {
    var job = jobs[id];
    if (!job) return;
    delete jobs[id];
    job.reject(err);
  }

  function bindWorker(w) {
    w.onmessage = function (ev) {
      var msg = ev.data || {};
      if (msg.type === "ready") {
        workerReady = true;
        var wait = readyWaiters;
        readyWaiters = [];
        var i;
        for (i = 0; i < wait.length; i++) wait[i](null, w);
        return;
      }
      var job = jobs[msg.id];
      if (!job) return;
      if (msg.type === "progress") {
        if (job.onProgress) job.onProgress(msg);
        return;
      }
      delete jobs[msg.id];
      if (msg.type === "done") {
        job.resolve({
          scanners: msg.scanners,
          maxError: msg.maxError,
          numScanners: msg.numScanners,
          stages: msg.stages,
        });
        return;
      }
      if (msg.type === "cancelled") {
        job.reject(Object.assign(new Error("cancelled"), { cancelled: true }));
        return;
      }
      job.reject(new Error(msg.message || "Placement failed"));
    };
    w.onerror = function (ev) {
      workerReady = false;
      try {
        w.terminate();
      } catch (e) {
        /* ignore */
      }
      if (worker === w) worker = null;
      var err = new Error((ev && ev.message) || "Placement worker failed");
      var wait = readyWaiters;
      readyWaiters = [];
      var i;
      for (i = 0; i < wait.length; i++) wait[i](err);
      var id;
      for (id in jobs) {
        if (Object.prototype.hasOwnProperty.call(jobs, id)) failJob(id, err);
      }
    };
  }

  function getWorker() {
    return new Promise(function (resolve, reject) {
      if (worker && workerReady) {
        resolve(worker);
        return;
      }
      if (typeof Worker === "undefined") {
        reject(new Error("Web Workers are required for Locator placement"));
        return;
      }
      var timer = setTimeout(function () {
        reject(new Error("Placement worker did not start"));
      }, 8000);
      readyWaiters.push(function (err, w) {
        clearTimeout(timer);
        if (err) reject(err);
        else resolve(w);
      });
      if (worker && !workerReady) return;
      try {
        worker = new Worker(workerUrl());
        workerReady = false;
        bindWorker(worker);
      } catch (e) {
        worker = null;
        var wait = readyWaiters;
        readyWaiters = [];
        var i;
        for (i = 0; i < wait.length; i++) wait[i](e);
      }
    });
  }

  function runWorker(opts) {
    return getWorker().then(function (w) {
      var id = nextId++;
      return new Promise(function (resolve, reject) {
        jobs[id] = {
          resolve: resolve,
          reject: reject,
          onProgress: opts.onProgress || null,
        };
        function onAbort() {
          try {
            w.postMessage({ type: "cancel", id: id });
          } catch (e) {
            /* ignore */
          }
          failJob(id, Object.assign(new Error("cancelled"), { cancelled: true }));
        }
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
          maxScanners: opts.maxScanners != null ? opts.maxScanners : opts.numScanners || 1,
          allSteps: opts.allSteps !== false,
        });
      });
    });
  }

  function calculateRecommendedPlacement(opts) {
    opts = opts || {};
    return runWorker(opts);
  }

  NS.calculateRecommendedPlacement = calculateRecommendedPlacement;
  NS._placementWorkerUrl = workerUrl;
  NS._placementScriptBase = scriptBaseUrl;
})(typeof self !== "undefined" ? self : window);
