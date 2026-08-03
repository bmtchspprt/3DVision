/**
 * Step-by-step install guide for 3DInstallGuide fork.
 * Modes: HOST Install | Client Remote Viewer | Free (demo silos).
 * Flow: blank browser → type downloads URL → Custom + Service install → …
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
  var resizeBound = null;
  var guideTrack = "host"; // host | client

  var POINTER_SVG =
    '<svg viewBox="0 0 48 48" aria-hidden="true">' +
    '<path fill="#111" d="M12 4l2 30 7-5 6 12 5-2-6-12 10-1z"/>' +
    '<path fill="#fff" stroke="#111" stroke-width="1.5" d="M14 8l1.5 24 5.5-4 5.5 11 3.2-1.5-5.5-11 8-.8z"/>' +
    "</svg>";

  var WIZ_NEXT = "#installerWizardFooter .installer-wiz-btn--default";

  var EXAMPLE_HOST_IP = "192.168.1.28";

  var STEPS_THROUGH_USERS = [
    {
      id: "welcome",
      title: "Install 3D MultiVision",
      body: "This guide will show you how to install 3D as a Service. A blank browser will open — you will type the downloads address yourself.",
      blocking: true,
      primary: "Start",
      target: null,
    },
    {
      id: "type-url",
      title: "Open the downloads site",
      body:
        "Type the ghosted address in the bar — next key is highlighted. When finished, press <strong>Enter</strong>.",
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
        "Click the <strong>check mark</strong> next to <strong>Server app files</strong> to uncheck it. Leave <strong>Client app files</strong> checked — this PC only needs the remote viewer.",
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
        "The address box is the <strong>Host IP</strong> — the IP of the Host/Server computer (not this Client PC). " +
        "Type the ghosted address — next key is highlighted. For this example: <code>" +
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
        "Type the ghosted user name — next key is highlighted. For this guide: <code>stech</code>.",
      target: "#user-name-wrap",
      advanceOn: "install-guide:username-ok",
      pointer: "right",
    },
    {
      id: "enter-password",
      title: "Enter password",
      body:
        "Type the ghosted password — next key is highlighted. For this guide: <code>techS</code> (capital S).",
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
      body: "Keep defaults (1 vessel, RS-485 on COM3 for USB↔485), then click <strong>Finish</strong> to create the project.",
      target: "#mvProjWizNext",
      advanceOn: "install-guide:project-created",
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

  function buildHostSteps() {
    var steps = [].concat(
      cloneSteps(STEPS_THROUGH_USERS),
      cloneSteps(HOST_SERVICE_STEPS),
      cloneSteps(STEPS_INSTALL_FINISH),
      cloneSteps(STEPS_ADVANCED_START),
      cloneSteps(STEPS_LOGIN_CONNECT),
      cloneSteps(HOST_PROJECT_STEPS)
    );
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
      "This guide installs the Client (remote viewer) on a second PC. You will uncheck Server files, then point Advanced Connection at the Host IP. A blank browser will open — type the downloads address yourself.";
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
        "Click <strong>Connect</strong>. You will open the Host project — it already has a vessel with live readings.";
    }
    return steps;
  }

  var HOST_STEPS = buildHostSteps();
  var CLIENT_STEPS = buildClientSteps();

  function getSteps() {
    return guideTrack === "client" ? CLIENT_STEPS : HOST_STEPS;
  }

  function ensureDom() {
    if (root) return;
    root = document.createElement("div");
    root.className = "ig-root";
    root.id = "installGuideRoot";
    root.innerHTML =
      '<div class="ig-mode-menu" id="igModeMenu">' +
      '<div class="ig-mode-panel">' +
      '<p class="ig-mode-kicker">3D MultiVision</p>' +
      "<h1>Choose Install Type</h1>" +
      '<div class="ig-mode-list" role="list">' +
      '<div class="ig-mode-row" role="listitem">' +
      '<button type="button" class="ig-mode-btn" data-mode="host">' +
      '<span class="ig-mode-btn-label">Host Install</span>' +
      "</button>" +
      '<button type="button" class="ig-mode-info" data-info="host" aria-label="About Host Install" title="About Host Install">' +
      '<span class="ig-mode-info-ico" aria-hidden="true">i</span>' +
      "</button>" +
      '<div class="ig-mode-tip" id="igTipHost" hidden>' +
      "This is the designated Server PC install." +
      "</div></div>" +
      '<div class="ig-mode-row" role="listitem">' +
      '<button type="button" class="ig-mode-btn" data-mode="client">' +
      '<span class="ig-mode-btn-label">Client Remote Viewer</span>' +
      "</button>" +
      '<button type="button" class="ig-mode-info" data-info="client" aria-label="About Client Remote Viewer" title="About Client Remote Viewer">' +
      '<span class="ig-mode-info-ico" aria-hidden="true">i</span>' +
      "</button>" +
      '<div class="ig-mode-tip" id="igTipClient" hidden>' +
      "Install Client only on a second PC, then enter the Host IP in Advanced Connection → Edit." +
      "</div></div>" +
      "</div>" +
      '<button type="button" class="ig-mode-free" data-mode="free">Free mode (installed — Demo silos)</button>' +
      "</div></div>" +
      '<div class="ig-dim" aria-hidden="true"></div>' +
      '<div class="ig-spotlight ig-pulse" id="igSpotlight" hidden></div>' +
      '<div class="ig-pointer" id="igPointer" hidden>' +
      POINTER_SVG +
      "</div>" +
      '<div class="ig-card" id="igCard" role="dialog" aria-live="polite" hidden>' +
      '<div class="ig-card-kicker" id="igKicker">Install guide</div>' +
      '<h2 class="ig-card-title" id="igTitle"></h2>' +
      '<p class="ig-card-body" id="igBody"></p>' +
      '<div class="ig-card-actions">' +
      '<button type="button" class="ig-btn ig-btn--primary" id="igPrimary" hidden>Continue</button>' +
      '<span class="ig-progress" id="igProgress"></span>' +
      "</div></div>";
    document.body.appendChild(root);
    modeMenu = document.getElementById("igModeMenu");
    dim = root.querySelector(".ig-dim");
    spot = document.getElementById("igSpotlight");
    pointer = document.getElementById("igPointer");
    card = document.getElementById("igCard");
    document.getElementById("igPrimary").addEventListener("click", onPrimary);
    // Event delegation — reliable even when clicking the inner label span
    modeMenu.addEventListener("click", function (e) {
      var infoBtn = e.target.closest ? e.target.closest("[data-info]") : null;
      if (infoBtn && modeMenu.contains(infoBtn)) {
        e.preventDefault();
        e.stopPropagation();
        toggleInstallInfo(infoBtn.getAttribute("data-info"));
        return;
      }
      var modeBtn = e.target.closest ? e.target.closest("[data-mode]") : null;
      if (modeBtn && modeMenu.contains(modeBtn)) {
        e.preventDefault();
        e.stopPropagation();
        onModeChosen(modeBtn.getAttribute("data-mode"));
      }
    });
    document.addEventListener("click", function (e) {
      if (!modeMenu || modeMenu.hidden || modeMenu.classList.contains("ig-mode-menu--hidden")) {
        return;
      }
      if (e.target.closest && e.target.closest(".ig-mode-info, .ig-mode-tip")) return;
      hideInstallTips();
    });
  }

  function hideInstallTips() {
    ["igTipHost", "igTipClient"].forEach(function (id) {
      var tip = document.getElementById(id);
      if (tip) tip.hidden = true;
    });
    if (modeMenu) {
      modeMenu.querySelectorAll(".ig-mode-info.is-open").forEach(function (b) {
        b.classList.remove("is-open");
        b.setAttribute("aria-expanded", "false");
      });
    }
  }

  function toggleInstallInfo(which) {
    var tipId = which === "client" ? "igTipClient" : "igTipHost";
    var tip = document.getElementById(tipId);
    var btn = modeMenu
      ? modeMenu.querySelector('.ig-mode-info[data-info="' + which + '"]')
      : null;
    var wasOpen = tip && !tip.hidden;
    hideInstallTips();
    if (!wasOpen && tip) {
      tip.hidden = false;
      if (btn) {
        btn.classList.add("is-open");
        btn.setAttribute("aria-expanded", "true");
      }
    }
  }

  function currentStep() {
    var steps = getSteps();
    return steps[stepIndex] || null;
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

  function isAdvancedConnectionViewActive() {
    var adv = document.querySelector('input[name="nav-view"][value="advanced"]');
    var panel = document.getElementById("view-advanced");
    return !!(adv && adv.checked && panel && panel.classList.contains("active"));
  }

  function setGuiding(on) {
    document.body.classList.toggle("ig-guiding", !!on);
  }

  function setTrackClass() {
    document.body.classList.remove("ig-track-host", "ig-track-client");
    if (guideTrack === "client") {
      document.body.classList.add("ig-track-client");
    } else {
      document.body.classList.add("ig-track-host");
    }
  }

  function isClickAllowed(e) {
    if (!document.body.classList.contains("ig-guiding")) return true;
    // Install-type picker handles its own clicks
    if (modeMenu && !modeMenu.hidden && !modeMenu.classList.contains("ig-mode-menu--hidden")) {
      return !!(e.target.closest && e.target.closest("#igModeMenu"));
    }
    if (e.target.closest && e.target.closest("#igCard, .ig-card, #igPrimary")) return true;
    if (e.target.closest && e.target.closest("#igBootCurtain")) return true;

    var step = currentStep();
    if (!step) return false;
    if (step.blocking) return false;

    var sel = stepTarget(step);
    if (!sel) return false;

    var target = document.querySelector(sel);
    if (!target) return false;

    if (target === e.target || target.contains(e.target)) return true;

    var label = target.closest && target.closest("label");
    if (label && label.contains(e.target)) return true;

    if (target.id) {
      var forLab = document.querySelector('label[for="' + target.id + '"]');
      if (forLab && forLab.contains(e.target)) return true;
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

    return false;
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
    if (step.id === "welcome") {
      openBlankBrowser();
      goNext();
      return;
    }
    if (step.id === "done") {
      endGuide();
    }
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

  function hideModeMenu() {
    if (!modeMenu) return;
    modeMenu.hidden = true;
    modeMenu.classList.add("ig-mode-menu--hidden");
    modeMenu.setAttribute("aria-hidden", "true");
  }

  function revealModeMenu() {
    if (!modeMenu) return;
    modeMenu.hidden = false;
    modeMenu.classList.remove("ig-mode-menu--hidden");
    modeMenu.setAttribute("aria-hidden", "false");
  }

  function onModeChosen(mode) {
    if (!mode) return;
    if (mode === "free") {
      enterFreeMode();
      return;
    }
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
    // Stay in guide chrome — hide coach card only; do not return to install-type picker.
    if (card) card.hidden = true;
    clearHighlight();
    window.dispatchEvent(new CustomEvent("install-guide:finished"));
  }

  function goNext() {
    var steps = getSteps();
    if (stepIndex < steps.length - 1) {
      stepIndex += 1;
      renderStep();
    }
  }

  function clearPoll() {
    if (pollTimer) {
      clearInterval(pollTimer);
      pollTimer = null;
    }
  }

  function placeCard(nearRect) {
    if (!card) return;
    var pad = 16;
    var cw = card.offsetWidth || 320;
    var ch = card.offsetHeight || 160;
    // Dock left — leave the center/right clear for browser and Setup
    var left = pad;
    var top = pad;

    if (nearRect) {
      var cardBox = { left: left, top: top, right: left + cw, bottom: top + ch };
      var overlaps =
        nearRect.left < cardBox.right &&
        nearRect.right > cardBox.left &&
        nearRect.top < cardBox.bottom &&
        nearRect.bottom > cardBox.top;
      if (overlaps) {
        top = Math.min(
          Math.max(pad, nearRect.bottom + pad),
          Math.max(pad, window.innerHeight - ch - pad)
        );
      }
    }

    card.style.left = left + "px";
    card.style.top = top + "px";
  }

  function placePointer(rect, mode) {
    if (!pointer || !rect || mode === "none" || mode === false) {
      if (pointer) pointer.hidden = true;
      return;
    }
    pointer.hidden = false;
    var size = 48;
    var left;
    var top;
    var midY = rect.top + rect.height / 2 - 4;
    if (mode === "right") {
      left = Math.min(rect.right + 6, window.innerWidth - size - 8);
      top = midY;
    } else if (mode === "left") {
      left = Math.max(8, rect.left - size - 4);
      top = midY;
    } else {
      // Sit fully under the target so typed text stays readable
      left =
        rect.left +
        Math.min(Math.max(rect.width * 0.35, 24), Math.max(rect.width - 24, 24));
      top = rect.bottom + 6;
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
    if (step.pointer === "none" || step.id === "enter-host-ip") {
      return "none";
    }
    if (
      target === WIZ_NEXT ||
      target === "#btn-connect" ||
      target === "#browseFolderOk" ||
      target === "#browseFolderNew" ||
      target === "#btnBrowseServer" ||
      target === "#btn-edit-server" ||
      target === "#btn-config-ok" ||
      target === "#browserUrl" ||
      target === "#browserUrlWrap"
    ) {
      return "bottom";
    }
    if (step.pointer) return step.pointer;
    return "right";
  }

  function clearHighlight() {
    if (spot) spot.hidden = true;
    if (pointer) pointer.hidden = true;
    root.classList.remove("ig-spot-on", "ig-dim-on");
  }

  function highlight(selector, pointerMode) {
    if (!spot) return null;
    if (!selector) {
      clearHighlight();
      placeCard(null);
      return null;
    }
    var el = document.querySelector(selector);
    if (el && el.matches && el.matches('input[type="radio"], input[type="checkbox"]')) {
      var label = el.closest("label");
      if (label) el = label;
    }
    if (!el || el.hidden || el.offsetParent === null) {
      if (spot) spot.hidden = true;
      if (pointer) pointer.hidden = true;
      root.classList.remove("ig-spot-on", "ig-dim-on");
      placeCard(null);
      return null;
    }

    try {
      el.scrollIntoView({ block: "nearest", inline: "nearest" });
    } catch (err) {
      /* ignore */
    }

    var r = el.getBoundingClientRect();
    if (r.bottom > window.innerHeight - 8 || r.top < 8) {
      var absTop = r.top + window.scrollY;
      var desired = absTop - Math.max(80, window.innerHeight * 0.45);
      window.scrollTo({ top: Math.max(0, desired), behavior: "auto" });
      r = el.getBoundingClientRect();
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
    placeCard(r);
    return el;
  }

  function renderStep() {
    ensureDom();
    clearPoll();
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
      kicker.textContent =
        guideTrack === "client" ? "Client Remote Viewer" : "HOST Install guide";
    }
    document.getElementById("igTitle").textContent = step.title;
    document.getElementById("igBody").innerHTML = step.body;
    document.getElementById("igProgress").textContent =
      "Step " + (stepIndex + 1) + " of " + steps.length;

    var primary = document.getElementById("igPrimary");
    if (step.blocking) {
      primary.hidden = false;
      primary.textContent = step.primary || "Continue";
      root.classList.add("ig-blocking");
    } else {
      primary.hidden = true;
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

    highlight(stepTarget(step), stepPointer(step));

    pollTimer = setInterval(function () {
      highlight(stepTarget(step), stepPointer(step));
      maybeAutoAdvance(step);
    }, 200);
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
    if (step.id === "blank-project") {
      var dlg = document.getElementById("mv-dlg-project-wizard");
      if (dlg && !dlg.hidden && dlg.offsetParent !== null) {
        window.dispatchEvent(new CustomEvent("install-guide:new-project-opened"));
      }
    }
  }

  function onGuideEvent(name) {
    var step = currentStep();
    if (step && step.advanceOn === name) {
      if (name === "install-guide:project-created") {
        endGuide();
        return;
      }
      if (name === "install-guide:connected" && guideTrack === "client") {
        endGuide();
        return;
      }
      goNext();
    }
  }

  function wireEvents() {
    document.addEventListener("click", guideInteractionGuard, true);
    document.addEventListener("mousedown", guideInteractionGuard, true);
    document.addEventListener("pointerdown", guideInteractionGuard, true);
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
    ].forEach(function (name) {
      window.addEventListener(name, function () {
        onGuideEvent(name);
      });
    });

    resizeBound = function () {
      var step = currentStep();
      if (step && card && !card.hidden) highlight(stepTarget(step), stepPointer(step));
    };
    window.addEventListener("resize", resizeBound);
  }

  function showModeMenu() {
    ensureDom();
    root.hidden = false;
    revealModeMenu();
    if (card) {
      card.hidden = true;
      card.classList.add("ig-card--hidden");
    }
    clearHighlight();
    clearPoll();
    startTeaseBackground(finishBootReveal);
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
      showModeMenu();
    },
    enterFreeMode: enterFreeMode,
  };
})();
