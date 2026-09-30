/**
 * Troubleshooting topics and walkthrough steps.
 * Advice from the 3D Vision emulator troubleshooting list; screens match this guide.
 */
(function (global) {
  "use strict";

  function esc(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
  }

  function p(text) {
    return "<p>" + esc(text) + "</p>";
  }

  var ITEMS = [
    {
      id: "capture-3d",
      title: "3D Capture",
      blurb: "Open the BinMaster support page and use 3DCAPTURE.",
      explanation:
        "3D Capture is on the BinMaster support site. Click Open page. That opens https://support.binmaster.com/kb/view/637b3236-68d8-4e7c-ba5b-d4b7308225b5 in your browser. Use 3DCAPTURE on that page.",
    },
    {
      id: "snr-zero",
      title: "SNR Reading is 0",
      explanation:
        "Change Output Dampening Power to 420, MPN Rate to 7, Max Fill to 7, Max Empty to 8. Click Upload All. Then go to Device › False Echo Mapping, confirm Action Type is Reset User and Auto False Echoes, click Reset Mapping, Close, then Load from Vessel and monitor SNR.",
    },
    {
      id: "sensor-full",
      title: "Sensor Reading Full (Wrong Level)",
      explanation:
        "Change Distance (Top) to 1.64. Click Finish to save. Then click Load from Vessel to confirm the level reads correctly.",
    },
    {
      id: "reset-after-map",
      title: "Sensor Reset After Mapping Clear",
      explanation:
        "Click Reset, then Yes on the confirmation. Do not choose Reset to Factory Defaults. The picture disappears and the readings stay at 0. Watch the vessel, then click Load from Vessel. The picture comes back after that.",
    },
    {
      id: "controller-sleep",
      title: "Controller Goes to Sleep",
      explanation:
        "Search for sleep and open Power, sleep, and battery settings. Expand Screen, sleep, and hibernate timeouts. Under Plugged in, set Make my device sleep after to Never. Screen off is OK.",
    },
    {
      id: "auto-beam",
      title: "Auto Beam Selection Issues",
      explanation:
        "Uncheck Auto Beam Selection and Automatic Beams Range. The beams are already on. Click Upload All to apply, then click Load from Vessel to confirm the reading.",
    },
    {
      id: "echo-curve",
      title: "How to Read the Echo Curve",
      explanation:
        "The Echo Curve starts automatically. Look for a grouping of colored lines. These represent the sensor's frequencies reflecting off the material. Lines start higher on the left (sensor at top of silo) and move right toward lower levels. Numbers along the bottom are feet from the sensor. Click All Beams. Each color is one beam. If all lines form a tight cluster with no erratic spikes away from the group, this is a Good echo curve. The sensor is reading correctly. An isolated spike far from the main cluster indicates a false echo.",
    },
    {
      id: "reset-mapping",
      title: "Reset Sensor Mapping",
      explanation:
        "From the Action Type list, select Reset User and Auto False Echoes, then click Reset Mapping. This clears all stored false echo maps from the sensor. Close the window, then click Load from Vessel to confirm the sensor is reading correctly.",
    },
    {
      id: "wizard-deadzone",
      title: "Wizard: Confirm Dimensions & Dead-Zone",
      explanation:
        "Confirm all silo measurements on each step are accurate, clicking Next through each screen. On the final Full Calibration screen, the Distance (Top) value must be no less than 1.64 ft. This is the sensor dead-zone. If material comes within 1.64 ft of the sensor, the sensor will lock at its last reading. You may enter a higher value to trigger 100% output before overfilling, but 1.64 ft is the absolute minimum. Click Finish to save.",
    },
    {
      id: "ap-review",
      title: "Advanced Parameters: Full Review & Upload",
      explanation:
        "On the Basic tab, confirm no values are negative or in the thousands. Factory defaults work for most vessels; professional programming is needed for tuned adjustments. Click the Advanced tab, open Auto False Echoes, and choose Disable. Then click the Beams tab and uncheck Auto Beam Selection and Automatic Beams Range. Click Upload All to apply all changes to the sensor, then click Close.",
    },
  ];

  function click(id, title, body, target, advanceOn, extra) {
    var step = {
      id: id,
      phase: "ts",
      title: title,
      body: body,
      target: target,
      pointer: extra && extra.pointer ? extra.pointer : "bottom",
    };
    if (advanceOn) step.advanceOn = advanceOn;
    if (extra) {
      if (extra.blocking) step.blocking = true;
      if (extra.primary) step.primary = extra.primary;
      if (extra.allowInside) step.allowInside = extra.allowInside;
      if (extra.pointer === "none") step.pointer = "none";
      if (extra.typeId) step.typeId = extra.typeId;
      if (extra.typeValue) step.typeValue = extra.typeValue;
    }
    return step;
  }

  var AP_INSIDE =
    "#mv-dlg-advanced-params, #mvApClose, #mv-dlg-advanced-params .title-btn.close, #mv-dlg-progress";
  var WIZ_INSIDE = "#mv-dlg-device-wizard";
  var FE_INSIDE = "#mv-dlg-false-echo";
  var ACT_INSIDE = "#mv-dlg-devices-act";
  var ECHO_INSIDE = "#mv-dlg-echo-curve, #mv-dlg-echo-activate";
  var DEVICE_MENU = "#mv-popup-device, #mv-menu-device";

  function doneStep(line) {
    return click("ts-done", "Done", line, null, null, {
      blocking: true,
      primary: "Done",
      pointer: "none",
    });
  }

  function nextStep(id, title, line) {
    return click(id, title, line, null, null, {
      blocking: true,
      primary: "Next",
      pointer: "none",
    });
  }

  function deviceMenuThen(itemSel, itemTitle, itemBody, openedEvent) {
    return [
      click(
        "ts-device-menu",
        "Open Device",
        "Click <strong>Device</strong> on the menu bar.",
        "#mv-menu-device",
        "install-guide:device-menu-open",
        { pointer: "bottom", allowInside: DEVICE_MENU }
      ),
      click(
        "ts-device-item",
        itemTitle,
        itemBody,
        itemSel,
        openedEvent,
        { pointer: "right", allowInside: DEVICE_MENU }
      ),
    ];
  }

  function closeApStep(id) {
    return click(
      id || "ts-ap-close",
      "Close Advanced Parameters",
      "Click <strong>Close</strong> on Advanced Parameters before the next step.",
      "#mvApClose",
      "install-guide:ap-closed",
      { pointer: "bottom", allowInside: AP_INSIDE }
    );
  }

  function closeFeStep() {
    return click(
      "ts-fe-close",
      "Close Mapping",
      "Click <strong>Close</strong>.",
      '#mv-dlg-false-echo [data-mv-dlg-close="mv-dlg-false-echo"], #mv-dlg-false-echo .title-btn.close',
      "install-guide:false-echo-closed",
      { pointer: "bottom", allowInside: FE_INSIDE }
    );
  }

  function falseEchoResetSteps() {
    return [
      nextStep(
        "ts-fe-action",
        "Action Type",
        "Leave <strong>Action Type</strong> on <strong>Reset User and Auto False Echoes</strong>."
      ),
      click(
        "ts-fe-reset",
        "Reset Mapping",
        "Click <strong>Reset Mapping</strong> to clear stored maps. The window stays open until you Close.",
        "#mvFeResetBtn",
        "install-guide:false-echo-reset",
        { pointer: "bottom", allowInside: FE_INSIDE }
      ),
      closeFeStep(),
    ];
  }

  function closeActStep() {
    return click(
      "ts-act-close",
      "Close Devices Activations",
      "Click the window <strong>Close</strong> button.",
      '#mv-dlg-devices-act [data-mv-dlg-close="mv-dlg-devices-act"], #mv-dlg-devices-act .title-btn.close',
      "install-guide:devices-act-closed",
      { pointer: "bottom", allowInside: ACT_INSIDE }
    );
  }

  function typeBody(lead, value) {
    return (
      lead +
      '<p class="ig-type-hint">Type <kbd>' +
      esc(value) +
      "</kbd>. Yellow is the next key. Gray letters are not typed yet. The box starts empty.</p>"
    );
  }

  function typeStep(id, title, lead, fieldId, value, allowInside) {
    return click(
      id,
      title,
      typeBody(lead, value),
      "#" + fieldId,
      "install-guide:typed-ok",
      {
        pointer: "right",
        allowInside: allowInside,
        typeId: fieldId,
        typeValue: value,
      }
    );
  }

  function wizNextSteps() {
    return [
      click(
        "ts-wiz-next-2",
        "Device Position",
        "Click <strong>Next</strong> to open Device Position.",
        "#mvWizNext",
        "install-guide:wiz-step-2",
        { pointer: "bottom", allowInside: WIZ_INSIDE }
      ),
      click(
        "ts-wiz-next-3",
        "Filling Points",
        "Click <strong>Next</strong> to open Filling Points.",
        "#mvWizNext",
        "install-guide:wiz-step-3",
        { pointer: "bottom", allowInside: WIZ_INSIDE }
      ),
      click(
        "ts-wiz-next-4",
        "Full / Empty Calibration",
        "Click <strong>Next</strong> to open Full / Empty Calibration.",
        "#mvWizNext",
        "install-guide:wiz-step-4",
        { pointer: "bottom", allowInside: WIZ_INSIDE }
      ),
    ];
  }

  function loadFromVesselStep() {
    return click(
      "ts-load-vessel",
      "Load from Vessel",
      "Click <strong>Load from Vessel</strong> on the toolbar.",
      "#mvToolbarLoadVessel",
      "install-guide:load-from-vessel",
      { pointer: "bottom", allowInside: "#mv-dlg-progress" }
    );
  }

  function buildSteps(item) {
    if (!item) return [];
    var steps = [];
    var id = item.id;

    if (id === "capture-3d") {
      steps = [
        click(
          "ts-cap-open",
          "3D Capture",
          "3D Capture is on the BinMaster support site. Click <strong>Open page</strong>.",
          null,
          null,
          { blocking: true, primary: "Open page", pointer: "none" }
        ),
        click(
          "ts-cap-follow",
          "3D Capture",
          "Use <strong>3DCAPTURE</strong> on the page that opened in your browser.",
          null,
          null,
          { blocking: true, primary: "Done", pointer: "none" }
        ),
      ];
    } else if (id === "snr-zero") {
      steps = [
        nextStep(
          "ts-snr-see",
          "SNR is 0",
          "Overview shows <strong>SNR 0.00</strong> and <strong>Device in Low SNR</strong>."
        ),
      ];
      steps = steps.concat(
        deviceMenuThen(
          '[data-mv-menu-id="dev-advanced"]',
          "Advanced Parameters",
          "Click <strong>Advanced Parameters...</strong>.",
          "install-guide:advanced-params-opened"
        )
      );
      steps.push(
        typeStep(
          "ts-snr-damp",
          "Output Damping Time",
          "Type <strong>420</strong> in <strong>Output Damping Time</strong>.",
          "mvApDamping",
          "420",
          AP_INSIDE
        ),
        typeStep(
          "ts-snr-fill",
          "Max Filling Rate",
          "Type <strong>7</strong> in <strong>Max. Filling Rate</strong>.",
          "mvApFillRate",
          "7",
          AP_INSIDE
        ),
        typeStep(
          "ts-snr-empty",
          "Max Emptying Rate",
          "Type <strong>8</strong> in <strong>Max. Emptying Rate</strong>.",
          "mvApEmptyRate",
          "8",
          AP_INSIDE
        ),
        click(
          "ts-snr-upload",
          "Upload All",
          "Click <strong>Upload All</strong> to push the changes.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        closeApStep("ts-snr-close")
      );
      steps = steps.concat(
        deviceMenuThen(
          '[data-mv-menu-id="dev-false-echo"]',
          "False Echo Mapping",
          "Click <strong>Device False Echo Mapping...</strong>.",
          "install-guide:false-echo-opened"
        )
      );
      steps = steps.concat(falseEchoResetSteps());
      steps.push(
        loadFromVesselStep(),
        click(
          "ts-snr-watch",
          "Check SNR",
          "Read <strong>SNR</strong> on the left.",
          "#mvOvSnr",
          null,
          { blocking: true, primary: "Done", pointer: "right", allowInside: "#mvOverview" }
        )
      );
    } else if (id === "sensor-full") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-wizard"]',
        "Device Configuration Wizard",
        "Click <strong>Device Configuration Wizard...</strong>.",
        "install-guide:device-wizard-opened"
      );
      steps = steps.concat(wizNextSteps());
      steps.push(
        typeStep(
          "ts-full-dist",
          "Distance (Top)",
          "Type <strong>1.64</strong> in Full Calib <strong>Distance (Top)</strong>.",
          "mvWizFullDist",
          "1.64",
          WIZ_INSIDE
        ),
        click(
          "ts-full-finish",
          "Finish",
          "Click <strong>Finish</strong>.",
          "#mvWizNext",
          "install-guide:wiz-uploaded",
          { pointer: "bottom", allowInside: WIZ_INSIDE }
        ),
        loadFromVesselStep(),
        doneStep("Check the level on Overview.")
      );
    } else if (id === "reset-after-map") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-act"]',
        "Devices Activations",
        "Click <strong>Devices Activations...</strong>.",
        "install-guide:devices-act-opened"
      );
      steps.push(
        nextStep(
          "ts-reset-choice",
          "Restart, not Factory",
          "Leave <strong>Reset (Restart) Device</strong> selected. Do not choose <strong>Reset to Factory Defaults</strong>."
        ),
        click(
          "ts-reset-go",
          "Reset",
          "Click <strong>Reset</strong>.",
          "#mvDevResetBtn",
          "install-guide:device-reset-ask",
          { pointer: "right", allowInside: "#mv-dlg-devices-act" }
        ),
        click(
          "ts-reset-yes",
          "Confirm reset",
          "Click <strong>Yes</strong>. Wait until the reset finishes.",
          "#btn-mv-msg-yes",
          "install-guide:device-reset",
          {
            pointer: "bottom",
            allowInside: "#mvMsgOverlay, #mv-dlg-progress, #mv-dlg-devices-act",
          }
        ),
        closeActStep(),
        click(
          "ts-reset-watch",
          "Sensor is down",
          "The picture is gone and every reading is <strong>0</strong>. Watch the vessel. It stays like this for about <strong>15 seconds</strong>.",
          "#mvOverview3d",
          "install-guide:device-reboot-watch",
          { pointer: "bottom", allowInside: "#mvOverview" }
        ),
        loadFromVesselStep(),
        click(
          "ts-reset-back",
          "Sensor is answering",
          "The picture and the readings come back after <strong>Load from Vessel</strong>.",
          "#mvOverview3d",
          "install-guide:device-reboot-back",
          { pointer: "bottom", allowInside: "#mvOverview" }
        ),
        doneStep("<strong>Sensor Reset Complete!</strong>")
      );
    } else if (id === "controller-sleep") {
      var SLEEP_INSIDE = "#backdropPowerSettings, #winStartMenu";
      steps = [
        click(
          "ts-sleep-start",
          "Start",
          "Click <strong>Start</strong>.",
          "#winStartBtn",
          "install-guide:start-open",
          { pointer: "right" }
        ),
        click(
          "ts-sleep-type",
          "Search sleep",
          "Type <strong>sleep</strong> in the search box.",
          "#winStartSearch",
          "install-guide:typed-ok",
          { pointer: "bottom", allowInside: "#winStartMenu", typeId: "winStartSearch", typeValue: "sleep" }
        ),
        click(
          "ts-sleep-open",
          "Sleep settings",
          "Click <strong>Power, sleep, and battery settings</strong>.",
          "#winSearchHitSleep",
          "install-guide:sleep-settings-opened",
          { pointer: "right", allowInside: "#winSearchPanelSleep" }
        ),
        click(
          "ts-sleep-expand",
          "Timeouts",
          "Click <strong>Screen, sleep, &amp; hibernate timeouts</strong>.",
          "#pwrSleepTimeouts",
          "install-guide:sleep-timeouts-open",
          { pointer: "bottom", allowInside: SLEEP_INSIDE }
        ),
        click(
          "ts-sleep-menu",
          "Sleep after",
          "Under <strong>Plugged in</strong>, click <strong>Make my device sleep after</strong>.",
          "#pwrSleepPlugged",
          "install-guide:sleep-menu-open",
          { pointer: "bottom", allowInside: SLEEP_INSIDE }
        ),
        click(
          "ts-sleep-never",
          "Never",
          "Click <strong>Never</strong>.",
          "#pwrSleepOptNever",
          "install-guide:sleep-never",
          { pointer: "bottom", allowInside: SLEEP_INSIDE }
        ),
        doneStep("Leave the screen timeout as it is. Screen off is OK."),
      ];
    } else if (id === "auto-beam") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-advanced"]',
        "Advanced Parameters",
        "Click <strong>Advanced Parameters...</strong>.",
        "install-guide:advanced-params-opened"
      );
      steps.push(
        click(
          "ts-beam-tab",
          "Beams Activation",
          "Click the <strong>Beams Activation</strong> tab.",
          '.mv-ap-tab[data-tab="beams"]',
          "install-guide:ap-tab-beams",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        click(
          "ts-beam-uncheck",
          "Auto Beam Selection",
          "Uncheck <strong>Auto Beam Selection</strong>.",
          "#mvApAutoBeamSel",
          "install-guide:ap-beam-sel-off",
          { pointer: "right", allowInside: AP_INSIDE }
        ),
        click(
          "ts-beam-range",
          "Automatic Beams Range",
          "Uncheck <strong>Automatic Beams Range</strong>.",
          "#mvApAutoBeamRange",
          "install-guide:ap-beam-range-off",
          { pointer: "right", allowInside: AP_INSIDE }
        ),
        click(
          "ts-beam-upload",
          "Upload All",
          "Click <strong>Upload All</strong> to apply.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        closeApStep("ts-beam-close"),
        loadFromVesselStep(),
        doneStep("Check the reading on Overview.")
      );
    } else if (id === "echo-curve") {
      steps = [
        click(
          "ts-echo-open",
          "Echo Curve",
          "Click <strong>Echo Curve</strong> on the toolbar. Analysis starts on its own.",
          "#mvToolbarEchoCurve",
          "install-guide:echo-opened",
          { pointer: "bottom" }
        ),
        click(
          "ts-echo-curve",
          "Echo Curve window",
          "Wait. The Echo Curve window opens on its own.",
          "#mv-dlg-echo-curve",
          "install-guide:echo-curve-opened",
          { pointer: "none", allowInside: ECHO_INSIDE }
        ),
        nextStep(
          "ts-echo-left",
          "Left to right",
          "Lines start on the left (sensor) and move right (lower in the silo)."
        ),
        nextStep(
          "ts-echo-feet",
          "Bottom numbers",
          "Numbers along the bottom are feet from the sensor."
        ),
        nextStep(
          "ts-echo-good",
          "Good curve",
          "A tight group of lines, with no spike away from the group, is a good curve."
        ),
        nextStep(
          "ts-echo-bad",
          "False echo",
          "A spike far from that group is a false echo."
        ),
        click(
          "ts-echo-all",
          "All Beams",
          "Click <strong>All Beams</strong>. Each color is one beam.",
          '[data-echo-beam="all"]',
          "install-guide:echo-all-beams",
          { pointer: "bottom" }
        ),
        nextStep(
          "ts-echo-all-good",
          "Same good curve",
          "All beams together still form one tight group around the same distance. A spike away from that group is a false echo."
        ),
        click(
          "ts-echo-close-curve",
          "Close Echo Curve",
          "Click <strong>Close</strong> on the Echo Curve window.",
          '#mv-dlg-echo-curve [data-mv-dlg-close="mv-dlg-echo-curve"], #mv-dlg-echo-curve .title-btn.close',
          "install-guide:echo-curve-closed",
          { pointer: "bottom", allowInside: ECHO_INSIDE }
        ),
        click(
          "ts-echo-close-act",
          "Close analysis",
          "Click <strong>Close</strong> on Activate Echo Curve Analysis.",
          '#mv-dlg-echo-activate [data-mv-dlg-close="mv-dlg-echo-activate"], #mv-dlg-echo-activate .title-btn.close',
          "install-guide:echo-activate-closed",
          { pointer: "bottom", allowInside: ECHO_INSIDE }
        ),
        doneStep("That is how you read the Echo Curve."),
      ];
    } else if (id === "reset-mapping") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-false-echo"]',
        "False Echo Mapping",
        "Click <strong>Device False Echo Mapping...</strong>.",
        "install-guide:false-echo-opened"
      );
      steps = steps.concat(falseEchoResetSteps());
      steps.push(
        loadFromVesselStep(),
        doneStep("Check the reading on Overview.")
      );
    } else if (id === "wizard-deadzone") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-wizard"]',
        "Device Configuration Wizard",
        "Click <strong>Device Configuration Wizard...</strong>.",
        "install-guide:device-wizard-opened"
      );
      steps = steps.concat(wizNextSteps());
      steps.push(
        nextStep(
          "ts-dz-min",
          "Dead-zone",
          "<strong>Distance (Top)</strong> cannot be under <strong>1.64 ft</strong>."
        ),
        typeStep(
          "ts-dz-dist",
          "Distance (Top)",
          "Type <strong>1.64</strong> in <strong>Distance (Top)</strong>.",
          "mvWizFullDist",
          "1.64",
          WIZ_INSIDE
        ),
        click(
          "ts-dz-finish",
          "Finish",
          "Click <strong>Finish</strong>.",
          "#mvWizNext",
          "install-guide:wiz-uploaded",
          { pointer: "bottom", allowInside: WIZ_INSIDE }
        ),
        doneStep("The dead-zone is saved.")
      );
    } else if (id === "ap-review") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-advanced"]',
        "Advanced Parameters",
        "Click <strong>Advanced Parameters...</strong>.",
        "install-guide:advanced-params-opened"
      );
      steps.push(
        nextStep(
          "ts-ap-vessel",
          "Vessel tab",
          "On the <strong>Vessel</strong> tab, check that no value is negative or in the thousands."
        ),
        click(
          "ts-ap-adv-tab",
          "Advanced tab",
          "Click the <strong>Advanced</strong> tab.",
          '.mv-ap-tab[data-tab="adv"]',
          "install-guide:ap-tab-adv",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-auto-fe-open",
          "Auto False Echoes",
          "Click the <strong>Auto False Echoes</strong> dropdown.",
          "#mvApAutoFalseEchoes",
          "install-guide:ap-auto-false-open",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-auto-fe",
          "Disable",
          "Click <strong>Disable</strong>.",
          "#mvApAutoFalseEchoesDisable",
          "install-guide:ap-auto-false-off",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-beams-tab",
          "Beams Activation",
          "Click the <strong>Beams Activation</strong> tab.",
          '.mv-ap-tab[data-tab="beams"]',
          "install-guide:ap-tab-beams",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-beam-sel",
          "Auto Beam Selection",
          "Uncheck <strong>Auto Beam Selection</strong>.",
          "#mvApAutoBeamSel",
          "install-guide:ap-beam-sel-off",
          { pointer: "right", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-beam-range",
          "Automatic Beams Range",
          "Uncheck <strong>Automatic Beams Range</strong>.",
          "#mvApAutoBeamRange",
          "install-guide:ap-beam-range-off",
          { pointer: "right", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-upload",
          "Upload All",
          "Click <strong>Upload All</strong>.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        closeApStep("ts-ap-close"),
        doneStep("Advanced Parameters are uploaded.")
      );
    } else {
      steps = [doneStep(item.explanation || "")];
    }

    return steps;
  }

  function listHtml() {
    return ITEMS.map(function (item) {
      var note = item.blurb
        ? '<span class="ig-ts-blurb">' + esc(item.blurb) + "</span>"
        : "";
      return (
        '<button type="button" class="ig-ts-item" data-ts-id="' +
        esc(item.id) +
        '"><span class="ig-ts-item-title">' +
        esc(item.title) +
        "</span>" +
        note +
        "</button>"
      );
    }).join("");
  }

  global.IgTroubleshooting = {
    items: ITEMS,
    find: function (id) {
      var i;
      for (i = 0; i < ITEMS.length; i++) {
        if (ITEMS[i].id === id) return ITEMS[i];
      }
      return null;
    },
    buildSteps: buildSteps,
    listHtml: listHtml,
  };
})(window);
