/**
 * Echo Curve math from docs/firmware/RESEARCH-CLOSED.md.
 * Pick is Grade vs Threshold only. Do not mix, do not slew metres, do not skip bins from maps.
 */
(function (global) {
  "use strict";

  var GRADE_N = 5242;
  var THRESH_N = 1310;
  var AFE_N = 655;
  var FALSE_N = 327;
  /** BM4 / FW window fract32: metres = (x / 2^31) * 1000. 0x0A3D70A3 ≈ 80 m. */
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
   * AFE[i>>3] = max(AFE, Grade[i]). Do not replay mix (addend a is unused stack).
   */
  function buildAfeFromGrade(gradeAmp) {
    var afe = resetAfeMap();
    var i;
    var n = gradeAmp ? gradeAmp.length : 0;
    for (i = 0; i < n; i++) {
      var j = i >> 3;
      if (j >= AFE_N) break;
      var g = gradeAmp[i] || 0;
      if (g > afe[j]) afe[j] = g;
    }
    return afe;
  }

  /**
   * last G>T. G = amp×1.01; T = Threshold[i>>2]. acc += G².
   * Does not read AFE, user map, SNR, or damping.
   */
  function pickReported(gradeAmp, threshAmp, opts) {
    opts = opts || {};
    var offsetM = opts.offsetM || 0;
    var i;
    var lastI = -1;
    var sumSq = 0;
    var n = 0;
    var len = gradeAmp ? gradeAmp.length : 0;
    for (i = 0; i < len; i++) {
      var g = (gradeAmp[i] || 0) * PEAK_GRADE_SCALE;
      var t = sampleCoarse(threshAmp, i);
      if (g <= t) continue;
      sumSq += g * g;
      n += 1;
      lastI = i;
    }
    return {
      index: lastI,
      meters: lastI < 0 ? null : gradeIndexToMeters(lastI, offsetM),
      orangeWord: lastI >= 0 ? orangeWordFromGradeIndex(lastI) : null,
      qualityRsqrt: n > 0 ? 1 / Math.sqrt(sumSq / n) : 0,
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
        "Grade is above Threshold closer than Orange. Opcode 6 stores a map series; this pick does not skip those bins."
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
          "Map samples are high at Orange. Pick still uses Grade vs Threshold only; opcode 6 is a stored series."
        );
      }
    }
    var notes = [];
    notes.push("Metres = grade_index × (1000/65536). Orange word is last_i<<15 when written.");
    notes.push("Pick: last Grade×1.01 > Threshold[i>>2]. Maps and damping do not change this shot.");
    notes.push("Use Threshold already in the file. Do not rebuild T from Grade. Do not mix AFE.");
    if (tapeM != null && pickM != null) {
      var dlt = tapeM - pickM;
      if (Math.abs(dlt) > 0.3) {
        notes.push(
          dlt > 0
            ? "Tape is farther than Orange: something closer is still beating Threshold (map it, or Threshold is low)."
            : "Tape is closer than Orange: last G>T is past the material."
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
      summary = "No closer G>T run than Orange. Compare tape to last_i × (1000/65536).";
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
    pickReported: pickReported,
    recommendFalseEchoFix: recommendFalseEchoFix,
    downsampleAmp: downsampleAmp,
    pointsFromAmp: pointsFromAmp,
  };
})(typeof window !== "undefined" ? window : globalThis);
