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
   * Sample amplitudes follow ArrayToFract * gain semantics (≈ 0..1).
   * Geometry uses vessel measured distance (Orange) like parser num12 / MaxHValue.
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
    var maxH = n * resolution;
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

    function gauss(h, c, w, a) {
      var d = (h - c) / w;
      return a * Math.exp(-(d * d));
    }

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
        var gradeAmp = [];
        var threshAmp = [];
        for (i = 0; i < n; i++) {
          var h = offset + i * resolution;
          var clutter = 0;
          if (h < 0.55) {
            clutter +=
              0.55 *
              Math.exp(-h / 0.08) *
              (0.7 + 0.3 * Math.abs(Math.sin(h * 90)));
          }
          clutter += gauss(h, 0.42, 0.06, 0.12);
          clutter += gauss(h, 1.05, 0.09, 0.07);
          clutter += gauss(h, Math.max(1.2, heightM - 0.4), 0.22, 0.1);
          clutter += 0.02 + br() * 0.025;
          clutter += 0.012 * Math.sin(h * 7.3 + b) + 0.006 * Math.sin(h * 19.1);
          var f = clutter;
          f += gauss(h, distB, 0.1, 0.85);
          f += gauss(h, distB + 0.4, 0.14, 0.18);
          f = Math.max(0, Math.min(1, f));
          clutter = Math.max(0, Math.min(1, clutter));
          gradeAmp.push(f);
          var th = h < 0.6 ? 0.22 : 0.07;
          if (h > distB - 0.4 && h < distB + 0.6) {
            th = 0.22 + 0.45 * Math.exp(-Math.pow((h - distB) / 0.25, 2));
          }
          threshAmp.push(Math.min(1, th));
        }

        var afeAmp =
          useAfe && math
            ? math.buildAfeFromGrade(gradeAmp)
            : math
              ? math.resetAfeMap()
              : [];
        var falseAmp = math ? math.resetUserMap() : [];
        if (useUser && math && opts.falseEchoFrom != null && opts.falseEchoTo != null) {
          falseAmp = math.applyManualScan(
            falseAmp,
            opts.falseEchoFrom,
            opts.falseEchoTo,
            opts.falseEchoThreshold || 0.2,
            offset
          );
        }

        var thCoarse = math ? math.downsampleAmp(threshAmp, math.THRESH_N) : threshAmp;
        var pick = math
          ? math.pickReported(gradeAmp, thCoarse, { offsetM: offset })
          : { meters: distB };
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
        var c3 = Math.min(maxH * 0.55, heightM * 0.65 + br());
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
      MaxHValue: distanceM,
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

    var padL = 40;
    var padR = 8;
    var padT = 22;
    var padB = 26;
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
      return;
    }

    var seriesList = [];
    var maxF = 0;
    var maxH = 0;
    var bi;
    var pi;
    var si;

    if (beamIndex < 0) {
      for (bi = 0; bi < beamData.NumOfBeams; bi++) {
        if (!beamData.beamsHasDataList[bi]) continue;
        var echoPts = beamData.beamsDataList[bi][0] || [];
        seriesList.push({
          name: BEAM_NAMES[bi],
          color: BEAM_ALL_COLORS[bi],
          pts: echoPts,
          width: 1.2,
        });
        for (pi = 0; pi < echoPts.length; pi++) {
          maxF = Math.max(maxF, echoPts[pi].f);
          maxH = Math.max(maxH, echoPts[pi].h);
        }
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
          width: 1.25,
        });
        for (pi = 0; pi < pts.length; pi++) {
          maxF = Math.max(maxF, pts[pi].f);
          maxH = Math.max(maxH, pts[pi].h);
        }
      }
    }
    if (maxF <= 0) maxF = 1;
    if (maxH <= 0) maxH = beamData.maxRange || 20;
    var yMax = maxF * 1.02;
    var xMaxDisp = convertDistance(maxH, unit);

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
    for (gy = 0; gy <= 6; gy++) {
      var yp = padT + (gy / 6) * plotH;
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
        var px = xOf(pt.h);
        var py = yOf(pt.f);
        if (pi === 0) ctx.moveTo(px, py);
        else ctx.lineTo(px, py);
      }
      ctx.stroke();
    }

    // Vertical BeamLines — SCIChartHelper CreateVerticalLineAnnotation StrokeDashArray {2,2}
    var lines =
      beamIndex < 0 ? [] : (beamData.BeamLines && beamData.BeamLines[beamIndex]) || [];
    for (bi = 0; bi < lines.length; bi++) {
      var ln = lines[bi];
      ctx.strokeStyle = LINE_BRUSH[ln.color] || "#FFFFFF";
      ctx.setLineDash([2, 2]);
      ctx.lineWidth = 1.25;
      ctx.beginPath();
      ctx.moveTo(xOf(ln.val), padT);
      ctx.lineTo(xOf(ln.val), padT + plotH);
      ctx.stroke();
      ctx.setLineDash([]);
    }

    // Fuzzy scatter — always loaded; annotations only if Show Fuzzy (IsShowFuzzyData)
    if (vis.Fuzzy !== false && beamIndex >= 0) {
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
    // Y: SciChart left axis Min=0; fractional amps with integer format → "0"
    ctx.textAlign = "right";
    for (gy = 0; gy <= 6; gy++) {
      ctx.fillText("0", padL - 4, padT + (gy / 6) * plotH + 3);
    }
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
  };
})(typeof window !== "undefined" ? window : globalThis);
