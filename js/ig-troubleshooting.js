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
        "Click Reset — do NOT click Reset to Factory. Watch for a temperature alert confirming the reboot. Then click Load from Vessel to confirm ~20 mA output.",
    },
    {
      id: "controller-sleep",
      title: "Controller Goes to Sleep",
      explanation:
        "Expand Screen, sleep, and hibernation timeouts. Set “Make my device sleep after” to Never. Screen turning off is OK — only the sleep setting causes disconnects.",
    },
    {
      id: "auto-beam",
      title: "Auto Beam Selection Issues",
      explanation:
        "Verify all 6 beam checkboxes at the top are checked. Uncheck Auto Beam Selection at the bottom. Click Upload All to apply. Then click Load from Vessel to confirm correct readings.",
    },
    {
      id: "echo-curve",
      title: "How to Read the Echo Curve",
      explanation:
        "The Echo Curve starts automatically. Look for a grouping of colored lines — these represent the sensor's frequencies reflecting off the material. Lines start higher on the left (sensor at top of silo) and move right toward lower levels. Numbers along the bottom are feet from the sensor. Each line in the group is a different beam frequency. If all lines form a tight cluster with no erratic spikes away from the group, this is a Good echo curve — the sensor is reading correctly. An isolated spike far from the main cluster indicates a false echo.",
    },
    {
      id: "reset-mapping",
      title: "Reset Sensor Mapping",
      explanation:
        "From the Action Type list, select Reset User and Auto False Echoes, then click Reset Mapping. This clears all stored false echo maps from the sensor. Close the window, then click Load from Vessel to confirm the sensor is reading correctly.",
    },
    {
      id: "wizard-deadzone",
      title: "Wizard — Confirm Dimensions & Dead-Zone",
      explanation:
        "Confirm all silo measurements on each step are accurate, clicking Next through each screen. On the final Full Calibration screen, the Distance (Top) value must be no less than 1.64 ft — this is the sensor dead-zone. If material comes within 1.64 ft of the sensor, the sensor will lock at its last reading. You may enter a higher value to trigger 100% output before overfilling, but 1.64 ft is the absolute minimum. Click Finish to save.",
    },
    {
      id: "ap-review",
      title: "Advanced Parameters — Full Review & Upload",
      explanation:
        "On the Basic tab, confirm no values are negative or in the thousands — factory defaults work for most vessels; professional programming is needed for tuned adjustments. Click the Advanced tab and set Auto False Echoes to Deactivated. Then click the Beams tab: uncheck Auto Beam Selection and Automatic Beams Range, then click Select All above the beam list to activate all echo beams. Click Upload All to apply all changes to the sensor, then click Close.",
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

  function doneStep(explanation) {
    return click(
      "ts-done",
      "Do this",
      p(explanation),
      null,
      null,
      { blocking: true, primary: "Done", pointer: "none" }
    );
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
      click(
        "ts-fe-action",
        "Action Type",
        p("Leave Action Type on Reset User and Auto False Echoes. From, To, and Threshold stay “-” for a reset.") +
          "<p>The other actions are Scan and Manual Scan.</p>",
        "#mvFeActionType",
        null,
        { blocking: true, pointer: "right", allowInside: FE_INSIDE }
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
      "Click <strong>Close</strong>.",
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
      "</kbd>. Yellow is the next key. Gray letters are not typed yet — the box starts empty.</p>"
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

  function wizUnitSteps() {
    return [
      click(
        "wiz-set-feet",
        "Distance in feet",
        "Change <strong>Distance</strong> from m to <strong>ft</strong>.",
        "#mvWizDist",
        "install-guide:wiz-feet",
        { pointer: "right", allowInside: WIZ_INSIDE }
      ),
      click(
        "wiz-set-fahrenheit",
        "Temperature in Fahrenheit",
        "Change <strong>Temperature</strong> to <strong>Fahrenheit</strong>.",
        "#mvWizTemp",
        "install-guide:wiz-fahrenheit",
        { pointer: "right", allowInside: WIZ_INSIDE }
      ),
    ];
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
      { pointer: "bottom" }
    );
  }

  function buildSteps(item) {
    if (!item) return [];
    var steps = [];
    var id = item.id;

    if (id === "snr-zero") {
      steps = [
        click(
          "ts-snr-see",
          "SNR is 0",
          p("Overview SNR is 0.00 and shows Device in Low SNR. Continue to recover the signal."),
          "#mvOverviewProblems",
          null,
          { blocking: true, pointer: "right", allowInside: "#mvOverview" }
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
          p("Change Output Dampening Power to 420.") +
            "<p>In this window type <strong>Output Damping Time</strong>.</p>",
          "mvApDamping",
          "420",
          AP_INSIDE
        ),
        typeStep(
          "ts-snr-fill",
          "Max Filling Rate",
          p("Set Max Fill to 7.") + "<p>Type <strong>Max. Filling Rate</strong>.</p>",
          "mvApFillRate",
          "7",
          AP_INSIDE
        ),
        typeStep(
          "ts-snr-empty",
          "Max Emptying Rate",
          p("Set Max Empty to 8.") + "<p>Type <strong>Max. Emptying Rate</strong>.</p>",
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
          "Monitor SNR",
          p("Finally click Load from Vessel and monitor SNR.") +
            "<p>SNR is on the Overview pane at the left.</p>",
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
      steps = steps.concat(wizUnitSteps());
      steps = steps.concat(wizNextSteps());
      steps.push(
        typeStep(
          "ts-full-dist",
          "Distance (Top)",
          p("Change Distance (Top) to 1.64 ft. This is the sensor dead-zone minimum.") +
            "<p>Type Full Calib <strong>Distance (Top)</strong>.</p>",
          "mvWizFullDist",
          "1.64",
          WIZ_INSIDE
        ),
        click(
          "ts-full-finish",
          "Finish",
          "Click <strong>Finish</strong> to save the configuration.",
          "#mvWizNext",
          "install-guide:wiz-uploaded",
          { pointer: "bottom", allowInside: WIZ_INSIDE }
        ),
        loadFromVesselStep(),
        doneStep("Then click Load from Vessel to confirm the level reads correctly.")
      );
    } else if (id === "reset-after-map") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-act"]',
        "Devices Activations",
        "Click <strong>Devices Activations...</strong>.",
        "install-guide:devices-act-opened"
      );
      steps.push(
        click(
          "ts-reset-choice",
          "Reset — not Factory",
          p("Leave <strong>Reset (Restart) Device</strong> selected. Do not choose Reset to Factory Defaults.") +
            "<p>Click <strong>Reset</strong>.</p>",
          "#mvDevResetBtn",
          "install-guide:device-reset",
          { pointer: "right", allowInside: ACT_INSIDE }
        ),
        closeActStep(),
        loadFromVesselStep(),
        doneStep("Watch for a temperature alert confirming the reboot. Then click Load from Vessel to confirm ~20 mA output.")
      );
    } else if (id === "controller-sleep") {
      steps = [
        click(
          "ts-sleep-start",
          "Windows Start",
          "On the controller PC, click the Start button (lower-left).",
          "#winStartBtn",
          "install-guide:start-open",
          { pointer: "bottom", allowInside: "#winStartBtn, .win-taskbar, #winStartMenu, #winStartBackdrop" }
        ),
        doneStep(
          "Expand Screen, sleep, and hibernation timeouts. Set “Make my device sleep after” to Never. Screen turning off is OK — only the sleep setting causes disconnects."
        ),
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
          "Uncheck <strong>Auto Beam Selection</strong> so you can pick beams by hand.",
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
          "ts-beam-select-all",
          "Select All beams",
          "Click <strong>Select All</strong> so every echo beam is checked.",
          "#mvApBeamSelectAll",
          "install-guide:ap-beams-select-all",
          { pointer: "bottom", allowInside: AP_INSIDE }
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
        doneStep("Then click Load from Vessel to confirm correct readings.")
      );
    } else if (id === "echo-curve") {
      steps = [
        click(
          "ts-echo-open",
          "Echo Curve",
          "Click <strong>Echo Curve</strong> on the toolbar.",
          "#mvToolbarEchoCurve",
          "install-guide:echo-opened",
          { pointer: "bottom" }
        ),
        click(
          "ts-echo-start",
          "Start analysis",
          "Click <strong>Start</strong> to run Echo Curve Analysis.",
          "#mvEchoActStart",
          "install-guide:echo-started",
          { pointer: "bottom", allowInside: ECHO_INSIDE }
        ),
        click(
          "ts-echo-curve",
          "Echo Curve window",
          "Wait for the Echo Curve window to open.",
          "#mv-dlg-echo-curve",
          "install-guide:echo-curve-opened",
          { pointer: "none", allowInside: ECHO_INSIDE }
        ),
        click(
          "ts-echo-read",
          "How to read it",
          p(item.explanation),
          "#mv-dlg-echo-curve",
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "none",
            allowInside: ECHO_INSIDE,
          }
        ),
        click(
          "ts-echo-close-curve",
          "Close Echo Curve",
          "Close the Echo Curve window.",
          '#mv-dlg-echo-curve [data-mv-dlg-close="mv-dlg-echo-curve"], #mv-dlg-echo-curve .title-btn.close',
          "install-guide:echo-curve-closed",
          { pointer: "bottom", allowInside: ECHO_INSIDE }
        ),
        click(
          "ts-echo-close-act",
          "Close analysis",
          "Close Activate Echo Curve Analysis.",
          '#mv-dlg-echo-activate [data-mv-dlg-close="mv-dlg-echo-activate"], #mv-dlg-echo-activate .title-btn.close',
          "install-guide:echo-activate-closed",
          { pointer: "bottom", allowInside: ECHO_INSIDE }
        ),
        doneStep(item.explanation),
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
        doneStep(
          "This clears all stored false echo maps from the sensor. After Reset Mapping, click Load from Vessel in the toolbar to confirm the sensor is reading correctly."
        )
      );
    } else if (id === "wizard-deadzone") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-wizard"]',
        "Device Configuration Wizard",
        "Click <strong>Device Configuration Wizard...</strong>.",
        "install-guide:device-wizard-opened"
      );
      steps = steps.concat(wizUnitSteps());
      steps = steps.concat(wizNextSteps());
      steps.push(
        typeStep(
          "ts-dz-dist",
          "Dead-zone (Distance Top)",
          p(item.explanation),
          "mvWizFullDist",
          "1.64",
          WIZ_INSIDE
        ),
        click(
          "ts-dz-finish",
          "Finish",
          "Click <strong>Finish</strong> to save.",
          "#mvWizNext",
          "install-guide:wiz-uploaded",
          { pointer: "bottom", allowInside: WIZ_INSIDE }
        ),
        doneStep("Click Finish to save.")
      );
    } else if (id === "ap-review") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-advanced"]',
        "Advanced Parameters",
        "Click <strong>Advanced Parameters...</strong>.",
        "install-guide:advanced-params-opened"
      );
      steps.push(
        click(
          "ts-ap-vessel",
          "Vessel tab",
          p(
            "On the Basic tab, confirm no values are negative or in the thousands — factory defaults work for most vessels; professional programming is needed for tuned adjustments."
          ) + "<p>That review is on the <strong>Vessel</strong> tab in this window.</p>",
          '.mv-ap-tab[data-tab="vessel"]',
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "bottom",
            allowInside: AP_INSIDE,
          }
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
          "ts-ap-auto-fe",
          "Auto False Echoes",
          "Set <strong>Auto False Echoes</strong> to <strong>Disable</strong> (Deactivated).",
          "#mvApAutoFalseEchoes",
          "install-guide:ap-auto-false-off",
          { pointer: "right", allowInside: AP_INSIDE }
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
          "ts-ap-select-all",
          "Select All beams",
          "Click <strong>Select All</strong> above the beam list.",
          "#mvApBeamSelectAll",
          "install-guide:ap-beams-select-all",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        click(
          "ts-ap-upload",
          "Upload All",
          "Click <strong>Upload All</strong> to apply all changes.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: AP_INSIDE }
        ),
        closeApStep("ts-ap-close"),
        doneStep(item.explanation)
      );
    } else {
      steps = [doneStep(item.explanation || "")];
    }

    return steps;
  }

  function listHtml() {
    return ITEMS.map(function (item) {
      return (
        '<button type="button" class="ig-ts-item" data-ts-id="' +
        esc(item.id) +
        '">' +
        esc(item.title) +
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
