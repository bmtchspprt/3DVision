/**
 * Echo Curve / Beams — ported from decompiled 3D Vision:
 *   ApplMngr BeamData / BeamPoint / BeamLine / BeamDataParser
 *   APM.WPF.Beams ViewBeamSingle / ViewBeamAll / ViewBeamsMain
 *   Data.UnitsConverter
 *   WPFStuff ChartLegendView (legend labels / Select All)
 *
 * Do not invent UI chrome here — dialog HTML/CSS must mirror XAML.
 */
(function (global) {
  "use strict";

  // ViewBeamsMain.beamNames ← EnumRes
  var BEAM_NAMES = [
    "High",
    "Medium",
    "Low",
    "Dir 30",
    "Dir 90",
    "Dir 150",
    "Dir 210",
    "Dir 270",
    "Dir 330",
  ];

  // ViewBeamAll.CreateChartsLegend colors (per-beam Echo when All Beams)
  var BEAM_ALL_COLORS = [
    "#FF0000",
    "#00FF00",
    "#FFFF00",
    "#0000FF",
    "#000000",
    "#808080",
    "#FF00FF",
    "#008000",
    "#8A2BE2",
  ];

  // ViewBeamSingle ReloadDataSCIChart series mapping
  var SERIES_ECHO = { tag: "Grade", name: "Echo", color: "#0000FF" };
  var SERIES_THRESHOLD = {
    tag: "Threshold",
    name: "Threshold",
    color: "#00FF00",
  };
  var SERIES_AFE = {
    tag: "AFE",
    name: "Auto False Echo",
    color: "#FF0000",
  };
  var SERIES_FALSE = {
    tag: "False E.",
    name: "User False Echo",
    color: "#FF00FF",
  };
  var SERIES_FUZZY = { tag: "Fuzzy", name: "Fuzzy", color: "#000000" };

  // eBeamLineColor → ViewBeamBase.BrushFromBeamEnum
  var LINE_BRUSH = {
    Orange: "#FFA500",
    Black: "#000000",
    Cyan: "#00FFFF",
  };

  // UnitsConverter.coeffFrom_Feet_To_Meter
  var FEET_TO_METER = 0.3048;

  function convertDistance(meters, displayUnits) {
    if (displayUnits === "ft") {
      return meters / FEET_TO_METER;
    }
    return meters;
  }

  function getDistanceUnitsCaption(displayUnits) {
    return displayUnits === "ft" ? "ft" : "m";
  }

  function formatAmp(v) {
    if (!isFinite(v)) return "0";
    var a = Math.abs(v);
    if (a >= 100) return String(Math.round(v));
    if (a >= 10) return v.toFixed(1);
    if (a >= 1) return v.toFixed(2);
    if (a === 0) return "0";
    return v.toFixed(3);
  }

  // BeamDataParser.ParseBeamFile (fastParsing, linear scale). Playback of a recorded .bm4.
  var goodCurveData = null;
  var goodCurvePromise = null;

  function u32(buf, i) {
    return (
      (buf[i] | (buf[i + 1] << 8) | (buf[i + 2] << 16) | (buf[i + 3] << 24)) >>> 0
    );
  }
  function i32(buf, i) {
    return buf[i] | (buf[i + 1] << 8) | (buf[i + 2] << 16) | (buf[i + 3] << 24);
  }
  function u16(buf, i) {
    return buf[i] | (buf[i + 1] << 8);
  }
  function f32(buf, i) {
    var ab = new ArrayBuffer(4);
    var v = new Uint8Array(ab);
    v[0] = buf[i];
    v[1] = buf[i + 1];
    v[2] = buf[i + 2];
    v[3] = buf[i + 3];
    return new Float32Array(ab)[0];
  }
  function fract32(x) {
    return (x / 2147483648) * 1000;
  }
  function arrayToFract(outcome) {
    return outcome > 32768 ? (65536 - outcome) / 32768 : outcome / 32768;
  }

  function readTaggedSeries(buf, header, beam, stride, mmm) {
    var gain = f32(buf, header.gainOff + beam * stride);
    var pts = [];
    if (!(gain > 0)) return pts;
    var n = header.off + beam * stride;
    var j;
    for (j = 0; j < header.length; j++) {
      var h = header.offset + j * header.res;
      if (h > mmm) break;
      var raw = u16(buf, n + j * 2);
      pts.push({ h: h, f: arrayToFract(raw) * gain });
    }
    return pts;
  }

  function parseBeamArrayBuffer(buffer) {
    var buf = buffer instanceof Uint8Array ? buffer : new Uint8Array(buffer);
    var n = 0;
    n += 4;
    var numTables = u32(buf, n);
    n += 4;
    var numBeams = u32(buf, n);
    n += 4;
    var stride = u32(buf, n);
    n += 4;
    var headers = [];
    var t;
    for (t = 0; t < numTables; t++) {
      var tag = "";
      var j;
      for (j = 8; j < 19 && buf[n + j]; j++) tag += String.fromCharCode(buf[n + j]);
      headers.push({
        tag: tag.trim(),
        off: u32(buf, n),
        length: u32(buf, n + 4),
        offset: fract32(i32(buf, n + 20)),
        res: fract32(i32(buf, n + 24)),
        gainOff: u32(buf, n + 28),
      });
      n += 32;
    }
    var maximasOffset = u32(buf, n);
    var maximasPtr = n + 4;
    var tablesUsed = numTables > 6 ? 6 : numTables;
    var byTag = {};
    for (t = 0; t < tablesUsed; t++) byTag[headers[t].tag] = headers[t];
    var beamsDataList = [];
    var beamsHasDataList = [];
    var beamsAllTableList = [];
    var BeamLines = [];
    var mmm = 0;
    var b;
    for (b = 0; b < numBeams; b++) {
      var gradeHeader = byTag.Grade;
      var orange = 0;
      if (gradeHeader) {
        orange = fract32(i32(buf, gradeHeader.off + b * stride - 4));
        if (orange > mmm) mmm = orange;
      }
      var grade = gradeHeader ? readTaggedSeries(buf, gradeHeader, b, stride, mmm) : [];
      var threshold = byTag.Threshold
        ? readTaggedSeries(buf, byTag.Threshold, b, stride, mmm)
        : [];
      var afe = byTag.AFE ? readTaggedSeries(buf, byTag.AFE, b, stride, mmm) : [];
      var falseE = byTag["False E."]
        ? readTaggedSeries(buf, byTag["False E."], b, stride, mmm)
        : [];
      var has = false;
      var pi;
      for (pi = 0; pi < grade.length; pi++) {
        if (grade[pi].f !== 0) {
          has = true;
          break;
        }
      }
      beamsHasDataList.push(has);
      beamsDataList.push([grade, threshold, afe, falseE]);
      beamsAllTableList.push(grade.slice());
      BeamLines.push(
        orange
          ? [{ color: "Orange", val: orange, BeamFuzzyFactor: 0, beamIndex: b }]
          : []
      );
    }
    var BeamAllLines = [];
    n = maximasPtr;
    if (n + 2 < buf.length) {
      var maximaCount = u16(buf, n) - 1;
      n += 4;
      if (maximaCount >= 0 && n + 8 <= buf.length) {
        var k2 = u16(buf, n);
        n += 4;
        var aux = u32(buf, n);
        var dist = ((aux + maximasOffset) / 2147483648) * 1000;
        n += 4;
        var fuzzy = n + 4 <= buf.length ? f32(buf, n) : 0;
        n += 4;
        if (k2 >= 0 && k2 < BeamLines.length) {
          var cyan = {
            color: "Cyan",
            val: dist,
            BeamFuzzyFactor: fuzzy,
            beamIndex: k2,
          };
          BeamLines[k2].push(cyan);
          BeamAllLines.push(cyan);
        }
        var mi;
        for (mi = 0; mi < maximaCount && n + 12 <= buf.length; mi++) {
          k2 = u16(buf, n);
          n += 4;
          aux = u32(buf, n);
          dist = ((aux + maximasOffset) / 2147483648) * 1000;
          n += 4;
          fuzzy = f32(buf, n);
          n += 4;
          if (k2 > BeamLines.length) k2 = 0;
          if (k2 < 0 || k2 >= BeamLines.length) continue;
          var black = {
            color: "Black",
            val: dist,
            BeamFuzzyFactor: fuzzy,
            beamIndex: k2,
          };
          BeamLines[k2].push(black);
          BeamAllLines.push({
            color: "FromBeamIndex",
            val: dist,
            BeamFuzzyFactor: fuzzy,
            beamIndex: k2,
          });
        }
      }
    }
    var gradeRes = byTag.Grade ? byTag.Grade.res : 0.0152587890625;
    return {
      bVersion4: true,
      NumOfBeams: numBeams,
      beamDataHeaderList: [
        { representation_tag: "Grade", representation_offset: 0, representation_resulotion: gradeRes },
        { representation_tag: "Threshold" },
        { representation_tag: "AFE" },
        { representation_tag: "False E." },
      ],
      beamsDataList: beamsDataList,
      beamsHasDataList: beamsHasDataList,
      beamsAllTableList: beamsAllTableList,
      BeamLines: BeamLines,
      BeamAllLines: BeamAllLines,
      MaxHValue: mmm,
      heightM: mmm,
      resolution: gradeRes,
      maxRange: mmm,
      fileName: "0_2026-08-04 15-44-23.bm4",
      pathLabel: "",
      fromRecording: true,
    };
  }

  function preloadGoodCurve() {
    if (goodCurveData) return Promise.resolve(goodCurveData);
    if (goodCurvePromise) return goodCurvePromise;
    if (typeof fetch !== "function") return Promise.resolve(null);
    goodCurvePromise = fetch("assets/grades/good-curve.bm4")
      .then(function (res) {
        if (!res.ok) throw new Error("bm4");
        return res.arrayBuffer();
      })
      .then(function (ab) {
        goodCurveData = parseBeamArrayBuffer(ab);
        return goodCurveData;
      })
      .catch(function () {
        goodCurvePromise = null;
        return null;
      });
    return goodCurvePromise;
  }

  function getGoodCurve() {
    return goodCurveData;
  }

  function seededRand(seed) {
    var s = (seed >>> 0) || 1;
    return function () {
      s = (s * 1664525 + 1013904223) >>> 0;
      return s / 4294967296;
    };
  }

  /**
   * Build BeamData matching BeamDataParser output shape:
   *   beamsDataList[beam][series] = BeamPoint[]  (f=amp, h=distance meters)
   *   beamDataHeaderList tags: Grade, Threshold, AFE, False E.
   *   BeamLines[beam]: Orange (measured) + Black (candidates) + optional Cyan
   *   beamsHasDataList, MaxHValue, ListBeamNoiseData
   *
   * Sample amplitudes: ArrayToFract(raw) * gain (BeamDataParser).
   * X window is vessel height so the hard-zero tail is visible (live Analyze).
   */
  function buildBeamData(opts) {
    opts = opts || {};
    var math = global.FwEchoMath;
    var distanceM = opts.distanceM != null ? opts.distanceM : 2.53;
    var heightM = opts.heightM != null ? opts.heightM : 16;
    var seed = opts.seed != null ? opts.seed : 709001467;
    var rand = seededRand(seed);
    var offset = 0;
    var resolution = math ? math.GRADE_DH_M : 0.04;
    var n = math ? math.GRADE_N : Math.floor((Math.max(20, heightM + 4) - offset) / resolution) + 1;
    var maxH = heightM;
    var numBeams = 9;
    var useAfe = opts.autoFalseEchoes !== false;
    var useUser = opts.useFalseEchoes !== false;
    var headers = [
      {
        representation_tag: "Grade",
        representation_offset: offset,
        representation_resulotion: resolution,
      },
      {
        representation_tag: "Threshold",
        representation_offset: offset,
        representation_resulotion: resolution * 4,
      },
      {
        representation_tag: "AFE",
        representation_offset: offset,
        representation_resulotion: resolution * 8,
      },
      {
        representation_tag: "False E.",
        representation_offset: offset,
        representation_resulotion: resolution * 16,
      },
    ];

    var beamsDataList = [];
    var beamsHasDataList = [];
    var BeamLines = [];
    var BeamAllLines = [];
    var beamsAllTableList = [];
    var beamFixAdvice = [];
    var b;
    var i;
    var sim = global.FwEchoSim;

    for (b = 0; b < numBeams; b++) {
      var br = seededRand(seed + (b + 1) * 7919);
      var bias = (b - 4) * 0.08;
      var distB = Math.max(0.15, distanceM + bias * 0.25);
      var grade = [];
      var threshold = [];
      var afe = [];
      var falseE = [];
      var hasData = b < 7;
      var lines = [];
      var fixAdvice = null;

      if (hasData) {
        var series =
          sim && math
            ? sim.simulateBeamSeries({
                distanceM: distB,
                heightM: heightM,
                seed: seed + (b + 1) * 7919,
                falseFrom: useUser ? opts.falseEchoFrom : null,
                falseTo: useUser ? opts.falseEchoTo : null,
                falseThreshold: opts.falseEchoThreshold || 0.2,
                useUser: useUser,
                useAfe: useAfe,
              })
            : null;
        var gradeAmp = series ? series.gradeAmp : [];
        var thCoarse = series ? series.threshAmp : [];
        var afeAmp = series ? series.afeAmp : math ? math.resetAfeMap() : [];
        if (!useAfe && math) afeAmp = math.resetAfeMap();
        var falseAmp = series ? series.falseAmp : math ? math.resetUserMap() : [];
        var pick = series ? series.pick : { meters: distB };
        var reported = pick.meters != null ? pick.meters : distB;
        var fixAdvice =
          math && math.recommendFalseEchoFix
            ? math.recommendFalseEchoFix(gradeAmp, thCoarse, {
                offsetM: offset,
                orangeM: reported,
                tapeM: opts.tapeM,
                afeAmp: afeAmp,
                falseAmp: falseAmp,
              })
            : null;

        lines.push({
          color: "Orange",
          val: reported,
          BeamFuzzyFactor: 0,
          beamIndex: b,
        });
        var c1 = reported + 0.35 + br() * 0.2;
        var c2 = reported + 0.7 + br() * 0.25;
        var c3 = Math.min(heightM * 0.92, reported + 2 + br());
        lines.push({
          color: "Black",
          val: c1,
          BeamFuzzyFactor: 0.04 + br() * 0.03,
          beamIndex: b,
        });
        lines.push({
          color: "Black",
          val: c2,
          BeamFuzzyFactor: 0.05 + br() * 0.03,
          beamIndex: b,
        });
        lines.push({
          color: "Black",
          val: c3,
          BeamFuzzyFactor: 0.03 + br() * 0.02,
          beamIndex: b,
        });
        BeamAllLines.push({
          color: "FromBeamIndex",
          val: c1,
          BeamFuzzyFactor: lines[1].BeamFuzzyFactor,
          beamIndex: b,
        });

        grade = math ? math.pointsFromAmp(gradeAmp, 1, offset) : [];
        threshold = math ? math.pointsFromAmp(thCoarse, 4, offset) : [];
        afe = math ? math.pointsFromAmp(afeAmp, 8, offset) : [];
        falseE = math ? math.pointsFromAmp(falseAmp, 16, offset) : [];
      }

      beamsHasDataList.push(hasData);
      beamsDataList.push(hasData ? [grade, threshold, afe, falseE] : [[], [], [], []]);
      beamsAllTableList.push(grade.slice());
      BeamLines.push(lines);
      beamFixAdvice.push(hasData ? fixAdvice : null);
    }

    // Noise table — BeamDataParser NoiseTable / ListBeamNoiseData
    var ListBeamNoiseData = [];
    for (i = 0; i < 12; i++) {
      var row = { BeamsWindow: i };
      for (b = 0; b < numBeams; b++) {
        row["Beam" + b] = hasNoise(b)
          ? +(0.08 + rand() * 0.18 + (i === 0 ? 0.05 : 0)).toFixed(3)
          : 0;
      }
      ListBeamNoiseData.push(row);
    }
    function hasNoise(bi) {
      return beamsHasDataList[bi];
    }

    return {
      bVersion4: true,
      NumOfBeams: numBeams,
      beamDataHeaderList: headers,
      beamsDataList: beamsDataList,
      beamsHasDataList: beamsHasDataList,
      beamsAllTableList: beamsAllTableList,
      BeamLines: BeamLines,
      BeamAllLines: BeamAllLines,
      MaxHValue: heightM,
      ListBeamNoiseData: ListBeamNoiseData,
      resolution: resolution,
      maxRange: maxH,
      distanceM: distanceM,
      heightM: heightM,
      pathLabel: opts.pathLabel || "",
      fileName: opts.fileName || "grades.bm4",
      beamFixAdvice: beamFixAdvice,
    };
  }

  function seriesVisibilityMap() {
    return {
      Echo: true,
      Threshold: true,
      "Auto False Echo": true,
      "User False Echo": true,
      Fuzzy: true,
    };
  }

  function legendItemsForBeam(beamIndex, vis) {
    if (beamIndex < 0) {
      return BEAM_NAMES.map(function (n, i) {
        return {
          key: n,
          name: n,
          color: BEAM_ALL_COLORS[i],
          mark: "line",
          checked: true,
        };
      });
    }
    return [
      SERIES_ECHO,
      SERIES_THRESHOLD,
      SERIES_AFE,
      SERIES_FALSE,
      SERIES_FUZZY,
    ].map(function (s) {
      return {
        key: s.name,
        name: s.name,
        color: s.color,
        mark: s.name === "Fuzzy" ? "rect" : "line",
        checked: !vis || vis[s.name] !== false,
      };
    });
  }

  /**
   * Canvas stand-in for ViewBeamSingle.ReloadDataSCIChart + LoadVerticalLinesSCIChartChart.
   * Title "Analyze", bottom axis "[{unit}]", series colors from ViewBeamSingle,
   * vertical lines StrokeDashArray {2,2}, Fuzzy at (val, maxF * BeamFuzzyFactor).
   */
  function drawBeamChart(canvas, beamData, state) {
    if (!canvas || !canvas.getContext || !beamData) return;
    var ctx = canvas.getContext("2d");
    var dpr = window.devicePixelRatio || 1;
    var cssW = canvas.clientWidth || 600;
    var cssH = canvas.clientHeight || 260;
    canvas.width = Math.round(cssW * dpr);
    canvas.height = Math.round(cssH * dpr);
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);

    var unit = (state && state.unit) || "m";
    var beamIndex = state && state.beamIndex != null ? state.beamIndex : 0;
    var vis = (state && state.seriesVisible) || seriesVisibilityMap();
    var showFuzzyAnnot = !!(state && state.showFuzzy);

    var padL = 52;
    var padR = 10;
    var padT = 22;
    var padB = 28;
    var plotW = Math.max(20, cssW - padL - padR);
    var plotH = Math.max(20, cssH - padT - padB);

    // rectChartXYZ Fill="#FFFFFFFF" Stroke="#FF425764"
    ctx.fillStyle = "#FFFFFF";
    ctx.fillRect(0, 0, cssW, cssH);

    if (beamIndex >= 0 && beamData.beamsHasDataList && !beamData.beamsHasDataList[beamIndex]) {
      ctx.fillStyle = "#666";
      ctx.font = "12px Segoe UI, Tahoma, sans-serif";
      ctx.textAlign = "center";
      ctx.fillText("No beam data", cssW / 2, cssH / 2);
      canvas.__mvGuide = null;
      return;
    }

    var seriesList = [];
    var xMaxM =
      beamData.MaxHValue > 1
        ? beamData.MaxHValue
        : beamData.heightM || beamData.MaxHValue || 16;
    if (xMaxM < 1) xMaxM = 16;
    var maxF = 0;
    var bi;
    var pi;
    var si;

    function noteF(pts) {
      for (pi = 0; pi < pts.length; pi++) {
        if (pts[pi].h <= xMaxM) maxF = Math.max(maxF, pts[pi].f);
      }
    }

    if (beamIndex < 0) {
      var allTables = beamData.beamsAllTableList || [];
      for (bi = 0; bi < beamData.NumOfBeams; bi++) {
        if (beamData.beamsHasDataList && !beamData.beamsHasDataList[bi]) continue;
        var echoPts = allTables[bi] || (beamData.beamsDataList[bi] && beamData.beamsDataList[bi][0]) || [];
        if (vis[BEAM_NAMES[bi]] === false) continue;
        seriesList.push({
          name: BEAM_NAMES[bi],
          color: BEAM_ALL_COLORS[bi],
          pts: echoPts,
          width: 1,
        });
        noteF(echoPts);
      }
    } else {
      var seriesDefs = [
        { meta: SERIES_ECHO, idx: 0 },
        { meta: SERIES_THRESHOLD, idx: 1 },
        { meta: SERIES_AFE, idx: 2 },
        { meta: SERIES_FALSE, idx: 3 },
      ];
      var beamSeries = beamData.beamsDataList[beamIndex] || [];
      for (si = 0; si < seriesDefs.length; si++) {
        var def = seriesDefs[si];
        if (vis[def.meta.name] === false) continue;
        var pts = beamSeries[def.idx] || [];
        seriesList.push({
          name: def.meta.name,
          color: def.meta.color,
          pts: pts,
          width: 1,
        });
        noteF(pts);
      }
    }
    if (maxF <= 0) maxF = 1;
    var yMax = maxF * 1.02;
    var xMaxDisp = convertDistance(xMaxM, unit);

    function xOf(meters) {
      return padL + (convertDistance(meters, unit) / (xMaxDisp || 1)) * plotW;
    }
    function yOf(amp) {
      return padT + plotH - (amp / (yMax || 1)) * plotH;
    }

    // Title — ViewBeamSingle: title = "Analyze"
    ctx.fillStyle = "#222222";
    ctx.font = "bold 12px Segoe UI, Tahoma, sans-serif";
    ctx.textAlign = "center";
    ctx.fillText("Analyze", padL + plotW / 2, 14);

    // Grid
    ctx.strokeStyle = "#D3D3D3";
    ctx.lineWidth = 1;
    ctx.setLineDash([2, 2]);
    var gx;
    var gy;
    var xMajor = unit === "ft" ? 10 : 2;
    var xTickMax = Math.ceil(xMaxDisp / xMajor) * xMajor;
    for (gx = 0; gx <= xTickMax + 0.001; gx += xMajor) {
      var xm = unit === "ft" ? gx * FEET_TO_METER : gx;
      var xp = xOf(xm);
      if (xp < padL || xp > padL + plotW) continue;
      ctx.beginPath();
      ctx.moveTo(xp, padT);
      ctx.lineTo(xp, padT + plotH);
      ctx.stroke();
    }
    for (gy = 0; gy <= 4; gy++) {
      var yp = padT + (gy / 4) * plotH;
      ctx.beginPath();
      ctx.moveTo(padL, yp);
      ctx.lineTo(padL + plotW, yp);
      ctx.stroke();
    }
    ctx.setLineDash([]);

    ctx.strokeStyle = "#425764";
    ctx.lineWidth = 2;
    ctx.strokeRect(padL + 0.5, padT + 0.5, plotW - 1, plotH - 1);

    // FastLine series
    for (si = 0; si < seriesList.length; si++) {
      var ser = seriesList[si];
      if (!ser.pts.length) continue;
      ctx.strokeStyle = ser.color;
      ctx.lineWidth = ser.width;
      ctx.beginPath();
      for (pi = 0; pi < ser.pts.length; pi++) {
        var pt = ser.pts[pi];
        if (pt.h > xMaxM) break;
        var px = xOf(pt.h);
        var py = yOf(pt.f);
        if (pi === 0) ctx.moveTo(px, py);
        else ctx.lineTo(px, py);
      }
      ctx.stroke();
    }

    // Vertical BeamLines — SCIChartHelper CreateVerticalLineAnnotation StrokeDashArray {2,2}
    // Single beam: BeamLines (orange measured + black/cyan picks).
    // All Beams: BeamAllLines, FromBeamIndex uses that beam's chart color (ViewBeamAll).
    var lines =
      beamIndex < 0
        ? beamData.BeamAllLines || []
        : (beamData.BeamLines && beamData.BeamLines[beamIndex]) || [];
    function lineColor(ln) {
      if (ln.color === "FromBeamIndex") {
        if (ln.beamIndex < 0 || ln.beamIndex >= BEAM_ALL_COLORS.length) return null;
        if (vis[BEAM_NAMES[ln.beamIndex]] === false) return null;
        return BEAM_ALL_COLORS[ln.beamIndex];
      }
      return LINE_BRUSH[ln.color] || "#FFFFFF";
    }
    for (bi = 0; bi < lines.length; bi++) {
      var ln = lines[bi];
      var stroke = lineColor(ln);
      if (!stroke || stroke === "#FFFFFF") continue;
      ctx.strokeStyle = stroke;
      ctx.setLineDash([2, 2]);
      ctx.lineWidth = 1.25;
      ctx.beginPath();
      ctx.moveTo(xOf(ln.val), padT);
      ctx.lineTo(xOf(ln.val), padT + plotH);
      ctx.stroke();
      ctx.setLineDash([]);
    }

    // Fuzzy scatter — always loaded; annotations only if Show Fuzzy (IsShowFuzzyData)
    if (beamIndex < 0) {
      for (bi = 0; bi < lines.length; bi++) {
        var mark = lines[bi];
        var markColor = lineColor(mark);
        if (!markColor || mark.BeamFuzzyFactor == null || mark.BeamFuzzyFactor <= 0) continue;
        var fzAll = maxF * mark.BeamFuzzyFactor;
        ctx.fillStyle = markColor;
        ctx.fillRect(xOf(mark.val) - 3, yOf(fzAll) - 3, 6, 6);
      }
    } else if (vis.Fuzzy !== false && beamIndex >= 0) {
      ctx.fillStyle = "#000000";
      for (bi = 0; bi < lines.length; bi++) {
        if (lines[bi].color !== "Black" && lines[bi].color !== "Cyan") continue;
        var fz = maxF * (lines[bi].BeamFuzzyFactor != null ? lines[bi].BeamFuzzyFactor : 0);
        ctx.fillRect(xOf(lines[bi].val) - 3, yOf(fz) - 3, 6, 6);
      }
    }
    if (showFuzzyAnnot && beamData.bVersion4 && beamIndex >= 0) {
      ctx.fillStyle = "#111";
      ctx.font = "10px Segoe UI, Tahoma, sans-serif";
      ctx.textAlign = "left";
      for (bi = 0; bi < lines.length; bi++) {
        if (lines[bi].BeamFuzzyFactor == null || lines[bi].BeamFuzzyFactor <= 0) continue;
        ctx.fillText(
          Number(lines[bi].BeamFuzzyFactor).toFixed(3),
          xOf(lines[bi].val) + 4,
          padT + 12 + bi * 11
        );
      }
    }

    // Axes — SetAxes: caption $"[{UnitsConverter.getDistanceUnits}]"
    ctx.fillStyle = "#333333";
    ctx.font = "11px Segoe UI, Tahoma, sans-serif";
    ctx.textAlign = "center";
    for (gx = 0; gx <= xTickMax + 0.001; gx += xMajor) {
      if (gx > xMaxDisp + 0.01) continue;
      var xMeters = unit === "ft" ? gx * FEET_TO_METER : gx;
      ctx.fillText(String(Math.round(gx)), xOf(xMeters), cssH - 10);
    }
    ctx.fillText(
      "[" + getDistanceUnitsCaption(unit) + "]",
      padL + plotW / 2,
      cssH - 1
    );
    ctx.textAlign = "right";
    ctx.textBaseline = "middle";
    for (gy = 0; gy <= 4; gy++) {
      var amp = yMax * (1 - gy / 4);
      ctx.fillText(formatAmp(amp), padL - 6, padT + (gy / 4) * plotH);
    }
    ctx.textBaseline = "alphabetic";

    // Tight peak window for the install-guide popups (same scale as this draw).
    var boxL = Infinity;
    var boxR = -Infinity;
    var boxT = Infinity;
    var boxB = -Infinity;
    var minH = Infinity;
    var saw = false;
    var gi;
    var gp;
    for (gi = 0; gi < seriesList.length; gi++) {
      var gser = seriesList[gi];
      if (gser.name !== "Echo" && BEAM_NAMES.indexOf(gser.name) < 0) continue;
      var peakF = 0;
      var peakH = 0;
      for (pi = 0; pi < gser.pts.length; pi++) {
        gp = gser.pts[pi];
        if (gp.h > xMaxM) break;
        if (gp.f > peakF) {
          peakF = gp.f;
          peakH = gp.h;
        }
      }
      if (!(peakF > 0)) continue;
      var cut = peakF * 0.55;
      for (pi = 0; pi < gser.pts.length; pi++) {
        gp = gser.pts[pi];
        if (gp.h > xMaxM) break;
        if (gp.f < cut || Math.abs(gp.h - peakH) > 3.4) continue;
        saw = true;
        if (gp.h < minH) minH = gp.h;
        var gx = xOf(gp.h);
        var gy2 = yOf(gp.f);
        if (gx < boxL) boxL = gx;
        if (gx > boxR) boxR = gx;
        if (gy2 < boxT) boxT = gy2;
        if (gy2 > boxB) boxB = gy2;
      }
    }
    if (!saw) {
      boxL = padL + plotW * 0.35;
      boxR = padL + plotW * 0.62;
      boxT = padT + plotH * 0.12;
      boxB = padT + plotH * 0.55;
      minH = xMaxM * 0.4;
    }
    boxL = Math.max(padL, boxL - 10);
    boxR = Math.min(padL + plotW, boxR + 10);
    boxT = Math.max(padT, boxT - 10);
    boxB = Math.min(padT + plotH - 4, Math.max(boxB + 16, padT + plotH * 0.78));
    var falseM = Math.max(0.9, minH - 3.2);
    if (falseM > minH - 1.2) falseM = Math.max(0.6, minH * 0.42);
    var falseX = xOf(falseM);
    if (falseX > boxL - 18) falseX = Math.max(padL + 12, boxL - 36);
    canvas.__mvGuide = {
      plotL: padL,
      plotT: padT,
      plotW: plotW,
      plotH: plotH,
      boxL: boxL,
      boxT: boxT,
      boxW: Math.max(28, boxR - boxL),
      boxH: Math.max(28, boxB - boxT),
      falseX: falseX,
      axisY: Math.max(padT, cssH - 2),
    };
  }

  function buildLegendHtml(beamIndex, vis) {
    var items = legendItemsForBeam(beamIndex, vis);
    var html = "";
    items.forEach(function (it) {
      html +=
        '<label class="mv-echo-legend-item">' +
        '<input type="checkbox" data-echo-series="' +
        it.key.replace(/"/g, "") +
        '"' +
        (it.checked ? " checked" : "") +
        ">" +
        '<span class="swatch' +
        (it.mark === "rect" ? " swatch-rect" : "") +
        '" style="background:' +
        it.color +
        '"></span>' +
        '<span class="mv-echo-legend-name">' +
        it.name +
        "</span></label>";
    });
    // ChartLegendView.xaml — Select All / Unselect All (resx DifferentStuff)
    html +=
      '<div class="mv-echo-legend-actions">' +
      '<button type="button" class="btn mv-params-btn mv-echo-legend-btn" data-echo-legend="all">Select All</button>' +
      '<button type="button" class="btn mv-params-btn mv-echo-legend-btn" data-echo-legend="none">Unselect All</button>' +
      "</div>";
    return html;
  }

  function noiseRowsHtml(beamData) {
    if (!beamData || !beamData.ListBeamNoiseData) return "";
    var html = "";
    beamData.ListBeamNoiseData.forEach(function (row) {
      html += "<tr><td>" + row.BeamsWindow + "</td>";
      for (var b = 0; b < 9; b++) {
        var v = row["Beam" + b];
        html += "<td>" + (typeof v === "number" ? v.toFixed(3) : "0.000") + "</td>";
      }
      html += "</tr>";
    });
    return html;
  }

  function firstEnabledBeamIndex(beamData) {
    if (!beamData || !beamData.beamsHasDataList) return 0;
    for (var i = 0; i < beamData.beamsHasDataList.length; i++) {
      if (beamData.beamsHasDataList[i]) return i;
    }
    return 0;
  }

  global.MvEchoBeams = {
    BEAM_NAMES: BEAM_NAMES,
    BEAM_ALL_COLORS: BEAM_ALL_COLORS,
    SERIES_ECHO: SERIES_ECHO,
    SERIES_THRESHOLD: SERIES_THRESHOLD,
    SERIES_AFE: SERIES_AFE,
    SERIES_FALSE: SERIES_FALSE,
    SERIES_FUZZY: SERIES_FUZZY,
    convertDistance: convertDistance,
    buildBeamData: buildBeamData,
    seriesVisibilityMap: seriesVisibilityMap,
    drawBeamChart: drawBeamChart,
    buildLegendHtml: buildLegendHtml,
    noiseRowsHtml: noiseRowsHtml,
    firstEnabledBeamIndex: firstEnabledBeamIndex,
    parseBeamArrayBuffer: parseBeamArrayBuffer,
    preloadGoodCurve: preloadGoodCurve,
    getGoodCurve: getGoodCurve,
  };

  preloadGoodCurve();
})(typeof window !== "undefined" ? window : globalThis);
