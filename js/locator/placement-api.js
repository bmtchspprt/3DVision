/**
 * Main-thread facade for Locator recommended placement Calculate.
 * Prefers a Web Worker so the progress bar can paint; falls back to deferred sync.
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

  var WORKER_SCRIPTS = [
    "constants.js",
    "defs.js",
    "balls.js",
    "matrix.js",
    "algo-error-estimation.js",
    "geometry.js",
    "fuzzy.js",
    "fuzzy-tables.js",
    "search-radius.js",
    "error-estimation-calc.js",
    "error-estimation.js",
    "vessel-adapter.js",
    "exhaustive-search.js",
    "placement-full-flow.js",
  ];

  function scriptBaseUrl() {
    try {
      var scripts = document.getElementsByTagName("script");
      var i;
      for (i = scripts.length - 1; i >= 0; i--) {
        var src = scripts[i].src || "";
        if (/placement-api\.js/i.test(src)) {
          return src.replace(/placement-api\.js.*/i, "");
        }
        if (/locator\//i.test(src)) {
          return src.replace(/[^/]+$/, "");
        }
      }
    } catch (e) {
      /* ignore */
    }
    try {
      return new URL("js/locator/", document.baseURI || location.href).href;
    } catch (e2) {
      return "js/locator/";
    }
  }

  function workerUrl() {
    return scriptBaseUrl() + "placement-worker.js";
  }

  /** Blob worker with absolute importScripts — avoids blob-relative path breakage. */
  function buildWorkerSource(base) {
    var lines = [];
    var i;
    for (i = 0; i < WORKER_SCRIPTS.length; i++) {
      lines.push("importScripts(" + JSON.stringify(base + WORKER_SCRIPTS[i]) + ");");
    }
    lines.push(
      [
        "var cancelFlag=false;",
        "self.onmessage=function(ev){",
        "var msg=ev.data||{};",
        "if(msg.type==='cancel'){cancelFlag=true;return;}",
        "if(msg.type!=='calculate')return;",
        "cancelFlag=false;",
        "var id=msg.id;",
        "try{",
        "var NS=self.LocatorPlacement;",
        "if(!NS||!NS.runPlacementFullFlow)throw new Error('Locator placement modules not loaded');",
        "var result=NS.runPlacementFullFlow({",
        "vessel:msg.vessel,",
        "fillPoints:msg.fillPoints||[],",
        "emptyPoints:msg.emptyPoints||[],",
        "numScanners:msg.numScanners||1,",
        "maxScanners:msg.maxScanners!=null?msg.maxScanners:3,",
        "allSteps:msg.allSteps!==false,",
        "shouldCancel:function(){return cancelFlag;},",
        "onProgress:function(p){",
        "self.postMessage({id:id,type:'progress',stage:p.stage,maxStages:p.maxStages,",
        "current:p.current,total:p.total,maxError:p.maxError,overall:p.overall});",
        "}",
        "});",
        "if(cancelFlag){self.postMessage({id:id,type:'cancelled'});return;}",
        "self.postMessage({id:id,type:'done',scanners:result.scanners,maxError:result.maxError,",
        "numScanners:result.numScanners,stages:result.stages});",
        "}catch(err){",
        "self.postMessage({id:id,type:'error',message:(err&&err.message)||String(err)});",
        "}",
        "};",
      ].join("")
    );
    return lines.join("\n");
  }

  function getWorker() {
    if (workerFailed) return null;
    if (worker) return worker;
    if (typeof Worker === "undefined") {
      workerFailed = true;
      return null;
    }
    var base = scriptBaseUrl();
    try {
      var blob = new Blob([buildWorkerSource(base)], { type: "application/javascript" });
      var blobUrl = URL.createObjectURL(blob);
      worker = new Worker(blobUrl);
      worker.__igBlobUrl = blobUrl;
      worker.onerror = function () {
        workerFailed = true;
        try {
          worker.terminate();
        } catch (e) {
          /* ignore */
        }
        if (worker && worker.__igBlobUrl) {
          try {
            URL.revokeObjectURL(worker.__igBlobUrl);
          } catch (e2) {
            /* ignore */
          }
        }
        worker = null;
      };
      return worker;
    } catch (e) {
      // Fall back to classic worker file (same-origin http/https).
      try {
        worker = new Worker(workerUrl());
        worker.onerror = function () {
          workerFailed = true;
          try {
            worker.terminate();
          } catch (e2) {
            /* ignore */
          }
          worker = null;
        };
        return worker;
      } catch (e3) {
        workerFailed = true;
        return null;
      }
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
    // Defer so the overlay can paint once before a blocking search.
    return new Promise(function (resolve, reject) {
      setTimeout(function () {
        try {
          var lastUi = 0;
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
            onProgress: function (p) {
              if (!opts.onProgress) return;
              var now = Date.now();
              if (now - lastUi < 80 && !(p && p.overall >= 0.99)) return;
              lastUi = now;
              opts.onProgress(p);
            },
          });
          if (cancelled) {
            reject(Object.assign(new Error("cancelled"), { cancelled: true }));
            return;
          }
          resolve(result);
        } catch (err) {
          reject(err);
        }
      }, 40);
    });
  }

  function runWorker(opts) {
    var w = getWorker();
    if (!w) return runSync(opts);
    var id = nextId++;
    return new Promise(function (resolve, reject) {
      var settled = false;
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
          maxScanners: opts.maxScanners != null ? opts.maxScanners : 3,
          allSteps: opts.allSteps !== false,
        });
      } catch (err) {
        workerFailed = true;
        cleanup();
        runSync(opts).then(resolve, reject);
      }
    });
  }

  /**
   * @returns {Promise<{scanners:[{x,y,z}], maxError:number, numScanners:number}>}
   */
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
      return runSync(opts);
    });
  }

  NS.calculateRecommendedPlacement = calculateRecommendedPlacement;
  NS._placementWorkerUrl = workerUrl;
  NS._placementScriptBase = scriptBaseUrl;
})(typeof self !== "undefined" ? self : window);
