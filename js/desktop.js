(function () {
  "use strict";

  var appShell = document.getElementById("appShell");
  var visionLoadingShell = document.getElementById("visionLoadingShell");
  var serverAppShell = document.getElementById("serverAppShell");
  var visionChromeShell = document.getElementById("visionChromeShell");
  var simDesktop = document.getElementById("simDesktop");
  var desktopIcon = document.getElementById("desktopVisionIcon");
  var taskbarBtnVision = document.getElementById("taskbarBtnVision");
  var taskbarBtnVisionServer = document.getElementById("taskbarBtnVisionServer");
  var taskbarBtnFileMgr = document.getElementById("taskbarBtnFileMgr");
  var btnServerClose = document.getElementById("btn-server-close");
  var btnChromeClose = document.getElementById("btn-chrome-close");
  var btnLoadingClose = document.getElementById("btn-loading-close");

  var zIndexTop = 110;
  var dragState = null;
  var visionChromeActive = false;
  var visionClientLoading = false;
  var visionLoadingTimer = null;
  var VISION_LOAD_MS = 1600;

  var windowDefaults = {
    client: { left: 72, top: 48, width: 646, height: 528 },
    server: { left: 112, top: 88, width: 420, height: 240 },
    chrome: { anchor: "bottom-left", marginLeft: 8, marginBottom: 28, width: 178, height: 31 },
  };

  function getShellMode(shell) {
    if (shell === serverAppShell) {
      return "server";
    }
    if (shell === visionChromeShell) {
      return "chrome";
    }
    return "client";
  }

  function getDefaultWindowPosition(shell, mode) {
    var defaults = windowDefaults[mode] || windowDefaults.client;
    if (defaults.anchor === "bottom-left") {
      var bounds = getDesktopBounds();
      var size = getShellSize(shell, mode);
      var marginLeft = defaults.marginLeft != null ? defaults.marginLeft : defaults.margin != null ? defaults.margin : 8;
      var marginBottom = defaults.marginBottom != null ? defaults.marginBottom : defaults.margin != null ? defaults.margin : 8;
      return {
        left: marginLeft,
        top: bounds.height - size.height - marginBottom,
      };
    }
    return { left: defaults.left, top: defaults.top };
  }

  function getShellSize(shell, mode) {
    var defaults = windowDefaults[mode] || windowDefaults.client;
    var inner = shell ? shell.querySelector(".app-window, .server-app-window, .vision-chrome-window, .vision-loading-window") : null;
    if (inner) {
      var width = inner.offsetWidth;
      var height = inner.offsetHeight;
      if (width > 0 && height > 0) {
        return { width: width, height: height };
      }
    }
    return { width: defaults.width, height: defaults.height };
  }

  function showDesktopPanel() {
    if (!simDesktop) {
      return;
    }
    simDesktop.hidden = false;
    simDesktop.setAttribute("aria-hidden", "false");
  }

  function getDesktopBounds() {
    if (!simDesktop) {
      return { left: 0, top: 0, width: 800, height: 600 };
    }
    return {
      left: 0,
      top: 0,
      width: simDesktop.clientWidth,
      height: simDesktop.clientHeight,
    };
  }

  function clampWindowPosition(shell, left, top, mode) {
    if (!shell || !simDesktop) {
      return { left: left, top: top };
    }
    var bounds = getDesktopBounds();
    var size = getShellSize(shell, mode);
    var maxLeft = Math.max(8, bounds.width - size.width - 8);
    var maxTop = Math.max(8, bounds.height - size.height - 8);
    return {
      left: Math.min(Math.max(left, 8), maxLeft),
      top: Math.min(Math.max(top, 8), maxTop),
    };
  }

  function applyWindowPosition(shell, left, top, mode) {
    if (!shell || !simDesktop) {
      return;
    }
    var clamped = clampWindowPosition(shell, left, top, mode);
    shell.style.left = clamped.left + "px";
    shell.style.top = clamped.top + "px";
  }

  function ensureDefaultPosition(shell, mode) {
    if (!shell || shell.dataset.positioned === "true") {
      return;
    }
    function place() {
      var position = getDefaultWindowPosition(shell, mode);
      applyWindowPosition(shell, position.left, position.top, mode);
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
    document.querySelectorAll(".app-shell.app-shell--focused").forEach(function (node) {
      if (node !== shell) {
        node.classList.remove("app-shell--focused");
      }
    });
    shell.classList.add("app-shell--focused");
    syncTaskbarStates();
  }

  function setTaskbarState(taskbarBtn, state) {
    if (!taskbarBtn) {
      return;
    }
    var activeClass =
      taskbarBtn.id === "taskbarBtnVisionServer"
        ? "win-taskbar-vision-server--active"
        : "win-taskbar-vision--active";
    var minimizedClass =
      taskbarBtn.id === "taskbarBtnVisionServer"
        ? "win-taskbar-vision-server--minimized"
        : "win-taskbar-vision--minimized";
    taskbarBtn.classList.toggle(activeClass, state === "active");
    taskbarBtn.classList.toggle(minimizedClass, state === "minimized");
  }

  function syncTaskbarStates() {
    if (taskbarBtnVision) {
      if (visionClientLoading) {
        setTaskbarState(taskbarBtnVision, "active");
      } else if (!isWindowOpen(appShell)) {
        setTaskbarState(taskbarBtnVision, "minimized");
      } else if (appShell.classList.contains("app-shell--focused")) {
        setTaskbarState(taskbarBtnVision, "active");
      } else {
        setTaskbarState(taskbarBtnVision, "open");
      }
    }
    if (taskbarBtnVisionServer) {
      if (!isWindowOpen(serverAppShell)) {
        setTaskbarState(taskbarBtnVisionServer, "minimized");
      } else if (serverAppShell.classList.contains("app-shell--focused")) {
        setTaskbarState(taskbarBtnVisionServer, "active");
      } else {
        setTaskbarState(taskbarBtnVisionServer, "open");
      }
    }
  }

  function isWindowOpen(shell) {
    return shell && !shell.hidden && !shell.classList.contains("app-shell--minimized");
  }

  function hideVisionLoading() {
    if (visionLoadingTimer) {
      clearTimeout(visionLoadingTimer);
      visionLoadingTimer = null;
    }
    visionClientLoading = false;
    if (!visionLoadingShell) {
      return;
    }
    visionLoadingShell.hidden = true;
    visionLoadingShell.classList.add("app-shell--minimized");
    visionLoadingShell.classList.remove("app-shell--focused");
    syncTaskbarStates();
  }

  function showVisionLoading() {
    if (!visionLoadingShell) {
      return;
    }
    visionLoadingShell.hidden = false;
    visionLoadingShell.classList.remove("app-shell--minimized");
    ensureDefaultPosition(visionLoadingShell, "client");
    bringToFront(visionLoadingShell);
    syncTaskbarStates();
    showDesktopPanel();
  }

  function finishVisionClientLaunch() {
    visionLoadingTimer = null;
    visionClientLoading = false;
    if (visionLoadingShell) {
      visionLoadingShell.hidden = true;
      visionLoadingShell.classList.add("app-shell--minimized");
      visionLoadingShell.classList.remove("app-shell--focused");
    }
    showAppWindow(appShell, taskbarBtnVision, "client");
  }

  function startVisionClientLaunch() {
    if (visionClientLoading) {
      return;
    }
    if (isWindowOpen(appShell)) {
      showVisionChrome();
      showAppWindow(appShell, taskbarBtnVision, "client");
      return;
    }

    visionClientLoading = true;
    showVisionChrome();
    showVisionLoading();
    visionLoadingTimer = window.setTimeout(finishVisionClientLaunch, VISION_LOAD_MS);
  }

  function cancelVisionClientLaunch() {
    hideVisionLoading();
    setTaskbarState(taskbarBtnVision, "minimized");
  }

  function showVisionChrome() {
    if (!visionChromeShell) {
      return;
    }
    visionChromeShell.hidden = false;
    visionChromeShell.classList.remove("app-shell--minimized");
    ensureDefaultPosition(visionChromeShell, "chrome");
    visionChromeActive = true;
    showDesktopPanel();
  }

  function hideVisionChrome() {
    if (!visionChromeShell) {
      return;
    }
    visionChromeShell.hidden = true;
    visionChromeShell.classList.add("app-shell--minimized");
    visionChromeShell.classList.remove("app-shell--focused");
    visionChromeActive = false;
  }

  function showAppWindow(shell, taskbarBtn, mode) {
    if (!shell) {
      return;
    }
    shell.hidden = false;
    shell.classList.remove("app-shell--minimized");
    ensureDefaultPosition(shell, mode);
    bringToFront(shell);
    syncTaskbarStates();
    showDesktopPanel();
  }

  function minimizeAppWindow(shell, taskbarBtn) {
    if (!shell) {
      return;
    }
    shell.hidden = true;
    shell.classList.add("app-shell--minimized");
    shell.classList.remove("app-shell--focused");
    setTaskbarState(taskbarBtn, "minimized");
    syncTaskbarStates();
  }

  function closeAppWindow(shell, taskbarBtn) {
    minimizeAppWindow(shell, taskbarBtn);
  }

  function launchApp(mode) {
    if (mode === "server") {
      showAppWindow(serverAppShell, taskbarBtnVisionServer, "server");
      return;
    }
    startVisionClientLaunch();
  }

  function launchFromDesktop() {
    launchApp("client");
  }

  function launchServerFromDesktop() {
    launchApp("server");
  }

  function restoreOrLaunchFromTaskbar(taskbarBtn, mode) {
    var shell = mode === "server" ? serverAppShell : appShell;
    var activeClass =
      mode === "server" ? "win-taskbar-vision-server--active" : "win-taskbar-vision--active";

    if (!isWindowOpen(shell)) {
      if (mode === "client" && visionClientLoading) {
        showVisionLoading();
        if (!visionChromeActive) {
          showVisionChrome();
        }
        return;
      }
      launchApp(mode);
      return;
    }

    if (mode === "client" && !visionChromeActive) {
      showVisionChrome();
    }

    if (taskbarBtn && taskbarBtn.classList.contains(activeClass)) {
      minimizeAppWindow(shell, taskbarBtn);
      return;
    }

    showAppWindow(shell, taskbarBtn, mode);
  }

  function wireWindowDrag(shell) {
    if (!shell) {
      return;
    }
    var titleBar = shell.querySelector(".title-bar");
    if (!titleBar) {
      return;
    }

    titleBar.addEventListener("mousedown", function (event) {
      if (event.button !== 0 || event.target.closest(".title-bar-controls")) {
        return;
      }
      bringToFront(shell);
      var mode = getShellMode(shell);
      var shellRect = shell.getBoundingClientRect();
      dragState = {
        shell: shell,
        mode: mode,
        offsetX: event.clientX - shellRect.left,
        offsetY: event.clientY - shellRect.top,
      };
      shell.classList.add("app-shell--dragging");
      event.preventDefault();
    });

    shell.addEventListener("mousedown", function () {
      bringToFront(shell);
    });
  }

  function wireDragListeners() {
    document.addEventListener("mousemove", function (event) {
      if (!dragState || !simDesktop) {
        return;
      }
      var desktopRect = simDesktop.getBoundingClientRect();
      applyWindowPosition(
        dragState.shell,
        event.clientX - desktopRect.left - dragState.offsetX,
        event.clientY - desktopRect.top - dragState.offsetY,
        dragState.mode
      );
    });

    document.addEventListener("mouseup", function () {
      if (!dragState) {
        return;
      }
      dragState.shell.classList.remove("app-shell--dragging");
      dragState = null;
    });
  }

  function wireDesktopIcons() {
    if (desktopIcon) {
      desktopIcon.addEventListener("dblclick", launchFromDesktop);
    }
    if (taskbarBtnVision) {
      taskbarBtnVision.addEventListener("click", function () {
        restoreOrLaunchFromTaskbar(taskbarBtnVision, "client");
      });
    }
    if (taskbarBtnVisionServer) {
      taskbarBtnVisionServer.addEventListener("click", function () {
        restoreOrLaunchFromTaskbar(taskbarBtnVisionServer, "server");
      });
    }
    if (taskbarBtnFileMgr) {
      taskbarBtnFileMgr.addEventListener("click", function () {
        if (typeof window.openFileExplorer === "function") {
          window.openFileExplorer();
        }
      });
    }
    if (btnServerClose) {
      btnServerClose.addEventListener("click", function () {
        closeAppWindow(serverAppShell, taskbarBtnVisionServer);
      });
    }
    if (btnChromeClose) {
      btnChromeClose.addEventListener("click", function () {
        hideVisionChrome();
      });
    }
    if (btnLoadingClose) {
      btnLoadingClose.addEventListener("click", function () {
        cancelVisionClientLaunch();
      });
    }
  }

  function wireTaskbarClock() {
    var clock = document.getElementById("taskbarClock");
    if (!clock) {
      return;
    }
    var timeEl = clock.querySelector(".win-taskbar-time");
    var dateEl = clock.querySelector(".win-taskbar-date");

    function tick() {
      var now = new Date();
      if (timeEl) {
        timeEl.textContent = now.toLocaleTimeString(undefined, {
          hour: "numeric",
          minute: "2-digit",
        });
      }
      if (dateEl) {
        dateEl.textContent = now.toLocaleDateString(undefined);
      }
    }

    tick();
    window.setInterval(tick, 30000);
  }

  function exitToDesktop() {
    cancelVisionClientLaunch();
    if (isWindowOpen(appShell)) {
      closeAppWindow(appShell, taskbarBtnVision);
    }
    if (isWindowOpen(serverAppShell)) {
      closeAppWindow(serverAppShell, taskbarBtnVisionServer);
    }
    hideVisionChrome();
    showDesktopPanel();
  }

  window.exitToDesktop = exitToDesktop;
  window.closeVisionClient = function () {
    cancelVisionClientLaunch();
    closeAppWindow(appShell, taskbarBtnVision);
    hideVisionChrome();
  };
  window.closeVisionServer = function () {
    closeAppWindow(serverAppShell, taskbarBtnVisionServer);
  };
  window.launchVisionFromDesktop = launchFromDesktop;
  window.launchVisionServerFromDesktop = launchServerFromDesktop;

  wireWindowDrag(appShell);
  wireWindowDrag(visionLoadingShell);
  wireWindowDrag(serverAppShell);
  wireWindowDrag(visionChromeShell);
  wireDragListeners();
  wireDesktopIcons();
  wireTaskbarClock();
  showDesktopPanel();
})();
