/**
 * Step-by-step install guide for 3DInstallGuide fork.
 * Flow: download EXE → run installer → service install → Advanced Connection
 * → stech / techS → blank project → New Project.
 */
(function () {
  "use strict";

  var root;
  var dim;
  var spot;
  var card;
  var stepIndex = 0;
  var pollTimer = null;
  var resizeBound = null;

  var STEPS = [
    {
      id: "welcome",
      title: "Install 3D MultiVision",
      body:
        "3D is not installed yet. This guide walks you through downloading the installer, running a service install, signing in, and creating your first project.",
      blocking: true,
      primary: "Start",
      target: null,
    },
    {
      id: "open-browser",
      title: "Open the Browser",
      body: "Click the Browser icon on the taskbar (or Start → Browser) to open the download page.",
      target: "#taskbarBtnBrowser",
      advanceOn: "install-guide:browser-opened",
    },
    {
      id: "download-exe",
      title: "Download the 3D installer",
      body: "Click Download to save BinMaster 3DVision_3.1.010.exe to your Downloads folder.",
      target: "#browserDownloadBtn",
      advanceOn: "install-guide:downloaded",
    },
    {
      id: "open-downloads",
      title: "Open Downloads",
      body: "Open File Manager to find the installer you just downloaded.",
      target: "#taskbarBtnFileMgr",
      advanceOn: "install-guide:downloads-opened",
    },
    {
      id: "run-exe",
      title: "Run the installer",
      body: "Double-click BinMaster 3DVision_3.1.010.exe (or right-click → Run as administrator).",
      target: "#downloadsFileTbody tr",
      advanceOn: "install-guide:uac-shown",
    },
    {
      id: "uac-yes",
      title: "Allow the installer",
      body: "Click Yes on the User Account Control prompt to start Setup.",
      target: "#uacYes",
      advanceOn: "install-guide:installer-started",
    },
    {
      id: "installer-next",
      title: "Continue through Setup",
      body: "Accept the license and keep clicking Next until you reach the Run as Service page.",
      target: "#installerWizardFooter .installer-wiz-btn--default",
      advanceOn: "install-guide:service-step",
    },
    {
      id: "service-install",
      title: "Install as a Service",
      body: 'Select "Install BinMaster 3DVision server as Service", then click Next and finish the remaining setup pages.',
      target: 'input[name="runAs"][value="service"]',
      advanceOn: "install-guide:install-complete",
    },
    {
      id: "advanced-connection",
      title: "Choose Advanced Connection",
      body: "In the connection window, select Advanced Connection (not Device Configuration or Demo Mode).",
      target: 'input[name="nav-view"][value="advanced"]',
      advanceOn: "install-guide:advanced-selected",
    },
    {
      id: "enter-login",
      title: "Sign in",
      body: "Enter user name <code>stech</code> and password <code>techS</code>, then click Connect.",
      target: "#view-advanced",
      advanceOn: "install-guide:connected",
    },
    {
      id: "blank-project",
      title: "Blank project",
      body: "3D MultiVision opened with no project loaded. Use File → New Project... to get started.",
      target: "#mvMenubar",
      advanceOn: "install-guide:new-project-opened",
    },
    {
      id: "create-project",
      title: "Create your project",
      body: "Confirm the project name and click OK to create it.",
      target: '[data-mv-dlg-ok="mv-dlg-project-new"]',
      advanceOn: "install-guide:project-created",
    },
    {
      id: "done",
      title: "You're ready",
      body: "Installation and first project setup are complete. Explore the site or continue configuring vessels.",
      blocking: true,
      primary: "Finish guide",
      target: null,
    },
  ];

  function ensureDom() {
    if (root) return;
    root = document.createElement("div");
    root.className = "ig-root";
    root.id = "installGuideRoot";
    root.innerHTML =
      '<div class="ig-dim" aria-hidden="true"></div>' +
      '<div class="ig-spotlight ig-pulse" id="igSpotlight" hidden></div>' +
      '<div class="ig-card" id="igCard" role="dialog" aria-live="polite">' +
      '<div class="ig-card-kicker">Install guide</div>' +
      '<h2 class="ig-card-title" id="igTitle"></h2>' +
      '<p class="ig-card-body" id="igBody"></p>' +
      '<div class="ig-card-actions">' +
      '<button type="button" class="ig-btn ig-btn--primary" id="igPrimary" hidden>Continue</button>' +
      '<button type="button" class="ig-btn" id="igSkip" hidden>Skip highlight</button>' +
      '<span class="ig-progress" id="igProgress"></span>' +
      "</div></div>";
    document.body.appendChild(root);
    dim = root.querySelector(".ig-dim");
    spot = document.getElementById("igSpotlight");
    card = document.getElementById("igCard");
    document.getElementById("igPrimary").addEventListener("click", onPrimary);
    document.getElementById("igSkip").addEventListener("click", function () {
      goNext();
    });
  }

  function currentStep() {
    return STEPS[stepIndex] || null;
  }

  function onPrimary() {
    var step = currentStep();
    if (!step) return;
    if (step.id === "welcome") {
      goNext();
      return;
    }
    if (step.id === "done") {
      endGuide();
    }
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
    if (stepIndex < STEPS.length - 1) {
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
    var cw = card.offsetWidth || 360;
    var ch = card.offsetHeight || 160;
    var left = pad;
    var top = pad;

    if (nearRect) {
      left = nearRect.left;
      top = nearRect.bottom + 12;
      if (top + ch > window.innerHeight - pad) {
        top = Math.max(pad, nearRect.top - ch - 12);
      }
      if (left + cw > window.innerWidth - pad) {
        left = Math.max(pad, window.innerWidth - cw - pad);
      }
      if (left < pad) left = pad;
      if (top < pad) top = pad;
    } else {
      left = Math.max(pad, (window.innerWidth - cw) / 2);
      top = Math.max(pad, (window.innerHeight - ch) / 2);
    }

    card.style.left = left + "px";
    card.style.top = top + "px";
  }

  function highlight(selector) {
    if (!spot) return null;
    if (!selector) {
      spot.hidden = true;
      root.classList.remove("ig-spot-on", "ig-dim-on");
      placeCard(null);
      return null;
    }
    var el = document.querySelector(selector);
    if (!el || el.hidden || el.offsetParent === null) {
      spot.hidden = true;
      root.classList.add("ig-dim-on");
      root.classList.remove("ig-spot-on");
      placeCard(null);
      return null;
    }
    var r = el.getBoundingClientRect();
    var pad = 6;
    spot.hidden = false;
    spot.style.left = r.left - pad + "px";
    spot.style.top = r.top - pad + "px";
    spot.style.width = r.width + pad * 2 + "px";
    spot.style.height = r.height + pad * 2 + "px";
    root.classList.add("ig-spot-on", "ig-dim-on");
    placeCard(r);
    return el;
  }

  function renderStep() {
    ensureDom();
    clearPoll();
    var step = currentStep();
    if (!step) return;

    root.hidden = false;
    document.getElementById("igTitle").textContent = step.title;
    document.getElementById("igBody").innerHTML = step.body;
    document.getElementById("igProgress").textContent =
      "Step " + (stepIndex + 1) + " of " + STEPS.length;

    var primary = document.getElementById("igPrimary");
    var skip = document.getElementById("igSkip");
    if (step.blocking) {
      primary.hidden = false;
      primary.textContent = step.primary || "Continue";
      skip.hidden = true;
      root.classList.add("ig-blocking");
    } else {
      primary.hidden = true;
      skip.hidden = stepIndex > 1 && step.id !== "done";
      root.classList.remove("ig-blocking");
    }

    highlight(step.target);

    pollTimer = setInterval(function () {
      highlight(step.target);
      maybeAutoAdvance(step);
    }, 400);
  }

  function maybeAutoAdvance(step) {
    if (!step) return;
    if (step.id === "advanced-connection") {
      var adv = document.querySelector('input[name="nav-view"][value="advanced"]');
      if (adv && adv.checked) {
        window.dispatchEvent(new CustomEvent("install-guide:advanced-selected"));
      }
    }
    if (step.id === "installer-next") {
      // Wait for custom event from installer hook
    }
    if (step.id === "service-install") {
      var svc = document.querySelector('input[name="runAs"][value="service"]');
      if (svc && !svc.checked) {
        // nudge: do not auto-check; user must select
      }
    }
    if (step.id === "blank-project") {
      var dlg = document.getElementById("mv-dlg-project-new");
      if (dlg && !dlg.hidden && dlg.offsetParent !== null) {
        window.dispatchEvent(new CustomEvent("install-guide:new-project-opened"));
      }
    }
  }

  function onGuideEvent(name) {
    var step = currentStep();
    if (step && step.advanceOn === name) {
      goNext();
    }
  }

  function wireEvents() {
    [
      "install-guide:browser-opened",
      "install-guide:downloaded",
      "install-guide:downloads-opened",
      "install-guide:uac-shown",
      "install-guide:installer-started",
      "install-guide:service-step",
      "install-guide:install-complete",
      "install-guide:advanced-selected",
      "install-guide:connected",
      "install-guide:new-project-opened",
      "install-guide:project-created",
    ].forEach(function (name) {
      window.addEventListener(name, function () {
        onGuideEvent(name);
      });
    });

    resizeBound = function () {
      var step = currentStep();
      if (step) highlight(step.target);
    };
    window.addEventListener("resize", resizeBound);
  }

  function boot() {
    document.body.classList.add("ig-mode");
    ensureDom();
    wireEvents();
    stepIndex = 0;
    renderStep();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }

  window.InstallGuide = {
    next: goNext,
    restart: function () {
      stepIndex = 0;
      renderStep();
    },
  };
})();
