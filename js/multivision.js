(function () {
  "use strict";

  var multiVisionLoadingShell = document.getElementById("multiVisionLoadingShell");
  var multiVisionShell = document.getElementById("multiVisionShell");
  var simDesktop = document.getElementById("simDesktop");
  var mvTitleBar = document.getElementById("mvTitleBar");
  var mvLoadingTitleBar = document.getElementById("mvLoadingTitleBar");
  var mvVesselsGrid = document.getElementById("mvVesselsGrid");
  var mvVesselStrip = document.getElementById("mvVesselStrip");
  var mvStatusText = document.getElementById("mvStatusText");
  var mvOverview = document.getElementById("mvOverview");
  var mvLogs = document.getElementById("mvLogs");
  var mvSiteLogs = document.getElementById("mvSiteLogs");
  var mvParameters = document.getElementById("mvParameters");
  var mvDevices = document.getElementById("mvDevices");
  var mvOverviewSilo = document.getElementById("mvOverviewSilo");
  var mvOverview3d = document.getElementById("mvOverview3d");
  var mvOverviewMini = document.getElementById("mvOverviewMini");
  var btnMvClose = document.getElementById("btn-mv-close");
  var btnMvLoadingClose = document.getElementById("btn-mv-loading-close");
  var winTrayChevronBtn = document.getElementById("winTrayChevronBtn");
  var winTrayOverflow = document.getElementById("winTrayOverflow");
  var winTrayOverflowBackdrop = document.getElementById("winTrayOverflowBackdrop");
  var trayIcon3DServer = document.getElementById("trayIcon3DServer");

  var zIndexTop = 130;
  var loadingTimer = null;
  var multiVisionLoading = false;
  var serverTrayActive = false;
  var activeConnection = null;
  var selectedVesselId = "lime-stone";
  var currentMvView = "vessels";
  var vesselDetailMode = false;
  var overview3dApi = null;
  var deviceConnected = true;
  var deviceConnType = "rs485";
  var logsChartsDrawnFor = null;
  // VesselDetailsLogsBase.CreateColorsTemplateOneColorRange
  var SITE_LOG_COLORS = [
    "#FF0000",
    "#00FFFF",
    "#008000",
    "#FFA500",
    "#A52A2A",
    "#0000FF",
    "#A9A9A9",
    "#90EE90",
  ];
  var siteLogSeriesVisible = {};
  var siteLogsChartsDrawn = false;
  var LOAD_MS = 1800;

  var windowDefaults = { left: 28, top: 22, width: 968, height: 658 };

  function fitMultiVisionToDesktop() {
    var bounds = getDesktopBounds();
    var margin = 12;
    var width = Math.min(968, bounds.width - margin * 2);
    var height = Math.min(658, bounds.height - margin * 2);
    document.documentElement.style.setProperty("--mv-window-width", width + "px");
    document.documentElement.style.setProperty("--mv-window-height", height + "px");
    windowDefaults.width = width;
    windowDefaults.height = height;
  }

  var ASSET = "assets/images/multivision/";

  /**
   * Strip LED status (green/grey circle beside each silo under the blue toolbar).
   * ONLINE  — green (default; vessel is connected)
   * OFFLINE — grey (vessel is offline / not connected)
   *
   * Default is always ONLINE. Set vessel.connectionStatus = VESSEL_CONNECTION.OFFLINE
   * when a guide step needs an offline silo. Do not change the default.
   */
  var VESSEL_CONNECTION = {
    ONLINE: "online",
    OFFLINE: "offline",
  };

  /**
   * MainScreenMngr.IsViewLevel — default true (Level from vessel bottom).
   * false = Distance/headspace from device (Z − level).
   * Toolbar shows the mode you can switch TO (MainToolBar.SetLevelDistamceText).
   */
  var isViewLevel = true;
  // Overview / wizard center geometry default (meters) — matches mv-overview-3d DEMO_CENTER_H.
  var DEFAULT_VESSEL_HEIGHT = 16;

  function isVesselOffline(vessel) {
    return vessel && vessel.connectionStatus === VESSEL_CONNECTION.OFFLINE;
  }

  /** Guide helper: set strip LED online (green) or offline (grey). Re-renders vessels. */
  function setVesselConnectionStatus(vesselId, status) {
    var vessel = findVessel(vesselId);
    if (!vessel) {
      return false;
    }
    vessel.connectionStatus =
      status === VESSEL_CONNECTION.OFFLINE
        ? VESSEL_CONNECTION.OFFLINE
        : VESSEL_CONNECTION.ONLINE;
    renderVessels();
    return true;
  }

  var VESSELS_ADMIN = [
    {
      id: "lime-stone",
      name: "Lime Stone (MV)",
      short: "Lime Stone",
      poll: 0,
      fill: 79.71,
      avg: 13.64,
      max: 14.66,
      min: 12.9,
      color: "#8a5a28",
      colorLight: "#c4a06a",
    },
    {
      id: "coke",
      name: "Coke (MV)",
      short: "Coke",
      poll: 1,
      fill: 78.05,
      avg: 13.34,
      max: 14.46,
      min: 12.48,
      color: "#6e6e6e",
      colorLight: "#b8b8b8",
    },
    {
      id: "sand",
      name: "Sand (MV)",
      short: "Sand",
      poll: 2,
      fill: 72.03,
      avg: 12.55,
      max: 13.55,
      min: 11.58,
      color: "#b89200",
      colorLight: "#e6c84a",
    },
    {
      id: "lime",
      name: "Lime (MV)",
      short: "Lime",
      poll: 3,
      fill: 68.88,
      avg: 11.87,
      max: 12.9,
      min: 10.88,
      color: "#4e8a32",
      colorLight: "#9fd07a",
    },
  ];

  var VESSELS_DEMO = [
    {
      id: "lime-stone",
      name: "Lime Stone (MV)",
      short: "Lime Stone",
      poll: 0,
      fill: 75.41,
      avg: 13.47,
      max: 14.92,
      min: 12.39,
      color: "#8a5a28",
      colorLight: "#c4a06a",
      scannerName: "Carmel Ulpinim",
      serial: "709001467",
      hardware: "16",
      firmware: "2.9.986",
      deviceType: "MV",
      scadaId: 1,
      temp: 24.83,
      snr: 38.89,
      output: 16.54,
    },
    {
      id: "coke",
      name: "Coke (MV)",
      short: "Coke",
      poll: 1,
      fill: 75.41,
      avg: 13.47,
      max: 14.56,
      min: 12.7,
      color: "#6e6e6e",
      colorLight: "#b8b8b8",
      scannerName: "Coke Scanner",
      serial: "709001468",
      hardware: "16",
      firmware: "2.9.986",
      deviceType: "MV",
      scadaId: 2,
      temp: 31.2,
      snr: 36.4,
      output: 16.1,
    },
    {
      id: "sand",
      name: "Sand (MV)",
      short: "Sand",
      poll: 2,
      fill: 49.6,
      avg: 8.9,
      max: 9.4,
      min: 8.08,
      color: "#b89200",
      colorLight: "#e6c84a",
      scannerName: "Sand Scanner",
      serial: "709001469",
      hardware: "16",
      firmware: "2.9.986",
      deviceType: "MV",
      scadaId: 3,
      temp: 22.1,
      snr: 41.05,
      output: 12.0,
    },
    {
      id: "lime",
      name: "Lime (MV)",
      short: "Lime",
      poll: 3,
      fill: 39.22,
      avg: 7.07,
      max: 8.02,
      min: 5.95,
      color: "#4e8a32",
      colorLight: "#9fd07a",
      scannerName: "Lime Scanner",
      serial: "709001470",
      hardware: "16",
      firmware: "2.9.986",
      deviceType: "MV",
      scadaId: 4,
      temp: 19.8,
      snr: 40.2,
      output: 10.4,
    },
  ];

  var VESSELS = VESSELS_DEMO.slice();

  var DEFAULT_SELECTED_PARAMS = ["avg_level", "max_level", "min_level", "vol_pct"];

  /**
   * Parameter catalog.
   * listLabel = Properties dialog Available/Selected text (enable/disable list).
   * cardLabel + unit = what the vessel card shows (often different from listLabel).
   * Card format is always:  [cardLabel]  [value or "-"]  [unit]
   * e.g. list "Mass (US tons)" → card "Mass(US):" + "192.10" + "ton"
   */
  var PARAM_DEFS = [
    {
      id: "avg_level",
      listLabel: "Distance/Level",
      cardLabel: "Avg. Level:",
      unit: "m",
      value: function (m) {
        return m.avg.toFixed(2);
      },
    },
    {
      id: "max_level",
      listLabel: "Maximum Distance/Level",
      cardLabel: "Max Level:",
      unit: "m",
      value: function (m) {
        return m.max.toFixed(2);
      },
    },
    {
      id: "min_level",
      listLabel: "Minimum Distance/Level",
      cardLabel: "Min Level:",
      unit: "m",
      value: function (m) {
        return m.min.toFixed(2);
      },
    },
    {
      id: "vol_pct",
      listLabel: "Vol/Mass (%)",
      cardLabel: "Volume (%):",
      unit: "%",
      value: function (m) {
        return m.fill.toFixed(2);
      },
    },
    {
      id: "mass_metric",
      listLabel: "Mass (Metric tons)",
      cardLabel: "Mass:",
      unit: "ton",
      value: function (m) {
        return m.massT == null ? null : m.massT.toFixed(2);
      },
    },
    {
      id: "mass_us",
      listLabel: "Mass (US tons)",
      cardLabel: "Mass(US):",
      unit: "ton",
      value: function (m) {
        return m.massUs == null ? null : m.massUs.toFixed(2);
      },
    },
    {
      id: "mass_lb",
      listLabel: "Mass (Lb.)",
      cardLabel: "Mass:",
      unit: "lb",
      value: function (m) {
        return m.massLb == null ? null : m.massLb.toFixed(0);
      },
    },
    {
      id: "volume_m3",
      listLabel: "Volume (M^3)",
      cardLabel: "Volume:",
      unit: "m^3",
      value: function (m) {
        return m.volM3.toFixed(2);
      },
    },
    {
      id: "volume_ft3",
      listLabel: "Volume (Ft.^3)",
      cardLabel: "Volume:",
      unit: "ft^3",
      value: function (m) {
        return m.volFt3.toFixed(2);
      },
    },
    {
      id: "volume_liter",
      listLabel: "Volume (Liter)",
      cardLabel: "Volume:",
      unit: "liter",
      value: function (m) {
        return m.volL.toFixed(2);
      },
    },
    {
      id: "volume_gal",
      listLabel: "Volume (Gallons)",
      cardLabel: "Volume:",
      unit: "gal",
      value: function (m) {
        return m.volGal.toFixed(2);
      },
    },
    {
      id: "volume_bushel",
      listLabel: "Volume (Bushels)",
      cardLabel: "Volume:",
      unit: "bsh",
      value: function (m) {
        return m.volBsh.toFixed(2);
      },
    },
    {
      id: "max_scale_mass",
      listLabel: "Max Scale Mass",
      cardLabel: "Mass Cap.:",
      unit: "ton",
      value: function (m) {
        return m.massCap == null ? null : m.massCap.toFixed(2);
      },
    },
    {
      id: "max_scale_volume",
      listLabel: "Max Scale Volume",
      cardLabel: "Vol Cap.:",
      unit: "m^3",
      value: function (m) {
        return m.volCap.toFixed(2);
      },
    },
    {
      id: "manual_density",
      listLabel: "Manual Density",
      cardLabel: "Density:",
      unit: "lb/ft^3",
      value: function (m) {
        return m.density == null ? null : m.density.toFixed(2);
      },
    },
    {
      id: "distance_pct",
      listLabel: "Distance/Level (%)",
      cardLabel: "Avg. Level %:",
      unit: "%",
      value: function (m) {
        return (m.avgLevelPct != null ? m.avgLevelPct : 0).toFixed(2);
      },
    },
    {
      id: "temperature",
      listLabel: "Temperature",
      cardLabel: "Temperature:",
      unit: "C",
      value: function (m) {
        return m.temp.toFixed(2);
      },
    },
    {
      id: "snr",
      listLabel: "SNR",
      cardLabel: "SNR:",
      unit: "dB",
      value: function (m) {
        return m.snr.toFixed(2);
      },
    },
    {
      id: "output_current",
      listLabel: "Output Current (4-20 mA)",
      cardLabel: "Output (4-20):",
      unit: "mA",
      value: function (m) {
        return m.output.toFixed(2);
      },
    },
  ];

  var PARAM_BY_ID = {};
  PARAM_DEFS.forEach(function (p) {
    PARAM_BY_ID[p.id] = p;
  });

  var ALL_PARAM_IDS = PARAM_DEFS.map(function (p) {
    return p.id;
  });

  var ctxMenuVesselId = null;
  var paramsVesselId = null;
  var paramsDraftSelected = [];
  var paramsDraftAlerts = { maxEnabled: false, maxValue: "100", minEnabled: false, minValue: "0" };
  var paramsDraftGeneral = { sectionsX: "1", sectionsY: "1" };

  var mvVesselCtxMenu = document.getElementById("mvVesselCtxMenu");
  var mvParamsOverlay = document.getElementById("mvParamsOverlay");
  var mvParamsTitle = document.getElementById("mvParamsTitle");
  var mvParamsAvailable = document.getElementById("mvParamsAvailable");
  var mvParamsSelected = document.getElementById("mvParamsSelected");

  function ensureVesselParams(vessel) {
    if (!vessel.selectedParams || !vessel.selectedParams.length) {
      vessel.selectedParams = DEFAULT_SELECTED_PARAMS.slice();
    }
    if (!vessel.alerts) {
      vessel.alerts = { maxEnabled: false, maxValue: "100", minEnabled: false, minValue: "0" };
    }
    if (!vessel.general) {
      vessel.general = { sectionsX: "1", sectionsY: "1" };
    }
    if (vessel.scannerName == null) {
      vessel.scannerName = "Carmel Ulpinim";
    }
    if (vessel.serial == null) {
      vessel.serial = "709001467";
    }
    if (vessel.hardware == null) {
      vessel.hardware = "16";
    }
    if (vessel.firmware == null) {
      vessel.firmware = "2.9.986";
    }
    if (vessel.deviceType == null) {
      vessel.deviceType = "MV";
    }
    if (vessel.scadaId == null) {
      vessel.scadaId = (vessel.poll != null ? Number(vessel.poll) : 0) + 1;
    }
    // Geometry / calibration (meters). Level + Distance = height.
    if (vessel.height == null) {
      // Demo cards: Distance 2.53 + Level 13.47 = 16 (echo curve sample).
      vessel.height = DEFAULT_VESSEL_HEIGHT;
    }
    if (vessel.emptyLevel == null) {
      vessel.emptyLevel = 0;
    }
    if (vessel.fullLevel == null) {
      vessel.fullLevel = Math.max(0, Number(vessel.height) - 0.5);
    }
    return vessel;
  }

  function vesselHeightM(vessel) {
    ensureVesselParams(vessel);
    var h = Number(vessel.height);
    return isFinite(h) && h > 0 ? h : DEFAULT_VESSEL_HEIGHT;
  }

  function vesselEmptyLevelM(vessel) {
    ensureVesselParams(vessel);
    var v = Number(vessel.emptyLevel);
    return isFinite(v) ? v : 0;
  }

  function vesselFullLevelM(vessel) {
    ensureVesselParams(vessel);
    var v = Number(vessel.fullLevel);
    return isFinite(v) ? v : Math.max(0, vesselHeightM(vessel) - 0.5);
  }

  /** PERCENT_LEVEL = (level − empty) / (full − empty) × 100 */
  function calcLevelPercent(vessel, levelM) {
    var empty = vesselEmptyLevelM(vessel);
    var full = vesselFullLevelM(vessel);
    var span = full - empty;
    if (span <= 0) return 0;
    return Math.max(0, Math.min(100, ((Number(levelM) || 0) - empty) / span * 100));
  }

  /** PERCENT_DISTANCE ≈ distance / (height − empty) × 100 */
  function calcDistancePercent(vessel, levelM) {
    var h = vesselHeightM(vessel);
    var empty = vesselEmptyLevelM(vessel);
    var denom = h - empty;
    if (denom <= 0) return 0;
    var dist = Math.max(0, h - (Number(levelM) || 0));
    return Math.max(0, Math.min(100, (dist / denom) * 100));
  }

  /**
   * Display avg/max/min in current Level or Distance mode.
   * Distance: avg = H−avgLevel; minDist = H−maxLevel; maxDist = H−minLevel
   * (MultiScannerCalc.GetMinMaxDistanceLevelValue).
   */
  function displayLevelDistance(vessel) {
    var h = vesselHeightM(vessel);
    var avgL = Number(vessel.avg) || 0;
    var maxL = Number(vessel.max) || 0;
    var minL = Number(vessel.min) || 0;
    if (isViewLevel) {
      return {
        avg: avgL,
        max: maxL,
        min: minL,
        pct: calcLevelPercent(vessel, avgL),
      };
    }
    return {
      avg: Math.max(0, h - avgL),
      max: Math.max(0, h - minL),
      min: Math.max(0, h - maxL),
      pct: calcDistancePercent(vessel, avgL),
    };
  }

  function levelDistanceCardLabel(paramId) {
    if (paramId === "avg_level") {
      return isViewLevel ? "Avg. Level:" : "Avg. Dist:";
    }
    if (paramId === "max_level") {
      return isViewLevel ? "Max Level:" : "Max Dist:";
    }
    if (paramId === "min_level") {
      return isViewLevel ? "Min Level:" : "Min Dist:";
    }
    if (paramId === "distance_pct") {
      return isViewLevel ? "Avg. Level %:" : "Avg. Dist %:";
    }
    return null;
  }

  function syncLevelDistanceChrome() {
    var icon = document.getElementById("mvBtnLevelDistanceIcon");
    var label = document.getElementById("mvBtnLevelDistanceLabel");
    // Icon = current mode; text = mode you switch TO (SetLevelDistamceText).
    if (icon) {
      icon.src = isViewLevel
        ? "assets/images/multivision/icon_level.png"
        : "assets/images/multivision/icon_distance.png";
    }
    if (label) {
      label.textContent = isViewLevel ? "Distance" : "Level";
    }
    function setLab(id, text) {
      var el = document.getElementById(id);
      if (el) el.textContent = text;
    }
    if (isViewLevel) {
      setLab("mvOvAvgLabel", "Avg. Level:");
      setLab("mvOvMaxLabel", "Max. Level:");
      setLab("mvOvMinLabel", "Min. Level:");
      setLab("mvOvAvgPctLabel", "Avg. Level (%):");
    } else {
      setLab("mvOvAvgLabel", "Avg. Dist:");
      setLab("mvOvMaxLabel", "Max. Dist:");
      setLab("mvOvMinLabel", "Min. Dist:");
      setLab("mvOvAvgPctLabel", "Avg. Dist (%):");
    }
  }

  VESSELS.forEach(ensureVesselParams);

  function vesselMetrics(vessel) {
    var fillFrac = Math.max(0, Math.min(1, (Number(vessel.fill) || 0) / 100));
    // Default vol cap matches real MultiVision cards (~100 m^3).
    var volCap = vessel.volCap != null ? Number(vessel.volCap) : 100;
    var volM3 = volCap * fillFrac;
    // Mass/density only when vessel.density is set (otherwise card shows "-").
    var density = vessel.density != null ? Number(vessel.density) : null;
    var massT = density != null ? volM3 * density : null;
    var massCap =
      vessel.massCap != null
        ? Number(vessel.massCap)
        : density != null
          ? volCap * density
          : null;
    var disp = displayLevelDistance(vessel);
    return {
      avg: disp.avg,
      max: disp.max,
      min: disp.min,
      fill: vessel.fill,
      avgLevelPct: disp.pct,
      massT: massT,
      massUs: massT == null ? null : massT * 1.10231,
      massLb: massT == null ? null : massT * 2204.62,
      volM3: volM3,
      volFt3: volM3 * 35.3147,
      volL: volM3 * 1000,
      volGal: volM3 * 264.172,
      volBsh: volM3 * 28.3776,
      massCap: massCap,
      volCap: volCap,
      density: density,
      temp: vessel.temp != null ? vessel.temp : 24.83,
      snr: vessel.snr != null ? vessel.snr : 38.89,
      output: vessel.output != null ? vessel.output : 4 + fillFrac * 16,
    };
  }

  function findVessel(id) {
    for (var i = 0; i < VESSELS.length; i++) {
      if (VESSELS[i].id === id) {
        return VESSELS[i];
      }
    }
    return null;
  }

  function buildStatsHtml(vessel) {
    ensureVesselParams(vessel);
    var metrics = vesselMetrics(vessel);
    var rows = "";
    vessel.selectedParams.forEach(function (id) {
      var def = PARAM_BY_ID[id];
      if (!def) {
        return;
      }
      var raw = def.value(metrics);
      var display = raw == null || raw === "" ? "-" : raw;
      var cardLabel = levelDistanceCardLabel(id) || def.cardLabel;
      rows +=
        "<dt>" +
        cardLabel +
        '</dt><dd class="mv-stat-val">' +
        display +
        '</dd><dd class="mv-stat-unit">' +
        (def.unit || "") +
        "</dd>";
    });
    var dense = vessel.selectedParams.length > 6 ? " is-dense" : "";
    return (
      '<div class="mv-vessel-stats' +
      dense +
      '">' +
      "<h3>" +
      vessel.short +
      "</h3>" +
      "<dl>" +
      rows +
      "</dl>" +
      "</div>"
    );
  }

  function getShellSize(shell) {
    var inner = shell ? shell.querySelector(".mv-window, .mv-loading-window") : null;
    if (inner && inner.offsetWidth > 0 && inner.offsetHeight > 0) {
      return { width: inner.offsetWidth, height: inner.offsetHeight };
    }
    return { width: windowDefaults.width, height: windowDefaults.height };
  }

  function getDesktopBounds() {
    if (!simDesktop) {
      return { width: 1100, height: 704 };
    }
    return { width: simDesktop.clientWidth, height: simDesktop.clientHeight };
  }

  function applyWindowPosition(shell, left, top) {
    if (!shell || !simDesktop) {
      return;
    }
    var bounds = getDesktopBounds();
    var size = getShellSize(shell);
    var maxLeft = Math.max(8, bounds.width - size.width - 8);
    var maxTop = Math.max(8, bounds.height - size.height - 8);
    shell.style.left = Math.min(Math.max(left, 8), maxLeft) + "px";
    shell.style.top = Math.min(Math.max(top, 8), maxTop) + "px";
  }

  function ensureDefaultPosition(shell) {
    if (!shell || shell.dataset.positioned === "true") {
      return;
    }
    function place() {
      applyWindowPosition(shell, windowDefaults.left, windowDefaults.top);
      shell.dataset.positioned = "true";
    }
    requestAnimationFrame(function () {
      requestAnimationFrame(place);
    });
  }

  function bringToFront(shell) {
    if (!shell) {
      return;
    }
    zIndexTop += 1;
    shell.style.zIndex = String(zIndexTop);
  }

  function buildSessionTitle(connection, includeView) {
    var user = connection.userName || (connection.isDemo ? "demoUser" : "stech");
    var host = connection.serverHost || "localhost:127.0.0.1";
    var title = "3D MultiVision (" + user + " - " + host + ")";
    if (includeView && connection.viewTitle) {
      title += " - " + connection.viewTitle;
    }
    return title;
  }

  function buildLoadingTitle(connection) {
    var host = connection.serverHost || "localhost:127.0.0.1";
    return "3D MultiVision (" + host + ")";
  }

  function applyVesselDataset(userName, isDemo, blankProject) {
    // Demo Mode always uses the simulated Aggregates dataset (DemoManager / _demo*)
    if (blankProject) {
      VESSELS = [];
    } else if (isDemo) {
      VESSELS = VESSELS_DEMO.slice();
    } else {
      VESSELS = userName === "admin" ? VESSELS_ADMIN.slice() : VESSELS_DEMO.slice();
    }
    VESSELS.forEach(ensureVesselParams);
  }

  function formatStatusTimestamp() {
    return new Date().toLocaleString(undefined, {
      month: "numeric",
      day: "numeric",
      year: "numeric",
      hour: "numeric",
      minute: "2-digit",
      second: "2-digit",
    });
  }

  // Dynamic vessel silo — geometry from measured MultiVision card:
  // body ~112px / height ~280+ → aspect ~0.39; roof ~5%; hopper ~6% (shallow obtuse to a point).
  function buildSiloSvg(vessel, idSuffix) {
    var fill = Math.max(0, Math.min(100, Number(vessel.fill) || 0));
    var uid = vessel.id.replace(/[^a-z0-9]/gi, "_") + (idSuffix || "");

    // Sized to fit 4 cards in the MultiVision window without horizontal scroll.
    var vbW = 92;
    var vbH = 236;
    var cx = 40;
    var halfW = 36; // body ~72px / 236h ≈ 0.31; with F ≈ 0.39
    var peakY = 8;
    var roofY = 20; // shallow roof ~5%
    var tipY = 230;
    var hopperY = tipY - 14; // shallow hopper ~6%
    var left = cx - halfW;
    var right = cx + halfW;
    var fullY = roofY + 1;
    var emptyY = tipY;
    var bodyTop = roofY;
    var bodyBottom = tipY;
    var bodyH = bodyBottom - bodyTop;
    var fillH = (fill / 100) * bodyH;
    var fillTop = bodyBottom - fillH;
    var dark = vessel.color || "#9a6b2f";
    var mid = vessel.colorLight || "#c4a06a";

    // Point tip with shallow hopper (wide angle). Real MultiVision is obtuse, not truncated.
    var outline =
      "M " +
      cx +
      " " +
      peakY +
      " L " +
      right +
      " " +
      roofY +
      " L " +
      right +
      " " +
      hopperY +
      " L " +
      cx +
      " " +
      tipY +
      " L " +
      left +
      " " +
      hopperY +
      " L " +
      left +
      " " +
      roofY +
      " Z";

    return (
      '<svg class="mv-silo-svg" viewBox="0 0 ' +
      vbW +
      " " +
      vbH +
      '" width="' +
      vbW +
      '" height="' +
      vbH +
      '" data-fill="' +
      fill.toFixed(2) +
      '" aria-hidden="true">' +
      "<defs>" +
      '<linearGradient id="siloFill_' +
      uid +
      '" x1="0" y1="0" x2="1" y2="0">' +
      '<stop offset="0%" stop-color="' +
      dark +
      '"/>' +
      '<stop offset="10%" stop-color="' +
      mid +
      '"/>' +
      '<stop offset="22%" stop-color="#f3e6c4"/>' +
      '<stop offset="28%" stop-color="#fffaf0"/>' +
      '<stop offset="36%" stop-color="' +
      mid +
      '"/>' +
      '<stop offset="70%" stop-color="' +
      mid +
      '"/>' +
      '<stop offset="100%" stop-color="' +
      dark +
      '"/>' +
      "</linearGradient>" +
      '<clipPath id="siloClip_' +
      uid +
      '"><path d="' +
      outline +
      '"/></clipPath>' +
      "</defs>" +
      '<rect class="mv-silo-fill-rect" x="0" y="' +
      fillTop +
      '" width="' +
      vbW +
      '" height="' +
      fillH +
      '" fill="url(#siloFill_' +
      uid +
      ')" clip-path="url(#siloClip_' +
      uid +
      ')"/>' +
      // Clear wireframe outline (empty area shows card background)
      '<path d="' +
      outline +
      '" fill="none" stroke="#1a1a1a" stroke-width="1.35" stroke-linejoin="miter"/>' +
      '<line x1="' +
      left +
      '" y1="' +
      fullY +
      '" x2="' +
      right +
      '" y2="' +
      fullY +
      '" stroke="#e00000" stroke-width="1.6"/>' +
      // Empty marker: same full body width as Full (F), drawn through the hopper tip.
      '<line x1="' +
      left +
      '" y1="' +
      emptyY +
      '" x2="' +
      right +
      '" y2="' +
      emptyY +
      '" stroke="#e8a000" stroke-width="1.6"/>' +
      '<text x="' +
      (right + 3) +
      '" y="' +
      (fullY + 4) +
      '" fill="#e00000" font-size="11" font-family="Tahoma, Arial, sans-serif" font-weight="700">F</text>' +
      '<text x="' +
      (right + 3) +
      '" y="' +
      (emptyY + 4) +
      '" fill="#e8a000" font-size="11" font-family="Tahoma, Arial, sans-serif" font-weight="700">E</text>' +
      "</svg>"
    );
  }

  function setVesselFill(vesselId, percent) {
    var vessel = null;
    var i;
    for (i = 0; i < VESSELS.length; i++) {
      if (VESSELS[i].id === vesselId || VESSELS[i].short === vesselId) {
        vessel = VESSELS[i];
        break;
      }
    }
    if (!vessel) {
      return false;
    }
    vessel.fill = Math.max(0, Math.min(100, Number(percent) || 0));
    renderVessels();
    return true;
  }

  function vesselChipSiloSvg(uid, fillPct) {
    // Flat strip icon; fill height tracks vessel volume % (same as home card silo).
    var clipId = "chipSiloClip_" + uid;
    var fill = Math.max(0, Math.min(100, Number(fillPct) || 0));
    var bodyTop = 5.5;
    var bodyBottom = 32.5;
    var bodyH = bodyBottom - bodyTop;
    var fillH = (fill / 100) * bodyH;
    var fillTop = bodyBottom - fillH;
    return (
      '<svg class="mv-vessel-chip-silo" viewBox="0 0 20 34" width="17" height="32" aria-hidden="true">' +
      "<defs>" +
      '<clipPath id="' +
      clipId +
      '"><path d="M2 1.5 H18 V22 L10 32.5 L2 22 Z"/></clipPath>' +
      "</defs>" +
      '<g clip-path="url(#' +
      clipId +
      ')">' +
      '<rect x="2" y="1.5" width="16" height="31" fill="#E8E7EA"/>' +
      '<rect x="2" y="' +
      fillTop.toFixed(2) +
      '" width="16" height="' +
      fillH.toFixed(2) +
      '" fill="#8DBC90"/>' +
      "</g>" +
      '<path d="M2 1.5 H18 V22 L10 32.5 L2 22 Z" fill="none" stroke="#5A5A5C" stroke-width="1.1" stroke-linejoin="miter"/>' +
      "</svg>"
    );
  }

  function renderVesselChip(vessel) {
    var chip = document.createElement("button");
    chip.type = "button";
    chip.className = "mv-vessel-chip" + (vessel.id === selectedVesselId ? " is-selected" : "");
    chip.dataset.vesselId = vessel.id;
    // connectionStatus: online (green, default) | offline (grey) — strip LED under blue bar
    var offline = isVesselOffline(vessel);
    chip.dataset.connectionStatus = offline
      ? VESSEL_CONNECTION.OFFLINE
      : VESSEL_CONNECTION.ONLINE;
    // Icon wrap is silo-sized only so the silo stays optically centered; LED hangs to the right.
    chip.innerHTML =
      '<span class="mv-vessel-chip-graphic">' +
      '<span class="mv-vessel-chip-icon">' +
      vesselChipSiloSvg(vessel.id.replace(/[^a-z0-9]/gi, "_"), vessel.fill) +
      '<span class="mv-vessel-chip-dot' +
      (offline ? " is-offline" : "") +
      '" title="' +
      (offline ? "Offline" : "Online") +
      '" aria-label="' +
      (offline ? "Offline" : "Online") +
      '"></span>' +
      "</span>" +
      "</span>" +
      '<span class="mv-vessel-chip-label">' +
      vessel.short +
      "</span>";
    chip.addEventListener("click", function () {
      openVesselOverview(vessel.id);
    });
    return chip;
  }

  function renderVesselPanel(vessel) {
    ensureVesselParams(vessel);
    var panel = document.createElement("article");
    panel.className = "mv-vessel-panel" + (vessel.id === selectedVesselId ? " is-selected" : "");
    panel.dataset.vesselId = vessel.id;
    panel.innerHTML =
      '<div class="mv-vessel-panel-head">' +
      '<span class="mv-vessel-panel-title">' +
      '<img class="mv-vessel-panel-dot" src="' +
      ASSET +
      'led_small_green.png" alt="" width="10" height="10">' +
      "<span>" +
      vessel.name +
      "</span>" +
      "</span>" +
      '<span class="mv-vessel-poll">Poll:' +
      vessel.poll +
      "</span>" +
      "</div>" +
      '<div class="mv-vessel-panel-body">' +
      '<div class="mv-silo">' +
      buildSiloSvg(vessel) +
      "</div>" +
      buildStatsHtml(vessel) +
      "</div>";
    panel.addEventListener("click", function () {
      selectVessel(vessel.id);
    });
    panel.addEventListener("dblclick", function (event) {
      event.preventDefault();
      openVesselOverview(vessel.id);
    });
    panel.addEventListener("contextmenu", function (event) {
      event.preventDefault();
      event.stopPropagation();
      selectVessel(vessel.id);
      openVesselContextMenu(vessel.id, event.clientX, event.clientY);
    });
    return panel;
  }

  function hideVesselContextMenu() {
    if (!mvVesselCtxMenu) {
      return;
    }
    mvVesselCtxMenu.hidden = true;
    mvVesselCtxMenu.setAttribute("aria-hidden", "true");
    ctxMenuVesselId = null;
    var sub = mvVesselCtxMenu.querySelector(".mv-ctx-submenu");
    if (sub) {
      sub.hidden = true;
    }
  }

  function openVesselContextMenu(vesselId, x, y) {
    if (!mvVesselCtxMenu) {
      return;
    }
    ctxMenuVesselId = vesselId;
    mvVesselCtxMenu.hidden = false;
    mvVesselCtxMenu.setAttribute("aria-hidden", "false");
    mvVesselCtxMenu.style.left = "0px";
    mvVesselCtxMenu.style.top = "0px";
    var rect = mvVesselCtxMenu.getBoundingClientRect();
    var left = x;
    var top = y;
    if (left + rect.width > window.innerWidth - 4) {
      left = Math.max(4, window.innerWidth - rect.width - 4);
    }
    if (top + rect.height > window.innerHeight - 4) {
      top = Math.max(4, window.innerHeight - rect.height - 4);
    }
    mvVesselCtxMenu.style.left = left + "px";
    mvVesselCtxMenu.style.top = top + "px";
  }

  function fillParamsList(selectEl, ids) {
    if (!selectEl) {
      return;
    }
    selectEl.innerHTML = "";
    ids.forEach(function (id) {
      var def = PARAM_BY_ID[id];
      if (!def) {
        return;
      }
      var opt = document.createElement("option");
      opt.value = id;
      opt.textContent = def.listLabel;
      selectEl.appendChild(opt);
    });
  }

  function availableParamIds(selectedIds) {
    var selected = {};
    selectedIds.forEach(function (id) {
      selected[id] = true;
    });
    return ALL_PARAM_IDS.filter(function (id) {
      return !selected[id];
    });
  }

  function refreshParamsLists() {
    fillParamsList(mvParamsAvailable, availableParamIds(paramsDraftSelected));
    fillParamsList(mvParamsSelected, paramsDraftSelected);
  }

  function selectedOptionValues(selectEl) {
    var values = [];
    if (!selectEl) {
      return values;
    }
    Array.prototype.forEach.call(selectEl.options, function (opt) {
      if (opt.selected) {
        values.push(opt.value);
      }
    });
    return values;
  }

  function moveParams(fromSelected, ids) {
    if (!ids.length) {
      return;
    }
    if (fromSelected) {
      paramsDraftSelected = paramsDraftSelected.filter(function (id) {
        return ids.indexOf(id) === -1;
      });
    } else {
      ids.forEach(function (id) {
        if (paramsDraftSelected.indexOf(id) === -1) {
          paramsDraftSelected.push(id);
        }
      });
    }
    refreshParamsLists();
  }

  function reorderSelected(delta) {
    var selected = selectedOptionValues(mvParamsSelected);
    if (selected.length !== 1) {
      return;
    }
    var id = selected[0];
    var idx = paramsDraftSelected.indexOf(id);
    var next = idx + delta;
    if (idx < 0 || next < 0 || next >= paramsDraftSelected.length) {
      return;
    }
    paramsDraftSelected.splice(idx, 1);
    paramsDraftSelected.splice(next, 0, id);
    refreshParamsLists();
    Array.prototype.forEach.call(mvParamsSelected.options, function (opt) {
      opt.selected = opt.value === id;
    });
  }

  function setParamsTab(tabId) {
    var tabs = document.querySelectorAll(".mv-params-tab");
    var panels = document.querySelectorAll(".mv-params-panel");
    tabs.forEach(function (tab) {
      var on = tab.getAttribute("data-tab") === tabId;
      tab.classList.toggle("is-active", on);
      tab.setAttribute("aria-selected", on ? "true" : "false");
    });
    panels.forEach(function (panel) {
      var on = panel.getAttribute("data-panel") === tabId;
      panel.classList.toggle("is-active", on);
      panel.hidden = !on;
    });
  }

  function syncAlertInputsEnabled() {
    var maxEn = document.getElementById("mvAlertMaxEnabled");
    var minEn = document.getElementById("mvAlertMinEnabled");
    var maxVal = document.getElementById("mvAlertMaxValue");
    var minVal = document.getElementById("mvAlertMinValue");
    if (maxVal) {
      maxVal.disabled = !(maxEn && maxEn.checked);
    }
    if (minVal) {
      minVal.disabled = !(minEn && minEn.checked);
    }
  }

  function openPropertiesDialog(vesselId) {
    var vessel = findVessel(vesselId);
    if (!vessel || !mvParamsOverlay) {
      return;
    }
    ensureVesselParams(vessel);
    paramsVesselId = vesselId;
    paramsDraftSelected = vessel.selectedParams.slice();
    paramsDraftAlerts = {
      maxEnabled: !!vessel.alerts.maxEnabled,
      maxValue: String(vessel.alerts.maxValue != null ? vessel.alerts.maxValue : "100"),
      minEnabled: !!vessel.alerts.minEnabled,
      minValue: String(vessel.alerts.minValue != null ? vessel.alerts.minValue : "0"),
    };
    paramsDraftGeneral = {
      sectionsX: String(vessel.general.sectionsX != null ? vessel.general.sectionsX : "1"),
      sectionsY: String(vessel.general.sectionsY != null ? vessel.general.sectionsY : "1"),
    };

    if (mvParamsTitle) {
      mvParamsTitle.textContent = "Parameters Definition " + vessel.short;
    }
    refreshParamsLists();

    var maxEn = document.getElementById("mvAlertMaxEnabled");
    var minEn = document.getElementById("mvAlertMinEnabled");
    var maxVal = document.getElementById("mvAlertMaxValue");
    var minVal = document.getElementById("mvAlertMinValue");
    var secX = document.getElementById("mvSectionsX");
    var secY = document.getElementById("mvSectionsY");
    if (maxEn) {
      maxEn.checked = paramsDraftAlerts.maxEnabled;
    }
    if (minEn) {
      minEn.checked = paramsDraftAlerts.minEnabled;
    }
    if (maxVal) {
      maxVal.value = paramsDraftAlerts.maxValue;
    }
    if (minVal) {
      minVal.value = paramsDraftAlerts.minValue;
    }
    if (secX) {
      secX.value = paramsDraftGeneral.sectionsX;
    }
    if (secY) {
      secY.value = paramsDraftGeneral.sectionsY;
    }
    syncAlertInputsEnabled();
    setParamsTab("data");
    mvParamsOverlay.hidden = false;
  }

  function closePropertiesDialog() {
    if (mvParamsOverlay) {
      mvParamsOverlay.hidden = true;
    }
    paramsVesselId = null;
  }

  function applyPropertiesDialog() {
    var vessel = findVessel(paramsVesselId);
    if (!vessel) {
      closePropertiesDialog();
      return;
    }
    vessel.selectedParams = paramsDraftSelected.slice();
    var maxEn = document.getElementById("mvAlertMaxEnabled");
    var minEn = document.getElementById("mvAlertMinEnabled");
    var maxVal = document.getElementById("mvAlertMaxValue");
    var minVal = document.getElementById("mvAlertMinValue");
    var secX = document.getElementById("mvSectionsX");
    var secY = document.getElementById("mvSectionsY");
    vessel.alerts = {
      maxEnabled: !!(maxEn && maxEn.checked),
      maxValue: maxVal ? maxVal.value : "100",
      minEnabled: !!(minEn && minEn.checked),
      minValue: minVal ? minVal.value : "0",
    };
    vessel.general = {
      sectionsX: secX ? secX.value : "1",
      sectionsY: secY ? secY.value : "1",
    };
    closePropertiesDialog();
    renderVessels();
  }

  function handleVesselContextAction(action) {
    var vesselId = ctxMenuVesselId;
    hideVesselContextMenu();
    if (!vesselId) {
      return;
    }
    if (action === "properties") {
      openPropertiesDialog(vesselId);
    } else if (action === "show-3d") {
      openVesselOverview(vesselId);
    } else if (action === "connect") {
      setVesselConnectionStatus(vesselId, VESSEL_CONNECTION.ONLINE);
      updateMvStatus();
    } else if (action === "disconnect") {
      setVesselConnectionStatus(vesselId, VESSEL_CONNECTION.OFFLINE);
      updateMvStatus();
    } else if (action === "load-vessel") {
      if (window.MvDialogs) window.MvDialogs.status("Load from Vessel completed.");
    } else if (action === "wizard") {
      if (window.mvHandleMenuAction) window.mvHandleMenuAction("dev-wizard");
    } else if (action === "advanced") {
      if (window.mvHandleMenuAction) window.mvHandleMenuAction("dev-advanced");
    } else if (action === "echo") {
      if (window.mvHandleMenuAction) window.mvHandleMenuAction("dev-echo");
    } else if (action === "false-echo") {
      if (window.mvHandleMenuAction) window.mvHandleMenuAction("dev-false-echo");
    } else if (action === "material") {
      if (window.mvHandleMenuAction) window.mvHandleMenuAction("tools-materials");
    } else if (action === "edit-rename") {
      if (window.MvDialogs) window.MvDialogs.open("mv-dlg-rename");
    } else if (action === "report-server" || action === "report-local") {
      if (window.MvDialogs) window.MvDialogs.status("Generate report for selected vessel — demo complete.");
    }
  }

  function formatStatusStamp() {
    var d = new Date();
    var stamp =
      d.toLocaleDateString("en-US") +
      " " +
      d.toLocaleTimeString("en-US", { hour: "numeric", minute: "2-digit", second: "2-digit" });
    return "Scanners General Data retrieve:Completed " + stamp;
  }

  function updateMvStatus() {
    if (mvStatusText) {
      mvStatusText.textContent = formatStatusStamp();
    }
  }

  function fillScannersSelect(vessel, forDevices) {
    var scanSel = document.getElementById("mvScannersSelect");
    if (!scanSel || !vessel) {
      return;
    }
    scanSel.innerHTML = "";
    VESSELS.forEach(function (v) {
      var opt = document.createElement("option");
      opt.value = v.id;
      if (forDevices && !deviceConnected) {
        opt.textContent = v.short + " " + v.poll + "/1";
      } else {
        opt.textContent = v.name;
      }
      if (v.id === vessel.id) {
        opt.selected = true;
      }
      scanSel.appendChild(opt);
    });
  }

  function fillParametersPage(vessel) {
    var table = document.getElementById("mvParametersTable");
    var scadaEl = document.getElementById("mvParametersScadaId");
    if (!table || !vessel) {
      return;
    }
    ensureVesselParams(vessel);
    var m = vesselMetrics(vessel);
    if (scadaEl) {
      scadaEl.textContent = String(vessel.scadaId != null ? vessel.scadaId : 1);
    }
    // VesselScannersParamsUC.SetRowNames() — label | unit | scanner column
    var lvl = isViewLevel ? "Level" : "Dist";
    var rows = [
      { label: "Device Name:", unit: "", value: vessel.scannerName || vessel.short, header: true },
      { label: "Poll Address:", unit: "", value: String(vessel.poll) },
      { label: "Serial Number:", unit: "", value: vessel.serial || "-" },
      { label: "Hardware:", unit: "", value: String(vessel.hardware != null ? vessel.hardware : "-") },
      { label: "Firmware:", unit: "", value: vessel.firmware || "-" },
      { label: "Device Type:", unit: "", value: vessel.deviceType || "MV" },
      { label: "Avg " + lvl + ":", unit: "m", value: m.avg.toFixed(2) },
      { label: "Max " + lvl + ":", unit: "m", value: m.max.toFixed(2) },
      { label: "Min " + lvl + ":", unit: "m", value: m.min.toFixed(2) },
      { label: "Avg " + lvl + ":", unit: "%", value: (m.avgLevelPct != null ? m.avgLevelPct : 0).toFixed(2) },
      { label: "Volume:", unit: "[m*3]", value: m.volM3.toFixed(2) },
      { label: "Volume:", unit: "%", value: m.fill.toFixed(2) },
      { label: "Mass:", unit: "ton", value: m.massT == null ? "-" : m.massT.toFixed(2) },
      { label: "Max Volume Capacity:", unit: "[m*3]", value: m.volCap.toFixed(2) },
      { label: "Max Mass Capacity:", unit: "ton", value: m.massCap == null ? "-" : m.massCap.toFixed(2) },
      { label: "Temperature:", unit: "C", value: m.temp.toFixed(2) },
      { label: "SNR:", unit: "dB", value: m.snr.toFixed(2) },
      { label: "Output Current:", unit: "mA", value: m.output.toFixed(2) },
    ];
    var html = "";
    rows.forEach(function (row) {
      html +=
        '<div class="mv-param-label" role="rowheader">' +
        row.label +
        '</div><div class="mv-param-unit">' +
        row.unit +
        '</div><div class="mv-param-value' +
        (row.header ? " is-header" : "") +
        '">' +
        row.value +
        "</div>";
    });
    table.innerHTML = html;
  }

  function syncDevicesConnTypeUi() {
    // Mirrors WizardStepSite.UpdateVisualizationControls (decompiled).
    var type = deviceConnType;
    var isHartOrRs = type === "hart" || type === "rs485";
    var isTcp = type === "tcpip";
    var isGprs = type === "gprs";
    var isGprsSms = type === "gprs-sms";
    var isSmart = type === "smart-gprs";
    var showExtra = !isHartOrRs;
    var showPhoneBook = isTcp || isGprsSms || isSmart;
    var showPhone = isGprsSms || isSmart; // hidden for GPRS-only and TCP
    var showLocalPort = !isTcp && showExtra;
    var showTcp = isTcp;
    var showExtApn = isGprsSms || isSmart;
    var serialEnabled = !(isTcp || isGprs || isSmart);

    var extra = document.getElementById("mvDevicesConfigExtra");
    if (extra) {
      extra.hidden = !showExtra;
    }

    var serialPort = document.getElementById("mvDevicesSerialPort");
    if (serialPort) {
      serialPort.disabled = !serialEnabled || deviceConnected;
    }

    function setRows(attr, show) {
      document.querySelectorAll("[data-conn-show='" + attr + "']").forEach(function (row) {
        row.hidden = !show;
      });
    }
    setRows("phonebook", showPhoneBook);
    setRows("phone", showPhone);
    setRows("localport", showLocalPort);
    setRows("tcp", showTcp);
    setRows("extip", showExtApn);
    setRows("apn", showExtApn);

    var phoneLabel = document.getElementById("mvDevicesPhoneLabel");
    var localPortLabel = document.getElementById("mvDevicesLocalPortLabel");
    if (phoneLabel) {
      phoneLabel.textContent = "Phone Number:";
    }
    if (localPortLabel) {
      localPortLabel.textContent = "Local IP Port:";
    }

    // When connected, real UI greys editable connection fields.
    [
      "mvDevicesPhoneNumber",
      "mvDevicesLocalIpPort",
      "mvDevicesServerIp",
      "mvDevicesServerPort",
      "mvDevicesExternalIp",
      "mvDevicesApn",
      "mvDevicesPhoneBook",
    ].forEach(function (id) {
      var el = document.getElementById(id);
      if (el) {
        el.disabled = deviceConnected;
      }
    });
    var addBtn = document.getElementById("mvDevicesPhoneAdd");
    var delBtn = document.getElementById("mvDevicesPhoneDel");
    if (addBtn) {
      addBtn.disabled = deviceConnected;
    }
    if (delBtn) {
      delBtn.disabled = deviceConnected;
    }

    document.querySelectorAll('input[name="mvConnType"]').forEach(function (input) {
      input.checked = input.value === deviceConnType;
    });
  }

  function ensureDevicesPollOptions() {
    var addrEl = document.getElementById("mvDevicesPollAddr");
    if (!addrEl || addrEl.options.length >= 64) {
      return addrEl;
    }
    var selected = addrEl.value || "0";
    var html = "";
    var i;
    for (i = 0; i <= 63; i++) {
      html += '<option value="' + i + '">' + i + "</option>";
    }
    addrEl.innerHTML = html;
    addrEl.value = selected;
    return addrEl;
  }

  function fillDevicesPage(vessel) {
    if (!vessel) {
      return;
    }
    ensureVesselParams(vessel);
    if (vessel.connType) {
      deviceConnType =
        vessel.connType === "tcp" ? "tcpip" : vessel.connType;
    }
    syncDevicesConnTypeUi();
    var nameEl = document.getElementById("mvDevicesPollName");
    var addrEl = ensureDevicesPollOptions();
    var btn = document.getElementById("mvDevicesConnectBtn");
    var serialPort = document.getElementById("mvDevicesSerialPort");
    if (nameEl) {
      nameEl.textContent = deviceConnected ? vessel.scannerName : vessel.short + "_" + vessel.poll;
    }
    if (addrEl) {
      var pollVal = Math.max(0, Math.min(63, Number(vessel.poll) || 0));
      addrEl.value = String(pollVal);
    }
    if (serialPort && vessel.serialPort) {
      serialPort.value = vessel.serialPort;
      if (serialPort.value !== vessel.serialPort) {
        var opt = document.createElement("option");
        opt.value = vessel.serialPort;
        opt.textContent = vessel.serialPort;
        serialPort.insertBefore(opt, serialPort.firstChild);
        serialPort.value = vessel.serialPort;
      }
    }
    if (btn) {
      btn.textContent = deviceConnected ? "Disconnect" : "Connect";
    }
    fillScannersSelect(vessel, true);
  }

  function seededRand(seed) {
    var x = Math.sin(seed) * 10000;
    return x - Math.floor(x);
  }

  function buildLogSeries(kind, vessel, count) {
    var points = [];
    var i;
    var baseAvg = vessel.avg || 12;
    var baseFill = vessel.fill || 70;
    var baseSnr = vessel.snr != null ? vessel.snr : 50;
    var baseTemp = vessel.temp != null ? vessel.temp : 25;
    // Clear diamond sawtooth (~8–10 peaks) like Demo Mode TeeCharts — not a solid band.
    var cycles = kind === "snr" ? 28 : 9;
    for (i = 0; i < count; i++) {
      var t = i / Math.max(1, count - 1);
      var phase = (t * cycles) % 1;
      var tri = phase < 0.5 ? phase * 2 : (1 - phase) * 2;
      var wobble = (seededRand(i * 1.973 + kind.charCodeAt(0)) - 0.5) * 0.08;
      var drop = seededRand(i * 4.17 + 11) < 0.04;
      if (kind === "avg") {
        points.push(7.5 + tri * 6.5 + wobble * 0.6);
      } else if (kind === "vol") {
        points.push(45 + tri * 35 + wobble * 1.5);
      } else if (kind === "snr") {
        points.push(drop ? 8 : 38 + tri * 24 + wobble * 6);
      } else {
        points.push(baseTemp);
      }
    }
    if (kind === "avg") {
      points[count - 1] = baseAvg;
    } else if (kind === "vol") {
      points[count - 1] = baseFill;
    } else if (kind === "snr") {
      points[count - 1] = Math.max(0, baseSnr);
    }
    return points;
  }

  function drawLogChart(canvas, opts) {
    if (!canvas) {
      return;
    }
    var dpr = window.devicePixelRatio || 1;
    var cssW = canvas.clientWidth || 320;
    var cssH = canvas.clientHeight || 180;
    canvas.width = Math.max(1, Math.floor(cssW * dpr));
    canvas.height = Math.max(1, Math.floor(cssH * dpr));
    var ctx = canvas.getContext("2d");
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    ctx.clearRect(0, 0, cssW, cssH);

    var padL = 34;
    var padR = 8;
    var padT = 20;
    var padB = 22;
    var plotW = Math.max(10, cssW - padL - padR);
    var plotH = Math.max(10, cssH - padT - padB);

    // Outer chrome matches TeeChart panels in MultiVision logs.
    ctx.fillStyle = "#f0f0f0";
    ctx.fillRect(0, 0, cssW, cssH);
    ctx.fillStyle = "#ffffff";
    ctx.fillRect(padL, padT, plotW, plotH);

    ctx.fillStyle = "#222";
    ctx.font = "11px Tahoma, Arial, sans-serif";
    ctx.textAlign = "center";
    ctx.textBaseline = "top";
    ctx.fillText(opts.title, padL + plotW / 2, 3);

    // Horizontal dashed grid
    ctx.strokeStyle = "#c4c4c4";
    ctx.lineWidth = 1;
    ctx.setLineDash([2, 2]);
    var gy;
    for (gy = 0; gy <= opts.yTicks; gy++) {
      var yy = padT + (plotH * gy) / opts.yTicks;
      ctx.beginPath();
      ctx.moveTo(padL, yy);
      ctx.lineTo(padL + plotW, yy);
      ctx.stroke();
    }
    // Vertical dashed grid
    var gx;
    var xDiv = Math.max(1, (opts.xLabels || []).length - 1);
    for (gx = 0; gx <= xDiv; gx++) {
      var xx = padL + (plotW * gx) / xDiv;
      ctx.beginPath();
      ctx.moveTo(xx, padT);
      ctx.lineTo(xx, padT + plotH);
      ctx.stroke();
    }
    ctx.setLineDash([]);

    ctx.strokeStyle = "#6a6a6a";
    ctx.strokeRect(padL + 0.5, padT + 0.5, plotW - 1, plotH - 1);

    ctx.fillStyle = "#333";
    ctx.font = "9px Tahoma, Arial, sans-serif";
    ctx.textAlign = "right";
    ctx.textBaseline = "middle";
    var ti;
    for (ti = 0; ti <= opts.yTicks; ti++) {
      var yVal = opts.yMax - ((opts.yMax - opts.yMin) * ti) / opts.yTicks;
      var yPos = padT + (plotH * ti) / opts.yTicks;
      ctx.fillText(String(Math.round(yVal)), padL - 3, yPos);
    }
    ctx.save();
    ctx.translate(11, padT + plotH / 2);
    ctx.rotate(-Math.PI / 2);
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(opts.yUnit, 0, 0);
    ctx.restore();

    ctx.textAlign = "center";
    ctx.textBaseline = "top";
    var dates = opts.xLabels || [];
    for (ti = 0; ti < dates.length; ti++) {
      var dx = padL + (plotW * ti) / Math.max(1, dates.length - 1);
      ctx.fillText(dates[ti], dx, padT + plotH + 4);
    }

    var pts = opts.points || [];
    if (!pts.length) {
      return;
    }
    ctx.strokeStyle = opts.color;
    ctx.lineWidth = 1.05;
    ctx.lineJoin = "round";
    ctx.beginPath();
    for (ti = 0; ti < pts.length; ti++) {
      var px = padL + (plotW * ti) / Math.max(1, pts.length - 1);
      var py =
        padT +
        plotH -
        ((pts[ti] - opts.yMin) / Math.max(0.0001, opts.yMax - opts.yMin)) * plotH;
      if (ti === 0) {
        ctx.moveTo(px, py);
      } else {
        ctx.lineTo(px, py);
      }
    }
    ctx.stroke();
  }

  function refreshLogsCharts(vessel) {
    if (!vessel || !mvLogs || mvLogs.hidden) {
      return;
    }
    var count = 260;
    var xLabels = ["7/29/2026", "7/31/2026", "8/2/2026", "8/4/2026", "8/6/2026", "8/8/2026"];
    drawLogChart(document.getElementById("mvLogChartAvg"), {
      title: "Avg. Level",
      yUnit: "[m]",
      yMin: 0,
      yMax: 18,
      yTicks: 9,
      color: "#1a66c2",
      points: buildLogSeries("avg", vessel, count),
      xLabels: xLabels,
    });
    drawLogChart(document.getElementById("mvLogChartVol"), {
      title: "Volume/Mass (%)",
      yUnit: "[%]",
      yMin: 0,
      yMax: 100,
      yTicks: 10,
      color: "#1a66c2",
      points: buildLogSeries("vol", vessel, count),
      xLabels: xLabels,
    });
    drawLogChart(document.getElementById("mvLogChartSnr"), {
      title: "SNR",
      yUnit: "[db]",
      yMin: 0,
      yMax: 100,
      yTicks: 10,
      color: "#8b1a1a",
      points: buildLogSeries("snr", vessel, count),
      xLabels: xLabels,
    });
    drawLogChart(document.getElementById("mvLogChartTemp"), {
      title: "Temperature",
      yUnit: "[C]",
      yMin: -50,
      yMax: 200,
      yTicks: 5,
      color: "#228b22",
      points: buildLogSeries("temp", vessel, count),
      xLabels: xLabels,
    });
    logsChartsDrawnFor = vessel.id;
  }

  function ensureSiteLogVisibility() {
    VESSELS.forEach(function (vessel, index) {
      if (siteLogSeriesVisible[vessel.id] === undefined) {
        siteLogSeriesVisible[vessel.id] = true;
      }
    });
  }

  function formatSiteLogTimeLabels(count) {
    var labels = [];
    var now = new Date();
    var start = new Date(now.getTime() - 3 * 60 * 1000);
    var i;
    for (i = 0; i < count; i++) {
      var t = new Date(start.getTime() + ((now.getTime() - start.getTime()) * i) / Math.max(1, count - 1));
      var h = t.getHours();
      var m = t.getMinutes();
      var ampm = h >= 12 ? "PM" : "AM";
      var hr = h % 12;
      if (hr === 0) {
        hr = 12;
      }
      labels.push(hr + ":" + (m < 10 ? "0" : "") + m + " " + ampm);
    }
    return labels;
  }

  function buildSiteLogSeries(kind, vessel, count, seedOffset) {
    var points = [];
    var i;
    var baseAvg = vessel.avg || 12;
    var baseFill = vessel.fill || 70;
    var cycles = 5;
    for (i = 0; i < count; i++) {
      var t = i / Math.max(1, count - 1);
      var phase = (t * cycles + seedOffset * 0.17) % 1;
      var tri = phase < 0.5 ? phase * 2 : (1 - phase) * 2;
      var wobble = (seededRand(i * 2.11 + seedOffset * 9.3 + kind.charCodeAt(0)) - 0.5) * 0.35;
      if (kind === "avg") {
        points.push(Math.max(0, baseAvg - 3.5 + tri * 5.5 + wobble));
      } else {
        points.push(Math.max(0, Math.min(100, baseFill - 18 + tri * 28 + wobble * 4)));
      }
    }
    return points;
  }

  function renderSiteLogLegend(containerId, vessels) {
    var el = document.getElementById(containerId);
    if (!el) {
      return;
    }
    var key = vessels
      .map(function (v) {
        return v.id;
      })
      .join("|");
    if (el.dataset.seriesKey === key) {
      el.querySelectorAll("input[data-site-series]").forEach(function (input) {
        input.checked = siteLogSeriesVisible[input.getAttribute("data-site-series")] !== false;
      });
      return;
    }
    el.dataset.seriesKey = key;
    var html = "";
    vessels.forEach(function (vessel, index) {
      var color = SITE_LOG_COLORS[index % SITE_LOG_COLORS.length];
      var checked = siteLogSeriesVisible[vessel.id] !== false ? " checked" : "";
      html +=
        '<label class="mv-site-logs-legend-item">' +
        '<input type="checkbox" data-site-series="' +
        vessel.id +
        '"' +
        checked +
        ">" +
        '<span class="mv-site-logs-legend-swatch" style="background:' +
        color +
        '"></span>' +
        '<span class="mv-site-logs-legend-name">' +
        vessel.short +
        "</span></label>";
    });
    el.innerHTML = html;
  }

  function drawSiteLogChart(canvas, opts) {
    if (!canvas) {
      return;
    }
    var dpr = window.devicePixelRatio || 1;
    var cssW = canvas.clientWidth || 640;
    var cssH = canvas.clientHeight || 220;
    canvas.width = Math.max(1, Math.floor(cssW * dpr));
    canvas.height = Math.max(1, Math.floor(cssH * dpr));
    var ctx = canvas.getContext("2d");
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    ctx.clearRect(0, 0, cssW, cssH);

    var padL = 42;
    var padR = 10;
    var padT = 22;
    var padB = 24;
    var plotW = Math.max(10, cssW - padL - padR);
    var plotH = Math.max(10, cssH - padT - padB);

    ctx.fillStyle = "#f0f0f0";
    ctx.fillRect(0, 0, cssW, cssH);
    ctx.fillStyle = "#ffffff";
    ctx.fillRect(padL, padT, plotW, plotH);

    ctx.fillStyle = "#222";
    ctx.font = "11px Tahoma, Arial, sans-serif";
    ctx.textAlign = "center";
    ctx.textBaseline = "top";
    ctx.fillText(opts.title, padL + plotW / 2, 4);

    ctx.strokeStyle = "#c4c4c4";
    ctx.lineWidth = 1;
    ctx.setLineDash([2, 2]);
    var gy;
    for (gy = 0; gy <= opts.yTicks; gy++) {
      var yy = padT + (plotH * gy) / opts.yTicks;
      ctx.beginPath();
      ctx.moveTo(padL, yy);
      ctx.lineTo(padL + plotW, yy);
      ctx.stroke();
    }
    var gx;
    var xDiv = Math.max(1, (opts.xLabels || []).length - 1);
    for (gx = 0; gx <= xDiv; gx++) {
      var xx = padL + (plotW * gx) / xDiv;
      ctx.beginPath();
      ctx.moveTo(xx, padT);
      ctx.lineTo(xx, padT + plotH);
      ctx.stroke();
    }
    ctx.setLineDash([]);

    ctx.strokeStyle = "#6a6a6a";
    ctx.strokeRect(padL + 0.5, padT + 0.5, plotW - 1, plotH - 1);

    ctx.fillStyle = "#333";
    ctx.font = "9px Tahoma, Arial, sans-serif";
    ctx.textAlign = "right";
    ctx.textBaseline = "middle";
    var ti;
    for (ti = 0; ti <= opts.yTicks; ti++) {
      var yVal = opts.yMax - ((opts.yMax - opts.yMin) * ti) / opts.yTicks;
      var yPos = padT + (plotH * ti) / opts.yTicks;
      ctx.fillText(String(Math.round(yVal)), padL - 4, yPos);
    }
    ctx.save();
    ctx.translate(12, padT + plotH / 2);
    ctx.rotate(-Math.PI / 2);
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(opts.yUnit, 0, 0);
    ctx.restore();

    ctx.textAlign = "center";
    ctx.textBaseline = "top";
    var dates = opts.xLabels || [];
    for (ti = 0; ti < dates.length; ti++) {
      var dx = padL + (plotW * ti) / Math.max(1, dates.length - 1);
      ctx.fillText(dates[ti], dx, padT + plotH + 5);
    }

    (opts.series || []).forEach(function (serie) {
      if (!serie.visible || !serie.points || !serie.points.length) {
        return;
      }
      ctx.strokeStyle = serie.color;
      ctx.lineWidth = 1.25;
      ctx.lineJoin = "round";
      ctx.beginPath();
      for (ti = 0; ti < serie.points.length; ti++) {
        var px = padL + (plotW * ti) / Math.max(1, serie.points.length - 1);
        var py =
          padT +
          plotH -
          ((serie.points[ti] - opts.yMin) / Math.max(0.0001, opts.yMax - opts.yMin)) * plotH;
        if (ti === 0) {
          ctx.moveTo(px, py);
        } else {
          ctx.lineTo(px, py);
        }
      }
      ctx.stroke();
    });
  }

  function refreshSiteLogsCharts() {
    if (!mvSiteLogs || mvSiteLogs.hidden) {
      return;
    }
    ensureSiteLogVisibility();
    var vessels = VESSELS.slice();
    renderSiteLogLegend("mvSiteLegendAvg", vessels);
    renderSiteLogLegend("mvSiteLegendVol", vessels);

    var count = 90;
    var xLabels = formatSiteLogTimeLabels(6);
    var distUnit = document.getElementById("mvSiteDistUnit");
    var yUnit = distUnit && distUnit.value === "feet" ? "[feet]" : "[meter]";
    var yMax = distUnit && distUnit.value === "feet" ? 55 : 16;

    var avgSeries = vessels.map(function (vessel, index) {
      return {
        color: SITE_LOG_COLORS[index % SITE_LOG_COLORS.length],
        visible: siteLogSeriesVisible[vessel.id] !== false,
        points: buildSiteLogSeries("avg", vessel, count, index),
      };
    });
    var volSeries = vessels.map(function (vessel, index) {
      return {
        color: SITE_LOG_COLORS[index % SITE_LOG_COLORS.length],
        visible: siteLogSeriesVisible[vessel.id] !== false,
        points: buildSiteLogSeries("vol", vessel, count, index),
      };
    });

    drawSiteLogChart(document.getElementById("mvSiteChartAvg"), {
      title: "Avg. Level",
      yUnit: yUnit,
      yMin: 0,
      yMax: yMax,
      yTicks: 8,
      xLabels: xLabels,
      series: avgSeries,
    });
    drawSiteLogChart(document.getElementById("mvSiteChartVol"), {
      title: "Volume/Mass (%)",
      yUnit: "[%]",
      yMin: 0,
      yMax: 100,
      yTicks: 10,
      xLabels: xLabels,
      series: volSeries,
    });
    siteLogsChartsDrawn = true;
  }

  function refreshDetailView(vessel) {
    if (currentMvView === "logs" && !vesselDetailMode) {
      window.requestAnimationFrame(function () {
        refreshSiteLogsCharts();
      });
      updateMvStatus();
      return;
    }
    if (!vessel) {
      return;
    }
    fillScannersSelect(vessel, currentMvView === "devices");
    if (currentMvView === "overview") {
      fillOverviewLeft(vessel);
    } else if (currentMvView === "parameters") {
      fillParametersPage(vessel);
    } else if (currentMvView === "devices") {
      fillDevicesPage(vessel);
    } else if (currentMvView === "logs") {
      window.requestAnimationFrame(function () {
        refreshLogsCharts(vessel);
      });
    }
    updateMvStatus();
  }

  function setMvView(view) {
    currentMvView = view || "vessels";
    // Site home (SiteViewMain): Vessels + Logs only.
    // Vessel detail (VesselDetails): Overview + Logs + Parameters + Devices.
    if (currentMvView === "vessels") {
      vesselDetailMode = false;
    } else if (
      currentMvView === "overview" ||
      currentMvView === "parameters" ||
      currentMvView === "devices"
    ) {
      vesselDetailMode = true;
    }
    // "logs" keeps whatever mode we are in (site logs vs vessel logs).

    var vesselsTab = document.querySelector('.mv-tab[data-mv-view="vessels"]');
    var overviewTab = document.querySelector('.mv-tab[data-mv-view="overview"]');
    var logsTab = document.querySelector('.mv-tab[data-mv-view="logs"]');
    if (vesselsTab) {
      vesselsTab.hidden = vesselDetailMode;
    }
    if (overviewTab) {
      overviewTab.hidden = !vesselDetailMode;
    }
    if (logsTab) {
      // Logs exists on both SiteViewMain and VesselDetails.
      logsTab.hidden = false;
    }
    document.querySelectorAll(".mv-tab-overview-only").forEach(function (tab) {
      tab.hidden = !vesselDetailMode;
    });

    document.querySelectorAll(".mv-tab[data-mv-view]").forEach(function (tab) {
      if (tab.hidden) {
        tab.classList.remove("is-active");
        tab.setAttribute("aria-selected", "false");
        return;
      }
      var on = tab.getAttribute("data-mv-view") === currentMvView;
      tab.classList.toggle("is-active", on);
      tab.setAttribute("aria-selected", on ? "true" : "false");
    });

    var scanners = document.getElementById("mvTabsScanners");
    if (scanners) {
      scanners.hidden = !vesselDetailMode;
    }

    if (mvVesselsGrid) {
      mvVesselsGrid.hidden = currentMvView !== "vessels";
    }
    if (mvOverview) {
      mvOverview.hidden = currentMvView !== "overview";
    }
    if (mvSiteLogs) {
      mvSiteLogs.hidden = !(currentMvView === "logs" && !vesselDetailMode);
    }
    if (mvLogs) {
      mvLogs.hidden = !(currentMvView === "logs" && vesselDetailMode);
    }
    if (mvParameters) {
      mvParameters.hidden = currentMvView !== "parameters";
    }
    if (mvDevices) {
      mvDevices.hidden = currentMvView !== "devices";
    }
    if (currentMvView !== "overview") {
      if (typeof window.disposeOverview3D === "function") {
        window.disposeOverview3D();
      }
      overview3dApi = null;
    }

    if (currentMvView === "logs" && !vesselDetailMode) {
      window.requestAnimationFrame(function () {
        refreshSiteLogsCharts();
      });
      updateMvStatus();
    } else if (currentMvView === "logs" || vesselDetailMode) {
      refreshDetailView(findVessel(selectedVesselId));
    }
  }

  function fitOverviewScale() {
    var fit = document.getElementById("mvOverviewFit");
    var design = document.getElementById("mvOverviewDesign");
    if (!fit || !design || !mvOverview || mvOverview.hidden) {
      return;
    }
    var designW = 1005;
    var designH = 480;
    var availW = fit.clientWidth || designW;
    var availH = fit.clientHeight || designH;
    var scale = Math.min(availW / designW, availH / designH);
    if (!isFinite(scale) || scale <= 0) {
      scale = 1;
    }
    design.style.transform = "scale(" + scale + ")";
    if (overview3dApi && overview3dApi.resize) {
      overview3dApi.resize();
    }
  }

  function fillOverviewLeft(vessel) {
    ensureVesselParams(vessel);
    var metrics = vesselMetrics(vessel);
    function setVal(id, text) {
      var el = document.getElementById(id);
      if (el) {
        el.value = text;
      }
    }
    var materialEl = document.getElementById("mvOverviewMaterial");
    var nameEl = document.getElementById("mvOverviewVesselName");
    var problemsEl = document.getElementById("mvOverviewProblems");
    if (materialEl) {
      materialEl.textContent = vessel.short;
    }
    if (nameEl) {
      nameEl.textContent = vessel.name;
    }
    // Demo Mode clears alert/problem text (VesselDetailsOverL)
    if (problemsEl) {
      problemsEl.textContent = "";
      problemsEl.hidden = true;
    }
    setVal("mvOvAvg", metrics.avg.toFixed(2));
    setVal("mvOvMax", metrics.max.toFixed(2));
    setVal("mvOvMin", metrics.min.toFixed(2));
    setVal("mvOvAvgPct", (metrics.avgLevelPct != null ? metrics.avgLevelPct : 0).toFixed(2));
    setVal("mvOvVol", metrics.volM3.toFixed(2));
    setVal("mvOvVolPct", metrics.fill.toFixed(2));
    setVal("mvOvMass", metrics.massT == null ? "-" : metrics.massT.toFixed(2));
    setVal("mvOvVolCap", metrics.volCap.toFixed(2));
    setVal("mvOvMassCap", metrics.massCap == null ? "-" : metrics.massCap.toFixed(2));
    setVal("mvOvTemp", metrics.temp.toFixed(2));
    setVal("mvOvSnr", metrics.snr.toFixed(2));
    setVal("mvOvOut", metrics.output.toFixed(2));

    var scanSel = document.getElementById("mvScannersSelect");
    if (scanSel) {
      fillScannersSelect(vessel, false);
    }

    if (mvOverviewSilo) {
      // Unique gradient/clip ids (_ov) so hidden vessel-card SVGs don't steal fill paint.
      mvOverviewSilo.innerHTML =
        '<div class="mv-silo">' + buildSiloSvg(vessel, "_ov") + "</div>";
    }
  }

  function openVesselOverview(vesselId, done) {
    var vessel = findVessel(vesselId || selectedVesselId);
    if (!vessel) {
      if (typeof done === "function") done();
      return;
    }
    selectedVesselId = vessel.id;
    vesselDetailMode = true;
    renderVessels();
    setMvView("overview");
    fillOverviewLeft(vessel);
    window.requestAnimationFrame(function () {
      fitOverviewScale();
      if (typeof window.mountOverview3D === "function" && mvOverview3d) {
        overview3dApi = window.mountOverview3D(mvOverview3d, mvOverviewMini, {
          vesselId: vessel.id,
          fill: vessel.fill,
          avg: vessel.avg,
          max: vessel.max,
          min: vessel.min,
        });
        window.requestAnimationFrame(function () {
          fitOverviewScale();
          if (overview3dApi && overview3dApi.resize) {
            overview3dApi.resize();
          }
          // One more frame so WebGL can paint before boot curtain lifts
          window.requestAnimationFrame(function () {
            if (typeof done === "function") done();
          });
        });
      } else if (typeof done === "function") {
        done();
      }
    });
  }

  function renderVessels() {
    if (!mvVesselsGrid || !mvVesselStrip) {
      return;
    }
    mvVesselStrip.innerHTML = "";
    mvVesselsGrid.innerHTML = "";
    if (!VESSELS.length) {
      // Real StartPageUC (server mode): New Project + Open Project cards on #C7D5DD
      var start = document.createElement("div");
      start.className = "mv-start-page";
      start.id = "mvStartPage";
      start.innerHTML =
        '<button type="button" class="mv-start-card" id="mvStartNewProject">' +
        '<img src="assets/images/multivision/icon_new_project.png" alt="" width="90" height="90">' +
        '<span class="mv-start-card-text">' +
        "<strong>New Project</strong>" +
        "<span>Create new project and configure site definition.</span>" +
        "<span>“New Project” option.</span>" +
        "</span></button>" +
        '<button type="button" class="mv-start-card" id="mvStartOpenProject">' +
        '<img src="assets/images/multivision/icon_recent_project.png" alt="" width="90" height="90">' +
        '<span class="mv-start-card-text">' +
        "<strong>Open Project</strong>" +
        "<span>Open project on Server</span>" +
        "<span>“Open Project” option.</span>" +
        "</span></button>";
      mvVesselsGrid.appendChild(start);
      var newBtn = document.getElementById("mvStartNewProject");
      if (newBtn) {
        newBtn.addEventListener("click", function () {
          if (window.MvDialogs && typeof window.MvDialogs.open === "function") {
            window.MvDialogs.open("mv-dlg-project-wizard");
          } else if (typeof window.mvOpenNewProjectDialog === "function") {
            window.mvOpenNewProjectDialog();
          }
          window.dispatchEvent(new CustomEvent("install-guide:new-project-opened"));
        });
      }
      var openBtn = document.getElementById("mvStartOpenProject");
      if (openBtn) {
        openBtn.addEventListener("click", function () {
          if (window.MvDialogs && typeof window.MvDialogs.status === "function") {
            window.MvDialogs.status("No recent project on Server.");
          }
        });
      }
      if (mvVesselStrip.parentElement) {
        mvVesselStrip.parentElement.hidden = true;
      }
      return;
    }
    if (mvVesselStrip.parentElement) {
      mvVesselStrip.parentElement.hidden = false;
    }
    VESSELS.forEach(function (vessel) {
      mvVesselStrip.appendChild(renderVesselChip(vessel));
      mvVesselsGrid.appendChild(renderVesselPanel(vessel));
    });
  }

  function selectVessel(vesselId) {
    selectedVesselId = vesselId;
    renderVessels();
    if (!vesselDetailMode) {
      return;
    }
    var vessel = findVessel(vesselId);
    if (!vessel) {
      return;
    }
    if (currentMvView === "overview") {
      fillOverviewLeft(vessel);
      window.requestAnimationFrame(function () {
        fitOverviewScale();
        if (typeof window.mountOverview3D === "function" && mvOverview3d) {
          overview3dApi = window.mountOverview3D(mvOverview3d, mvOverviewMini, {
            vesselId: vessel.id,
            fill: vessel.fill,
            avg: vessel.avg,
            max: vessel.max,
            min: vessel.min,
          });
          window.requestAnimationFrame(function () {
            fitOverviewScale();
            if (overview3dApi && overview3dApi.resize) {
              overview3dApi.resize();
            }
          });
        }
      });
    } else {
      refreshDetailView(vessel);
    }
  }

  function showTrayOverflow(open) {
    if (!winTrayOverflow || !winTrayChevronBtn) {
      return;
    }
    winTrayOverflow.hidden = !open;
    if (winTrayOverflowBackdrop) {
      winTrayOverflowBackdrop.hidden = !open;
    }
    winTrayChevronBtn.setAttribute("aria-expanded", open ? "true" : "false");
  }

  function show3DServerTrayIcon() {
    serverTrayActive = true;
    if (trayIcon3DServer) {
      trayIcon3DServer.hidden = false;
    }
    if (winTrayChevronBtn) {
      winTrayChevronBtn.hidden = false;
    }
    if (typeof window.register3DVisionService === "function") {
      window.register3DVisionService();
    }
  }

  function hideMultiVisionWindows() {
    if (loadingTimer) {
      clearTimeout(loadingTimer);
      loadingTimer = null;
    }
    multiVisionLoading = false;
    hideVesselContextMenu();
    closePropertiesDialog();
    setMvView("vessels");
    if (multiVisionLoadingShell) {
      multiVisionLoadingShell.hidden = true;
      multiVisionLoadingShell.classList.add("app-shell--minimized");
    }
    if (multiVisionShell) {
      multiVisionShell.hidden = true;
      multiVisionShell.classList.add("app-shell--minimized");
    }
  }

  function showMultiVisionLoading(connection) {
    if (!multiVisionLoadingShell) {
      return;
    }
    fitMultiVisionToDesktop();
    applyWindowPosition(multiVisionLoadingShell, windowDefaults.left, windowDefaults.top);
    if (mvLoadingTitleBar) {
      mvLoadingTitleBar.textContent = buildLoadingTitle(connection);
    }
    multiVisionLoadingShell.hidden = false;
    multiVisionLoadingShell.classList.remove("app-shell--minimized");
    ensureDefaultPosition(multiVisionLoadingShell);
    bringToFront(multiVisionLoadingShell);
    if (simDesktop) {
      simDesktop.hidden = false;
    }
  }

  function showMultiVisionMain(connection) {
    if (!multiVisionShell) {
      return;
    }
    applyWindowPosition(multiVisionShell, windowDefaults.left, windowDefaults.top);
    if (mvTitleBar) {
      mvTitleBar.textContent = buildSessionTitle(connection, true);
    }
    if (mvStatusText) {
      mvStatusText.textContent = connection.blankProject
        ? "Ready — choose New Project or Open Project."
        : "Scanners General Data retrieve: Completed " + formatStatusTimestamp();
    }
    applyVesselDataset(
      connection.userName || (connection.isDemo ? "demoUser" : "stech"),
      !!connection.isDemo,
      !!connection.blankProject
    );
    renderVessels();
    vesselDetailMode = false;
    setMvView("vessels");
    var siteHome = document.getElementById("mvSiteHome");
    if (siteHome) {
      var label = siteHome.querySelector("span");
      if (label) {
        label.textContent = connection.blankProject
          ? "(No Project)"
          : connection.viewTitle === "Aggregates"
            ? "Aggregat"
            : connection.viewTitle || "Aggregat";
      }
    }
    multiVisionShell.hidden = false;
    multiVisionShell.classList.remove("app-shell--minimized");
    ensureDefaultPosition(multiVisionShell);
    bringToFront(multiVisionShell);
  }

  function finishMultiVisionLaunch(connection) {
    loadingTimer = null;
    multiVisionLoading = false;
    if (multiVisionLoadingShell) {
      multiVisionLoadingShell.hidden = true;
      multiVisionLoadingShell.classList.add("app-shell--minimized");
    }
    showMultiVisionMain(connection);
  }

  function closeMultiVision() {
    if (multiVisionShell) {
      multiVisionShell.classList.remove("mv-shell--tease");
    }
    hideMultiVisionWindows();
    show3DServerTrayIcon();
  }

  function cancelMultiVisionLaunch() {
    hideMultiVisionWindows();
  }

  function wireDragFixed(shell) {
    if (!shell) {
      return;
    }
    var titleBar = shell.querySelector(".title-bar");
    if (!titleBar) {
      return;
    }
    var dragState = null;
    titleBar.addEventListener("mousedown", function (event) {
      if (event.button !== 0 || event.target.closest(".title-bar-controls")) {
        return;
      }
      bringToFront(shell);
      var shellRect = shell.getBoundingClientRect();
      var desktopRect = simDesktop.getBoundingClientRect();
      dragState = {
        shell: shell,
        offsetX: event.clientX - shellRect.left,
        offsetY: event.clientY - shellRect.top,
        desktopLeft: desktopRect.left,
        desktopTop: desktopRect.top,
      };
      event.preventDefault();
    });
    document.addEventListener("mousemove", function (event) {
      if (!dragState || dragState.shell !== shell) {
        return;
      }
      applyWindowPosition(
        shell,
        event.clientX - dragState.desktopLeft - dragState.offsetX,
        event.clientY - dragState.desktopTop - dragState.offsetY
      );
    });
    document.addEventListener("mouseup", function () {
      if (dragState && dragState.shell === shell) {
        dragState = null;
      }
    });
  }

  function wireTray() {
    if (winTrayChevronBtn) {
      winTrayChevronBtn.addEventListener("click", function (event) {
        event.stopPropagation();
        if (!serverTrayActive) {
          return;
        }
        var open = winTrayOverflow && winTrayOverflow.hidden;
        showTrayOverflow(open);
      });
    }
    if (winTrayOverflowBackdrop) {
      winTrayOverflowBackdrop.addEventListener("click", function () {
        showTrayOverflow(false);
      });
    }
    if (trayIcon3DServer) {
      trayIcon3DServer.addEventListener("click", function () {
        showTrayOverflow(false);
      });
    }
    document.addEventListener("click", function (event) {
      if (!winTrayOverflow || winTrayOverflow.hidden) {
        return;
      }
      if (
        winTrayOverflow.contains(event.target) ||
        (winTrayChevronBtn && winTrayChevronBtn.contains(event.target))
      ) {
        return;
      }
      showTrayOverflow(false);
    });
  }

  function wireControls() {
    if (btnMvClose) {
      btnMvClose.addEventListener("click", closeMultiVision);
    }
    if (btnMvLoadingClose) {
      btnMvLoadingClose.addEventListener("click", cancelMultiVisionLaunch);
    }

    document.querySelectorAll(".mv-tab[data-mv-view]").forEach(function (tab) {
      tab.addEventListener("click", function () {
        var view = tab.getAttribute("data-mv-view");
        if (view === "overview") {
          openVesselOverview(selectedVesselId);
        } else if (view === "parameters" || view === "devices") {
          vesselDetailMode = true;
          renderVessels();
          setMvView(view);
        } else if (view === "logs") {
          // Home Logs = SiteViewLogs (stay out of vessel detail).
          // Detail Logs = VesselDetailsLogs (keep vesselDetailMode).
          renderVessels();
          setMvView("logs");
        } else {
          setMvView(view);
        }
      });
    });

    var siteHome = document.getElementById("mvSiteHome");
    if (siteHome) {
      function goSiteHome() {
        vesselDetailMode = false;
        renderVessels();
        setMvView("vessels");
      }
      siteHome.addEventListener("click", goSiteHome);
      siteHome.addEventListener("keydown", function (event) {
        if (event.key === "Enter" || event.key === " ") {
          event.preventDefault();
          goSiteHome();
        }
      });
    }

    var scanSel = document.getElementById("mvScannersSelect");
    if (scanSel) {
      scanSel.addEventListener("change", function () {
        selectedVesselId = scanSel.value;
        selectVessel(selectedVesselId);
        if (currentMvView === "overview") {
          openVesselOverview(selectedVesselId);
        }
      });
    }

    document.querySelectorAll('input[name="mvConnType"]').forEach(function (input) {
      input.addEventListener("change", function () {
        if (!input.checked) {
          return;
        }
        deviceConnType = input.value;
        syncDevicesConnTypeUi();
      });
    });

    var devicesConnectBtn = document.getElementById("mvDevicesConnectBtn");
    if (devicesConnectBtn) {
      devicesConnectBtn.addEventListener("click", function () {
        deviceConnected = !deviceConnected;
        fillDevicesPage(findVessel(selectedVesselId));
      });
    }

    window.addEventListener("resize", function () {
      if (currentMvView === "overview") {
        fitOverviewScale();
      }
      if (currentMvView === "logs" && !vesselDetailMode) {
        refreshSiteLogsCharts();
      } else if (currentMvView === "logs") {
        refreshLogsCharts(findVessel(selectedVesselId));
      }
    });

    ["mvSiteDistUnit", "mvSiteVolUnit", "mvSiteMassUnit"].forEach(function (id) {
      var el = document.getElementById(id);
      if (el) {
        el.addEventListener("change", function () {
          if (currentMvView === "logs" && !vesselDetailMode) {
            refreshSiteLogsCharts();
          }
        });
      }
    });

    ["mvSiteLegendAvg", "mvSiteLegendVol"].forEach(function (id) {
      var legend = document.getElementById(id);
      if (!legend) {
        return;
      }
      legend.addEventListener("change", function (event) {
        var input = event.target;
        if (!input || !input.getAttribute || !input.getAttribute("data-site-series")) {
          return;
        }
        siteLogSeriesVisible[input.getAttribute("data-site-series")] = input.checked;
        // Keep both legends in sync (same series set).
        document.querySelectorAll("input[data-site-series='" + input.getAttribute("data-site-series") + "']").forEach(function (box) {
          box.checked = input.checked;
        });
        refreshSiteLogsCharts();
      });
    });

    function bindOverviewCtrl(id, fn) {
      var el = document.getElementById(id);
      if (el) {
        el.addEventListener("click", function () {
          if (overview3dApi) {
            fn(overview3dApi);
          }
        });
      }
    }
    bindOverviewCtrl("mvZoomIn", function (api) {
      api.zoom(-0.35);
    });
    bindOverviewCtrl("mvZoomOut", function (api) {
      api.zoom(0.35);
    });
    bindOverviewCtrl("mvRotLeft", function (api) {
      api.rotate(0.25, 0);
    });
    bindOverviewCtrl("mvRotRight", function (api) {
      api.rotate(-0.25, 0);
    });
    bindOverviewCtrl("mvRotUp", function (api) {
      api.rotate(0, -0.18);
    });
    bindOverviewCtrl("mvRotDown", function (api) {
      api.rotate(0, 0.18);
    });
    bindOverviewCtrl("mvRotReset", function (api) {
      api.reset();
    });

    if (mvVesselCtxMenu) {
      mvVesselCtxMenu.addEventListener("click", function (event) {
        var btn = event.target.closest("[data-mv-action]");
        if (!btn || btn.disabled) {
          return;
        }
        handleVesselContextAction(btn.getAttribute("data-mv-action"));
      });
    }

    document.addEventListener("click", function (event) {
      if (!mvVesselCtxMenu || mvVesselCtxMenu.hidden) {
        return;
      }
      if (mvVesselCtxMenu.contains(event.target)) {
        return;
      }
      hideVesselContextMenu();
    });
    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape") {
        hideVesselContextMenu();
        if (mvParamsOverlay && !mvParamsOverlay.hidden) {
          closePropertiesDialog();
        }
      }
    });

    var paramsClose = document.getElementById("btn-mv-params-close");
    var paramsOk = document.getElementById("btn-mv-params-ok");
    var paramsCancel = document.getElementById("btn-mv-params-cancel");
    if (paramsClose) {
      paramsClose.addEventListener("click", closePropertiesDialog);
    }
    if (paramsCancel) {
      paramsCancel.addEventListener("click", closePropertiesDialog);
    }
    if (paramsOk) {
      paramsOk.addEventListener("click", applyPropertiesDialog);
    }
    if (mvParamsOverlay) {
      mvParamsOverlay.addEventListener("click", function (event) {
        if (event.target === mvParamsOverlay) {
          closePropertiesDialog();
        }
      });
    }

    document.querySelectorAll(".mv-params-tab").forEach(function (tab) {
      tab.addEventListener("click", function () {
        setParamsTab(tab.getAttribute("data-tab"));
      });
    });

    var moveRight = document.getElementById("mvParamsMoveRight");
    var moveAllRight = document.getElementById("mvParamsMoveAllRight");
    var moveLeft = document.getElementById("mvParamsMoveLeft");
    var moveAllLeft = document.getElementById("mvParamsMoveAllLeft");
    var moveUp = document.getElementById("mvParamsMoveUp");
    var moveDown = document.getElementById("mvParamsMoveDown");
    if (moveRight) {
      moveRight.addEventListener("click", function () {
        moveParams(false, selectedOptionValues(mvParamsAvailable));
      });
    }
    if (moveAllRight) {
      moveAllRight.addEventListener("click", function () {
        moveParams(false, availableParamIds(paramsDraftSelected));
      });
    }
    if (moveLeft) {
      moveLeft.addEventListener("click", function () {
        moveParams(true, selectedOptionValues(mvParamsSelected));
      });
    }
    if (moveAllLeft) {
      moveAllLeft.addEventListener("click", function () {
        moveParams(true, paramsDraftSelected.slice());
      });
    }
    if (moveUp) {
      moveUp.addEventListener("click", function () {
        reorderSelected(-1);
      });
    }
    if (moveDown) {
      moveDown.addEventListener("click", function () {
        reorderSelected(1);
      });
    }

    var maxEn = document.getElementById("mvAlertMaxEnabled");
    var minEn = document.getElementById("mvAlertMinEnabled");
    if (maxEn) {
      maxEn.addEventListener("change", syncAlertInputsEnabled);
    }
    if (minEn) {
      minEn.addEventListener("change", syncAlertInputsEnabled);
    }
  }

  window.openMultiVisionFromConnect = function (connection) {
    connection = connection || {};
    connection.userName = connection.userName || (connection.isDemo ? "demoUser" : "stech");
    connection.serverHost = connection.serverHost || "127.0.0.1:22222";
    connection.blankProject = !!connection.blankProject;
    connection.viewTitle = connection.blankProject
      ? "(No Project)"
      : connection.viewTitle || "Aggregates";
    connection.isDemo = !!connection.isDemo;
    connection.tease = !!connection.tease;
    connection.instant = !!connection.instant || connection.tease;
    connection.openOverviewId = connection.openOverviewId || null;
    activeConnection = connection;

    function afterOpen() {
      function signalReady() {
        if (typeof connection.onReady === "function") {
          try {
            connection.onReady();
          } catch (err) {
            /* ignore */
          }
        }
      }

      if (connection.tease && multiVisionShell) {
        multiVisionShell.classList.add("mv-shell--tease");
      } else if (multiVisionShell) {
        multiVisionShell.classList.remove("mv-shell--tease");
      }

      if (connection.openOverviewId) {
        openVesselOverview(connection.openOverviewId, signalReady);
      } else {
        signalReady();
      }

      if (connection.blankProject && !connection.tease) {
        window.dispatchEvent(new CustomEvent("install-guide:connected"));
      }
    }

    if (multiVisionLoading && !connection.instant) {
      return;
    }

    if (
      multiVisionShell &&
      !multiVisionShell.hidden &&
      !multiVisionShell.classList.contains("app-shell--minimized")
    ) {
      bringToFront(multiVisionShell);
      afterOpen();
      return;
    }

    if (connection.instant) {
      if (loadingTimer) {
        clearTimeout(loadingTimer);
        loadingTimer = null;
      }
      multiVisionLoading = false;
      if (multiVisionLoadingShell) {
        multiVisionLoadingShell.hidden = true;
        multiVisionLoadingShell.classList.add("app-shell--minimized");
      }
      showMultiVisionMain(connection);
      afterOpen();
      if (typeof window.closeVisionClient === "function") {
        window.closeVisionClient();
      }
      return;
    }

    multiVisionLoading = true;
    showMultiVisionLoading(connection);

    loadingTimer = window.setTimeout(function () {
      finishMultiVisionLaunch(connection);
      afterOpen();
    }, LOAD_MS);

    requestAnimationFrame(function () {
      if (typeof window.closeVisionClient === "function") {
        window.closeVisionClient();
      }
    });
  };

  window.closeMultiVision = closeMultiVision;
  window.setVesselFill = setVesselFill;
  // Guide: setVesselConnectionStatus("lime-stone", VESSEL_CONNECTION.OFFLINE) → grey strip LED
  window.VESSEL_CONNECTION = VESSEL_CONNECTION;
  window.setVesselConnectionStatus = setVesselConnectionStatus;
  window.is3DServerTrayActive = function () {
    return serverTrayActive;
  };

  window.mvGetVessels = function () {
    return VESSELS.slice();
  };
  window.mvGetSession = function () {
    return {
      userName: (activeConnection && activeConnection.userName) || "stech",
      serverHost: (activeConnection && activeConnection.serverHost) || "127.0.0.1:22222",
      viewTitle: (activeConnection && activeConnection.viewTitle) || "Aggregates",
      isDemo: !!(activeConnection && activeConnection.isDemo),
      blankProject: !!(activeConnection && activeConnection.blankProject),
    };
  };

  window.mvCreateProjectFromGuide = function (projectName, opts) {
    opts = opts || {};
    var name = (projectName || "New_Project").trim() || "New_Project";
    var siteName = (opts.siteName || "Site1").trim() || "Site1";
    var numVessels = Math.max(1, parseInt(opts.numVessels, 10) || 1);
    var numDevices = Math.max(1, parseInt(opts.numDevices, 10) || 1);
    var connType = opts.connType || "rs485";
    // USB↔RS-485 adapter COM (FTDI / SiLabs) — preferred first in real client.
    var serialPort = opts.serialPort || "COM3";

    VESSELS = [];
    for (var i = 0; i < numVessels; i++) {
      // Default calib matches wizard Full/Empty + Overview 3D center H=16:
      // emptyLevel=0, fullLevel=15.5, height=16. Level + Distance = height.
      var heightM = DEFAULT_VESSEL_HEIGHT;
      var emptyL = 0;
      var fullL = heightM - 0.5;
      var avgL = 12.0;
      var maxL = 13.1;
      var minL = 10.9;
      var levelPct = ((avgL - emptyL) / (fullL - emptyL)) * 100;
      var vessel = {
        id: "vessel-" + (i + 1),
        name: "Vessel" + (i + 1) + " (MV)",
        short: "Vessel" + (i + 1),
        poll: i,
        height: heightM,
        emptyLevel: emptyL,
        fullLevel: fullL,
        // Stored as LEVEL meters from vessel bottom (IsViewLevel true).
        avg: avgL,
        max: maxL,
        min: minL,
        // Volume % aligned with level % so home silo fill matches measurements.
        fill: Math.round(levelPct * 100) / 100,
        avgLevelPct: Math.round(levelPct * 100) / 100,
        color: "#8a5a28",
        colorLight: "#c4a06a",
        scannerName: "Scanner " + i,
        serial: "",
        hardware: "16",
        firmware: "2.9.986",
        deviceType: "MV",
        scadaId: i + 1,
        temp: 24.5,
        snr: 36.4,
        output: 4 + (levelPct / 100) * 16,
        connType: connType,
        serialPort: serialPort,
        numDevices: numDevices,
        connectionStatus: VESSEL_CONNECTION.ONLINE,
      };
      ensureVesselParams(vessel);
      VESSELS.push(vessel);
    }

    deviceConnType = connType === "tcp" ? "tcpip" : connType;
    selectedVesselId = VESSELS[0] ? VESSELS[0].id : null;

    if (activeConnection) {
      activeConnection.blankProject = false;
      activeConnection.viewTitle = name;
      activeConnection.siteName = siteName;
      if (mvTitleBar) {
        mvTitleBar.textContent = buildSessionTitle(activeConnection, true);
      }
    }
    var siteHome = document.getElementById("mvSiteHome");
    if (siteHome) {
      var label = siteHome.querySelector("span");
      if (label) {
        // Site strip truncates long names like real Aggregat → Site1
        label.textContent = siteName.length > 8 ? siteName.slice(0, 8) : siteName;
      }
    }
    var serialEl = document.getElementById("mvDevicesSerialPort");
    if (serialEl) {
      var hasOpt = false;
      for (var s = 0; s < serialEl.options.length; s++) {
        if (serialEl.options[s].value === serialPort || serialEl.options[s].text === serialPort) {
          serialEl.selectedIndex = s;
          hasOpt = true;
          break;
        }
      }
      if (!hasOpt) {
        var opt = document.createElement("option");
        opt.value = serialPort;
        opt.textContent = serialPort;
        serialEl.insertBefore(opt, serialEl.firstChild);
        serialEl.selectedIndex = 0;
      }
    }
    if (typeof syncDevicesConnTypeUi === "function") {
      try {
        syncDevicesConnTypeUi();
      } catch (err) {
        /* ignore */
      }
    }
    if (mvStatusText) {
      mvStatusText.textContent =
        "Scanners General Data retrieve: Completed " + formatStatusTimestamp();
    }
    if (mvVesselStrip && mvVesselStrip.parentElement) {
      mvVesselStrip.parentElement.hidden = false;
    }
    renderVessels();
    window.dispatchEvent(new CustomEvent("install-guide:project-created"));
  };
  window.mvSetStatusText = function (msg) {
    if (mvStatusText) {
      mvStatusText.textContent = msg || formatStatusStamp();
    }
  };
  window.mvRequestClose = function () {
    var exitOverlay = document.getElementById("exit-confirm-overlay");
    if (exitOverlay) {
      exitOverlay.hidden = false;
      return;
    }
    closeMultiVision();
  };
  window.mvConnectAll = function () {
    VESSELS.forEach(function (v) {
      v.connectionStatus = VESSEL_CONNECTION.ONLINE;
    });
    renderVessels();
    updateMvStatus();
    if (window.MvDialogs) window.MvDialogs.status("Connect All completed.");
  };
  window.mvDisconnectAll = function () {
    VESSELS.forEach(function (v) {
      v.connectionStatus = VESSEL_CONNECTION.OFFLINE;
    });
    renderVessels();
    updateMvStatus();
    if (window.MvDialogs) window.MvDialogs.status("Disconnect All completed.");
  };
  window.mvConnectSelected = function () {
    if (selectedVesselId) {
      setVesselConnectionStatus(selectedVesselId, VESSEL_CONNECTION.ONLINE);
    }
    if (window.MvDialogs) window.MvDialogs.status("Vessel connected.");
  };
  window.mvDisconnectSelected = function () {
    if (selectedVesselId) {
      setVesselConnectionStatus(selectedVesselId, VESSEL_CONNECTION.OFFLINE);
    }
    if (window.MvDialogs) window.MvDialogs.status("Vessel disconnected.");
  };
  window.mvOpenSelectedProperties = function () {
    if (selectedVesselId) {
      openPropertiesDialog(selectedVesselId);
    } else if (VESSELS[0]) {
      openPropertiesDialog(VESSELS[0].id);
    }
  };
  window.mvRefreshDisplay = function () {
    renderVessels();
    updateMvStatus();
    if (window.MvDialogs) window.MvDialogs.status("Display refreshed.");
  };
  window.mvSignOutToConnect = function () {
    closeMultiVision();
    if (typeof window.focusVisionClient === "function") {
      window.focusVisionClient();
    }
    var appShell = document.getElementById("appShell");
    if (appShell) {
      appShell.hidden = false;
      appShell.classList.remove("app-shell--minimized");
    }
  };
  window.mvIsScannerContext = function () {
    return currentMvView === "devices";
  };
  window.mvToggleDistanceLevel = function () {
    // MainToolBar.ToggleLevelDistance → flip IsViewLevel, refresh silo cards.
    isViewLevel = !isViewLevel;
    syncLevelDistanceChrome();
    renderVessels();
    if (vesselDetailMode && selectedVesselId) {
      var v = findVessel(selectedVesselId);
      if (v) {
        fillOverviewLeft(v);
      }
    }
    if (window.MvDialogs) {
      window.MvDialogs.status(
        isViewLevel
          ? "Display: Level (from vessel bottom)."
          : "Display: Distance / headspace (from device)."
      );
    }
  };

  wireDragFixed(multiVisionLoadingShell);
  wireDragFixed(multiVisionShell);
  wireTray();
  wireControls();
  syncLevelDistanceChrome();
  renderVessels();
})();
