/* LocatorPlacement.placementFullFlow
 * Auto-escalate scanner count: N=1 → if maxError>3.5 try N=2 → if >4.5 try N=3.
 */
(function (global) {
  "use strict";
  var NS = global.LocatorPlacement = global.LocatorPlacement || {};

  /**
   * @param {object} opts - same as runExhaustiveSearch, plus optional maxErrorStage1/2
   * @returns {{ scanners:[{x,y,z}], maxError:number, numScanners:number, stages:array }}
   */
  function runPlacementFullFlow(opts) {
    opts = opts || {};
    var D = NS.DEFAULTS || {};
    var C = (global.LocatorAlgo && global.LocatorAlgo.Constants) || {};
    var stage1 = opts.maxErrorStage1 != null ? opts.maxErrorStage1 : (D.maxErrorStage1 || C.maxErrorStage1 || 3.5);
    var stage2 = opts.maxErrorStage2 != null ? opts.maxErrorStage2 : (D.maxErrorStage2 || C.maxErrorStage2 || 4.5);
    var maxN = opts.maxScanners != null ? opts.maxScanners : 3;
    var startN = opts.numScanners != null ? opts.numScanners : 1;
    var stages = [];
    var best = null;
    var n;

    for (n = startN; n <= maxN; n++) {
      if (opts.shouldCancel && opts.shouldCancel()) break;
      var runOpts = {};
      var k;
      for (k in opts) {
        if (Object.prototype.hasOwnProperty.call(opts, k)) runOpts[k] = opts[k];
      }
      runOpts.numScanners = n;
      if (opts.onProgress) {
        runOpts.onProgress = function (p) {
          opts.onProgress({ stage: n, current: p.current, total: p.total, maxError: p.maxError });
        };
      }
      var result = NS.runExhaustiveSearch(runOpts);
      stages.push({ numScanners: n, maxError: result.maxError, scanners: result.scanners });
      best = {
        scanners: result.scanners,
        maxError: result.maxError,
        numScanners: n,
        numCalc: result.numCalc,
        stages: stages
      };
      if (n === 1 && result.maxError > stage1 && maxN >= 2) continue;
      if (n === 2 && result.maxError > stage2 && maxN >= 3) continue;
      break;
    }
    return best || { scanners: [], maxError: NaN, numScanners: 0, stages: stages };
  }

  NS.runPlacementFullFlow = runPlacementFullFlow;
})(typeof self !== "undefined" ? self : (typeof globalThis !== "undefined" ? globalThis : this));
