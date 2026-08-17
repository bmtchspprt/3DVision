/**
 * Echo Curve Grade/Threshold from recording shape + proven pick/AFE/axis.
 * Real Grade is a range-gated filled envelope (meters of energy, then hard zero),
 * not a one-bin spike. Shape taken from a known-good .bm4; pick/AFE/dh stay firmware.
 */
(function (global) {
  "use strict";

  function rng(seed) {
    var s = (seed >>> 0) || 1;
    return function () {
      s = (s * 1664525 + 1013904223) >>> 0;
      return s / 4294967296;
    };
  }

  function simGrade(opts) {
    var math = global.FwEchoMath;
    var n = math.GRADE_N;
    var dh = math.GRADE_DH_M;
    var rand = rng(opts.seed || 1);
    var dist = Math.max(0.4, opts.distanceM || 4);
    var height = Math.max(dist + 1, opts.heightM || 16);
    var gateM = height;
    var amp = new Array(n);
    var i;
    for (i = 0; i < n; i++) {
      var h = i * dh;
      var g = 0;
      if (h <= gateM) {
        var near = 0.32 * Math.exp(-h / 0.45);
        var floor = 0.018 + 0.012 * Math.exp(-h / 8);
        var u = (h - dist) / Math.max(0.55, dist * 0.28);
        var main = Math.exp(-(u * u));
        var u2 = (h - (dist + 0.9)) / 0.7;
        var shelf = 0.55 * Math.exp(-(u2 * u2));
        var tail = 0.22 * Math.exp(-Math.max(0, h - dist) / (gateM * 0.35));
        g = near + floor + 0.92 * main + shelf + tail;
        g *= 0.88 + 0.24 * rand();
      }
      amp[i] = g;
    }
    var peak = 0;
    for (i = 0; i < n; i++) if (amp[i] > peak) peak = amp[i];
    if (peak < 1e-12) peak = 1;
    for (i = 0; i < n; i++) amp[i] /= peak;
    return amp;
  }

  function simThreshold(gradeAmp) {
    var math = global.FwEchoMath;
    var tn = math.THRESH_N;
    var T = new Array(tn);
    var t;
    var w;
    for (t = 0; t < tn; t++) {
      var i0 = t << 2;
      var h = i0 * math.GRADE_DH_M;
      var near = 0.95 * Math.exp(-h / 0.7);
      var sm = 0;
      var c = 0;
      for (w = i0 - 12; w <= i0 + 12; w++) {
        if (w < 0 || w >= gradeAmp.length) continue;
        sm += gradeAmp[w];
        c++;
      }
      var follow = c ? (sm / c) * 0.55 : 0;
      var v = near + follow + 0.04;
      if (v > 1) v = 1;
      T[t] = v;
    }
    return T;
  }

  function simulateBeamSeries(opts) {
    var math = global.FwEchoMath;
    var gradeAmp = simGrade(opts);
    var afeAmp = math.buildAfeFromGrade(gradeAmp);
    if (opts.useAfe === false) afeAmp = math.resetAfeMap();
    var threshAmp = simThreshold(gradeAmp);
    var falseAmp = math.resetUserMap();
    if (opts.useUser && opts.falseFrom != null && opts.falseTo != null) {
      falseAmp = math.applyManualScan(
        falseAmp,
        opts.falseFrom,
        opts.falseTo,
        opts.falseThreshold || 0.2,
        0
      );
    }
    var pick = math.pickReported(gradeAmp, threshAmp, { offsetM: 0 });
    return {
      gradeAmp: gradeAmp,
      threshAmp: threshAmp,
      afeAmp: afeAmp,
      falseAmp: falseAmp,
      pick: pick,
    };
  }

  global.FwEchoSim = {
    simulateBeamSeries: simulateBeamSeries,
  };
})(typeof window !== "undefined" ? window : globalThis);
