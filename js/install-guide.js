/**
 * Step-by-step install guide for 3DInstallGuide fork.
 * Modes: HOST Install | Server-Client Remote Viewer | Free (demo silos).
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

  /* Host and Client share the same tutorial for now. */
  var HOST_STEPS = [
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
        "In the address bar, type <code>support.binmaster.com/downloads</code> and press <strong>Enter</strong>.",
      target: "#browserUrl",
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
    {
      id: "components-next",
      title: "Choose components",
      body: "Keep <strong>Server app files</strong> checked, then click <strong>Next</strong>.",
      target: WIZ_NEXT,
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
      body: "Click <strong>Install</strong> to begin the service install.",
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
    {
      id: "advanced-connection",
      title: "Choose Advanced Connection",
      body: "In the connection window, select the highlighted <strong>Advanced Connection</strong> option.",
      target: 'input[name="nav-view"][value="advanced"]',
      advanceOn: "install-guide:advanced-selected",
      pointer: "right",
    },
    {
      id: "enter-username",
      title: "Enter user name",
      body: "Type user name <code>stech</code> in the highlighted field.",
      target: "#user-name",
      advanceOn: "install-guide:username-ok",
      pointer: "right",
    },
    {
      id: "enter-password",
      title: "Enter password",
      body: "Type password <code>techS</code> in the highlighted field.",
      target: "#password",
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

  function getSteps() {
    return HOST_STEPS;
  }

  function ensureDom() {
    if (root) return;
    root = document.createElement("div");
    root.className = "ig-root";
    root.id = "installGuideRoot";
    root.innerHTML =
      '<div class="ig-mode-menu" id="igModeMenu">' +
      '<div class="ig-mode-panel">' +
      '<p class="ig-mode-kicker">3D Install Guide</p>' +
      "<h1>Choose a mode</h1>" +
      "<p class=\"ig-mode-lead\">Pick how you want to run this simulator.</p>" +
      '<button type="button" class="ig-mode-btn" data-mode="host">HOST Install</button>' +
      '<button type="button" class="ig-mode-btn" data-mode="client">Server-Client Remote Viewer</button>' +
      '<button type="button" class="ig-mode-btn ig-mode-btn--free" data-mode="free">Free mode</button>' +
      '<p class="ig-mode-hint">Free mode: 3D already installed — Demo Mode silos, no guided steps.</p>' +
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
      '<button type="button" class="ig-btn" id="igSkip" hidden>Skip highlight</button>' +
      '<span class="ig-progress" id="igProgress"></span>' +
      "</div></div>";
    document.body.appendChild(root);
    modeMenu = document.getElementById("igModeMenu");
    dim = root.querySelector(".ig-dim");
    spot = document.getElementById("igSpotlight");
    pointer = document.getElementById("igPointer");
    card = document.getElementById("igCard");
    document.getElementById("igPrimary").addEventListener("click", onPrimary);
    document.getElementById("igSkip").addEventListener("click", function () {
      goNext();
    });
    modeMenu.querySelectorAll("[data-mode]").forEach(function (btn) {
      btn.addEventListener("click", function () {
        onModeChosen(btn.getAttribute("data-mode"));
      });
    });
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
      window.openBrowser({ blank: true });
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

  function enterFreeMode() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    if (modeMenu) modeMenu.hidden = true;
    if (card) card.hidden = true;
    clearHighlight();
    if (root) root.hidden = true;
    document.body.classList.remove("ig-mode");
    document.body.classList.add("ig-free-mode");
    markInstalledUi();
    if (typeof window.openMultiVisionFromConnect === "function") {
      window.openMultiVisionFromConnect({
        userName: "demoUser",
        serverHost: "127.0.0.1:22222",
        viewTitle: "Aggregates",
        isDemo: true,
        blankProject: false,
      });
    }
    window.dispatchEvent(new CustomEvent("install-guide:free-mode"));
  }

  function onModeChosen(mode) {
    if (mode === "free") {
      enterFreeMode();
      return;
    }
    guideTrack = mode === "client" ? "client" : "host";
    if (modeMenu) modeMenu.hidden = true;
    if (card) card.hidden = false;
    stepIndex = 0;
    renderStep();
  }

  function endGuide() {
    clearPoll();
    if (resizeBound) {
      window.removeEventListener("resize", resizeBound);
      resizeBound = null;
    }
    if (root) root.hidden = true;
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
    // Always dock left so the card stays clear of Setup / dialogs
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
        // Nudge down below the highlight if the left corner is occupied
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
    if (!pointer || !rect) {
      if (pointer) pointer.hidden = true;
      return;
    }
    pointer.hidden = false;
    var size = 48;
    var left;
    var top;
    var midY = rect.top + rect.height / 2 - 4;
    if (mode === "right") {
      left = Math.min(
        rect.right - 20,
        Math.max(rect.left + 28, Math.min(rect.left + 120, window.innerWidth - size - 8))
      );
      top = midY;
    } else if (mode === "left") {
      left = Math.max(8, rect.left - size + 8);
      top = midY;
    } else {
      left =
        rect.left +
        Math.min(Math.max(rect.width * 0.35, 24), Math.max(rect.width - 24, 24));
      top = rect.bottom - 10;
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
      target === WIZ_NEXT ||
      target === "#btn-connect" ||
      target === "#browseFolderOk" ||
      target === "#browseFolderNew" ||
      target === "#btnBrowseServer" ||
      target === "#browserUrl"
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
    if (modeMenu) modeMenu.hidden = true;
    if (card) card.hidden = false;

    var kicker = document.getElementById("igKicker");
    if (kicker) {
      kicker.textContent =
        guideTrack === "client" ? "Server-Client Remote Viewer" : "HOST Install guide";
    }
    document.getElementById("igTitle").textContent = step.title;
    document.getElementById("igBody").innerHTML = step.body;
    document.getElementById("igProgress").textContent =
      "Step " + (stepIndex + 1) + " of " + steps.length;

    var primary = document.getElementById("igPrimary");
    var skip = document.getElementById("igSkip");
    if (step.blocking) {
      primary.hidden = false;
      primary.textContent = step.primary || "Continue";
      skip.hidden = true;
      root.classList.add("ig-blocking");
    } else {
      primary.hidden = true;
      skip.hidden = true;
      root.classList.remove("ig-blocking");
    }

    if (step.id === "type-url") {
      openBlankBrowser();
    }

    if (step.id === "advanced-connection" || step.id === "enter-username") {
      if (typeof window.closeBrowser === "function") {
        window.closeBrowser();
      }
      if (typeof window.closeFileExplorer === "function") {
        window.closeFileExplorer();
      }
    }
    if (step.id === "enter-username") {
      var userEl = document.getElementById("user-name");
      var passEl = document.getElementById("password");
      if (userEl) {
        userEl.value = "";
        try {
          userEl.focus();
        } catch (err) {
          /* ignore */
        }
      }
      if (passEl) {
        passEl.value = "";
      }
    }
    if (step.id === "enter-password") {
      var passFocus = document.getElementById("password");
      if (passFocus) {
        try {
          passFocus.focus();
        } catch (err2) {
          /* ignore */
        }
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
    if (step.id === "advanced-connection") {
      var adv = document.querySelector('input[name="nav-view"][value="advanced"]');
      if (adv && adv.checked) {
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
      goNext();
    }
  }

  function wireEvents() {
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
    if (modeMenu) modeMenu.hidden = false;
    if (card) card.hidden = true;
    clearHighlight();
    clearPoll();
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
