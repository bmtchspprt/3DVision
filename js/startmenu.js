/* Start menu — adapted from eBob Tutorial wireSimulatedTaskbar() */
(function () {
  "use strict";

  var backdrop = document.getElementById("winStartBackdrop");
  var startMenu = document.getElementById("winStartMenu");
  var startBtn = document.getElementById("winStartBtn");
  var winStartSearch = document.getElementById("winStartSearch");
  var winSearchFlyout = document.getElementById("winSearchFlyout");
  var winSearchPanelServices = document.getElementById("winSearchPanelServices");
  var winSearchPanel3DVision = document.getElementById("winSearchPanel3DVision");
  var winSearchPanel3DVisionServer = document.getElementById("winSearchPanel3DVisionServer");
  var winSearchPanelPower = document.getElementById("winSearchPanelPower");
  var winSearchPanelSleep = document.getElementById("winSearchPanelSleep");
  var winStartHomeContent = document.getElementById("winStartHomeContent");
  var winStartPowerBtn = document.getElementById("winStartPowerBtn");
  var winStartPowerMenu = document.getElementById("winStartPowerMenu");

  function normalizeQuery(q) {
    return String(q || "").trim().toLowerCase();
  }

  function compactQuery(q) {
    return normalizeQuery(q).replace(/\s+/g, "");
  }

  function isVisionServerQuery(q) {
    var n = normalizeQuery(q);
    var c = compactQuery(q);
    return (
      n.indexOf("3d vision server") >= 0 ||
      n.indexOf("3dvision server") >= 0 ||
      c.indexOf("3dvisionserver") >= 0
    );
  }

  function isVisionClientQuery(q) {
    if (isVisionServerQuery(q)) {
      return false;
    }
    var n = normalizeQuery(q);
    var c = compactQuery(q);
    return n.indexOf("3d vision") >= 0 || c.indexOf("3dvision") >= 0;
  }

  function isServicesQuery(q) {
    var n = normalizeQuery(q);
    return n === "services" || n.indexOf("services") === 0;
  }

  function isSleepQuery(q) {
    var n = normalizeQuery(q);
    return n === "sleep" || n.indexOf("sleep") === 0;
  }

  function isPowerQuery(q) {
    if (isSleepQuery(q)) return false;
    var n = normalizeQuery(q);
    return (
      n === "power" ||
      n.indexOf("power") === 0 ||
      n === "shutdown" ||
      n.indexOf("shut down") === 0 ||
      n === "restart" ||
      n.indexOf("restart") === 0 ||
      n === "lock" ||
      n.indexOf("lock") === 0
    );
  }

  function closePowerMenu() {
    if (!winStartPowerMenu || !winStartPowerBtn) {
      return;
    }
    winStartPowerMenu.hidden = true;
    winStartPowerBtn.setAttribute("aria-expanded", "false");
  }

  function togglePowerMenu() {
    if (!winStartPowerMenu || !winStartPowerBtn) {
      return;
    }
    var open = winStartPowerMenu.hidden;
    winStartPowerMenu.hidden = !open;
    winStartPowerBtn.setAttribute("aria-expanded", open ? "true" : "false");
  }

  function runPowerAction(action) {
    closePowerMenu();
    closeStartMenu();
    if (action === "restart") {
      window.location.reload();
      return;
    }
    if (action === "shutdown") {
      if (typeof window.exitToDesktop === "function") {
        window.exitToDesktop();
      }
      return;
    }
    if (action === "sleep" || action === "lock") {
      return;
    }
  }

  function syncStartSearchView() {
    if (!winSearchFlyout || !winStartHomeContent || !startMenu) {
      return;
    }
    var q = normalizeQuery(winStartSearch && winStartSearch.value);
    var isServices = isServicesQuery(q);
    var isVisionServer = isVisionServerQuery(q);
    var isVisionClient = isVisionClientQuery(q);
    var isSleep = isSleepQuery(q);
    var isPower = isPowerQuery(q);
    if (isServices || isVisionServer || isVisionClient || isPower || isSleep) {
      winSearchFlyout.hidden = false;
      winStartHomeContent.hidden = true;
      startMenu.classList.add("win-start-menu--search");
      if (winSearchPanelServices) {
        winSearchPanelServices.hidden = !isServices;
      }
      if (winSearchPanel3DVisionServer) {
        winSearchPanel3DVisionServer.hidden = !isVisionServer;
      }
      if (winSearchPanel3DVision) {
        winSearchPanel3DVision.hidden = !isVisionClient;
      }
      if (winSearchPanelPower) {
        winSearchPanelPower.hidden = !isPower;
      }
      if (winSearchPanelSleep) {
        winSearchPanelSleep.hidden = !isSleep;
      }
    } else {
      winSearchFlyout.hidden = true;
      winStartHomeContent.hidden = false;
      startMenu.classList.remove("win-start-menu--search");
      if (winSearchPanelServices) {
        winSearchPanelServices.hidden = true;
      }
      if (winSearchPanel3DVisionServer) {
        winSearchPanel3DVisionServer.hidden = true;
      }
      if (winSearchPanel3DVision) {
        winSearchPanel3DVision.hidden = true;
      }
      if (winSearchPanelPower) {
        winSearchPanelPower.hidden = true;
      }
      if (winSearchPanelSleep) {
        winSearchPanelSleep.hidden = true;
      }
    }
  }

  function closeStartMenu() {
    if (!backdrop || !startMenu || !startBtn) {
      return;
    }
    if (winStartSearch && document.activeElement === winStartSearch) {
      winStartSearch.blur();
    }
    backdrop.hidden = true;
    backdrop.setAttribute("aria-hidden", "true");
    startMenu.hidden = true;
    startBtn.setAttribute("aria-expanded", "false");
    if (winStartSearch) {
      winStartSearch.value = "";
    }
    closePowerMenu();
    syncStartSearchView();
    if (document.activeElement === startBtn) {
      startBtn.blur();
    }
  }

  function openStartMenu() {
    if (!backdrop || !startMenu || !startBtn) {
      return;
    }
    backdrop.hidden = false;
    backdrop.setAttribute("aria-hidden", "false");
    startMenu.hidden = false;
    startBtn.setAttribute("aria-expanded", "true");
    try {
      window.dispatchEvent(new CustomEvent("install-guide:start-open"));
    } catch (err) {
      /* ignore */
    }
    syncStartSearchView();
    if (winStartSearch) {
      window.setTimeout(function () {
        winStartSearch.focus();
      }, 0);
    }
  }

  function toggleStartMenu() {
    if (!startMenu) {
      return;
    }
    if (startMenu.hidden) {
      openStartMenu();
    } else {
      closeStartMenu();
    }
  }

  function openPowerSettingsFromStart() {
    closeStartMenu();
    if (typeof window.showPowerSettings === "function") {
      window.showPowerSettings();
    }
  }

  function openServicesFromStart() {
    closeStartMenu();
    if (typeof window.showServicesUac === "function") {
      window.showServicesUac();
    } else if (typeof window.showServicesMsc === "function") {
      window.showServicesMsc();
    }
  }

  function openServicesMscFromStart() {
    closeStartMenu();
    if (typeof window.showServicesMsc === "function") {
      window.showServicesMsc();
    }
  }

  function open3DVisionClientFromStart() {
    closeStartMenu();
    if (typeof window.launchVisionFromDesktop === "function") {
      window.launchVisionFromDesktop();
    }
  }

  function open3DVisionServerFromStart() {
    closeStartMenu();
    if (typeof window.launchVisionServerFromDesktop === "function") {
      window.launchVisionServerFromDesktop();
    }
  }

  function handleSearchEnter(event) {
    if (event.key !== "Enter") {
      return;
    }
    var q = normalizeQuery(winStartSearch && winStartSearch.value);
    if (isServicesQuery(q)) {
      event.preventDefault();
      openServicesFromStart();
      return;
    }
    if (isVisionServerQuery(q)) {
      event.preventDefault();
      open3DVisionServerFromStart();
      return;
    }
    if (isVisionClientQuery(q)) {
      event.preventDefault();
      open3DVisionClientFromStart();
      return;
    }
    if (isSleepQuery(q)) {
      event.preventDefault();
      return;
    }
    if (isPowerQuery(q)) {
      event.preventDefault();
      closeStartMenu();
    }
  }

  function wire() {
    if (startBtn) {
      startBtn.addEventListener("click", function (event) {
        event.stopPropagation();
        toggleStartMenu();
      });
    }
    if (backdrop) {
      backdrop.addEventListener("click", closeStartMenu);
    }

    if (winStartPowerBtn) {
      winStartPowerBtn.addEventListener("click", function (event) {
        event.stopPropagation();
        togglePowerMenu();
      });
    }

    if (winStartPowerMenu) {
      winStartPowerMenu.addEventListener("click", function (event) {
        var btn = event.target.closest && event.target.closest("[data-power-action]");
        if (!btn) {
          return;
        }
        event.stopPropagation();
        runPowerAction(btn.getAttribute("data-power-action"));
      });
    }

    if (winStartSearch) {
      winStartSearch.addEventListener("input", syncStartSearchView);
      winStartSearch.addEventListener("click", function (event) {
        event.stopPropagation();
      });
      winStartSearch.addEventListener("keydown", handleSearchEnter);
    }

    if (startMenu) {
      startMenu.addEventListener("click", function (event) {
        var target = event.target;
        var powerBtn = target.closest && target.closest("[data-power-action]");
        if (powerBtn) {
          runPowerAction(powerBtn.getAttribute("data-power-action"));
          return;
        }
        if (target.closest && target.closest("#winSearchHitPower")) {
          return;
        }
        if (target.closest && target.closest("[data-sim-sleep='open']")) {
          openPowerSettingsFromStart();
          return;
        }
        var svcBtn = target.closest && target.closest("[data-sim-svc]");
        if (svcBtn) {
          var svcAction = svcBtn.getAttribute("data-sim-svc");
          if (svcAction === "open") {
            openServicesMscFromStart();
            return;
          }
          if (svcAction === "admin") {
            openServicesFromStart();
            return;
          }
        }
        var visionBtn = target.closest && target.closest("[data-sim-vision]");
        if (visionBtn && visionBtn.getAttribute("data-sim-vision") === "open") {
          open3DVisionClientFromStart();
          return;
        }
        var visionServerBtn = target.closest && target.closest("[data-sim-visionserver]");
        if (visionServerBtn && visionServerBtn.getAttribute("data-sim-visionserver") === "open") {
          open3DVisionServerFromStart();
          return;
        }
        if (target.closest && target.closest("#winSearchHitServices")) {
          openServicesMscFromStart();
          return;
        }
        if (target.closest && target.closest("#winSearchHit3DVision")) {
          open3DVisionClientFromStart();
          return;
        }
        if (target.closest && target.closest("#winSearchHit3DVisionServer")) {
          open3DVisionServerFromStart();
          return;
        }
        var tile = target.closest && target.closest(".win-start-tile[data-sim-app]");
        if (tile) {
          var app = tile.getAttribute("data-sim-app");
          if (app === "File Manager") {
            closeStartMenu();
            if (typeof window.openFileExplorer === "function") {
              window.openFileExplorer();
            }
            return;
          }
          if (app === "Browser") {
            closeStartMenu();
            if (typeof window.openBrowser === "function") {
              window.openBrowser();
            }
            return;
          }
          if (app === "3DVision") {
            open3DVisionClientFromStart();
            return;
          }
          if (app === "3DVision Server") {
            open3DVisionServerFromStart();
            return;
          }
          closeStartMenu();
          return;
        }
        if (target.closest && target.closest("[data-sim-start]")) {
          closeStartMenu();
        }
      });
    }

    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape" && startMenu && !startMenu.hidden) {
        if (winStartPowerMenu && !winStartPowerMenu.hidden) {
          closePowerMenu();
          return;
        }
        closeStartMenu();
      }
    });

    document.addEventListener("click", function (event) {
      if (!winStartPowerMenu || winStartPowerMenu.hidden) {
        return;
      }
      if (event.target.closest && event.target.closest(".win-start-power-wrap")) {
        return;
      }
      closePowerMenu();
    });
  }

  wire();
  window.closeStartMenu = closeStartMenu;
  window.openStartMenu = openStartMenu;
})();
