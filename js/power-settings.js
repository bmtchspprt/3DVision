/* Power & battery settings — Controller Goes to Sleep */
(function () {
  "use strict";

  var TIMEOUTS = [
    ["1", "1 minute"],
    ["3", "3 minutes"],
    ["5", "5 minutes"],
    ["10", "10 minutes"],
    ["15", "15 minutes"],
    ["30", "30 minutes"],
    ["45", "45 minutes"],
    ["60", "1 hour"],
    ["120", "2 hours"],
    ["180", "3 hours"],
    ["never", "Never"],
  ];

  var backdrop = document.getElementById("backdropPowerSettings");
  var timeoutsBtn = document.getElementById("pwrSleepTimeouts");
  var timeoutsBody = document.getElementById("pwrSleepTimeoutsBody");
  var pluggedSleep = document.getElementById("pwrSleepPlugged");
  var sleepMenu = document.getElementById("pwrSleepMenu");

  function emit(name) {
    try {
      window.dispatchEvent(new CustomEvent(name));
    } catch (err) {
      /* ignore */
    }
  }

  function fillSelect(id, value) {
    var sel = document.getElementById(id);
    if (!sel) return;
    if (!sel.options.length) {
      TIMEOUTS.forEach(function (pair) {
        var opt = document.createElement("option");
        opt.value = pair[0];
        opt.textContent = pair[1];
        sel.appendChild(opt);
      });
    }
    sel.value = value;
    if (id === "pwrSleepPlugged") {
      fillSleepMenu();
    }
  }

  function fillSleepMenu() {
    if (!sleepMenu) return;
    sleepMenu.innerHTML = "";
    TIMEOUTS.forEach(function (pair) {
      var btn = document.createElement("button");
      btn.type = "button";
      btn.setAttribute("data-pwr-sleep", pair[0]);
      btn.textContent = pair[1];
      if (pair[0] === "never") {
        btn.id = "pwrSleepOptNever";
        btn.className = "is-target";
      }
      sleepMenu.appendChild(btn);
    });
  }

  function setSleepMenuOpen(open) {
    if (!sleepMenu) return;
    sleepMenu.hidden = !open;
    if (open) {
      sleepMenu.scrollTop = 0;
    }
  }

  function scrollSleepMenuToNever() {
    var never = document.getElementById("pwrSleepOptNever");
    if (!sleepMenu || sleepMenu.hidden || !never) return;
    var top = never.offsetTop - (sleepMenu.clientHeight - never.offsetHeight - 6);
    sleepMenu.scrollTop = top < 0 ? 0 : top;
  }

  function setExpanded(open, silent) {
    if (!timeoutsBody || !timeoutsBtn) return;
    timeoutsBody.hidden = !open;
    timeoutsBtn.setAttribute("aria-expanded", open ? "true" : "false");
    if (open && !silent) {
      emit("install-guide:sleep-timeouts-open");
    }
  }

  function resetForm() {
    setExpanded(false, true);
    setSleepMenuOpen(false);
    fillSelect("pwrScreenPlugged", "120");
    fillSelect("pwrSleepPlugged", "30");
    fillSelect("pwrScreenBattery", "never");
    fillSelect("pwrSleepBattery", "never");
  }

  function showPowerSettings() {
    if (!backdrop) return;
    resetForm();
    backdrop.classList.add("show");
    backdrop.setAttribute("aria-hidden", "false");
    emit("install-guide:sleep-settings-opened");
  }

  function hidePowerSettings() {
    if (!backdrop) return;
    backdrop.classList.remove("show");
    backdrop.setAttribute("aria-hidden", "true");
    setExpanded(false, true);
    setSleepMenuOpen(false);
  }

  function wire() {
    resetForm();
    if (timeoutsBtn) {
      timeoutsBtn.addEventListener("click", function () {
        var open = timeoutsBody && timeoutsBody.hidden;
        setExpanded(!!open, false);
      });
    }
    if (pluggedSleep) {
      pluggedSleep.addEventListener("mousedown", function (event) {
        event.preventDefault();
        setSleepMenuOpen(!sleepMenu || sleepMenu.hidden);
        if (sleepMenu && !sleepMenu.hidden) {
          emit("install-guide:sleep-menu-open");
        }
      });
      pluggedSleep.addEventListener("change", function () {
        if (pluggedSleep.value === "never") {
          setSleepMenuOpen(false);
          emit("install-guide:sleep-never");
        }
      });
    }
    if (sleepMenu) {
      sleepMenu.addEventListener("click", function (event) {
        var btn = event.target.closest && event.target.closest("[data-pwr-sleep]");
        if (!btn || !pluggedSleep) return;
        pluggedSleep.value = btn.getAttribute("data-pwr-sleep");
        pluggedSleep.dispatchEvent(new Event("change", { bubbles: true }));
      });
    }
    var closeBtn = document.getElementById("pwrSettingsClose");
    if (closeBtn) {
      closeBtn.addEventListener("click", hidePowerSettings);
    }
  }

  wire();
  window.showPowerSettings = showPowerSettings;
  window.hidePowerSettings = hidePowerSettings;
  window.expandPowerSleepTimeouts = function () {
    setExpanded(true, true);
  };
  window.scrollPowerSleepMenu = scrollSleepMenuToNever;
})();
