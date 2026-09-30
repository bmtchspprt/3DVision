/**
 * Step-by-step Install & Setup guide for 3DInstallGuide fork.
 * Modes: Host (install + vessel/scanner setup) | Client (remote viewer) |
 * Already-installed vessel/scanner setup | How to Login | New Scanner | Free (demo silos).
 * Host flow: blank browser → downloads → Custom + Service install → project →
 * connect scanner → Device Wizard → Advanced Parameters → Overview tape compare.
 */
(function () {
  "use strict";

  var root;
  var modeMenu;
  var dim;
  var spot;
  var pointer;
  var card;
  var stepIndex = 0;
  var pollTimer = null;
  var rebootWatchTimer = null;
  var resizeBound = null;
  var guideTrack = "host"; // host | client | vessel | login | scanner | troubleshoot
  var addedVesselId = "";
  var tsSteps = [];
  var tsActiveId = "";

  var POINTER_SVG =
    '<svg viewBox="0 0 48 48" aria-hidden="true">' +
    '<path fill="#111" d="M12 4l2 30 7-5 6 12 5-2-6-12 10-1z"/>' +
    '<path fill="#fff" stroke="#111" stroke-width="1.5" d="M14 8l1.5 24 5.5-4 5.5 11 3.2-1.5-5.5-11 8-.8z"/>' +
    "</svg>";

  var WIZ_NEXT = "#installerWizardFooter .installer-wiz-btn--default";

  var EXAMPLE_HOST_IP = "192.168.1.28";
  /** Guide placement: how many scanners to search for (1–3). */
  var guideScannerPlan = { numScanners: 1, maxScanners: 1, label: "1 scanner" };
  var guideHasSweeper = false;
  var apTypingActive = null;
  var apTypingTarget = "";
  var AP_RATE_TARGET = "8";
  var AP_CAPACITY_TARGET = "100";

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
  }

  function buildTypingGhostHtml(typed, target) {
    var html = "";
    var i = 0;
    var matched = true;
    typed = String(typed || "");
    target = String(target || "");
    for (; i < typed.length && i < target.length; i++) {
      var want = target.charAt(i);
      var got = typed.charAt(i);
      if (matched && got === want) {
        html += '<span class="g-ok">' + escapeHtml(got) + "</span>";
      } else {
        matched = false;
        html += '<span class="g-bad">' + escapeHtml(got) + "</span>";
      }
    }
    for (; i < typed.length; i++) {
      html += '<span class="g-bad">' + escapeHtml(typed.charAt(i)) + "</span>";
    }
    if (typed.length < target.length) {
      html += '<span class="g-next">' + escapeHtml(target.charAt(typed.length)) + "</span>";
      if (typed.length + 1 < target.length) {
        html +=
          '<span class="g-rest">' + escapeHtml(target.slice(typed.length + 1)) + "</span>";
      }
    }
    if (!html && target.length) {
      html =
        '<span class="g-next">' +
        escapeHtml(target.charAt(0)) +
        "</span>" +
        '<span class="g-rest">' +
        escapeHtml(target.slice(1)) +
        "</span>";
    }
    return html;
  }

  function updateApTypingGhost() {
    if (!apTypingActive) return;
    var input = document.getElementById(apTypingActive);
    var ghost = document.getElementById(apTypingActive + "Ghost");
    if (!input || !ghost) return;
    ghost.innerHTML = buildTypingGhostHtml(input.value, apTypingTarget);
  }

  function setApFieldTypingCoach(fieldId, on, target) {
    var wrap = document.getElementById(fieldId + "Wrap");
    var input = document.getElementById(fieldId);
    var ghost = document.getElementById(fieldId + "Ghost");
    if (!on) {
      if (apTypingActive === fieldId) {
        apTypingActive = null;
        apTypingTarget = "";
      }
      if (wrap) wrap.classList.remove("is-typing");
      if (ghost) ghost.innerHTML = "";
      return;
    }
    apTypingActive = fieldId;
    apTypingTarget = String(target || "");
    if (wrap) wrap.classList.add("is-typing");
    if (input) {
      input.value = "";
      if (!input.__igApTyped) {
        input.__igApTyped = true;
        input.addEventListener("input", updateApTypingGhost);
      }
      try {
        input.focus();
        input.select();
      } catch (err) {
        /* ignore */
      }
    }
    updateApTypingGhost();
  }

  function clearAllApTypingCoaches() {
    ["mvApMaxCap", "mvApEmptyRate", "mvApFillRate", "mvApSlope", "mvApDamping", "mvWizFullDist"].forEach(function (id) {
      setApFieldTypingCoach(id, false);
    });
  }

  /**
   * Steepest vessel wall slope from cone/pyramid geometry (degrees from horizontal).
   * atan(height / radial_run) — used as recommended Steepest Material Slope.
   */
  function coneWallSlopeDeg(height, diamLarge, diamSmall) {
    var h = Math.abs(Number(height) || 0);
    var dL = Math.abs(Number(diamLarge) || 0);
    var dS = Math.abs(Number(diamSmall) || 0);
    var run = Math.abs(dL - dS) / 2;
    if (h < 1e-6 || run < 1e-6) return null;
    return (Math.atan(h / run) * 180) / Math.PI;
  }

  function recommendedSteepestMaterialSlope() {
    var wiz = document.getElementById("mv-dlg-device-wizard");
    function val(id) {
      var el = document.getElementById(id);
      return el ? parseFloat(el.value) : NaN;
    }
    var topShape = ((wiz && wiz.querySelector("#mvWizTopShape")) || {}).value || "cone";
    var botShape = ((wiz && wiz.querySelector("#mvWizBotShape")) || {}).value || "cone";
    var cenShape = ((wiz && wiz.querySelector("#mvWizCenShape")) || {}).value || "cylinder";
    var cenD =
      cenShape === "cube"
        ? Math.max(val("mvWizCenX") || 0, val("mvWizCenY") || 0)
        : val("mvWizCenD");
    if (isNaN(cenD) || cenD <= 0) cenD = 9;
    var candidates = [];
    if (topShape === "cone" || topShape === "pyramid") {
      var topH = val("mvWizTopH");
      var topD = topShape === "pyramid" ? val("mvWizTopX") : val("mvWizTopD");
      if (isNaN(topD)) topD = 0;
      var topSlope = coneWallSlopeDeg(topH, cenD, topD);
      if (topSlope != null) candidates.push(topSlope);
    }
    if (botShape === "cone" || botShape === "cone2" || botShape === "pyramid" || botShape === "pyramid2") {
      var botH = val("mvWizBotH");
      var botD =
        botShape === "pyramid" || botShape === "pyramid2" ? val("mvWizBotX") : val("mvWizBotD");
      if (isNaN(botD)) botD = 0;
      var botSlope = coneWallSlopeDeg(botH, cenD, botD);
      if (botSlope != null) candidates.push(botSlope);
    }
    var deg = 35;
    if (candidates.length) {
      deg = Math.max.apply(null, candidates);
    }
    deg = Math.round(deg);
    if (deg < 15) deg = 15;
    if (deg > 70) deg = 70;
    return deg;
  }

  var STEPS_THROUGH_USERS = [
    {
      id: "welcome",
      title: "Install 3D MultiVision",
      body: "This guide will show you how to install 3D as a Service. A blank browser will open. You will type the downloads address yourself.",
      blocking: true,
      primary: "Start",
      target: null,
    },
    {
      id: "type-url",
      title: "Open the downloads site",
      body:
        "Type the ghosted address in the bar. The next key is highlighted. When finished, press <strong>Enter</strong>.",
      target: "#browserUrlWrap",
      advanceOn: "install-guide:downloads-page",
      pointer: "bottom",
    },
    {
      id: "download-exe",
      title: "Download 3D LevelScanner Software",
      body: "On the downloads page, click <strong>3D LevelScanner Software</strong>.",
      target: "#browserDownloadBtn",
      advanceOn: "install-guide:downloaded",
      pointer: "right",
    },
    {
      id: "open-downloads",
      title: "Open Downloads",
      body: "Click the highlighted File Manager icon on the taskbar to open your Downloads folder.",
      target: "#taskbarBtnFileMgr",
      advanceOn: "install-guide:downloads-opened",
      pointer: "bottom",
    },
    {
      id: "run-exe",
      title: "Run the installer",
      body: "Double-click <code>BinMaster 3DVision_3.1.010.exe</code> (or right-click → Run as administrator).",
      target: "#downloadsFileTbody tr",
      advanceOn: "install-guide:uac-shown",
      pointer: "right",
    },
    {
      id: "uac-yes",
      title: "Allow the installer",
      body: "Click the highlighted <strong>Yes</strong> button on the User Account Control prompt.",
      target: "#uacYes",
      advanceOn: "install-guide:installer-started",
      pointer: "bottom",
    },
    {
      id: "lang-ok",
      title: "Choose language",
      body: "Click <strong>OK</strong> on the language dialog to open Setup.",
      target: "#installerLangOk",
      advanceOn: "install-guide:lang-ok",
      pointer: "bottom",
    },
    {
      id: "welcome-next",
      title: "Start Setup",
      body: "Click <strong>Next</strong> on the welcome page.",
      target: WIZ_NEXT,
      advanceOn: "install-guide:page-setupType",
      pointer: "bottom",
    },
    {
      id: "custom-install",
      title: "Choose Custom install",
      body: "Select <strong>Custom install</strong> (not Full), then click <strong>Next</strong>. Wrong choice will not continue.",
      getTarget: function () {
        var custom = document.getElementById("setupTypeCustom");
        if (custom && custom.checked) {
          return WIZ_NEXT;
        }
        return "#setupTypeCustom";
      },
      advanceOn: "install-guide:page-license",
      pointer: "right",
    },
    {
      id: "license-accept",
      title: "Accept the license",
      body: "Select <strong>I accept the terms of the License Agreement</strong>, then click <strong>Next</strong>.",
      getTarget: function () {
        var lic = document.getElementById("licenseAccept");
        if (lic && lic.checked) {
          return WIZ_NEXT;
        }
        return "#licenseAccept";
      },
      advanceOn: "install-guide:page-users",
      pointer: "right",
    },
    {
      id: "users-next",
      title: "Choose users",
      body: "Leave the default and click <strong>Next</strong>.",
      target: WIZ_NEXT,
      advanceOn: "install-guide:page-components",
      pointer: "bottom",
    },
  ];

  var HOST_SERVICE_STEPS = [
    {
      id: "components-next",
      title: "Choose components",
      body: "Keep <strong>Server app files</strong> checked, then click <strong>Next</strong>.",
      getTarget: function () {
        var server = document.getElementById("comp-server");
        if (server && server.checked) {
          return WIZ_NEXT;
        }
        return "#comp-server";
      },
      advanceOn: "install-guide:page-runAsService",
      pointer: "bottom",
    },
    {
      id: "service-install",
      title: "Install as a Service",
      body: "Select <strong>Install BinMaster 3DVision server as Service</strong> (not Application), then click <strong>Next</strong>. Wrong choice will not continue.",
      getTarget: function () {
        var svc = document.getElementById("runAsService");
        if (svc && svc.checked) {
          return WIZ_NEXT;
        }
        return "#runAsService";
      },
      advanceOn: "install-guide:page-serverLocalPath",
      pointer: "right",
    },
    {
      id: "server-browse",
      title: "Change the server data folder",
      body:
        "The default <code>C:\\Users\\UserProfile\\AppData\\Local</code> is not valid for a Service install. Click <strong>Browse...</strong>.",
      target: "#btnBrowseServer",
      advanceOn: "install-guide:browse-opened",
      pointer: "bottom",
    },
    {
      id: "browse-new-folder",
      title: "Create C:\\BinMaster",
      body: "Local Disk (C:) is selected. Click <strong>Make New Folder</strong> to create <code>C:\\BinMaster</code>.",
      target: "#browseFolderNew",
      advanceOn: "install-guide:browse-binmaster-named",
      pointer: "bottom",
    },
    {
      id: "browse-ok",
      title: "Confirm the folder",
      body: "With <code>C:\\BinMaster</code> selected, click <strong>OK</strong>.",
      target: "#browseFolderOk",
      advanceOn: "install-guide:browse-binmaster-ok",
      pointer: "bottom",
    },
    {
      id: "server-path-next",
      title: "Continue",
      body: "Server data folder is now <code>C:\\BinMaster</code>. Click <strong>Next</strong>.",
      target: WIZ_NEXT,
      advanceOn: "install-guide:page-installLocation",
      pointer: "bottom",
    },
  ];

  var CLIENT_COMPONENT_STEPS = [
    {
      id: "components-uncheck-server",
      title: "Client files only",
      body:
        "Click the <strong>check mark</strong> next to <strong>Server app files</strong> to uncheck it. Leave <strong>Client app files</strong> checked. This PC only needs the remote viewer.",
      getTarget: function () {
        var server = document.getElementById("comp-server");
        if (server && !server.checked) {
          return WIZ_NEXT;
        }
        return "#comp-server";
      },
      advanceOn: "install-guide:page-installLocation",
      pointer: "right",
    },
  ];

  var STEPS_INSTALL_FINISH = [
    {
      id: "install-loc-next",
      title: "Install location",
      body:
        "Leave the program files at the default <code>C:\\Program Files (x86)\\BinMaster 3DVision</code>. Click <strong>Next</strong>.",
      target: WIZ_NEXT,
      advanceOn: "install-guide:page-startMenu",
      pointer: "bottom",
    },
    {
      id: "install-btn",
      title: "Install",
      body: "Click <strong>Install</strong> to begin the install.",
      target: WIZ_NEXT,
      advanceOn: "install-guide:page-installing",
      pointer: "bottom",
    },
    {
      id: "installing-wait",
      title: "Installing",
      body: "Wait while Setup installs. Click <strong>Finish</strong> when the last page appears.",
      target: null,
      advanceOn: "install-guide:page-finish",
    },
    {
      id: "finish-btn",
      title: "Finish Setup",
      body: "Click <strong>Finish</strong> to close Setup.",
      target: WIZ_NEXT,
      advanceOn: "install-guide:install-complete",
      pointer: "bottom",
    },
  ];

  var STEPS_ADVANCED_START = [
    {
      id: "advanced-connection",
      title: "Choose Advanced Connection",
      body: "In the connection window, select the highlighted <strong>Advanced Connection</strong> option.",
      target: 'input[name="nav-view"][value="advanced"]',
      advanceOn: "install-guide:advanced-selected",
      pointer: "right",
    },
  ];

  var CLIENT_HOST_IP_STEPS = [
    {
      id: "edit-server",
      title: "Edit the server connection",
      body: "Click <strong>Edit...</strong> next to the server name.",
      target: "#btn-edit-server",
      advanceOn: "install-guide:server-config-opened",
      pointer: "bottom",
    },
    {
      id: "enter-host-ip",
      title: "Enter the Host IP",
      body:
        "The address box is the <strong>Host IP</strong> (the IP of the Host/Server computer, not this Client PC). " +
        "Type the ghosted address. The next key is highlighted. For this example: <code>" +
        EXAMPLE_HOST_IP +
        "</code>.",
      target: "#cfg-server-address-wrap",
      advanceOn: "install-guide:host-ip-ok",
      pointer: "none",
    },
    {
      id: "server-config-ok",
      title: "Save the Host IP",
      body: "Click <strong>OK</strong> to save the Host IP.",
      target: "#btn-config-ok",
      advanceOn: "install-guide:server-config-saved",
      pointer: "bottom",
    },
  ];

  var STEPS_LOGIN_CONNECT = [
    {
      id: "enter-username",
      title: "Enter user name",
      body:
        "Type the ghosted user name. The next key is highlighted. For this guide: <code>stech</code>.",
      target: "#user-name-wrap",
      advanceOn: "install-guide:username-ok",
      pointer: "right",
    },
    {
      id: "enter-password",
      title: "Enter password",
      body:
        "Type the ghosted password. The next key is highlighted. For this guide: <code>techS</code> (capital S).",
      target: "#password-wrap",
      advanceOn: "install-guide:password-ok",
      pointer: "right",
    },
    {
      id: "click-connect",
      title: "Connect",
      body: "Credentials look correct. Click <strong>Connect</strong>.",
      target: "#btn-connect",
      advanceOn: "install-guide:connected",
      pointer: "bottom",
    },
  ];

  var HOST_PROJECT_STEPS = [
    {
      id: "blank-project",
      title: "Start page",
      body: "3D MultiVision opened with no project. Click the highlighted <strong>New Project</strong> card.",
      target: "#mvStartNewProject",
      advanceOn: "install-guide:new-project-opened",
      pointer: "right",
    },
    {
      id: "project-general",
      title: "Name your project",
      body: "Enter a project name (default <code>New_Project</code>), then click <strong>Next &gt;</strong>.",
      getTarget: function () {
        var name = document.getElementById("mvProjName");
        if (name && name.value.trim() && !name.disabled) {
          return "#mvProjWizNext";
        }
        return "#mvProjName";
      },
      advanceOn: "install-guide:project-general-next",
      pointer: "right",
    },
    {
      id: "project-finish",
      title: "Finish project creation",
      body: "Keep defaults (1 vessel, RS-485 on COM3 for USB↔485), then click <strong>Finish</strong>. The vessel starts disconnected until you connect it from Devices.",
      target: "#mvProjWizNext",
      advanceOn: "install-guide:project-created",
      pointer: "bottom",
    },
    {
      id: "open-vessel1",
      title: "Open Vessel1",
      body: "Click the <strong>Vessel1</strong> silo icon in the vessel strip to open it.",
      getTarget: function () {
        var chip = document.querySelector(
          '#mvVesselStrip .mv-vessel-chip[data-vessel-id="vessel-1"]'
        );
        if (chip) return '#mvVesselStrip .mv-vessel-chip[data-vessel-id="vessel-1"]';
        var panel = document.querySelector(
          '#mvVesselsGrid .mv-vessel-panel[data-vessel-id="vessel-1"]'
        );
        if (panel) return '#mvVesselsGrid .mv-vessel-panel[data-vessel-id="vessel-1"]';
        return "#mvVesselStrip .mv-vessel-chip";
      },
      advanceOn: "install-guide:vessel-opened",
      pointer: "bottom",
    },
    {
      id: "open-devices-tab",
      title: "Open Devices",
      body: "Open the <strong>Devices</strong> tab to configure how this vessel’s scanner talks to the PC.",
      target: '.mv-tab[data-mv-view="devices"]',
      advanceOn: "install-guide:devices-tab",
      pointer: "bottom",
    },
    {
      id: "devices-connection-type",
      title: "Connection Type",
      body: "Connection Type is how the <strong>sensors connect to this PC</strong>: <strong>RS-485</strong> (USB adapter on a COM port) or <strong>TCP/IP</strong> over the network.",
      target: "#mvDevicesConnTypes",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "devices-polling-address",
      title: "Polling Address",
      body: "The default polling address for a scanner is <strong>0</strong>. It is configured on the scanner display screen. Each scanner on the same network needs a unique address.",
      target: "#mvDevicesPollCombo",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "devices-connect",
      title: "Connect the scanner",
      body: "Click the blue <strong>Connect</strong> button next to the polling address to start communication with the sensor.",
      target: "#mvDevicesConnectBtn",
      advanceOn: "install-guide:vessel-connected",
      pointer: "bottom",
    },
  ];

  function cloneSteps(list) {
    return list.map(function (step) {
      var copy = {};
      Object.keys(step).forEach(function (key) {
        copy[key] = step[key];
      });
      return copy;
    });
  }

  var VESSEL_CORE_STEPS = [
    {
      id: "open-device-menu",
      phase: "setup",
      title: "Open Device",
      body: "Click <strong>Device</strong> on the menu bar.",
      target: "#mv-menu-device",
      advanceOn: "install-guide:device-menu-open",
      pointer: "bottom",
    },
    {
      id: "open-device-wizard",
      phase: "setup",
      title: "Device Configuration Wizard",
      body: "Click <strong>Device Configuration Wizard...</strong> to open the setup wizard.",
      target: '[data-mv-menu-id="dev-wizard"]',
      advanceOn: "install-guide:device-wizard-opened",
      pointer: "right",
    },
    {
      id: "wiz-units-intro",
      phase: "setup",
      title: "Units",
      body: "Under General, set Distance and Temperature to match your site.",
      target: "#mvWizDist",
      blocking: true,
      primary: "Continue",
      pointer: "right",
    },
    {
      id: "wiz-set-feet",
      phase: "setup",
      title: "Distance in feet",
      body: "Change <strong>Distance</strong> from m to <strong>ft</strong>.",
      target: "#mvWizDist",
      advanceOn: "install-guide:wiz-feet",
      pointer: "right",
    },
    {
      id: "wiz-set-fahrenheit",
      phase: "setup",
      title: "Temperature in Fahrenheit",
      body: "Change <strong>Temperature</strong> to <strong>Fahrenheit</strong>.",
      target: "#mvWizTemp",
      advanceOn: "install-guide:wiz-fahrenheit",
      pointer: "right",
    },
    {
      id: "wiz-dim-intro",
      phase: "setup",
      title: "Vessel Dimension",
      body: "Vessel Dimension has three parts: <strong>Top</strong>, <strong>Center</strong>, and <strong>Bottom</strong>. Use your own vessel measurements.",
      target: ".mv-wiz-dim-title",
      blocking: true,
      primary: "Continue",
      pointer: "right",
    },
    {
      id: "wiz-top-shapes",
      phase: "setup",
      title: "Top Shape",
      body: "<strong>Flat</strong>, <strong>Cone</strong>, or <strong>Dome</strong> — choose the Top Shape for your vessel.",
      target: "#mvWizTopShape",
      blocking: true,
      primary: "Continue",
      allowInside: "#mv-dlg-device-wizard",
      pointer: "right",
    },
    {
      id: "wiz-center-explain",
      phase: "setup",
      title: "Center Shape",
      body: "Center is usually a <strong>Cylinder</strong>. Height and Diameter are the key measurements.",
      target: "#mvWizCenShape",
      blocking: true,
      primary: "Continue",
      allowInside: "#mv-dlg-device-wizard",
      pointer: "right",
    },
    {
      id: "wiz-enter-center",
      phase: "setup",
      title: "Enter center size",
      body: "Enter your vessel’s <strong>Height</strong> and <strong>Diameter</strong> in feet. Use real site measurements.",
      target: "#mvWizCenH",
      blocking: true,
      primary: "Continue",
      allowInside: "#mv-dlg-device-wizard",
      pointer: "right",
    },
    {
      id: "wiz-bottom-explain",
      phase: "setup",
      title: "Bottom Shape",
      body: "<strong>Flat</strong>, <strong>Cone</strong> (hopper), or <strong>Dome</strong>. Cone is common on grain silos.",
      target: "#mvWizBotShape",
      blocking: true,
      primary: "Continue",
      pointer: "right",
    },
    {
      id: "wiz-enter-bottom",
      phase: "setup",
      title: "Enter bottom size",
      body: "Set Bottom Shape and Height to match your vessel. Adjust Diameter if needed.",
      target: "#mvWizBotH",
      blocking: true,
      primary: "Continue",
      allowInside: "#mv-dlg-device-wizard",
      pointer: "right",
    },
    {
      id: "wiz-next-page2",
      phase: "setup",
      title: "Go to Device Position",
      body: "Click <strong>Next</strong> to open Device Position (page 2).",
      target: "#mvWizNext",
      advanceOn: "install-guide:wiz-step-2",
      pointer: "bottom",
    },
    {
      id: "wiz-page2-default",
      phase: "setup",
      title: "Default placement",
      body: "The scanner starts at center (<strong>0, 0</strong>) and <strong>180°</strong>. That is the default — not the recommended mount.",
      target: "#mvWizDeviceTable",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "wiz-scanner-count",
      phase: "setup",
      title: "How many scanners?",
      body: "Choose how many scanners you will mount on this vessel.",
      // No external target — choices live in the coach card.
      target: null,
      advanceOn: "install-guide:scanner-count",
      allowInside: "#igCard, #igScannerCount",
      pointer: "none",
    },
    {
      id: "wiz-placement-explain",
      phase: "setup",
      title: "Recommended placement",
      body: "Click <strong>Calculate</strong> to run recommended placement. A progress bar shows how far along it is.",
      // Primary lives on the coach card — do not spotlight/place relative to it.
      target: null,
      blocking: true,
      primary: "Calculate",
      pointer: "none",
    },
    {
      id: "wiz-placement-done",
      phase: "setup",
      title: "Scanners placed",
      body: "Recommended <strong>X</strong> and <strong>Y</strong> are applied for each scanner. <strong>Z</strong> and <strong>Angle</strong> update so each unit sits on the roof and aims toward center.",
      target: "#mvWizDeviceTable",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "wiz-next-fill",
      phase: "setup",
      title: "Filling Points",
      body: "Click <strong>Next</strong> to open Filling Points.",
      target: "#mvWizNext",
      advanceOn: "install-guide:wiz-step-3",
      pointer: "bottom",
    },
    {
      id: "wiz-fill-explain",
      phase: "setup",
      title: "What is a filling point?",
      body: "A filling point is where material enters the vessel. Mark the chute so the model knows the fill stream.",
      target: "#mvWizFillTable",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "wiz-fill-add",
      phase: "setup",
      title: "Add a filling point",
      body: "Click <strong>Add</strong>. Leave X and Y at 0 for a center chute, or enter the real location.",
      target: "#mvWizFillAdd",
      advanceOn: "install-guide:wiz-fill-added",
      pointer: "bottom",
    },
    {
      id: "wiz-next-calib",
      phase: "setup",
      title: "Full / Empty Calibration",
      body: "Click <strong>Next</strong> to set Full and Empty levels.",
      target: "#mvWizNext",
      advanceOn: "install-guide:wiz-step-4",
      pointer: "bottom",
    },
    {
      id: "wiz-full-empty-explain",
      phase: "setup",
      title: "Full and Empty points",
      body: "<strong>Full</strong> is 100% from the vessel bottom. <strong>Empty</strong> is 0%. Distance from the top updates automatically.",
      target: ".mv-wiz-calib-table",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "wiz-sweeper-ask",
      phase: "setup",
      title: "Sweeper",
      body:
        "Does this vessel have a sweeper?" +
        '<div class="ig-scanner-count" id="igSweeperChoice">' +
        '<button type="button" class="ig-btn" data-sweeper="yes">Yes</button>' +
        '<button type="button" class="ig-btn" data-sweeper="no">No</button>' +
        "</div>",
      target: null,
      advanceOn: "install-guide:sweeper-choice",
      allowInside: "#igCard, #igSweeperChoice",
      pointer: "none",
    },
    {
      id: "wiz-sweeper-note",
      phase: "setup",
      title: "Empty point with a sweeper",
      body: "If the scanner locks onto the sweeper, raise the <strong>Empty</strong> point above the sweep path.",
      target: "#mvWizEmptyLevel",
      blocking: true,
      primary: "Continue",
      allowInside: "#mv-dlg-device-wizard",
      pointer: "right",
    },
    {
      id: "wiz-finish",
      phase: "setup",
      title: "Upload the configuration",
      body: "Click <strong>Finish</strong> to upload the vessel and scanner settings.",
      target: "#mvWizNext",
      advanceOn: "install-guide:wiz-uploaded",
      pointer: "bottom",
    },
    {
      id: "ov-after-upload",
      phase: "setup",
      title: "Overview after upload",
      body: "Overview now shows the vessel with the new geometry. Confirm the silo looks right before Advanced Parameters.",
      target: "#mvOverview",
      blocking: true,
      primary: "Continue",
      pointer: "none",
    },
    {
      id: "ap-intro",
      phase: "setup",
      title: "Advanced Parameters",
      body: "Next, open Advanced Parameters to set capacity, rates, and beam options.",
      blocking: true,
      primary: "Continue",
      target: null,
    },
    {
      id: "ap-device-menu",
      phase: "setup",
      title: "Open Device again",
      body: "Click <strong>Device</strong> on the menu bar.",
      target: "#mv-menu-device",
      advanceOn: "install-guide:device-menu-open",
      pointer: "bottom",
    },
    {
      id: "ap-open",
      phase: "setup",
      title: "Advanced Parameters",
      body: "Click <strong>Advanced Parameters...</strong>.",
      target: '[data-mv-menu-id="dev-advanced"]',
      advanceOn: "install-guide:advanced-params-opened",
      pointer: "right",
    },
    {
      id: "ap-max-capacity",
      phase: "setup",
      title: "Max Capacity",
      body: "Type the ghosted value for <strong>Max. Capacity</strong>: <code>100</code>. Always use 100 for this guide.",
      target: "#mvApMaxCap",
      advanceOn: "install-guide:ap-capacity-100",
      allowInside: "#mv-dlg-advanced-params",
      pointer: "right",
    },
    {
      id: "ap-empty-rate",
      phase: "setup",
      title: "Max Emptying Rate",
      body: "Type the ghosted <strong>Max. Emptying Rate</strong>: <code>8</code> (typical install value between 7 and 10).",
      target: "#mvApEmptyRate",
      advanceOn: "install-guide:ap-empty-rate-ok",
      allowInside: "#mv-dlg-advanced-params",
      pointer: "right",
    },
    {
      id: "ap-fill-rate",
      phase: "setup",
      title: "Max Filling Rate",
      body: "Type the ghosted <strong>Max. Filling Rate</strong>: <code>8</code> (typical install value between 7 and 10).",
      target: "#mvApFillRate",
      advanceOn: "install-guide:ap-fill-rate-ok",
      allowInside: "#mv-dlg-advanced-params",
      pointer: "right",
    },
    {
      id: "ap-vessel-slope",
      phase: "setup",
      title: "Steepest Material Slope",
      body: "PLACEHOLDER_SLOPE",
      target: "#mvApSlopeWrap, #mvApSlope",
      advanceOn: "install-guide:ap-slope-ok",
      allowInside: "#mv-dlg-advanced-params",
      pointer: "right",
    },
    {
      id: "ap-click-advanced-tab",
      phase: "setup",
      title: "Open Advanced tab",
      body: "Click the <strong>Advanced</strong> tab.",
      target: '.mv-ap-tab[data-tab="adv"]',
      advanceOn: "install-guide:ap-tab-adv",
      pointer: "bottom",
    },
    {
      id: "ap-angle-adaptor",
      phase: "setup",
      title: "Angle Adaptor",
      body: "<strong>Angle Adaptor</strong> is the holder tilt in degrees. Use 0 unless the mount is angled.",
      target: "#mvApAngleAdaptor",
      blocking: true,
      primary: "Continue",
      allowInside: "#mv-dlg-advanced-params",
      pointer: "right",
    },
    {
      id: "ap-false-echoes",
      phase: "setup",
      title: "Auto False Echoes",
      body: "Set <strong>Auto False Echoes</strong> to <strong>Disable</strong>.",
      target: "#mvApAutoFalseEchoes",
      advanceOn: "install-guide:ap-auto-false-off",
      pointer: "right",
    },
    {
      id: "ap-click-beams-tab",
      phase: "setup",
      title: "Beams Activation",
      body: "Click the <strong>Beams Activation</strong> tab.",
      target: '.mv-ap-tab[data-tab="beams"]',
      advanceOn: "install-guide:ap-tab-beams",
      pointer: "bottom",
    },
    {
      id: "ap-uncheck-beam-sel",
      phase: "setup",
      title: "Auto Beam Selection",
      body: "Uncheck <strong>Auto Beam Selection</strong>.",
      target: "#mvApAutoBeamSel",
      advanceOn: "install-guide:ap-beam-sel-off",
      pointer: "right",
    },
    {
      id: "ap-uncheck-beam-range",
      phase: "setup",
      title: "Automatic Beams Range",
      body: "Uncheck <strong>Automatic Beams Range</strong>.",
      target: "#mvApAutoBeamRange",
      advanceOn: "install-guide:ap-beam-range-off",
      pointer: "right",
    },
    {
      id: "ap-upload",
      phase: "setup",
      title: "Upload All",
      body: "Click <strong>Upload All</strong> to send Advanced Parameters to the scanner.",
      target: "#mvApUploadAll",
      advanceOn: "install-guide:ap-uploaded",
      pointer: "bottom",
    },
    {
      id: "ap-close",
      phase: "setup",
      title: "Close Advanced Parameters",
      body: "Click <strong>Close</strong> at the bottom of Advanced Parameters. The guide stays here until that window is actually closed.",
      target: "#mvApClose",
      advanceOn: "install-guide:ap-closed",
      allowInside: "#mvApClose, #mv-dlg-advanced-params .title-btn.close, #mv-dlg-advanced-params",
      pointer: "bottom",
    },
    {
      id: "ov-show-level",
      phase: "setup",
      title: "Overview — Level",
      body: "Overview starts in <strong>Level</strong> view (from the vessel bottom). Note the average level reading.",
      target: "#mvOvAvgLabel",
      blocking: true,
      primary: "Continue",
      allowInside: "#mvOverview",
      pointer: "right",
    },
    {
      id: "ov-switch-distance",
      phase: "setup",
      title: "Switch to Distance",
      body: "Click <strong>Distance</strong> on the toolbar to show headspace distance from the scanner.",
      target: "#mvBtnLevelDistance",
      advanceOn: "install-guide:view-distance",
      pointer: "bottom",
    },
    {
      id: "ov-compare-tape",
      phase: "setup",
      title: "Compare to a tape measure",
      body: "Compare Avg. Dist to a physical tape or laser from the scanner. A <strong>3–5 ft</strong> difference is expected — the scanner calculates volume across many points, not a single spot. Click Finish when done.",
      target: "#mvOvAvg",
      blocking: true,
      primary: "Finish",
      allowInside: "#mvOverview",
      pointer: "right",
    },
  ];

  var HOST_SETUP_BRIDGE = [
    {
      id: "host-setup-bridge",
      phase: "setup",
      title: "Next: Vessel / Scanner Setup",
      body: "The scanner is connected. Next you will configure vessel dimensions, scanner placement, and advanced parameters.",
      blocking: true,
      primary: "Continue",
      target: null,
    },
  ];

  var VESSEL_STEPS = [
    {
      id: "vessel-welcome",
      phase: "setup",
      title: "Vessel / Scanner Setup",
      body: "This guide configures a vessel and scanner. MultiVision opens with the sensor already connected.",
      blocking: true,
      primary: "Start",
      target: null,
    },
  ].concat(cloneSteps(VESSEL_CORE_STEPS));

  function buildLoginSteps() {
    var steps = [
      {
        id: "login-open",
        title: "Open 3D MultiVision",
        body: "Click <strong>3DVision</strong> on the taskbar. The connection window is where you sign in.",
        target: "#taskbarBtnVision",
        advanceOn: "install-guide:vision-client-opened",
        pointer: "right",
      },
    ].concat(
      cloneSteps(STEPS_ADVANCED_START),
      cloneSteps(CLIENT_HOST_IP_STEPS),
      cloneSteps(STEPS_LOGIN_CONNECT)
    );
    var connectBtn = steps.filter(function (s) {
      return s.id === "click-connect";
    })[0];
    if (connectBtn) {
      connectBtn.body =
        "Click <strong>Connect</strong>. Wait while the Host project opens.";
    }
    steps.push({
      id: "login-in-project",
      title: "You're in the project",
      body: "The Host project is open. You are signed in as a viewer, and the silo is on screen. Click <strong>Finish</strong>.",
      blocking: true,
      primary: "Finish",
      target: "#mvVesselsGrid",
      allowInside: "#multiVisionShell",
      pointer: "bottom",
    });
    return steps;
  }

  function buildScannerSteps() {
    var devices = cloneSteps(
      HOST_PROJECT_STEPS.filter(function (s) {
        return (
          s.id === "open-devices-tab" ||
          s.id === "devices-connection-type" ||
          s.id === "devices-connect"
        );
      })
    );
    var withPoll = [];
    devices.forEach(function (step) {
      withPoll.push(step);
      if (step.id === "devices-connection-type") {
        withPoll.push({
          id: "scan-poll",
          title: "Polling address",
          body: "Each scanner on this project needs its own address. This new one already has the next free number. Leave it. Address <strong>0</strong> belongs to a scanner that is already here.",
          target: "#mvDevicesPollCombo",
          blocking: true,
          primary: "Continue",
          pointer: "none",
        });
      }
    });
    return [
      {
        id: "scanner-welcome",
        phase: "setup",
        title: "Add a scanner",
        body: "This project already has silos. You will add one more, connect its scanner, then set it up from the defaults.",
        blocking: true,
        primary: "Start",
        target: null,
      },
      {
        id: "scan-edit",
        phase: "setup",
        title: "Open Edit",
        body: "Click <strong>Edit</strong> on the menu bar.",
        target: "#mv-menu-edit",
        advanceOn: "install-guide:edit-menu-open",
        pointer: "bottom",
      },
      {
        id: "scan-add",
        phase: "setup",
        title: "Open Add",
        body: "Click <strong>Add</strong>.",
        target: '[data-mv-menu-id="edit-add"]',
        advanceOn: "install-guide:edit-add-open",
        pointer: "right",
      },
      {
        id: "scan-vessel",
        phase: "setup",
        title: "Add a vessel",
        body: "Click <strong>Vessel</strong> to add a silo to this project.",
        target: '[data-mv-menu-id="edit-add-vessel"]',
        advanceOn: "install-guide:add-vessel-opened",
        pointer: "right",
      },
      {
        id: "scan-finish",
        phase: "setup",
        title: "Finish the new silo",
        body: "This silo starts at the project defaults: one scanner, and the same connection as the site. Click <strong>Finish</strong>.",
        target: "#mvProjWizNext",
        advanceOn: "install-guide:vessel-added",
        pointer: "bottom",
      },
      {
        id: "scan-open",
        phase: "setup",
        title: "Open the new silo",
        body: "Click the new silo to open it. It stays offline until you connect the scanner.",
        getTarget: function () {
          if (!addedVesselId) return "#mvVesselsGrid .mv-vessel-panel";
          return (
            '#mvVesselStrip .mv-vessel-chip[data-vessel-id="' +
            addedVesselId +
            '"], #mvVesselsGrid .mv-vessel-panel[data-vessel-id="' +
            addedVesselId +
            '"]'
          );
        },
        advanceOn: "install-guide:vessel-opened",
        pointer: "bottom",
      },
    ].concat(withPoll, cloneSteps(VESSEL_CORE_STEPS));
  }

  var LOGIN_STEPS = buildLoginSteps();
  var SCANNER_STEPS = buildScannerSteps();

  function buildHostSteps() {
    var steps = [].concat(
      cloneSteps(STEPS_THROUGH_USERS),
      cloneSteps(HOST_SERVICE_STEPS),
      cloneSteps(STEPS_INSTALL_FINISH),
      cloneSteps(STEPS_ADVANCED_START),
      cloneSteps(STEPS_LOGIN_CONNECT),
      cloneSteps(HOST_PROJECT_STEPS),
      cloneSteps(HOST_SETUP_BRIDGE),
      cloneSteps(VESSEL_CORE_STEPS)
    );
    steps[0].title = "Install & Setup — Host PC";
    steps[0].body =
      "This guide installs 3D as a Service on the Host PC, then walks through vessel and scanner setup. A blank browser will open. Type the downloads address yourself.";
    var installBtn = steps.filter(function (s) {
      return s.id === "install-btn";
    })[0];
    if (installBtn) {
      installBtn.body = "Click <strong>Install</strong> to begin the service install.";
    }
    return steps;
  }

  function buildClientSteps() {
    var steps = [].concat(
      cloneSteps(STEPS_THROUGH_USERS),
      cloneSteps(CLIENT_COMPONENT_STEPS),
      cloneSteps(STEPS_INSTALL_FINISH),
      cloneSteps(STEPS_ADVANCED_START),
      cloneSteps(CLIENT_HOST_IP_STEPS),
      cloneSteps(STEPS_LOGIN_CONNECT)
    );
    steps[0].title = "Install the Client viewer";
    steps[0].body =
      "This guide installs the Client (remote viewer) on a second PC. You will uncheck Server files, then point Advanced Connection at the Host IP. A blank browser will open. Type the downloads address yourself.";
    var installBtn = steps.filter(function (s) {
      return s.id === "install-btn";
    })[0];
    if (installBtn) {
      installBtn.body = "Click <strong>Install</strong> to begin the client install.";
    }
    var connectBtn = steps.filter(function (s) {
      return s.id === "click-connect";
    })[0];
    if (connectBtn) {
      connectBtn.body =
        "Click <strong>Connect</strong>. You join the Host project as a viewer. The silo is already connected on the Host. Clients cannot connect scanners.";
    }
    return steps;
  }

  var HOST_STEPS = buildHostSteps();
  var CLIENT_STEPS = buildClientSteps();

  function getSteps() {
    if (guideTrack === "client") return CLIENT_STEPS;
    if (guideTrack === "login") return LOGIN_STEPS;
    if (guideTrack === "vessel") return VESSEL_STEPS;
    if (guideTrack === "scanner") return SCANNER_STEPS;
    if (guideTrack === "troubleshoot") return tsSteps;
    return HOST_STEPS;
  }

  function ensureDom() {
    if (root) return;
    root = document.createElement("div");
    root.className = "ig-root";
    root.id = "installGuideRoot";
    root.innerHTML =
      '<div class="ig-mode-menu" id="igModeMenu">' +
      '<div class="ig-mode-panel ig-mode-panel--setup" id="igModeMain">' +
      '<button type="button" class="ig-welcome-ts" id="igWelcomeTs" aria-label="Troubleshooting">' +
      '<img class="ig-welcome-ts-icon" src="assets/ui/troubleshoot-alert.png" alt="" width="42" height="42" draggable="false">' +
      '<span class="ig-welcome-ts-label">Troubleshooting</span>' +
      "</button>" +
      '<h1 class="ig-welcome-title">' +
      '<span class="ig-welcome-line">Welcome to the</span>' +
      '<span class="ig-welcome-line ig-welcome-line--accent">3D MultiVision Setup Guide</span>' +
      "</h1>" +
      '<p class="ig-welcome-tagline">Choose how this PC is set up. Host installs the service and the vessel. Client joins that host.</p>' +
      '<div class="ig-mode-list">' +
      '<button type="button" class="ig-mode-option" data-mode="host">' +
      '<span class="ig-mode-option-title">Host PC — Install + Vessel Setup</span>' +
      '<span class="ig-mode-option-sub">Install as a Service, connect the scanner, then configure the vessel.</span>' +
      "</button>" +
      '<button type="button" class="ig-mode-option" data-mode="client">' +
      '<span class="ig-mode-option-title">Client PC — Remote Viewer</span>' +
      '<span class="ig-mode-option-sub">Install the client on a second PC and join the Host project.</span>' +
      "</button>" +
      '<button type="button" class="ig-mode-option ig-mode-option--secondary" data-mode="vessel">' +
      '<span class="ig-mode-option-title">Already installed — Vessel/Scanner Setup</span>' +
      '<span class="ig-mode-option-sub">Skip the install. Configure vessel dimensions, placement, and advanced parameters.</span>' +
      "</button>" +
      '<button type="button" class="ig-mode-option ig-mode-option--secondary" data-mode="login">' +
      '<span class="ig-mode-option-title">How to Login</span>' +
      '<span class="ig-mode-option-sub">Open 3D, choose Advanced Connection, enter the Host IP, and sign in.</span>' +
      "</button>" +
      '<button type="button" class="ig-mode-option ig-mode-option--secondary" data-mode="scanner">' +
      '<span class="ig-mode-option-title">New Scanner?</span>' +
      '<span class="ig-mode-option-sub">Add a silo to a project that is already there, then set it up from the defaults.</span>' +
      "</button>" +
      "</div>" +
      '<button type="button" class="ig-mode-free" data-mode="free">Free mode (installed, Demo silos)</button>' +
      "</div></div>" +
      '<div class="ig-ts-panel" id="igTsPanel" hidden>' +
      '<div class="ig-ts-hdr">' +
      '<img class="ig-ts-hdr-ico" src="assets/ui/troubleshoot-alert.png" alt="" width="22" height="22">' +
      '<span class="ig-ts-hdr-title">Troubleshooting</span>' +
      '<button type="button" class="ig-ts-hbtn" id="igTsMin" aria-label="Minimize">−</button>' +
      "</div>" +
      '<div class="ig-ts-body" id="igTsBody"></div>' +
      '<button type="button" class="ig-ts-home" id="igTsHome">Back to setup menu</button>' +
      "</div>" +
      '<div class="ig-dim" aria-hidden="true"></div>' +
      '<div class="ig-spotlight ig-pulse" id="igSpotlight" hidden></div>' +
      '<div class="ig-pointer" id="igPointer" hidden>' +
      POINTER_SVG +
      "</div>" +
      '<div class="ig-card" id="igCard" role="dialog" aria-live="polite" hidden>' +
      '<div class="ig-card-kicker" id="igKicker">Install guide</div>' +
      '<h2 class="ig-card-title" id="igTitle"></h2>' +
      '<div class="ig-card-body" id="igBody"></div>' +
      '<div class="ig-card-actions">' +
      '<button type="button" class="ig-btn ig-btn--primary" id="igPrimary" hidden>Continue</button>' +
      "</div>" +
      '<div class="ig-card-progress">' +
      '<div class="ig-progress-track" aria-hidden="true">' +
      '<div class="ig-progress-fill" id="igProgressFill"></div></div>' +
      '<span class="ig-progress" id="igProgress"></span>' +
      "</div></div>" +
      '<div class="ig-place-overlay" id="igPlaceOverlay" hidden>' +
      '<div class="ig-place-panel" role="status" aria-live="polite">' +
      '<div class="ig-place-title">Calculating placement</div>' +
      '<div class="ig-place-stage" id="igPlaceStage">Starting…</div>' +
      '<div class="ig-place-track" aria-hidden="true">' +
      '<div class="ig-place-fill" id="igPlaceFill"></div></div>' +
      '<div class="ig-place-meta">' +
      '<span class="ig-place-pct" id="igPlacePct">0%</span>' +
      '<span class="ig-place-eta" id="igPlaceEta">Estimating time…</span>' +
      "</div></div></div>" +
      '<div class="ig-end" id="igEndScreen" hidden>' +
      '<div class="ig-end-inner">' +
      '<div class="ig-end-mark" id="igEndMark">' +
      '<div class="ig-end-rings" aria-hidden="true">' +
      '<span class="ig-end-ring"></span>' +
      '<span class="ig-end-ring"></span>' +
      '<span class="ig-end-ring"></span>' +
      "</div>" +
      '<div class="ig-end-badge">' +
      '<svg class="ig-end-check" viewBox="0 0 32 32" aria-hidden="true">' +
      '<path class="ig-end-check-path" d="M8 17 L14 23 L24 11"/>' +
      "</svg></div></div>" +
      '<p class="ig-end-kicker" id="igEndKicker">Install guide</p>' +
      '<h1 class="ig-end-title" id="igEndTitle">You\'re done</h1>' +
      '<p class="ig-end-body" id="igEndBody"></p>' +
      '<p class="ig-end-note" id="igEndAlert" role="status"></p>' +
      '<div class="ig-end-recap" id="igEndRecap" hidden>' +
      '<p class="ig-end-recap-heading">Recap</p>' +
      '<ol class="ig-end-recap-list" id="igEndRecapList"></ol>' +
      "</div>" +
      '<div class="ig-end-actions">' +
      '<button type="button" class="ig-end-btn ig-end-btn--ghost" id="igEndRecapBtn">View recap</button>' +
      '<button type="button" class="ig-end-btn ig-end-btn--ghost" id="igEndReplay">Replay guide</button>' +
      '<button type="button" class="ig-end-btn ig-end-btn--primary" id="igEndClose">Close guide</button>' +
      "</div></div></div>";
    document.body.appendChild(root);
    modeMenu = document.getElementById("igModeMenu");
    dim = root.querySelector(".ig-dim");
    spot = document.getElementById("igSpotlight");
    pointer = document.getElementById("igPointer");
    card = document.getElementById("igCard");
    document.getElementById("igPrimary").addEventListener("click", onPrimary);
    document.getElementById("igEndClose").addEventListener("click", onEndClose);
    document.getElementById("igEndRecapBtn").addEventListener("click", onEndRecapToggle);
    card.addEventListener("click", onScannerCountClick);
    card.addEventListener("click", function (e) {
      var swBtn = e.target.closest ? e.target.closest("[data-sweeper]") : null;
      if (!swBtn || !card.contains(swBtn)) return;
      var step = currentStep();
      if (!step || step.id !== "wiz-sweeper-ask") return;
      e.preventDefault();
      e.stopPropagation();
      guideHasSweeper = swBtn.getAttribute("data-sweeper") === "yes";
      window.dispatchEvent(new CustomEvent("install-guide:sweeper-choice"));
    });
    var replayBtn = document.getElementById("igEndReplay");
    if (replayBtn) {
      replayBtn.addEventListener("click", function (e) {
        e.preventDefault();
        e.stopPropagation();
        restartCurrentTrack();
      });
    }
    // Event delegation: reliable even when clicking the inner label span
    modeMenu.addEventListener("click", function (e) {
      var tsHome = e.target.closest ? e.target.closest("#igWelcomeTs") : null;
      if (tsHome && modeMenu.contains(tsHome)) {
        e.preventDefault();
        e.stopPropagation();
        enterTroubleshootMode();
        return;
      }
      var modeBtn = e.target.closest ? e.target.closest("[data-mode]") : null;
      if (modeBtn && modeMenu.contains(modeBtn)) {
        e.preventDefault();
        e.stopPropagation();
        onModeChosen(modeBtn.getAttribute("data-mode"));
      }
    });
    var tsPanel = document.getElementById("igTsPanel");
    var tsBody = document.getElementById("igTsBody");
    if (tsBody && window.IgTroubleshooting && typeof window.IgTroubleshooting.listHtml === "function") {
      tsBody.innerHTML = window.IgTroubleshooting.listHtml();
    }
    if (tsPanel) {
      tsPanel.addEventListener("click", function (e) {
        var minBtn = e.target.closest ? e.target.closest("#igTsMin") : null;
        if (minBtn) {
          e.preventDefault();
          tsPanel.classList.toggle("is-mini");
          minBtn.textContent = tsPanel.classList.contains("is-mini") ? "+" : "−";
          return;
        }
        var homeBtn = e.target.closest ? e.target.closest("#igTsHome") : null;
        if (homeBtn) {
          e.preventDefault();
          leaveTroubleshootMode();
          return;
        }
        var itemBtn = e.target.closest ? e.target.closest("[data-ts-id]") : null;
        if (itemBtn && tsPanel.contains(itemBtn)) {
          e.preventDefault();
          startTroubleshootItem(itemBtn.getAttribute("data-ts-id"));
        }
      });
    }
  }

  function showModeMain() {
    var main = document.getElementById("igModeMain");
    if (main) main.hidden = false;
  }

  function hideInstallTips() {
    /* tips removed from single-panel mode menu */
  }

  function toggleInstallInfo() {
    /* no-op — info tips removed */
  }

  function currentStep() {
    var steps = getSteps();
    return steps[stepIndex] || null;
  }

  function onScannerCountClick(e) {
    var scBtn = e.target && e.target.closest ? e.target.closest("[data-scanners]") : null;
    if (!scBtn) return;
    var step = currentStep();
    if (!step || step.id !== "wiz-scanner-count") return;
    e.preventDefault();
    e.stopPropagation();
    var n = parseInt(scBtn.getAttribute("data-scanners"), 10) || 1;
    if (n < 1) n = 1;
    if (n > 3) n = 3;
    guideScannerPlan = {
      numScanners: n,
      maxScanners: n,
      label: n + " scanner" + (n > 1 ? "s" : ""),
    };
    window.dispatchEvent(new CustomEvent("install-guide:scanner-count"));
  }

  function openBlankBrowser() {
    if (typeof window.resetBrowserForGuide === "function") {
      window.resetBrowserForGuide();
    }
    if (typeof window.openBrowser === "function") {
      window.openBrowser({ blank: true, typingCoach: true });
    } else if (typeof window.setBrowserUrlTypingCoach === "function") {
      window.setBrowserUrlTypingCoach(true);
    }
  }

  function ensureDeviceConfigConnectionView() {
    if (typeof window.setConnectionNavView === "function") {
      window.setConnectionNavView("device-config");
      return;
    }
    var device = document.querySelector('input[name="nav-view"][value="device-config"]');
    var adv = document.querySelector('input[name="nav-view"][value="advanced"]');
    var demo = document.querySelector('input[name="nav-view"][value="demo"]');
    if (device) device.checked = true;
    if (adv) adv.checked = false;
    if (demo) demo.checked = false;
    document.querySelectorAll(".view-panel").forEach(function (panel) {
      panel.classList.toggle("active", panel.id === "view-device-config");
    });
  }

  function ensureOverviewVisible() {
    var ov = document.getElementById("mvOverview");
    if (ov && !ov.hidden && ov.offsetParent !== null) return;
    var tab = document.querySelector('.mv-tab[data-mv-view="overview"]');
    if (tab) {
      try {
        tab.click();
      } catch (err) {
        /* ignore */
      }
    }
  }

  function isAdvancedConnectionViewActive() {
    var adv = document.querySelector('input[name="nav-view"][value="advanced"]');
    var panel = document.getElementById("view-advanced");
    return !!(adv && adv.checked && panel && panel.classList.contains("active"));
  }

  function setGuiding(on) {
    document.body.classList.toggle("ig-guiding", !!on);
  }

  function setTrackClass() {
    document.body.classList.remove(
      "ig-track-host",
      "ig-track-client",
      "ig-track-vessel",
      "ig-track-troubleshoot",
      "ig-track-login",
      "ig-track-scanner"
    );
    if (guideTrack === "login") {
      document.body.classList.add("ig-track-client", "ig-track-login");
    } else if (guideTrack === "client") {
      document.body.classList.add("ig-track-client");
    } else if (guideTrack === "scanner") {
      document.body.classList.add("ig-track-scanner");
    } else if (guideTrack === "vessel") {
      document.body.classList.add("ig-track-vessel");
    } else if (guideTrack === "troubleshoot") {
      document.body.classList.add("ig-track-troubleshoot");
    } else {
      document.body.classList.add("ig-track-host");
    }
  }

  function deviceWizardNavKind(el) {
    if (!el || !el.closest) return null;
    if (el.closest("#mvWizNext")) return "next";
    if (el.closest("#mvWizBack")) return "back";
    if (el.closest('#mv-dlg-device-wizard [data-mv-dlg-close]')) return "cancel";
    return null;
  }

  function deviceWizardNavAllowed(kind) {
    if (!kind) return false;
    var step = currentStep();
    if (!step) return false;
    var t = stepTarget(step);
    if (kind === "next") return t === "#mvWizNext";
    if (kind === "back") return t === "#mvWizBack";
    return false;
  }

  function queryGuideTarget(selector) {
    if (!selector) return null;
    var parts = String(selector).split(",");
    var i;
    var s;
    var el;
    for (i = 0; i < parts.length; i++) {
      s = parts[i].trim();
      if (!s) continue;
      try {
        el = document.querySelector(s);
      } catch (err) {
        el = null;
      }
      if (el) return el;
    }
    return null;
  }

  function clickHitsSelector(e, selector) {
    if (!selector || !e.target || !e.target.closest) return false;
    var parts = String(selector).split(",");
    var i;
    var s;
    var nodes;
    var j;
    var el;
    var label;
    var forLab;
    for (i = 0; i < parts.length; i++) {
      s = parts[i].trim();
      if (!s) continue;
      try {
        nodes = document.querySelectorAll(s);
      } catch (err) {
        continue;
      }
      for (j = 0; j < nodes.length; j++) {
        el = nodes[j];
        if (el === e.target || (el.contains && el.contains(e.target))) return true;
        label = el.closest && el.closest("label");
        if (label && label.contains(e.target)) return true;
        if (el.id) {
          forLab = document.querySelector('label[for="' + el.id + '"]');
          if (forLab && forLab.contains(e.target)) return true;
        }
      }
    }
    return false;
  }

  function isClickAllowed(e) {
    // End screen is modal until Close (even after guiding stops)
    var end = document.getElementById("igEndScreen");
    if (end && !end.hidden) {
      return !!(e.target.closest && e.target.closest("#igEndScreen"));
    }
    if (e.target.closest && e.target.closest("#igTsPanel, #igWelcomeTs")) return true;
    if (!document.body.classList.contains("ig-guiding")) return true;
    // Install-type picker handles its own clicks
    if (modeMenu && !modeMenu.hidden && !modeMenu.classList.contains("ig-mode-menu--hidden")) {
      return !!(e.target.closest && e.target.closest("#igModeMenu"));
    }
    if (e.target.closest && e.target.closest("#igCard, .ig-card, #igPrimary")) return true;
    if (e.target.closest && e.target.closest("[data-scanners], [data-sweeper], #igScannerCount, #igSweeperChoice")) {
      return true;
    }
    if (e.target.closest && e.target.closest("#igBootCurtain")) return true;

    var step = currentStep();
    if (!step) return false;

    var wizNav = deviceWizardNavKind(e.target);
    if (wizNav && !deviceWizardNavAllowed(wizNav)) return false;

    if (
      step.allowInside &&
      e.target.closest &&
      e.target.closest(step.allowInside)
    ) {
      return true;
    }
    if (step.blocking) {
      return false;
    }

    var sel = stepTarget(step);
    if (!sel) return false;

    if (clickHitsSelector(e, sel)) return true;

    // Device menu: only the item this step is asking for.
    if (
      (step.id === "ap-open" ||
        step.id === "ts-device-menu" ||
        step.id === "ts-device-item") &&
      e.target.closest &&
      e.target.closest("#mv-popup-device, #mv-menu-device")
    ) {
      return true;
    }
    if (
      step.id === "open-device-wizard" &&
      e.target.closest &&
      e.target.closest('[data-mv-menu-id="dev-wizard"]')
    ) {
      return true;
    }

    if (step.id === "scan-edit" && e.target.closest && e.target.closest("#mv-menu-edit")) {
      return true;
    }
    if (
      step.id === "scan-add" &&
      e.target.closest &&
      e.target.closest('[data-mv-menu-id="edit-add"]')
    ) {
      return true;
    }
    if (
      step.id === "scan-vessel" &&
      e.target.closest &&
      e.target.closest('[data-mv-menu-id="edit-add-vessel"]')
    ) {
      return true;
    }

    // Host: allow Vessel1 strip icon / home silo for open-vessel1
    if (
      step.id === "open-vessel1" &&
      e.target.closest &&
      e.target.closest(
        '#mvVesselStrip .mv-vessel-chip[data-vessel-id="vessel-1"], #mvVesselsGrid .mv-vessel-panel[data-vessel-id="vessel-1"]'
      )
    ) {
      return true;
    }

    // Components: allow the Server checkbox hit target (label wraps only the box)
    if (
      (step.id === "components-uncheck-server" || step.id === "components-next") &&
      e.target.closest &&
      e.target.closest("#comp-server, label.installer-comp-check[for='comp-server']")
    ) {
      return true;
    }

    // Merged choice+Next: allow the radio group while choosing
    if (step.id === "custom-install" && e.target.closest && e.target.closest("#setupTypeCustom, label[for='setupTypeCustom']")) {
      return true;
    }
    if (step.id === "service-install" && e.target.closest && e.target.closest("#runAsService, label[for='runAsService']")) {
      return true;
    }
    if (step.id === "license-accept" && e.target.closest && e.target.closest("#licenseAccept, label[for='licenseAccept']")) {
      return true;
    }
    if (step.id === "type-url" && e.target.closest && e.target.closest("#browserUrlWrap, #browserUrl")) {
      return true;
    }
    if (
      step.id === "enter-username" &&
      e.target.closest &&
      e.target.closest("#user-name-wrap, #user-name")
    ) {
      return true;
    }
    if (
      step.id === "enter-password" &&
      e.target.closest &&
      e.target.closest("#password-wrap, #password")
    ) {
      return true;
    }
    if (
      (step.id === "enter-host-ip" || step.id === "server-config-ok") &&
      e.target.closest &&
      e.target.closest("#server-config-overlay")
    ) {
      if (
        step.id === "enter-host-ip" &&
        e.target.closest("#cfg-server-address-wrap, #cfg-server-address")
      ) {
        return true;
      }
      if (step.id === "server-config-ok" && e.target.closest("#btn-config-ok")) return true;
    }

    // Vessel AP: capacity / rate / slope fields + close
    if (
      (step.id === "ap-max-capacity" ||
        step.id === "ap-empty-rate" ||
        step.id === "ap-fill-rate" ||
        step.id === "ap-vessel-slope") &&
      e.target.closest &&
      e.target.closest(
        "#mvApMaxCap, #mvApEmptyRate, #mvApFillRate, #mvApSlope, #mvApMaxCapWrap, #mvApEmptyRateWrap, #mvApFillRateWrap, #mvApSlopeWrap, #mv-dlg-advanced-params"
      )
    ) {
      return true;
    }
    if (
      step.id === "ap-close" &&
      e.target.closest &&
      e.target.closest(
        '#mvApClose, #mv-dlg-advanced-params [data-mv-dlg-close="mv-dlg-advanced-params"]'
      )
    ) {
      return true;
    }
    if (
      (step.id === "wiz-scanner-count" || step.id === "wiz-sweeper-ask") &&
      e.target.closest &&
      e.target.closest("#igScannerCount, #igSweeperChoice, #igCard")
    ) {
      return true;
    }

    // Vessel AP: allow checkbox label hit targets
    if (
      (step.id === "ap-uncheck-beam-sel" || step.id === "ap-uncheck-beam-range") &&
      e.target.closest &&
      e.target.closest("#mvApAutoBeamSel, #mvApAutoBeamRange, label.mv-ap-check")
    ) {
      return true;
    }
    if (
      step.id === "ap-false-echoes" &&
      e.target.closest &&
      e.target.closest("#mvApAutoFalseEchoes, #mvApAutoFalseEchoesMenu")
    ) {
      return true;
    }

    // Overview Level / Distance / tape compare
    if (
      step.id === "ov-switch-distance" &&
      e.target.closest &&
      e.target.closest("#mvBtnLevelDistance")
    ) {
      return true;
    }
    if (
      (step.id === "ov-show-level" ||
        step.id === "ov-compare-tape" ||
        step.id === "ov-after-upload") &&
      e.target.closest &&
      e.target.closest("#mvOverview, #mvOvAvg, #mvOvAvgLabel")
    ) {
      return true;
    }

    // Allow progress dialog during wizard / AP upload
    if (
      (step.id === "wiz-finish" ||
        step.id === "ap-upload" ||
        step.id === "ts-snr-upload" ||
        step.id === "ts-beam-upload" ||
        step.id === "ts-ap-upload" ||
        step.id === "ts-full-finish" ||
        step.id === "ts-dz-finish" ||
        step.id === "ts-load-vessel") &&
      e.target.closest &&
      e.target.closest("#mv-dlg-progress")
    ) {
      return true;
    }

    return false;
  }

  function guideKeyGuard(e) {
    if (!document.body.classList.contains("ig-guiding")) return;
    if (e.key !== "Enter" && e.key !== " ") return;
    var el = e.target;
    var wizNav = deviceWizardNavKind(el) || deviceWizardNavKind(document.activeElement);
    if (wizNav && !deviceWizardNavAllowed(wizNav)) {
      e.preventDefault();
      e.stopPropagation();
      e.stopImmediatePropagation();
      if (card) {
        card.classList.remove("ig-card--deny");
        void card.offsetWidth;
        card.classList.add("ig-card--deny");
      }
    }
  }

  function guideInteractionGuard(e) {
    if (isClickAllowed(e)) return;
    e.preventDefault();
    e.stopPropagation();
    e.stopImmediatePropagation();
    if (card) {
      card.classList.remove("ig-card--deny");
      // reflow for re-trigger
      void card.offsetWidth;
      card.classList.add("ig-card--deny");
    }
  }

  function onPrimary() {
    var step = currentStep();
    if (!step) return;
    if (guideTrack === "troubleshoot") {
      if (step.id === "ts-cap-open") {
        var captureTab = window.open(
          "https://support.binmaster.com/kb/view/637b3236-68d8-4e7c-ba5b-d4b7308225b5",
          "_blank"
        );
        if (captureTab) {
          try {
            captureTab.opener = null;
          } catch (err) {
            /* ignore */
          }
        }
        goNext();
        return;
      }
      var tsList = getSteps();
      if (step.id === "ts-done" || stepIndex >= tsList.length - 1) {
        finishTsWalkthrough();
        return;
      }
    }
    if (step.id === "welcome") {
      openBlankBrowser();
      goNext();
      return;
    }
    if (step.id === "vessel-welcome" || step.id === "scanner-welcome") {
      goNext();
      return;
    }
    if (step.id === "login-in-project") {
      showEndScreen();
      return;
    }
    if (step.id === "wiz-placement-explain") {
      var btn = document.getElementById("igPrimary");
      if (btn) {
        btn.disabled = true;
        btn.textContent = "Calculating…";
      }
      showPlacementProgress(true);
      // Let the overlay paint before starting heavy work.
      window.requestAnimationFrame(function () {
        window.requestAnimationFrame(function () {
          applyVesselRecommendedPlacement()
            .then(function () {
              finishPlacementProgress(100);
              window.setTimeout(function () {
                showPlacementProgress(false);
                if (btn) {
                  btn.disabled = false;
                  btn.textContent = step.primary || "Continue";
                }
                goNext();
              }, 280);
            })
            .catch(function (err) {
              if (btn) {
                btn.disabled = false;
                btn.textContent = step.primary || "Calculate";
              }
              if (err && err.cancelled) {
                showPlacementProgress(false);
                return;
              }
              console.warn("Placement calculate failed", err);
              var stageEl = document.getElementById("igPlaceStage");
              var etaEl = document.getElementById("igPlaceEta");
              if (stageEl) {
                stageEl.textContent =
                  "Locator search failed. Click Calculate to try again.";
              }
              if (etaEl) etaEl.textContent = (err && err.message) || "Error";
            });
        });
      });
      return;
    }
    if (step.id === "ov-compare-tape") {
      showEndScreen();
      return;
    }
    if (step.id === "done") {
      endGuide();
      return;
    }
    if (step.blocking) {
      goNext();
    }
  }

  var placeProgressState = null;

  function formatEta(ms) {
    if (!isFinite(ms) || ms < 0) return "Estimating time…";
    var sec = Math.round(ms / 1000);
    if (sec < 5) return "Less than 5 seconds left";
    if (sec < 60) return "About " + sec + " seconds left";
    var min = Math.floor(sec / 60);
    var rem = sec % 60;
    if (min < 3 && rem > 0) return "About " + min + " min " + rem + " sec left";
    if (min === 1) return "About 1 minute left";
    return "About " + min + " minutes left";
  }

  function showPlacementProgress(on) {
    var el = document.getElementById("igPlaceOverlay");
    if (!el) return;
    if (placeProgressState && placeProgressState.tickTimer) {
      clearInterval(placeProgressState.tickTimer);
    }
    if (!on) {
      el.hidden = true;
      placeProgressState = null;
      return;
    }
    placeProgressState = {
      start: Date.now(),
      lastOverall: 0,
      lastPaint: 0,
      displayed: 0,
      tickTimer: null,
    };
    el.hidden = false;
    var stage = document.getElementById("igPlaceStage");
    var fill = document.getElementById("igPlaceFill");
    var pct = document.getElementById("igPlacePct");
    var eta = document.getElementById("igPlaceEta");
    if (stage) stage.textContent = "Locator error estimation…";
    if (fill) fill.style.width = "0%";
    if (pct) pct.textContent = "0%";
    if (eta) eta.textContent = "This can take a while for 2–3 scanners";
  }

  function finishPlacementProgress(pctVal) {
    if (!placeProgressState) return;
    if (placeProgressState.tickTimer) {
      clearInterval(placeProgressState.tickTimer);
      placeProgressState.tickTimer = null;
    }
    paintPlacementProgress(1, {
      stage: 1,
      maxStages: 1,
      current: 1,
      total: 1,
      done: true,
    });
    var fill = document.getElementById("igPlaceFill");
    var pctEl = document.getElementById("igPlacePct");
    var stageEl = document.getElementById("igPlaceStage");
    var etaEl = document.getElementById("igPlaceEta");
    if (fill) fill.style.width = (pctVal != null ? pctVal : 100) + "%";
    if (pctEl) pctEl.textContent = (pctVal != null ? pctVal : 100) + "%";
    if (stageEl) stageEl.textContent = "Placement found";
    if (etaEl) etaEl.textContent = "Done";
  }

  function paintPlacementProgress(overall, p) {
    if (!placeProgressState) return;
    p = p || {};
    var now = Date.now();
    if (!p.done && !p.soft && now - placeProgressState.lastPaint < 80 && overall < 0.99) {
      return;
    }
    placeProgressState.lastPaint = now;
    if (overall < placeProgressState.lastOverall && !p.soft) {
      overall = placeProgressState.lastOverall;
    }
    if (overall < placeProgressState.displayed && p.soft) {
      return;
    }
    placeProgressState.lastOverall = Math.max(placeProgressState.lastOverall, overall);
    placeProgressState.displayed = Math.max(placeProgressState.displayed, overall);
    var pctVal = Math.max(0, Math.min(p.done ? 100 : 99, Math.round(placeProgressState.displayed * 100)));

    var stageEl = document.getElementById("igPlaceStage");
    var fill = document.getElementById("igPlaceFill");
    var pctEl = document.getElementById("igPlacePct");
    var etaEl = document.getElementById("igPlaceEta");
    var stageN = p.stage || 1;
    var maxStages = p.maxStages || 1;
    var stagePct = p.total > 0 ? Math.min(100, Math.round((100 * (p.current || 0)) / p.total)) : pctVal;
    if (stageEl && !p.soft) {
      stageEl.textContent =
        "Locator error estimation — " +
        stageN +
        " scanner" +
        (stageN > 1 ? "s" : "") +
        (maxStages > 1 ? " (pass " + stageN + " of " + maxStages + ")" : "") +
        " — " +
        stagePct +
        "%";
    }
    if (fill) fill.style.width = pctVal + "%";
    if (pctEl) pctEl.textContent = pctVal + "%";
    if (etaEl && !p.done) {
      var elapsed = now - placeProgressState.start;
      if (placeProgressState.displayed < 0.04 || elapsed < 1200) {
        etaEl.textContent = "Estimating time…";
      } else {
        var etaMs = elapsed / placeProgressState.displayed - elapsed;
        etaEl.textContent = formatEta(etaMs);
      }
    }
  }

  function updatePlacementProgress(p) {
    if (!placeProgressState) return;
    var overall = typeof p.overall === "number" ? p.overall : 0;
    if (!(overall > 0) && p.total > 0) {
      overall = (p.current || 0) / p.total;
    }
    if (!(overall > 0) && typeof p.current === "number" && p.current > 0) {
      // Worker may report current before total settles — show motion.
      overall = Math.min(0.9, placeProgressState.displayed + 0.01);
    }
    paintPlacementProgress(overall, p);
  }

  function maxSupportedScannersForGuide() {
    var wiz = document.getElementById("mv-dlg-device-wizard");
    if (wiz && typeof wiz.__mvWizMaxSupportedScanners === "function") {
      var n = wiz.__mvWizMaxSupportedScanners();
      if (n >= 3) return 3;
      if (n >= 2) return 2;
      return 1;
    }
    return 1;
  }

  function scannerCountStepBody() {
    var maxN = 3;
    try {
      maxN = maxSupportedScannersForGuide();
    } catch (err) {
      maxN = 3;
    }
    if (!(maxN >= 1)) maxN = 1;
    if (maxN > 3) maxN = 3;
    var html =
      "Choose how many scanners you will mount on this vessel. The guide runs placement Calculate for that count.";
    if (maxN <= 1) {
      html +=
        " This vessel only has a legal mount ring for <strong>1 scanner</strong> (keep off the fill point and walls, and keep units apart).";
    } else {
      html += " This vessel can host up to <strong>" + maxN + " scanners</strong>.";
    }
    html += '<div class="ig-scanner-count" id="igScannerCount">';
    html += '<button type="button" class="ig-btn" data-scanners="1">1 scanner</button>';
    if (maxN >= 2) {
      html += '<button type="button" class="ig-btn" data-scanners="2">2 scanners</button>';
    }
    if (maxN >= 3) {
      html += '<button type="button" class="ig-btn" data-scanners="3">3 scanners</button>';
    }
    html += "</div>";
    return html;
  }

  function applyVesselRecommendedPlacement() {
    var wiz = document.getElementById("mv-dlg-device-wizard");
    if (wiz && typeof wiz.__mvWizApplyRecommendedPlacement === "function") {
      return wiz.__mvWizApplyRecommendedPlacement({
        numScanners: guideScannerPlan.numScanners,
        maxScanners: guideScannerPlan.maxScanners,
        onProgress: updatePlacementProgress,
      });
    }
    return Promise.resolve(null);
  }

  function markInstalledUi() {
    document.body.classList.add("ig-installed");
    var desktopIcon = document.getElementById("desktopVisionIcon");
    var taskbarBtn = document.getElementById("taskbarBtnVision");
    if (desktopIcon) desktopIcon.hidden = false;
    if (taskbarBtn) taskbarBtn.hidden = false;
  }

  function stopTeaseBackground() {
    document.body.classList.remove("ig-tease");
    if (typeof window.closeMultiVision === "function") {
      window.closeMultiVision();
    }
  }

  function finishBootReveal() {
    if (document.body.classList.contains("ig-boot-ready")) return;
    window.requestAnimationFrame(function () {
      window.requestAnimationFrame(function () {
        document.documentElement.classList.remove("ig-preload");
        document.body.classList.remove("ig-boot-pending");
        document.body.classList.add("ig-boot-ready");
        var curtain = document.getElementById("igBootCurtain");
        if (curtain) {
          curtain.classList.add("ig-boot-curtain--out");
          window.setTimeout(function () {
            curtain.hidden = true;
          }, 600);
        }
      });
    });
  }

  function startTeaseBackground(onReady) {
    document.body.classList.add("ig-tease");
    var readyFired = false;
    function done() {
      if (readyFired) return;
      readyFired = true;
      if (typeof onReady === "function") onReady();
    }
    // Safety: never leave users stuck on the boot curtain
    window.setTimeout(done, 2500);
    if (typeof window.openMultiVisionFromConnect !== "function") {
      done();
      return;
    }
    window.openMultiVisionFromConnect({
      userName: "demoUser",
      serverHost: "127.0.0.1:22222",
      viewTitle: "Aggregates",
      isDemo: true,
      blankProject: false,
      tease: true,
      instant: true,
      openOverviewId: "lime-stone",
      onReady: done,
    });
  }

  function enterFreeMode() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    hideModeMenu();
    setGuiding(false);
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    clearHighlight();
    if (root) root.hidden = true;
    document.body.classList.remove("ig-mode", "ig-tease");
    document.body.classList.add("ig-free-mode");
    markInstalledUi();
    hideTsPanel();
    if (typeof window.openMultiVisionFromConnect === "function") {
      window.openMultiVisionFromConnect({
        userName: "demoUser",
        serverHost: "127.0.0.1:22222",
        viewTitle: "Aggregates",
        isDemo: true,
        blankProject: false,
        openOverviewId: "lime-stone",
        instant: true,
      });
    }
    window.dispatchEvent(new CustomEvent("install-guide:free-mode"));
  }

  function setupMenuVisible() {
    return !!(
      modeMenu &&
      !modeMenu.hidden &&
      !modeMenu.classList.contains("ig-mode-menu--hidden")
    );
  }

  function syncTsHome() {
    var home = document.getElementById("igTsHome");
    if (!home) return;
    home.hidden = setupMenuVisible();
  }

  function hideTsPanel() {
    var panel = document.getElementById("igTsPanel");
    if (panel) {
      panel.hidden = true;
      panel.classList.remove("is-mini");
      var minBtn = document.getElementById("igTsMin");
      if (minBtn) minBtn.textContent = "−";
    }
    tsActiveId = "";
    tsSteps = [];
    document.body.classList.remove("ig-ts-mode");
    var items = document.querySelectorAll(".ig-ts-item.is-active");
    items.forEach(function (el) {
      el.classList.remove("is-active");
    });
  }

  function placeTsPanel() {
    var panel = document.getElementById("igTsPanel");
    if (!panel) return;
    var win = document.querySelector("#multiVisionShell .mv-window");
    if (!win) return;
    var rect = win.getBoundingClientRect();
    if (!rect.width || !rect.height) return;
    var top = Math.round(rect.top + rect.height * 0.097);
    var height = Math.round(rect.height * 0.846);
    var wrap = document.querySelector(".page-wrap");
    var wrapRight = wrap ? wrap.getBoundingClientRect().right : rect.right + rect.width * 0.107;
    var edge = 16;
    var room = window.innerWidth - edge - wrapRight;
    var width = Math.round(Math.min(rect.width * 0.351, Math.max(room, 0)));
    var left = Math.round(wrapRight);
    if (width < 220) {
      width = Math.min(268, Math.round(rect.width * 0.28));
      left = Math.round(Math.max(rect.right + 12, window.innerWidth - edge - width));
    }
    if (left + width > window.innerWidth - edge) {
      width = Math.max(180, window.innerWidth - edge - left);
    }
    if (top + height > window.innerHeight - 8) {
      height = Math.max(180, window.innerHeight - 8 - top);
    }
    panel.style.top = top + "px";
    panel.style.left = left + "px";
    panel.style.right = "auto";
    panel.style.width = width + "px";
    panel.style.height = height + "px";
    panel.style.maxHeight = height + "px";
  }

  function showTsPanel() {
    var panel = document.getElementById("igTsPanel");
    if (!panel) return;
    var body = document.getElementById("igTsBody");
    if (body && window.IgTroubleshooting && !body.childElementCount) {
      body.innerHTML = window.IgTroubleshooting.listHtml();
    }
    panel.hidden = false;
    document.body.classList.add("ig-ts-mode");
    if (root) root.hidden = false;
    syncTsHome();
    placeTsPanel();
  }

  function activateTsApp() {
    document.body.classList.remove("ig-mode", "ig-tease");
    document.body.classList.add("ig-free-mode");
    markInstalledUi();
    if (typeof window.mvSetDisplayUnits === "function") {
      window.mvSetDisplayUnits({ distance: "ft", temperature: "F" });
    }
    if (typeof window.openMultiVisionFromConnect === "function") {
      window.openMultiVisionFromConnect({
        userName: "demoUser",
        serverHost: "127.0.0.1:22222",
        viewTitle: "Aggregates",
        isDemo: true,
        blankProject: false,
        openOverviewId: "lime-stone",
        instant: true,
      });
    }
  }

  function applyTsSnrScene(id) {
    if (typeof window.mvSetGuideLowSnr === "function") {
      window.mvSetGuideLowSnr(id === "snr-zero");
    }
  }

  function finishTsWalkthrough() {
    setGuiding(false);
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    clearHighlight();
    clearPoll();
    if (rebootWatchTimer) {
      clearTimeout(rebootWatchTimer);
      rebootWatchTimer = null;
    }
    tsSteps = [];
    stepIndex = 0;
    var items = document.querySelectorAll(".ig-ts-item.is-active");
    items.forEach(function (el) {
      el.classList.remove("is-active");
    });
    tsActiveId = "";
    applyTsSnrScene("");
    showTsPanel();
    if (typeof window.MvDialogs === "object" && window.MvDialogs.closeAll) {
      window.MvDialogs.closeAll();
    }
    if (typeof window.hidePowerSettings === "function") {
      window.hidePowerSettings();
    }
    if (typeof window.closeStartMenu === "function") {
      window.closeStartMenu();
    }
  }

  function enterTroubleshootMode() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    hideModeMenu();
    setGuiding(false);
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    clearHighlight();
    guideTrack = "troubleshoot";
    setTrackClass();
    showTsPanel();
    activateTsApp();
  }

  function leaveTroubleshootMode() {
    finishTsWalkthrough();
    hideTsPanel();
    if (typeof window.MvDialogs === "object" && window.MvDialogs.closeAll) {
      window.MvDialogs.closeAll();
    }
    document.body.classList.remove("ig-free-mode");
    document.body.classList.add("ig-mode");
    guideTrack = "host";
    setTrackClass();
    showModeMenu();
  }

  function startTroubleshootItem(id) {
    var api = window.IgTroubleshooting;
    if (!api) return;
    var item = api.find(id);
    if (!item) return;
    if (typeof window.MvDialogs === "object" && window.MvDialogs.closeAll) {
      window.MvDialogs.closeAll();
    }
    tsActiveId = id;
    tsSteps = api.buildSteps(item) || [];
    document.querySelectorAll(".ig-ts-item").forEach(function (el) {
      el.classList.toggle("is-active", el.getAttribute("data-ts-id") === id);
    });
    if (!tsSteps.length) return;
    applyTsSnrScene(id);
    if (id === "snr-zero") {
      ensureOverviewVisible();
    }
    guideTrack = "troubleshoot";
    setTrackClass();
    hideModeMenu();
    activateTsApp();
    showTsPanel();
    if (root) root.hidden = false;
    setGuiding(true);
    stepIndex = 0;
    resetCardDock();
    wireResize();
    renderStep();
  }

  function hideModeMenu() {
    if (!modeMenu) return;
    modeMenu.hidden = true;
    modeMenu.classList.add("ig-mode-menu--hidden");
    modeMenu.setAttribute("aria-hidden", "true");
    syncTsHome();
  }

  function revealModeMenu() {
    if (!modeMenu) return;
    modeMenu.hidden = false;
    modeMenu.classList.remove("ig-mode-menu--hidden");
    modeMenu.setAttribute("aria-hidden", "false");
    syncTsHome();
  }

  function enterVesselMode() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    guideTrack = "vessel";
    setTrackClass();
    hideModeMenu();
    hideTsPanel();
    document.body.classList.remove("ig-mode", "ig-tease");
    markInstalledUi();
    setGuiding(true);
    if (card) {
      card.hidden = false;
      card.classList.remove("ig-card--hidden");
    }
    stepIndex = 0;
    guideHasSweeper = false;
    function startSteps() {
      wireResize();
      renderStep();
    }
    if (typeof window.openMultiVisionFromConnect === "function") {
      window.openMultiVisionFromConnect({
        userName: "demoUser",
        serverHost: "127.0.0.1:22222",
        viewTitle: "Aggregates",
        isDemo: true,
        blankProject: false,
        openOverviewId: "lime-stone",
        instant: true,
        onReady: startSteps,
      });
    } else {
      startSteps();
    }
  }

  function enterLoginMode() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    guideTrack = "login";
    setTrackClass();
    hideModeMenu();
    hideTsPanel();
    document.body.classList.remove("ig-mode", "ig-tease");
    stopTeaseBackground();
    markInstalledUi();
    setGuiding(true);
    if (card) {
      card.hidden = false;
      card.classList.remove("ig-card--hidden");
    }
    stepIndex = 0;
    guideHasSweeper = false;
    wireResize();
    renderStep();
  }

  function enterScannerMode() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    guideTrack = "scanner";
    addedVesselId = "";
    setTrackClass();
    hideModeMenu();
    hideTsPanel();
    document.body.classList.remove("ig-mode", "ig-tease");
    markInstalledUi();
    setGuiding(true);
    if (card) {
      card.hidden = false;
      card.classList.remove("ig-card--hidden");
    }
    stepIndex = 0;
    guideHasSweeper = false;
    function startSteps() {
      setGuiding(false);
      var home = document.getElementById("mvSiteHome");
      if (home) home.click();
      setGuiding(true);
      wireResize();
      renderStep();
    }
    if (typeof window.openMultiVisionFromConnect === "function") {
      window.openMultiVisionFromConnect({
        userName: "demoUser",
        serverHost: "127.0.0.1:22222",
        viewTitle: "Aggregates",
        isDemo: true,
        blankProject: false,
        instant: true,
        onReady: startSteps,
      });
    } else {
      startSteps();
    }
  }

  function wireResize() {
    if (resizeBound) return;
    resizeBound = function () {
      var step = currentStep();
      if (!step || !card || card.hidden) return;
      var w = window.innerWidth;
      var h = window.innerHeight;
      if (
        Math.abs(w - lastWindowSize.w) < 24 &&
        Math.abs(h - lastWindowSize.h) < 24
      ) {
        return;
      }
      lastWindowSize = { w: w, h: h };
      // Never move the coach card on resize — only refresh an external spotlight.
      var sel = stepTarget(step);
      if (sel) {
        highlight(sel, stepPointer(step), { allowScroll: false });
      }
    };
    lastWindowSize = { w: window.innerWidth, h: window.innerHeight };
    window.addEventListener("resize", resizeBound);
  }

  function onModeChosen(mode) {
    if (!mode) return;
    if (mode === "free") {
      enterFreeMode();
      return;
    }
    if (mode === "vessel") {
      enterVesselMode();
      return;
    }
    if (mode === "login") {
      enterLoginMode();
      return;
    }
    if (mode === "scanner") {
      enterScannerMode();
      return;
    }
    hideTsPanel();
    guideTrack = mode === "client" ? "client" : "host";
    setTrackClass();
    hideModeMenu();
    stopTeaseBackground();
    setGuiding(true);
    if (card) {
      card.hidden = false;
      card.classList.remove("ig-card--hidden");
    }
    stepIndex = 0;
    guideHasSweeper = false;
    wireResize();
    renderStep();
  }

  function endGuide() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    setGuiding(false);
    if (typeof window.setBrowserUrlTypingCoach === "function") {
      window.setBrowserUrlTypingCoach(false);
    }
    if (typeof window.setServerAddressTypingCoach === "function") {
      window.setServerAddressTypingCoach(false);
    }
    if (typeof window.setUserNameTypingCoach === "function") {
      window.setUserNameTypingCoach(false);
    }
    if (typeof window.setPasswordTypingCoach === "function") {
      window.setPasswordTypingCoach(false);
    }
    clearAllApTypingCoaches();
    showPlacementProgress(false);
    hideEndScreen();
    // Stay in guide chrome: hide coach card only; do not return to install-type picker.
    if (card) card.hidden = true;
    clearHighlight();
    window.dispatchEvent(new CustomEvent("install-guide:finished"));
  }

  function hostRecapItems() {
    return [
      "Installed 3D MultiVision as the Host (Server) PC and signed in.",
      "Created a project, opened Devices, and connected the scanner.",
      "Configured vessel dimensions, placement, filling points, and Full/Empty calibration.",
      "Set Max Capacity to 100 and emptying/filling rates between 7 and 10.",
      "Disabled Auto False Echoes and unchecked both beam autos, then uploaded.",
      "Checked Overview Level, switched to Distance, and compared to tape or laser (expect ~3–5 ft — volume vs single-point).",
    ];
  }

  function clientRecapItems() {
    return [
      "Installed the Client Remote Viewer (Server component unchecked).",
      "Set the Host IP under Advanced Connection → Edit.",
      "Signed in with Host credentials.",
      "Connected as a remote viewer — scanners stay connected on the Host.",
    ];
  }

  function loginRecapItems() {
    return [
      "Opened 3D MultiVision from the taskbar.",
      "Chose Advanced Connection and set the Host IP.",
      "Signed in and connected to the Host project as a viewer.",
    ];
  }

  function scannerRecapItems() {
    return [
      "Added a silo to the existing project from Edit, Add, Vessel.",
      "Left the next free polling address and connected the scanner from Devices.",
    ].concat(vesselRecapItems());
  }

  function vesselRecapItems() {
    return [
      "Opened Device Configuration Wizard with the scanner already connected.",
      "Set units to feet and Fahrenheit, then entered your vessel dimensions.",
      "Applied recommended placement from Calculate, added a filling point, and reviewed Full/Empty.",
      "Set Max Capacity to 100 and emptying/filling rates between 7 and 10.",
      "Disabled Auto False Echoes, unchecked both beam autos, then uploaded.",
      "Checked Overview Level, switched to Distance, and compared to tape or laser (expect ~3–5 ft — volume vs single-point).",
    ];
  }

  function showEndScreen() {
    ensureDom();
    clearPoll();
    clearHighlight();
    setGuiding(false);
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    if (typeof window.setBrowserUrlTypingCoach === "function") {
      window.setBrowserUrlTypingCoach(false);
    }
    if (typeof window.setServerAddressTypingCoach === "function") {
      window.setServerAddressTypingCoach(false);
    }
    if (typeof window.setUserNameTypingCoach === "function") {
      window.setUserNameTypingCoach(false);
    }
    if (typeof window.setPasswordTypingCoach === "function") {
      window.setPasswordTypingCoach(false);
    }
    clearAllApTypingCoaches();

    var end = document.getElementById("igEndScreen");
    var kicker = document.getElementById("igEndKicker");
    var title = document.getElementById("igEndTitle");
    var body = document.getElementById("igEndBody");
    var alert = document.getElementById("igEndAlert");
    var recap = document.getElementById("igEndRecap");
    var recapList = document.getElementById("igEndRecapList");
    var recapBtn = document.getElementById("igEndRecapBtn");
    var mark = document.getElementById("igEndMark");
    if (!end) {
      endGuide();
      return;
    }

    var isClient = guideTrack === "client";
    var isLogin = guideTrack === "login";
    var isVessel = guideTrack === "vessel";
    var isScanner = guideTrack === "scanner";
    if (kicker) {
      kicker.textContent = isScanner
        ? "New Scanner"
        : isLogin
          ? "How to Login"
          : isVessel
            ? "Vessel / Scanner Setup"
            : isClient
              ? "Client Remote Viewer"
              : "Install & Setup — Host";
    }
    if (title) {
      title.textContent = "You're done";
    }
    if (body) {
      body.textContent = isScanner
        ? "The new silo is on the project. Its scanner is connected, and dimensions, placement, and advanced parameters are set."
        : isLogin
          ? "You are signed in. This PC is connected to the Host project as a remote viewer."
          : isVessel
            ? "Vessel and scanner setup is finished. Dimensions, placement, advanced parameters, and the tape compare are complete."
            : isClient
              ? "The Client install guide is finished. You are connected to the Host as a remote viewer."
              : "Host install and vessel/scanner setup are finished. The scanner is connected and Overview is ready.";
    }
    if (alert) {
      alert.textContent = isScanner
        ? "Use Replay guide anytime to add and set up another scanner."
        : isLogin
          ? "Do not connect scanners from this login — that stays on the Host."
          : isVessel
            ? "Use Replay guide anytime to run Vessel/Scanner Setup again."
            : isClient
              ? "Do not connect scanners from the Client PC — that stays on the Host."
              : "Use Replay guide to return to the mode menu and run Install & Setup again.";
    }
    if (recap) {
      recap.hidden = true;
    }
    if (recapBtn) {
      recapBtn.textContent = "View recap";
      recapBtn.setAttribute("aria-expanded", "false");
    }
    if (recapList) {
      var items = isScanner
        ? scannerRecapItems()
        : isLogin
          ? loginRecapItems()
          : isVessel
            ? vesselRecapItems()
            : isClient
              ? clientRecapItems()
              : hostRecapItems();
      recapList.innerHTML = items
        .map(function (t) {
          return "<li>" + t + "</li>";
        })
        .join("");
    }

    // Replay enter animation cleanly each time
    end.classList.remove("ig-end--enter", "ig-end--live");
    if (mark) mark.classList.remove("ig-end-mark--live");
    void end.offsetWidth;

    root.hidden = false;
    end.hidden = false;
    end.setAttribute("aria-hidden", "false");
    window.requestAnimationFrame(function () {
      end.classList.add("ig-end--enter");
      window.setTimeout(function () {
        end.classList.add("ig-end--live");
        if (mark) mark.classList.add("ig-end-mark--live");
      }, 1100);
    });
  }

  function hideEndScreen() {
    var end = document.getElementById("igEndScreen");
    if (end) {
      end.hidden = true;
      end.setAttribute("aria-hidden", "true");
      end.classList.remove("ig-end--enter", "ig-end--live");
    }
    var mark = document.getElementById("igEndMark");
    if (mark) mark.classList.remove("ig-end-mark--live");
    var recap = document.getElementById("igEndRecap");
    if (recap) recap.hidden = true;
  }

  function onEndClose() {
    hideEndScreen();
    endGuide();
  }

  function onEndRecapToggle() {
    var recap = document.getElementById("igEndRecap");
    var recapBtn = document.getElementById("igEndRecapBtn");
    if (!recap) return;
    var open = recap.hidden;
    recap.hidden = !open;
    if (recapBtn) {
      recapBtn.textContent = open ? "Hide recap" : "View recap";
      recapBtn.setAttribute("aria-expanded", open ? "true" : "false");
    }
  }

  function restartCurrentTrack() {
    hideEndScreen();
    clearPoll();
    clearHighlight();
    if (guideTrack === "vessel") {
      enterVesselMode();
      return;
    }
    if (guideTrack === "login") {
      enterLoginMode();
      return;
    }
    if (guideTrack === "scanner") {
      enterScannerMode();
      return;
    }
    if (guideTrack === "troubleshoot") {
      enterTroubleshootMode();
      return;
    }
    setGuiding(false);
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    showModeMenu();
  }

  function goNext() {
    var steps = getSteps();
    if (stepIndex < steps.length - 1) {
      stepIndex += 1;
      var skip = currentStep();
      if (skip && skip.id === "wiz-sweeper-note" && !guideHasSweeper) {
        if (stepIndex < steps.length - 1) stepIndex += 1;
      }
      renderStep();
    }
  }

  function clearPoll() {
    if (pollTimer) {
      clearInterval(pollTimer);
      pollTimer = null;
    }
  }

  /**
   * Coach card docks once at top-left and stays there for the whole guide.
   * Never chase spotlight targets — that made the box jump (especially when
   * choices lived inside the card itself).
   */
  var cardDocked = false;
  var lastWindowSize = { w: 0, h: 0 };

  function isInsideCoachCard(el) {
    if (!el || !card) return false;
    try {
      return card === el || card.contains(el);
    } catch (err) {
      return false;
    }
  }

  function resetCardDock() {
    cardDocked = false;
  }

  function dockCardOnce() {
    // Position comes from CSS (fixed top/left). Flag only tracks guide session.
    if (!card || cardDocked) return;
    cardDocked = true;
  }

  function placePointer(rect, mode) {
    if (!pointer || !rect || mode === "none" || mode === false) {
      if (pointer) pointer.hidden = true;
      if (root) root.classList.add("ig-no-pointer");
      return;
    }
    if (root) root.classList.remove("ig-no-pointer");
    pointer.hidden = false;
    var size = 48;
    var left;
    var top;
    var midY = rect.top + rect.height / 2 - 4;
    var midX = rect.left + rect.width / 2 - size / 2;
    if (mode === "right") {
      left = Math.min(rect.right + 6, window.innerWidth - size - 8);
      top = midY;
    } else if (mode === "left") {
      left = Math.max(8, rect.left - size - 4);
      top = midY;
    } else {
      // Tip of cursor SVG is at the top; sit under the control and aim up at it.
      left = midX;
      top = rect.bottom + 4;
    }
    left = Math.max(4, Math.min(left, window.innerWidth - size - 4));
    top = Math.max(4, Math.min(top, window.innerHeight - size - 4));
    pointer.style.left = left + "px";
    pointer.style.top = top + "px";
  }

  function stepTarget(step) {
    if (!step) return null;
    if (typeof step.getTarget === "function") {
      try {
        return step.getTarget();
      } catch (err) {
        return step.target || null;
      }
    }
    return step.target || null;
  }

  function stepPointer(step) {
    var target = stepTarget(step);
    if (!step) return "bottom";
    if (
      step.pointer === "none" ||
      step.id === "enter-host-ip" ||
      step.id === "devices-connection-type" ||
      step.id === "devices-polling-address" ||
      step.id === "wiz-scanner-count" ||
      step.id === "wiz-sweeper-ask" ||
      step.id === "wiz-placement-explain"
    ) {
      return "none";
    }
    if (
      target === WIZ_NEXT ||
      target === "#btn-connect" ||
      target === "#mvDevicesConnectBtn" ||
      target === "#browseFolderOk" ||
      target === "#browseFolderNew" ||
      target === "#btnBrowseServer" ||
      target === "#btn-edit-server" ||
      target === "#btn-config-ok" ||
      target === "#browserUrl" ||
      target === "#browserUrlWrap" ||
      target === "#mvWizNext" ||
      target === "#mvWizFillAdd" ||
      target === "#mvApUploadAll" ||
      target === "#mvApClose" ||
      target === "#mv-menu-device"
    ) {
      return "bottom";
    }
    if (step.pointer) return step.pointer;
    return "right";
  }

  function clearHighlight() {
    if (spot) {
      spot.hidden = true;
      // Drop position so the next step does not inherit a sliding ring.
      spot.style.left = "";
      spot.style.top = "";
      spot.style.width = "";
      spot.style.height = "";
    }
    if (pointer) pointer.hidden = true;
    root.classList.remove("ig-spot-on", "ig-dim-on", "ig-no-pointer");
  }

  /**
   * @param {string|null} selector
   * @param {string} pointerMode
   * @param {{ allowScroll?: boolean }} [opts]
   *   allowScroll: only on step enter — polling must not scroll the page.
   */
  function highlight(selector, pointerMode, opts) {
    opts = opts || {};
    var allowScroll = !!opts.allowScroll;
    if (!spot) return null;
    if (!selector) {
      clearHighlight();
      return null;
    }
    var el = queryGuideTarget(selector);
    if (el && el.matches && el.matches('input[type="radio"], input[type="checkbox"]')) {
      var label = el.closest("label");
      if (label) el = label;
    }
    // Never spotlight controls inside the coach card.
    if (isInsideCoachCard(el)) {
      clearHighlight();
      return null;
    }
    if (!el || el.hidden || el.offsetParent === null) {
      if (spot) spot.hidden = true;
      if (pointer) pointer.hidden = true;
      root.classList.remove("ig-spot-on", "ig-dim-on");
      root.classList.add("ig-no-pointer");
      return null;
    }

    // Never scroll the page for the coach — fixed card + window scroll looked like the box jumped.
    var r = el.getBoundingClientRect();
    // If the target is clipped inside a scrollable dialog, nudge only that scroller.
    if (allowScroll) {
      try {
        var scroller = el.closest
          ? el.closest(".mv-dialog-body, .mv-dlg-body, .mv-scroll, [data-ig-scroll]")
          : null;
        if (scroller && typeof scroller.scrollTop === "number") {
          var er = el.getBoundingClientRect();
          var sr = scroller.getBoundingClientRect();
          if (er.top < sr.top + 8) {
            scroller.scrollTop -= sr.top + 8 - er.top;
          } else if (er.bottom > sr.bottom - 8) {
            scroller.scrollTop += er.bottom - (sr.bottom - 8);
          }
          r = el.getBoundingClientRect();
        }
      } catch (err) {
        /* ignore */
      }
    }

    var pad = 8;
    spot.hidden = false;
    spot.style.left = r.left - pad + "px";
    spot.style.top = r.top - pad + "px";
    spot.style.width = r.width + pad * 2 + "px";
    spot.style.height = r.height + pad * 2 + "px";
    root.classList.add("ig-spot-on");
    root.classList.remove("ig-dim-on");
    placePointer(r, pointerMode || "bottom");
    return el;
  }

  function renderStep() {
    ensureDom();
    clearPoll();
    if (rebootWatchTimer) {
      clearTimeout(rebootWatchTimer);
      rebootWatchTimer = null;
    }
    var step = currentStep();
    if (!step) return;
    var steps = getSteps();

    root.hidden = false;
    hideModeMenu();
    if (card) {
      card.hidden = false;
      card.classList.remove("ig-card--hidden");
    }

    var kicker = document.getElementById("igKicker");
    if (kicker) {
      if (guideTrack === "login") {
        kicker.textContent = "How to Login";
      } else if (guideTrack === "scanner") {
        kicker.textContent = "New Scanner";
      } else if (guideTrack === "client") {
        kicker.textContent = "Client Remote Viewer";
      } else if (guideTrack === "troubleshoot") {
        kicker.textContent = "Troubleshooting";
      } else if (
        guideTrack === "vessel" ||
        (step && step.phase === "setup")
      ) {
        kicker.textContent = "Vessel / Scanner Setup";
      } else {
        kicker.textContent = "Install";
      }
    }
    document.getElementById("igTitle").textContent = step.title;
    var bodyHtml = step.body;
    if (step.id === "ap-vessel-slope") {
      var slopeDeg = recommendedSteepestMaterialSlope();
      bodyHtml =
        "<strong>Steepest Material Slope matters</strong> — it tells the scanner how steep the product surface can get and affects volume accuracy.<br><br>" +
        "From your vessel cone/hopper dimensions, the steepest wall slope is about <strong>" +
        slopeDeg +
        "°</strong> (atan of height ÷ radial run). Type the ghosted value: <code>" +
        slopeDeg +
        "</code>.";
    }
    if (step.id === "wiz-scanner-count") {
      bodyHtml = scannerCountStepBody();
    }
    if (step.id === "wiz-placement-explain") {
      bodyHtml =
        "Click <strong>Calculate</strong> to find recommended mount positions for <strong>" +
        escapeHtml(guideScannerPlan.label) +
        "</strong>. Watch the progress bar while the search runs.";
    }
    document.getElementById("igBody").innerHTML = bodyHtml;
    document.getElementById("igProgress").textContent =
      "Step " + (stepIndex + 1) + " of " + steps.length;
    var fill = document.getElementById("igProgressFill");
    if (fill) {
      fill.style.width =
        Math.max(0, Math.min(100, ((stepIndex + 1) / steps.length) * 100)) + "%";
    }

    if (step.id === "ts-sleep-type" && typeof window.openStartMenu === "function") {
      window.openStartMenu();
    }
    if (step.id === "ts-sleep-open") {
      if (typeof window.openStartMenu === "function") window.openStartMenu();
      var sleepSearch = document.getElementById("winStartSearch");
      if (sleepSearch && String(sleepSearch.value).trim().toLowerCase() !== "sleep") {
        sleepSearch.value = "sleep";
        sleepSearch.dispatchEvent(new Event("input", { bubbles: true }));
      }
    }
    if (step.id === "ts-sleep-expand" || step.id === "ts-sleep-menu" || step.id === "ts-sleep-never") {
      var pwrBd = document.getElementById("backdropPowerSettings");
      if ((!pwrBd || !pwrBd.classList.contains("show")) && typeof window.showPowerSettings === "function") {
        window.showPowerSettings();
      }
      if (step.id !== "ts-sleep-expand" && typeof window.expandPowerSleepTimeouts === "function") {
        window.expandPowerSleepTimeouts();
      }
      if (step.id === "ts-sleep-never" && typeof window.scrollPowerSleepMenu === "function") {
        window.scrollPowerSleepMenu();
      }
    }
    if (step.typeId && step.typeValue) {
      setApFieldTypingCoach(step.typeId, true, step.typeValue);
    } else if (step.id === "ap-max-capacity") {
      var capField = document.getElementById("mvApMaxCap");
      if (capField) capField.value = "";
      setApFieldTypingCoach("mvApMaxCap", true, AP_CAPACITY_TARGET);
    } else if (step.id === "ap-empty-rate") {
      var emptyRate = document.getElementById("mvApEmptyRate");
      if (emptyRate) emptyRate.value = "";
      setApFieldTypingCoach("mvApEmptyRate", true, AP_RATE_TARGET);
    } else if (step.id === "ap-fill-rate") {
      var fillRate = document.getElementById("mvApFillRate");
      if (fillRate) fillRate.value = "";
      setApFieldTypingCoach("mvApFillRate", true, AP_RATE_TARGET);
    } else if (step.id === "ap-vessel-slope") {
      var slopeField = document.getElementById("mvApSlope");
      var slopeTarget = String(recommendedSteepestMaterialSlope());
      if (slopeField) slopeField.value = "";
      setApFieldTypingCoach("mvApSlope", true, slopeTarget);
    } else {
      clearAllApTypingCoaches();
    }
    if (step.id === "ov-after-upload" || step.id === "ts-reset-watch" || step.id === "ts-reset-back") {
      ensureOverviewVisible();
    }
    if (step.id === "ts-reset-watch") {
      rebootWatchTimer = setTimeout(function () {
        rebootWatchTimer = null;
        var live = currentStep();
        if (live && live.id === "ts-reset-watch") {
          window.dispatchEvent(new CustomEvent("install-guide:device-reboot-watch"));
        }
      }, 15000);
    }

    var primary = document.getElementById("igPrimary");
    if (step.blocking) {
      primary.hidden = false;
      primary.textContent = step.primary || "Continue";
      primary.classList.add("ig-btn--flash");
      root.classList.add("ig-blocking");
    } else {
      primary.hidden = true;
      primary.classList.remove("ig-btn--flash");
      root.classList.remove("ig-blocking");
    }
    if (step.id === "wiz-scanner-count" || step.id === "wiz-sweeper-ask") {
      primary.hidden = true;
      primary.classList.remove("ig-btn--flash");
      root.classList.remove("ig-blocking");
    }

    if (step.id === "advanced-connection") {
      // Always start on Device Configuration so the user must click Advanced Connection.
      ensureDeviceConfigConnectionView();
    }

    if (step.id === "type-url") {
      openBlankBrowser();
      if (typeof window.setBrowserUrlTypingCoach === "function") {
        window.setBrowserUrlTypingCoach(true);
      }
    } else if (typeof window.setBrowserUrlTypingCoach === "function") {
      window.setBrowserUrlTypingCoach(false);
    }

    if (step.id === "enter-host-ip") {
      if (typeof window.setServerAddressTypingCoach === "function") {
        window.setServerAddressTypingCoach(true, EXAMPLE_HOST_IP);
      }
    } else if (typeof window.setServerAddressTypingCoach === "function") {
      window.setServerAddressTypingCoach(false);
    }

    if (step.id === "enter-username") {
      if (typeof window.setUserNameTypingCoach === "function") {
        window.setUserNameTypingCoach(true, "stech");
      }
      if (typeof window.setPasswordTypingCoach === "function") {
        window.setPasswordTypingCoach(false);
      }
      var passClear = document.getElementById("password");
      if (passClear) passClear.value = "";
    } else if (typeof window.setUserNameTypingCoach === "function") {
      window.setUserNameTypingCoach(false);
    }

    if (step.id === "enter-password") {
      if (typeof window.setPasswordTypingCoach === "function") {
        window.setPasswordTypingCoach(true, "techS");
      }
    } else if (step.id !== "enter-username" && typeof window.setPasswordTypingCoach === "function") {
      // Keep password coach off except on its step (username step clears above).
      window.setPasswordTypingCoach(false);
    }

    if (step.id === "advanced-connection" || step.id === "enter-username") {
      if (typeof window.closeBrowser === "function") {
        window.closeBrowser();
      }
      if (typeof window.closeFileExplorer === "function") {
        window.closeFileExplorer();
      }
    }

    // Card stays put for the whole guide. Spotlight only tracks external UI.
    dockCardOnce();
    var sel = stepTarget(step);
    if (sel) {
      highlight(sel, stepPointer(step), { allowScroll: true });
    } else {
      clearHighlight();
    }

    pollTimer = setInterval(function () {
      var pollSel = stepTarget(step);
      // Skip clearHighlight spam on no-target steps (that looked like a flash).
      if (pollSel) {
        highlight(pollSel, stepPointer(step), { allowScroll: false });
      }
      maybeAutoAdvance(step);
    }, 200);
  }

  function isAdvancedParamsOpen() {
    var el = document.getElementById("mv-dlg-advanced-params");
    if (!el) return false;
    if (el.hidden || el.hasAttribute("hidden")) return false;
    try {
      var cs = window.getComputedStyle(el);
      if (!cs || cs.display === "none" || cs.visibility === "hidden") return false;
    } catch (err) {
      /* ignore */
    }
    return true;
  }

  function maybeAutoAdvance(step) {
    if (!step) return;
    if (step.id === "enter-username") {
      var user = document.getElementById("user-name");
      if (user && user.value.trim() === "stech") {
        window.dispatchEvent(new CustomEvent("install-guide:username-ok"));
      }
    }
    if (step.id === "enter-password") {
      var pass = document.getElementById("password");
      if (pass && pass.value === "techS") {
        window.dispatchEvent(new CustomEvent("install-guide:password-ok"));
      }
    }
    if (step.id === "enter-host-ip") {
      var addr = document.getElementById("cfg-server-address");
      if (addr && addr.value.trim() === EXAMPLE_HOST_IP) {
        window.dispatchEvent(new CustomEvent("install-guide:host-ip-ok"));
      }
    }
    if (step.id === "advanced-connection") {
      if (isAdvancedConnectionViewActive()) {
        window.dispatchEvent(new CustomEvent("install-guide:advanced-selected"));
      }
    }
    if (step.id === "login-open") {
      var clientShell = document.getElementById("appShell");
      if (
        clientShell &&
        !clientShell.hidden &&
        !clientShell.classList.contains("app-shell--minimized")
      ) {
        window.dispatchEvent(new CustomEvent("install-guide:vision-client-opened"));
      }
    }
    if (step.id === "scan-edit") {
      var editPopup = document.getElementById("mv-popup-edit");
      if (editPopup && !editPopup.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:edit-menu-open"));
      }
    }
    if (step.id === "scan-add") {
      var addItem = document.querySelector('[data-mv-menu-id="edit-add"]');
      if (addItem && addItem.classList.contains("is-open")) {
        window.dispatchEvent(new CustomEvent("install-guide:edit-add-open"));
      }
    }
    if (step.id === "scan-vessel") {
      var addWiz = document.getElementById("mv-dlg-project-wizard");
      if (addWiz && !addWiz.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:add-vessel-opened"));
      }
    }
    if (step.id === "blank-project") {
      var dlg = document.getElementById("mv-dlg-project-wizard");
      if (dlg && !dlg.hidden && dlg.offsetParent !== null) {
        window.dispatchEvent(new CustomEvent("install-guide:new-project-opened"));
      }
    }
    if (step.id === "open-devices-tab") {
      var devicesTab = document.querySelector(
        '.mv-tab[data-mv-view="devices"].is-active'
      );
      if (devicesTab) {
        window.dispatchEvent(new CustomEvent("install-guide:devices-tab"));
      }
    }
    if (step.id === "open-vessel1") {
      var ov = document.getElementById("mvOverview");
      if (ov && !ov.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:vessel-opened"));
      }
    }
    if (step.id === "open-device-menu" || step.id === "ap-device-menu" || step.id === "ts-device-menu") {
      var devicePopup = document.getElementById("mv-popup-device");
      if (devicePopup && !devicePopup.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:device-menu-open"));
      }
    }
    if (step.id === "ts-echo-curve") {
      var echoOpenNow = document.getElementById("mv-dlg-echo-curve");
      if (echoOpenNow && !echoOpenNow.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:echo-curve-opened"));
      }
    }
    if (step.id === "open-device-wizard") {
      var wizDlg = document.getElementById("mv-dlg-device-wizard");
      if (wizDlg && !wizDlg.hidden && wizDlg.offsetParent !== null) {
        window.dispatchEvent(new CustomEvent("install-guide:device-wizard-opened"));
      }
    }
    if (step.id === "wiz-set-feet") {
      var dist = document.getElementById("mvWizDist");
      if (dist && dist.value === "ft") {
        window.dispatchEvent(new CustomEvent("install-guide:wiz-feet"));
      }
    }
    if (step.id === "wiz-set-fahrenheit") {
      var temp = document.getElementById("mvWizTemp");
      if (temp && /fahrenheit/i.test(temp.value)) {
        window.dispatchEvent(new CustomEvent("install-guide:wiz-fahrenheit"));
      }
    }
    if (step.id === "wiz-fill-add") {
      var fillRows = document.querySelectorAll("#mvWizFillTable tbody tr");
      if (fillRows && fillRows.length > 0) {
        window.dispatchEvent(new CustomEvent("install-guide:wiz-fill-added"));
      }
    }
    if (step.id === "ap-open" || step.advanceOn === "install-guide:advanced-params-opened") {
      if (isAdvancedParamsOpen()) {
        window.dispatchEvent(new CustomEvent("install-guide:advanced-params-opened"));
      }
    }
    if (step.advanceOn === "install-guide:device-wizard-opened") {
      var wizOpen = document.getElementById("mv-dlg-device-wizard");
      if (wizOpen && !wizOpen.hidden && wizOpen.offsetParent !== null) {
        window.dispatchEvent(new CustomEvent("install-guide:device-wizard-opened"));
      }
    }
    if (step.advanceOn === "install-guide:false-echo-opened") {
      var feDlg = document.getElementById("mv-dlg-false-echo");
      if (feDlg && !feDlg.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:false-echo-opened"));
      }
    }
    if (step.advanceOn === "install-guide:devices-act-opened") {
      var actDlg = document.getElementById("mv-dlg-devices-act");
      if (actDlg && !actDlg.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:devices-act-opened"));
      }
    }
    if (step.advanceOn === "install-guide:echo-opened") {
      var echoDlg = document.getElementById("mv-dlg-echo-curve") || document.getElementById("mv-dlg-echo-activate");
      if (echoDlg && !echoDlg.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:echo-opened"));
      }
    }
    if (step.id === "ap-click-advanced-tab" || step.id === "ts-ap-adv-tab") {
      var advTab = document.querySelector('.mv-ap-tab[data-tab="adv"].is-active');
      if (advTab) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-tab-adv"));
      }
    }
    if (step.id === "ap-click-beams-tab" || step.id === "ts-beam-tab" || step.id === "ts-ap-beams-tab") {
      var beamsTab = document.querySelector('.mv-ap-tab[data-tab="beams"].is-active');
      if (beamsTab) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-tab-beams"));
      }
    }
    if (step.id === "ap-false-echoes") {
      var autoFalse = document.getElementById("mvApAutoFalseEchoes");
      if (autoFalse && /disable/i.test(autoFalse.value)) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-auto-false-off"));
      }
    }
    if (step.id === "ap-uncheck-beam-sel" || step.id === "ts-beam-uncheck" || step.id === "ts-ap-beam-sel") {
      var beamSel = document.getElementById("mvApAutoBeamSel");
      if (beamSel && !beamSel.checked) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-beam-sel-off"));
      }
    }
    if (step.id === "ap-uncheck-beam-range" || step.id === "ts-beam-range" || step.id === "ts-ap-beam-range") {
      var beamRange = document.getElementById("mvApAutoBeamRange");
      if (beamRange && !beamRange.checked) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-beam-range-off"));
      }
    }
    if (step.id === "ap-close" || step.id === "ts-ap-close" || step.id === "ts-snr-close" || step.id === "ts-beam-close") {
      // Do not use offsetParent — the AP overlay is position:fixed, so
      // offsetParent is always null even while the window is still open.
      if (!isAdvancedParamsOpen()) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-closed"));
      }
    }
    if (step.id === "ap-max-capacity") {
      var cap = document.getElementById("mvApMaxCap");
      if (cap && String(cap.value).trim() === AP_CAPACITY_TARGET) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-capacity-100"));
      }
    }
    if (step.id === "ap-empty-rate") {
      var emptyEl = document.getElementById("mvApEmptyRate");
      if (emptyEl && String(emptyEl.value).trim() === AP_RATE_TARGET) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-empty-rate-ok"));
      }
    }
    if (step.id === "ap-fill-rate") {
      var fillEl = document.getElementById("mvApFillRate");
      if (fillEl && String(fillEl.value).trim() === AP_RATE_TARGET) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-fill-rate-ok"));
      }
    }
    if (step.id === "ap-vessel-slope") {
      var slopeEl = document.getElementById("mvApSlope");
      var wantSlope = String(recommendedSteepestMaterialSlope());
      if (slopeEl && String(slopeEl.value).trim() === wantSlope) {
        window.dispatchEvent(new CustomEvent("install-guide:ap-slope-ok"));
      }
    }
    if (step.typeId && step.typeValue) {
      var typedEl = document.getElementById(step.typeId);
      if (typedEl && String(typedEl.value).trim() === String(step.typeValue)) {
        window.dispatchEvent(new CustomEvent(step.advanceOn || "install-guide:typed-ok"));
      }
    }
    if (step.id === "ov-switch-distance") {
      var avgLab = document.getElementById("mvOvAvgLabel");
      var btnLab = document.getElementById("mvBtnLevelDistanceLabel");
      var isDist =
        (avgLab && /dist/i.test(avgLab.textContent || "")) ||
        (btnLab && /^level$/i.test((btnLab.textContent || "").trim()));
      if (isDist) {
        window.dispatchEvent(new CustomEvent("install-guide:view-distance"));
      }
    }
    if (step.id === "ov-after-upload") {
      ensureOverviewVisible();
    }
    if (step.advanceOn && step.advanceOn.indexOf("install-guide:wiz-step-") === 0) {
      var needWiz = parseInt(step.advanceOn.replace("install-guide:wiz-step-", ""), 10);
      var wizEl = document.getElementById("mv-dlg-device-wizard");
      var wizAt = wizEl && !wizEl.hidden ? Number(wizEl.__mvWizPrevStep || 0) : 0;
      if (needWiz && wizAt >= needWiz) {
        window.dispatchEvent(new CustomEvent(step.advanceOn));
      }
    }
    if (step.advanceOn === "install-guide:fe-action-ok") {
      var feAct = document.getElementById("mvFeActionType");
      var feVal = feAct && (feAct.value || (feAct.options[feAct.selectedIndex] && feAct.options[feAct.selectedIndex].text) || "");
      if (feAct && (feVal === "reset-all" || /reset user and auto/i.test(feVal))) {
        window.dispatchEvent(new CustomEvent("install-guide:fe-action-ok"));
      }
    }
    if (step.advanceOn === "install-guide:sleep-settings-opened") {
      var sleepBd = document.getElementById("backdropPowerSettings");
      if (sleepBd && sleepBd.classList.contains("show")) {
        window.dispatchEvent(new CustomEvent("install-guide:sleep-settings-opened"));
      }
    }
    if (step.advanceOn === "install-guide:sleep-timeouts-open") {
      var sleepBdExpand = document.getElementById("backdropPowerSettings");
      if (sleepBdExpand && !sleepBdExpand.classList.contains("show") && typeof window.showPowerSettings === "function") {
        window.showPowerSettings();
      }
      var sleepBody = document.getElementById("pwrSleepTimeoutsBody");
      if (sleepBody && !sleepBody.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:sleep-timeouts-open"));
      }
    }
    if (step.advanceOn === "install-guide:sleep-menu-open") {
      var sleepMenu = document.getElementById("pwrSleepMenu");
      if (sleepMenu && !sleepMenu.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:sleep-menu-open"));
      }
    }
    if (step.advanceOn === "install-guide:sleep-never") {
      var sleepBdNever = document.getElementById("backdropPowerSettings");
      if (sleepBdNever && !sleepBdNever.classList.contains("show") && typeof window.showPowerSettings === "function") {
        window.showPowerSettings();
      }
      if (typeof window.scrollPowerSleepMenu === "function") {
        window.scrollPowerSleepMenu();
      }
      var sleepSel = document.getElementById("pwrSleepPlugged");
      if (sleepSel && sleepSel.value === "never") {
        window.dispatchEvent(new CustomEvent("install-guide:sleep-never"));
      }
    }
    if (step.id === "ts-sleep-type") {
      var sleepQuery = document.getElementById("winStartSearch");
      if (sleepQuery && String(sleepQuery.value).trim().toLowerCase() === "sleep") {
        window.dispatchEvent(new CustomEvent("install-guide:typed-ok"));
      }
    }
    if (step.advanceOn === "install-guide:start-open") {
      var startBtn = document.getElementById("winStartBtn");
      var startMenu = document.getElementById("winStartMenu");
      if ((startBtn && startBtn.getAttribute("aria-expanded") === "true") || (startMenu && !startMenu.hidden)) {
        window.dispatchEvent(new CustomEvent("install-guide:start-open"));
      }
    }
    if (step.advanceOn === "install-guide:echo-curve-opened") {
      var echoCurve = document.getElementById("mv-dlg-echo-curve");
      if (echoCurve && !echoCurve.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:echo-curve-opened"));
      }
    }
    if (step.advanceOn === "install-guide:echo-started") {
      var echoCurve2 = document.getElementById("mv-dlg-echo-curve");
      if (echoCurve2 && !echoCurve2.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:echo-started"));
      }
    }
    if (step.advanceOn === "install-guide:echo-curve-closed") {
      var echoCurve3 = document.getElementById("mv-dlg-echo-curve");
      if (!echoCurve3 || echoCurve3.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:echo-curve-closed"));
      }
    }
    if (step.advanceOn === "install-guide:echo-activate-closed") {
      var echoAct = document.getElementById("mv-dlg-echo-activate");
      if (!echoAct || echoAct.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:echo-activate-closed"));
      }
    }
    if (step.advanceOn === "install-guide:devices-act-closed") {
      var actDlg2 = document.getElementById("mv-dlg-devices-act");
      if (!actDlg2 || actDlg2.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:devices-act-closed"));
      }
    }
    if (step.advanceOn === "install-guide:false-echo-closed") {
      var feDlg2 = document.getElementById("mv-dlg-false-echo");
      if (!feDlg2 || feDlg2.hidden) {
        window.dispatchEvent(new CustomEvent("install-guide:false-echo-closed"));
      }
    }
  }

  function onGuideEvent(name) {
    var step = currentStep();
    if (step && step.advanceOn === name) {
      if (name === "install-guide:connected" && guideTrack === "client") {
        showEndScreen();
        return;
      }
      if (name === "install-guide:wiz-uploaded") {
        ensureOverviewVisible();
      }
      if (name === "install-guide:ap-closed") {
        if (isAdvancedParamsOpen()) return;
      }
      if (name === "install-guide:load-from-vessel" && tsActiveId === "snr-zero") {
        applyTsSnrScene("");
        ensureOverviewVisible();
      }
      goNext();
    }
  }

  function wireEvents() {
    window.addEventListener("install-guide:vessel-added", function (e) {
      if (e.detail && e.detail.vesselId) addedVesselId = String(e.detail.vesselId);
    });
    document.addEventListener("click", guideInteractionGuard, true);
    document.addEventListener("mousedown", guideInteractionGuard, true);
    document.addEventListener("pointerdown", guideInteractionGuard, true);
    document.addEventListener("keydown", guideKeyGuard, true);
    document.addEventListener("click", onScannerCountClick);
    [
      "install-guide:browser-opened",
      "install-guide:downloads-page",
      "install-guide:downloaded",
      "install-guide:downloads-opened",
      "install-guide:uac-shown",
      "install-guide:installer-started",
      "install-guide:lang-ok",
      "install-guide:page-welcome",
      "install-guide:page-setupType",
      "install-guide:custom-selected",
      "install-guide:page-license",
      "install-guide:license-accepted",
      "install-guide:page-users",
      "install-guide:page-components",
      "install-guide:page-runAsService",
      "install-guide:service-selected",
      "install-guide:page-serverLocalPath",
      "install-guide:browse-opened",
      "install-guide:browse-binmaster-named",
      "install-guide:browse-binmaster-ok",
      "install-guide:page-installLocation",
      "install-guide:page-startMenu",
      "install-guide:page-installing",
      "install-guide:page-finish",
      "install-guide:install-complete",
      "install-guide:advanced-selected",
      "install-guide:server-config-opened",
      "install-guide:host-ip-ok",
      "install-guide:server-config-saved",
      "install-guide:username-ok",
      "install-guide:password-ok",
      "install-guide:connected",
      "install-guide:new-project-opened",
      "install-guide:project-general-next",
      "install-guide:project-created",
      "install-guide:vision-client-opened",
      "install-guide:edit-menu-open",
      "install-guide:edit-add-open",
      "install-guide:add-vessel-opened",
      "install-guide:vessel-added",
      "install-guide:vessel-opened",
      "install-guide:devices-tab",
      "install-guide:vessel-connected",
      "install-guide:device-menu-open",
      "install-guide:device-wizard-opened",
      "install-guide:wiz-feet",
      "install-guide:wiz-fahrenheit",
      "install-guide:wiz-step-2",
      "install-guide:wiz-step-3",
      "install-guide:wiz-step-4",
      "install-guide:wiz-fill-added",
      "install-guide:wiz-uploaded",
      "install-guide:advanced-params-opened",
      "install-guide:ap-capacity-100",
      "install-guide:ap-empty-rate-ok",
      "install-guide:ap-fill-rate-ok",
      "install-guide:ap-slope-ok",
      "install-guide:scanner-count",
      "install-guide:sweeper-choice",
      "install-guide:ap-tab-adv",
      "install-guide:ap-tab-beams",
      "install-guide:ap-auto-false-open",
      "install-guide:ap-auto-false-off",
      "install-guide:ap-beam-sel-off",
      "install-guide:ap-beam-range-off",
      "install-guide:ap-uploaded",
      "install-guide:ap-closed",
      "install-guide:view-distance",
      "install-guide:level-distance-toggled",
      "install-guide:echo-opened",
      "install-guide:false-echo-opened",
      "install-guide:false-echo-reset",
      "install-guide:false-echo-closed",
      "install-guide:devices-act-opened",
      "install-guide:load-from-vessel",
      "install-guide:fe-action-ok",
      "install-guide:device-reset-ask",
      "install-guide:device-reset",
      "install-guide:device-reboot-watch",
      "install-guide:device-reboot-back",
      "install-guide:devices-act-closed",
      "install-guide:ap-beams-select-all",
      "install-guide:echo-started",
      "install-guide:echo-curve-opened",
      "install-guide:echo-curve-closed",
      "install-guide:echo-activate-closed",
      "install-guide:start-open",
      "install-guide:sleep-settings-opened",
      "install-guide:sleep-timeouts-open",
      "install-guide:sleep-menu-open",
      "install-guide:sleep-never",
      "install-guide:typed-ok",
    ].forEach(function (name) {
      window.addEventListener(name, function () {
        if (name === "install-guide:level-distance-toggled") {
          var step = currentStep();
          if (step && step.id === "ov-switch-distance") {
            maybeAutoAdvance(step);
          }
          return;
        }
        onGuideEvent(name);
      });
    });

    wireResize();
  }

  function showModeMenu() {
    ensureDom();
    root.hidden = false;
    showModeMain();
    revealModeMenu();
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    resetCardDock();
    clearHighlight();
    clearPoll();
    showTsPanel();
    startTeaseBackground(function () {
      finishBootReveal();
      placeTsPanel();
      window.setTimeout(placeTsPanel, 400);
    });
    if (!placeTsPanel.bound) {
      placeTsPanel.bound = true;
      window.addEventListener("resize", placeTsPanel);
    }
  }

  function boot() {
    document.body.classList.add("ig-mode");
    ensureDom();
    wireEvents();
    showModeMenu();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }

  window.InstallGuide = {
    next: goNext,
    restart: function () {
      restartCurrentTrack();
    },
    enterFreeMode: enterFreeMode,
  };
  window.__igDeviceWizNavAllowed = deviceWizardNavAllowed;
})();
