/**
 * Echo Curve series for the guide chart.
 * Pick / AFE / dh stay in FwEchoMath. Sample Y matches BeamDataParser:
 *   amp = ArrayToFract(int16) * gain
 * Envelope follows recorded BM4 shape (filled lobe, then hard zeros) — not DSP.
 */
(function (global) {
  "use strict";

  // Typical BM4 IEEE754 gains (display only; parser multiplies these).
  var GAIN_GRADE = 9480.1376953125;
  var GAIN_THRESH = 10185.1533203125;
  var GAIN_AFE = 40;
  var GAIN_FALSE = 1;

  function rng(seed) {
    var s = (seed >>> 0) || 1;
    return function () {
      s = (s * 1664525 + 1013904223) >>> 0;
      return s / 4294967296;
    };
  }

  function speckle(rand) {
    var u = rand();
    if (u < 1e-6) u = 1e-6;
    var v = Math.sqrt(-2 * Math.log(u));
    if (v > 2.4) v = 2.4;
    return v;
  }

  function simGrade(opts) {
    var math = global.FwEchoMath;
    var n = math.GRADE_N;
    var dh = math.GRADE_DH_M;
    var rand = rng(opts.seed || 1);
    var dist = Math.max(0.4, opts.distanceM || 4);
    var height = Math.max(dist + 1, opts.heightM || 16);
    var lobeEnd = Math.min(height, dist + 2.4);
    var lobeStart = Math.max(0.35, dist - 1.15);
    var amp = new Array(n);
    var i;
    for (i = 0; i < n; i++) {
      var h = i * dh;
      var g = 0;
      if (h >= 0.08 && h <= lobeEnd) {
        var sp = speckle(rand);
        var near = h < 1.35 ? 0.28 * Math.exp(-h / 0.32) * sp : 0;
        var floor = 0.035 * sp;
        var main = 0;
        if (h >= lobeStart) {
          var u = (h - dist) / 0.52;
          main = Math.exp(-(u * u)) * (0.45 + 0.55 * sp);
        }
        g = near + floor + main;
      }
      amp[i] = g;
    }
    var peak = 0;
    for (i = 0; i < n; i++) if (amp[i] > peak) peak = amp[i];
    if (peak < 1e-12) peak = 1;
    for (i = 0; i < n; i++) amp[i] /= peak;
    return amp;
  }

  function simThreshold(gradeAmp, distM) {
    var math = global.FwEchoMath;
    var tn = math.THRESH_N;
    var T = new Array(tn);
    var t;
    var w;
    var dist = distM || 0;
    for (t = 0; t < tn; t++) {
      var i0 = t << 2;
      var h = i0 * math.GRADE_DH_M;
      var near = 0.92 * Math.exp(-h / 0.55);
      var sm = 0;
      var c = 0;
      for (w = i0 - 16; w <= i0 + 16; w++) {
        if (w < 0 || w >= gradeAmp.length) continue;
        sm += gradeAmp[w];
        c++;
      }
      var follow = c ? (sm / c) * 0.42 : 0;
      var after = h > dist ? 0.55 : 0;
      var v = near + follow + 0.05 + after;
      if (v > 1) v = 1;
      T[t] = v;
    }
    return T;
  }

  function toPc(arr, gain) {
    var math = global.FwEchoMath;
    var out = new Array(arr.length);
    var i;
    for (i = 0; i < arr.length; i++) {
      out[i] = math.pcDisplayAmp(arr[i], gain);
    }
    return out;
  }

  function simulateBeamSeries(opts) {
    var math = global.FwEchoMath;
    var gradeAmp = simGrade(opts);
    var afeAmp = math.buildAfeFromGrade(gradeAmp);
    if (opts.useAfe === false) afeAmp = math.resetAfeMap();
    var threshAmp = simThreshold(gradeAmp, opts.distanceM);
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
      gradeAmp: toPc(gradeAmp, GAIN_GRADE),
      threshAmp: toPc(threshAmp, GAIN_THRESH),
      afeAmp: toPc(afeAmp, GAIN_AFE),
      falseAmp: toPc(falseAmp, GAIN_FALSE),
      pick: pick,
    };
  }

  global.FwEchoSim = {
    simulateBeamSeries: simulateBeamSeries,
    GAIN_GRADE: GAIN_GRADE,
    GAIN_THRESH: GAIN_THRESH,
  };
})(typeof window !== "undefined" ? window : globalThis);
