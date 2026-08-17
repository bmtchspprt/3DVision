/**
 * Echo / false-echo / pick math used by Echo Curve.
 *
 * Proven (firmware image or PC packer/parser — see emulator docs/firmware):
 *   series lengths, ~80 m Grade axis, cmd 151 window, Grade vs Threshold pick loop,
 *   distance-power piecewise, damping field is a length in meters.
 * Reconstructed (wired because the user asked for working logic; not CERTAINTY-closed):
 *   AFE = block-max of Grade, apply = reject G<=map for pick, damping = track gate + slew.
 */
(function (global) {
  "use strict";

  var GRADE_N = 5242;
  var THRESH_N = 1310;
  var AFE_N = 655;
  var FALSE_N = 327;
  /** BM4 fract32→m: (x/2^31)*1000 with x=2^16 → 1000/65536 m per Grade sample. */
  var GRADE_DH_M = 1000 / 65536;
  var PEAK_GRADE_SCALE = 1.01;
  var RANGE_K = 0x20c49b;
  var CMP_1611 = 1611.0;
  var CMP_900 = 900.0;

  function gradeIndexToMeters(i, offsetM) {
    return (offsetM || 0) + i * GRADE_DH_M;
  }

  function metersToGradeIndex(m, offsetM) {
    var i = Math.round(((m || 0) - (offsetM || 0)) / GRADE_DH_M);
    if (i < 0) return 0;
    if (i >= GRADE_N) return GRADE_N - 1;
    return i;
  }

  function coarseIndex(gradeI, coarseN) {
    return Math.min(coarseN - 1, Math.floor((gradeI * coarseN) / GRADE_N));
  }

  function sampleCoarse(arr, gradeI) {
    if (!arr || !arr.length) return 0;
    return arr[coarseIndex(gradeI, arr.length)] || 0;
  }

  /**
   * Distance-power gain. Firmware FUN_20212a64.
   * rangeFixed is the same integer the DSP passes in (not meters).
   * depByte = DistancePowerDependency (cmd 174 offset 14).
   * t0,t1 at cfg+0x528/0x52c; s1,s2 at +0x530/+0x534.
   */
  function distancePowerGain(rangeFixed, depByte, cfg) {
    cfg = cfg || {};
    var t0 = cfg.t0 != null ? cfg.t0 : 0;
    var t1 = cfg.t1 != null ? cfg.t1 : 0;
    var s1 = cfg.s1 != null ? cfg.s1 : 1;
    var s2 = cfg.s2 != null ? cfg.s2 : 1;
    function fx(n) {
      return n + RANGE_K;
    }
    if (!depByte) {
      if (rangeFixed > t0) {
        if (rangeFixed > t1) {
          return Math.pow(fx(rangeFixed) / fx(t1), 1.0) * s2;
        }
        return Math.pow(fx(rangeFixed) / fx(t0), 1.5) * s1;
      }
      return Math.pow(fx(rangeFixed) * 1000, 2.0);
    }
    return Math.pow(fx(rangeFixed) * 1000, depByte / 2.0);
  }

  /**
   * Cmd 151 ManualScan (opcode 6): From/To meters, Threshold amplitude.
   * User map is 327 pts over the Grade span.
   */
  function applyManualScan(falseE, fromM, toM, threshold, offsetM) {
    var out = falseE ? falseE.slice() : new Array(FALSE_N);
    var i;
    var a = Math.min(fromM, toM);
    var b = Math.max(fromM, toM);
    var t = threshold || 0;
    for (i = 0; i < FALSE_N; i++) {
      if (out[i] == null) out[i] = 0;
      var h = gradeIndexToMeters(Math.floor((i * GRADE_N) / FALSE_N), offsetM);
      if (h >= a && h <= b) out[i] = Math.max(out[i], t);
    }
    return out;
  }

  function resetUserMap() {
    var a = new Array(FALSE_N);
    var i;
    for (i = 0; i < FALSE_N; i++) a[i] = 0;
    return a;
  }

  function resetAfeMap() {
    var a = new Array(AFE_N);
    var i;
    for (i = 0; i < AFE_N; i++) a[i] = 0;
    return a;
  }

  /**
   * Scan / AFE build (cmd 151 opcode 4) — reconstructed:
   * each AFE bin = max Grade in that ÷8 block, scaled by AutoFalseEchoesSensitivity.
   */
  function buildAfeFromGrade(gradeAmp, sensitivity) {
    var afe = resetAfeMap();
    var s = sensitivity == null ? 1 : sensitivity;
    var j;
    var i;
    for (j = 0; j < AFE_N; j++) {
      var i0 = Math.floor((j * GRADE_N) / AFE_N);
      var i1 = Math.floor(((j + 1) * GRADE_N) / AFE_N);
      var m = 0;
      for (i = i0; i < i1; i++) {
        if (gradeAmp[i] > m) m = gradeAmp[i];
      }
      afe[j] = m * s;
    }
    return afe;
  }

  function mapFloor(gradeI, afeAmp, falseAmp, useAfe, useUser) {
    var floor = 0;
    if (useAfe) floor = Math.max(floor, sampleCoarse(afeAmp, gradeI));
    if (useUser) floor = Math.max(floor, sampleCoarse(falseAmp, gradeI));
    return floor;
  }

  /**
   * FFA038E2: walk Grade vs Threshold (Threshold indexed ÷4).
   * Keep last index with G*1.01 > T (and G > map floor).
   * Return rsqrt(mean((G-T)^2)) as the helper's quality (0xffa0248c = rsqrt).
   */
  function pickReported(gradeAmp, threshAmp, opts) {
    opts = opts || {};
    var offsetM = opts.offsetM || 0;
    var maxScanM = opts.maxScannedDistanceM;
    var maxCapM = opts.maxCapacityM;
    var minSnr = opts.minimalSnr;
    var useAfe = !!opts.useAfe;
    var useUser = !!opts.useUser;
    var i;
    var lastI = -1;
    var sumSq = 0;
    var n = 0;
    var maxI = GRADE_N;
    if (maxScanM != null) maxI = Math.min(maxI, metersToGradeIndex(maxScanM, offsetM) + 1);
    if (maxCapM != null) maxI = Math.min(maxI, metersToGradeIndex(maxCapM, offsetM) + 1);
    var gateLo = 0;
    var gateHi = maxI;
    if (opts.prevDistanceM != null && opts.dampingM > 0) {
      gateLo = metersToGradeIndex(opts.prevDistanceM - opts.dampingM, offsetM);
      gateHi = Math.min(maxI, metersToGradeIndex(opts.prevDistanceM + opts.dampingM, offsetM) + 1);
    }
    for (i = Math.max(0, gateLo); i < gateHi; i++) {
      var g = (gradeAmp[i] || 0) * PEAK_GRADE_SCALE;
      var t = sampleCoarse(threshAmp, i);
      var floor = mapFloor(i, opts.afeAmp, opts.falseAmp, useAfe, useUser);
      if (g <= t) continue;
      if (g <= floor) continue;
      if (minSnr != null && minSnr !== 0x7fffffff && g - t < minSnr / 1000) continue;
      var d = g - t;
      sumSq += d * d;
      n += 1;
      lastI = i;
    }
    var meters = lastI < 0 ? null : gradeIndexToMeters(lastI, offsetM);
    if (meters != null && opts.prevDistanceM != null && opts.dampingM > 0) {
      var delta = meters - opts.prevDistanceM;
      if (Math.abs(delta) > opts.dampingM) {
        meters = opts.prevDistanceM + (delta < 0 ? -opts.dampingM : opts.dampingM);
      }
    }
    var rmsInv = n > 0 ? 1 / Math.sqrt(sumSq / n) : 0;
    return {
      index: lastI,
      meters: meters,
      qualityRsqrt: rmsInv,
    };
  }

  function downsampleAmp(src, dstN) {
    var out = new Array(dstN);
    var j;
    var i;
    for (j = 0; j < dstN; j++) {
      var i0 = Math.floor((j * src.length) / dstN);
      var i1 = Math.floor(((j + 1) * src.length) / dstN);
      var m = 0;
      for (i = i0; i < i1; i++) {
        if (src[i] > m) m = src[i];
      }
      out[j] = m;
    }
    return out;
  }

  function pointsFromAmp(amp, stepMul, offsetM) {
    var pts = [];
    var i;
    for (i = 0; i < amp.length; i++) {
      pts.push({
        f: amp[i],
        h: gradeIndexToMeters(i * stepMul, offsetM),
      });
    }
    return pts;
  }

  global.FwEchoMath = {
    GRADE_N: GRADE_N,
    THRESH_N: THRESH_N,
    AFE_N: AFE_N,
    FALSE_N: FALSE_N,
    GRADE_DH_M: GRADE_DH_M,
    PEAK_GRADE_SCALE: PEAK_GRADE_SCALE,
    CMP_1611: CMP_1611,
    CMP_900: CMP_900,
    gradeIndexToMeters: gradeIndexToMeters,
    metersToGradeIndex: metersToGradeIndex,
    distancePowerGain: distancePowerGain,
    applyManualScan: applyManualScan,
    resetUserMap: resetUserMap,
    resetAfeMap: resetAfeMap,
    buildAfeFromGrade: buildAfeFromGrade,
    mapFloor: mapFloor,
    pickReported: pickReported,
    downsampleAmp: downsampleAmp,
    pointsFromAmp: pointsFromAmp,
  };
})(typeof window !== "undefined" ? window : globalThis);
