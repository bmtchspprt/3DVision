/**
 * Echo Curve simulator — docs/firmware/OBJECTIVE.md + RESEARCH-CLOSED.md
 * Grade = pulse compression. Threshold = rsqrt walk. Orange = last G>T.
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
    var L = 96;
    var rand = rng(opts.seed || 1);
    var k;
    var i;
    var chirpRe = new Float64Array(L);
    var chirpIm = new Float64Array(L);
    for (k = 0; k < L; k++) {
      var ph = (Math.PI * k * k) / L;
      chirpRe[k] = Math.cos(ph);
      chirpIm[k] = Math.sin(ph);
    }
    var echoRe = new Float64Array(n);
    var echoIm = new Float64Array(n);

    function addReflection(distM, amp) {
      var d0 = Math.round((distM || 0) / dh);
      for (k = 0; k < L; k++) {
        var j = d0 + k;
        if (j >= 0 && j < n) {
          echoRe[j] += amp * chirpRe[k];
          echoIm[j] += amp * chirpIm[k];
        }
      }
    }

    addReflection(0.12, 0.22);
    addReflection(opts.distanceM, 1);
    addReflection((opts.distanceM || 0) + 0.55, 0.18);
    if (opts.heightM > 1) {
      addReflection(Math.max((opts.distanceM || 0) + 1, opts.heightM - 0.35), 0.12);
    }
    if (opts.falseFrom != null && opts.falseTo != null) {
      addReflection((Number(opts.falseFrom) + Number(opts.falseTo)) / 2, 0.28);
    }
    for (i = 0; i < n; i++) {
      echoRe[i] += (rand() - 0.5) * 0.02;
      echoIm[i] += (rand() - 0.5) * 0.02;
    }

    var mag = new Array(n);
    for (i = 0; i < n; i++) {
      var accRe = 0;
      var accIm = 0;
      for (k = 0; k < L; k++) {
        var t = i - (L - 1 - k);
        if (t < 0 || t >= n) continue;
        accRe += echoRe[t] * chirpRe[k] + echoIm[t] * chirpIm[k];
        accIm += echoIm[t] * chirpRe[k] - echoRe[t] * chirpIm[k];
      }
      mag[i] = Math.sqrt(accRe * accRe + accIm * accIm);
    }
    return mag;
  }

  function simThreshold(gradeAmp, afeAmp) {
    var math = global.FwEchoMath;
    var tn = math.THRESH_N;
    var T = new Array(tn);
    var t;
    var w;
    for (t = 0; t < tn; t++) {
      var i0 = t << 2;
      var acc = 0;
      for (w = i0 - 8; w < i0 + 8; w++) {
        if (w < 0 || w >= gradeAmp.length) continue;
        var g = gradeAmp[w];
        if (!(g > 0) || !isFinite(g)) continue;
        acc += 1 / Math.sqrt(g);
      }
      var v = acc / 4;
      var j = t >> 1;
      var a0 = 0;
      var a1 = 0;
      if (afeAmp && afeAmp.length) {
        a0 = afeAmp[Math.min(j, afeAmp.length - 1)] || 0;
        a1 = afeAmp[Math.min(j + 1, afeAmp.length - 1)] || a0;
      }
      var mix = t & 1 ? (a0 + a1) / 2 : a0;
      v = (v + mix) / 2;
      v = v * 1.2;
      if (v < 0.25) v = 0.25;
      T[t] = v;
    }
    return T;
  }

  function simulateBeamSeries(opts) {
    var math = global.FwEchoMath;
    var gradeRaw = simGrade(opts);
    var peak = 0;
    var i;
    for (i = 0; i < gradeRaw.length; i++) {
      if (gradeRaw[i] > peak) peak = gradeRaw[i];
    }
    if (peak < 1e-12) peak = 1;
    var gradeAmp = new Array(gradeRaw.length);
    for (i = 0; i < gradeRaw.length; i++) gradeAmp[i] = gradeRaw[i] / peak;
    var afeAmp = math.buildAfeFromGrade(gradeAmp);
    if (opts.useAfe === false) {
      afeAmp = math.resetAfeMap();
    }
    var threshRaw = simThreshold(
      gradeRaw,
      afeAmp.map(function (a) {
        return a * peak;
      })
    );
    var threshAmp = new Array(threshRaw.length);
    for (i = 0; i < threshRaw.length; i++) threshAmp[i] = threshRaw[i] / peak;
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
