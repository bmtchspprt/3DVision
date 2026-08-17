/**
 * Echo / false-echo / pick math used by Echo Curve.
 *
 * Proven (firmware image or PC packer/parser — see emulator docs/firmware):
 *   series lengths, ~80 m Grade axis, cmd 151 window, Grade vs Threshold pick loop,
 *   distance-power piecewise, damping field is a length in meters.
 * Reconstructed (wired because the user asked for working logic; not CERTAINTY-closed):
 *   AFE = block-max of Grade, apply = reject G<=map for pick, damping = track gate + slew.
 * recommendFalseEchoFix is a support heuristic (cmd 151 opcode 6), not the firmware apply path.
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
    if (coarseN === THRESH_N) return Math.min(THRESH_N - 1, gradeI >> 2);
    if (coarseN === AFE_N) return Math.min(AFE_N - 1, gradeI >> 3);
    if (coarseN === FALSE_N) return Math.min(FALSE_N - 1, gradeI >> 4);
    return Math.min(coarseN - 1, Math.floor((gradeI * coarseN) / GRADE_N));
  }

  /** BM4 Orange word candidate: last Grade index packed as i<<15. PC: (x/2^31)*1000 m. */
  function orangeWordFromGradeIndex(i) {
    return (i << 15) >>> 0;
  }

  function metersFromOrangeWord(word) {
    return (word / 0x80000000) * 1000;
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
   * FFA038E2 walk (proven): Threshold at i>>2; G = amp×1.01; if G>T keep last_i and acc+=G².
   * Map skip, SNR, max-scan, and damping extras are reconstructed — not in that helper.
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
      sumSq += g * g;
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
      orangeWord: lastI >= 0 ? orangeWordFromGradeIndex(lastI) : null,
      qualityRsqrt: rmsInv,
    };
  }

  /**
   * Support fix from a curve + Orange (and optional tape). Not firmware-faithful apply.
   * Peak helper never reads AFE/user maps; maps are stored/copied separately.
   * Action is cmd 151 opcode 6 (same window the chart zoom sends).
   */
  function recommendFalseEchoFix(gradeAmp, threshAmp, opts) {
    opts = opts || {};
    var offsetM = opts.offsetM || 0;
    var orangeM = opts.orangeM;
    var tapeM = opts.tapeM;
    var i;
    var lastI = -1;
    var runs = [];
    var run = null;
    var g;
    var t;
    var h;
    for (i = 0; i < GRADE_N; i++) {
      g = (gradeAmp[i] || 0) * PEAK_GRADE_SCALE;
      t = sampleCoarse(threshAmp, i);
      h = gradeIndexToMeters(i, offsetM);
      if (g > t) {
        lastI = i;
        if (!run) run = { i0: i, i1: i, maxG: g, maxT: t };
        else {
          run.i1 = i;
          if (g > run.maxG) run.maxG = g;
          if (t > run.maxT) run.maxT = t;
        }
      } else if (run) {
        runs.push(run);
        run = null;
      }
    }
    if (run) runs.push(run);
    var pickM = lastI < 0 ? orangeM : gradeIndexToMeters(lastI, offsetM);
    var early = [];
    var lockRun = null;
    for (i = 0; i < runs.length; i++) {
      var r = runs[i];
      r.fromM = gradeIndexToMeters(r.i0, offsetM);
      r.toM = gradeIndexToMeters(r.i1, offsetM);
      if (pickM != null && r.toM < pickM - GRADE_DH_M * 8) early.push(r);
      if (pickM != null && r.fromM <= pickM && pickM <= r.toM + GRADE_DH_M) lockRun = r;
    }
    var actions = [];
    function addWindow(fromM, toM, thr, why) {
      if (!(toM > fromM)) return;
      actions.push({
        opcode: 6,
        fromM: +fromM.toFixed(3),
        toM: +toM.toFixed(3),
        threshold: +Math.max(thr, 0.02).toFixed(4),
        why: why,
      });
    }
    if (early.length) {
      addWindow(
        early[0].fromM,
        early[early.length - 1].toM,
        early.reduce(function (m, x) { return Math.max(m, x.maxG); }, 0),
        "Grade is above Threshold closer than Orange — map that span so the last G>T bin can move out."
      );
    }
    if (opts.falseAmp && lockRun) {
      var fi = lastI >= 0 ? lastI : metersToGradeIndex(pickM || 0, offsetM);
      var mapAt = sampleCoarse(opts.falseAmp, fi);
      var afeAt = opts.afeAmp ? sampleCoarse(opts.afeAmp, fi) : 0;
      if (mapAt > 0 || afeAt > 0) {
        addWindow(
          Math.max(offsetM, (pickM || 0) - 0.5),
          (pickM || 0) + 0.25,
          Math.max(mapAt, afeAt, lockRun.maxG),
          "Map samples are high at Orange. Confirm whether firmware skips those bins (not proven); a ManualScan window still matches the PC command."
        );
      }
    }
    var notes = [];
    notes.push("Orange/PC axis: metres = grade_index × (1000/65536). Firmware packs last_i as index<<15 into the same fract32 shape.");
    notes.push("Peak helper compares Grade×1.01 to Threshold[i>>2] and keeps the last passing bin. It does not read AFE or user maps.");
    notes.push("0x2020421e / 0x20204634 copy or clear the map twin (flash persist), they do not apply during pick.");
    notes.push("Threshold floats at 0x20215060+0x51E8 are filled from existing Threshold int16 (convert-twin), not from 0x2021F97A (magnitude). How T is first made from Grade is still open.");
    notes.push("SNR, CRAF, max scan, UseFalseEchoes, and damping consumers are not traced — do not treat this as the unit's full decision tree.");
    if (tapeM != null && pickM != null) {
      var dlt = tapeM - pickM;
      if (Math.abs(dlt) > 0.3) {
        notes.push(
          dlt > 0
            ? "Tape is farther than Orange: something closer is still beating Threshold (map it, or Threshold is low)."
            : "Tape is closer than Orange: last G>T is past the material — check max range / empty echo / damping lag."
        );
      }
    }
    var summary;
    if (actions.length) {
      summary =
        "ManualScan (opcode 6) " +
        actions[0].fromM +
        "–" +
        actions[0].toM +
        " m @ Threshold " +
        actions[0].threshold;
    } else {
      summary = "No closer G>T run than Orange. If tape still disagrees, the gap is SNR/maps/damping (not this helper).";
    }
    return {
      lastIndex: lastI,
      pickMeters: pickM,
      orangeWord: lastI >= 0 ? orangeWordFromGradeIndex(lastI) : null,
      summary: summary,
      actions: actions,
      notes: notes,
      faithful: false,
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
    orangeWordFromGradeIndex: orangeWordFromGradeIndex,
    metersFromOrangeWord: metersFromOrangeWord,
    distancePowerGain: distancePowerGain,
    applyManualScan: applyManualScan,
    resetUserMap: resetUserMap,
    resetAfeMap: resetAfeMap,
    buildAfeFromGrade: buildAfeFromGrade,
    mapFloor: mapFloor,
    pickReported: pickReported,
    recommendFalseEchoFix: recommendFalseEchoFix,
    downsampleAmp: downsampleAmp,
    pointsFromAmp: pointsFromAmp,
  };
})(typeof window !== "undefined" ? window : globalThis);
