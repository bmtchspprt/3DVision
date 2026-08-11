/**
 * Locator placement worker — importScripts all modules, run full Calculate flow.
 * Message in:  { id, type:"calculate", vessel, fillPoints, maxScanners?, numScanners? }
 * Message out: { id, type:"progress"|"done"|"error"|"cancelled", ... }
 */
/* eslint-disable no-undef */
(function () {
  "use strict";

  var scripts = [
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

  var base = self.location.href.replace(/[^/]+$/, "");
  var i;
  for (i = 0; i < scripts.length; i++) {
    importScripts(base + scripts[i]);
  }

  var cancelFlag = false;

  self.onmessage = function (ev) {
    var msg = ev.data || {};
    if (msg.type === "cancel") {
      cancelFlag = true;
      return;
    }
    if (msg.type !== "calculate") return;
    cancelFlag = false;
    var id = msg.id;
    try {
      var NS = self.LocatorPlacement;
      if (!NS || !NS.runPlacementFullFlow) {
        throw new Error("Locator placement modules not loaded");
      }
      var result = NS.runPlacementFullFlow({
        vessel: msg.vessel,
        fillPoints: msg.fillPoints || [],
        emptyPoints: msg.emptyPoints || [],
        numScanners: msg.numScanners || 1,
        maxScanners: msg.maxScanners != null ? msg.maxScanners : 3,
        allSteps: msg.allSteps !== false,
        shouldCancel: function () {
          return cancelFlag;
        },
        onProgress: function (p) {
          self.postMessage({
            id: id,
            type: "progress",
            stage: p.stage,
            maxStages: p.maxStages,
            current: p.current,
            total: p.total,
            maxError: p.maxError,
            overall: p.overall,
          });
        },
      });
      if (cancelFlag) {
        self.postMessage({ id: id, type: "cancelled" });
        return;
      }
      self.postMessage({
        id: id,
        type: "done",
        scanners: result.scanners,
        maxError: result.maxError,
        numScanners: result.numScanners,
        stages: result.stages,
      });
    } catch (err) {
      self.postMessage({
        id: id,
        type: "error",
        message: (err && err.message) || String(err),
      });
    }
  };
})();
