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
        "Change Output Dampening Power to 420, MPN Rate to 7, Max Fill to 7, Max Empty to 8. Click Upload All. Then go to Device › False Echo Mapping, select Reset Mapping and click Execute. Finally click Load from Vessel and monitor SNR.",
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
        "From the Action dropdown, select Reset User and Auto False Echoes, then click Execute. This clears all stored false echo maps from the sensor. After executing, click Load from Vessel in the toolbar to confirm the sensor is reading correctly.",
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
    }
    return step;
  }

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
        { pointer: "bottom" }
      ),
      click(
        "ts-device-item",
        itemTitle,
        itemBody,
        itemSel,
        openedEvent,
        { pointer: "right", allowInside: "#mv-popup-device, #mv-menu-device" }
      ),
    ];
  }

  function loadFromVesselStep() {
    return click(
      "ts-load-vessel",
      "Load from Vessel",
      "Click <strong>Load from Vessel</strong> on the toolbar, then confirm the reading.",
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
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-advanced"]',
        "Advanced Parameters",
        "Click <strong>Advanced Parameters...</strong>.",
        "install-guide:advanced-params-opened"
      );
      steps.push(
        click(
          "ts-snr-fields",
          "Damping, fill, and empty",
          p(
            "Change Output Dampening Power to 420, MPN Rate to 7, Max Fill to 7, Max Empty to 8."
          ) +
            "<p>In this window those values are <strong>Output Damping Time</strong>, <strong>Max. Filling Rate</strong> (7), and <strong>Max. Emptying Rate</strong> (8) on the Vessel tab.</p>",
          "#mvApDamping, #mvApFillRate, #mvApEmptyRate",
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "right",
            allowInside: "#mv-dlg-advanced-params",
          }
        ),
        click(
          "ts-snr-upload",
          "Upload All",
          "Click <strong>Upload All</strong> to push the changes.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        )
      );
      steps = steps.concat(
        deviceMenuThen(
          '[data-mv-menu-id="dev-false-echo"]',
          "False Echo Mapping",
          "Click <strong>Device False Echo Mapping...</strong>.",
          "install-guide:false-echo-opened"
        )
      );
      steps.push(
        click(
          "ts-snr-reset-map",
          "Reset Mapping",
          "Click <strong>Reset Mapping</strong> to clear stored maps.",
          '#mv-dlg-false-echo [data-mv-dlg-ok="mv-dlg-false-echo"]',
          "install-guide:false-echo-reset",
          { pointer: "bottom", allowInside: "#mv-dlg-false-echo" }
        ),
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
      steps.push(
        click(
          "ts-full-next",
          "Full / Empty Calibration",
          "Click <strong>Next</strong> until you reach Full / Empty Calibration.",
          "#mvWizNext",
          "install-guide:wiz-step-4",
          { pointer: "bottom", allowInside: "#mv-dlg-device-wizard" }
        ),
        click(
          "ts-full-dist",
          "Distance (Top)",
          p("Change Distance (Top) to 1.64. Click Finish to save.") +
            "<p>Use the Full Calib <strong>Distance (Top)</strong> field. The dead-zone minimum is 1.64 ft.</p>",
          "#mvWizFullDist",
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "right",
            allowInside: "#mv-dlg-device-wizard",
          }
        ),
        click(
          "ts-full-finish",
          "Finish",
          "Click <strong>Finish</strong> to save the configuration.",
          "#mvWizNext",
          "install-guide:wiz-uploaded",
          { pointer: "bottom", allowInside: "#mv-dlg-device-wizard" }
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
          p("Click Reset — do NOT click Reset to Factory.") +
            "<p>Leave <strong>Reset (Restart) Device</strong> selected. Do not choose Reset to Factory Defaults.</p>",
          "#mvDevResetBtn",
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "right",
            allowInside: "#mv-dlg-devices-act",
          }
        ),
        loadFromVesselStep(),
        doneStep("Watch for a temperature alert confirming the reboot. Then click Load from Vessel to confirm ~20 mA output.")
      );
    } else if (id === "controller-sleep") {
      steps = [
        click(
          "ts-sleep-start",
          "Windows Start",
          "On the controller PC, open the Start menu (lower-left).",
          "#winStartBtn",
          null,
          { blocking: true, primary: "Continue", pointer: "bottom", allowInside: "#winStartBtn, .win-taskbar" }
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
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-beam-uncheck",
          "Auto Beam Selection",
          p("Verify all 6 beam checkboxes at the top are checked. Uncheck Auto Beam Selection at the bottom.") +
            "<p>Use <strong>Select All</strong> if needed, then uncheck <strong>Auto Beam Selection</strong>.</p>",
          "#mvApAutoBeamSel",
          "install-guide:ap-beam-sel-off",
          { pointer: "right", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-beam-upload",
          "Upload All",
          "Click <strong>Upload All</strong> to apply.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        ),
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
          "ts-echo-read",
          "How to read it",
          p(item.explanation),
          "#mv-dlg-echo-activate",
          null,
          {
            blocking: true,
            primary: "Done",
            pointer: "none",
            allowInside: "#mv-dlg-echo-curve, #mv-dlg-echo-activate",
          }
        ),
      ];
    } else if (id === "reset-mapping") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-false-echo"]',
        "False Echo Mapping",
        "Click <strong>Device False Echo Mapping...</strong>.",
        "install-guide:false-echo-opened"
      );
      steps.push(
        click(
          "ts-fe-action",
          "Action Type",
          p(
            "From the Action dropdown, select Reset User and Auto False Echoes, then click Execute."
          ) +
            "<p>In this window choose the action, then click <strong>Reset Mapping</strong>.</p>",
          "#mvFeActionType",
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "right",
            allowInside: "#mv-dlg-false-echo",
          }
        ),
        click(
          "ts-fe-exec",
          "Reset Mapping",
          "Click <strong>Reset Mapping</strong>.",
          '#mv-dlg-false-echo [data-mv-dlg-ok="mv-dlg-false-echo"]',
          "install-guide:false-echo-reset",
          { pointer: "bottom", allowInside: "#mv-dlg-false-echo" }
        ),
        loadFromVesselStep(),
        doneStep(
          "This clears all stored false echo maps from the sensor. After executing, click Load from Vessel in the toolbar to confirm the sensor is reading correctly."
        )
      );
    } else if (id === "wizard-deadzone") {
      steps = deviceMenuThen(
        '[data-mv-menu-id="dev-wizard"]',
        "Device Configuration Wizard",
        "Click <strong>Device Configuration Wizard...</strong>.",
        "install-guide:device-wizard-opened"
      );
      steps.push(
        click(
          "ts-dz-next",
          "Work through the wizard",
          "Confirm measurements on each screen. Click <strong>Next</strong> until Full / Empty Calibration.",
          "#mvWizNext",
          "install-guide:wiz-step-4",
          { pointer: "bottom", allowInside: "#mv-dlg-device-wizard" }
        ),
        click(
          "ts-dz-dist",
          "Dead-zone (Distance Top)",
          p(item.explanation),
          "#mvWizFullDist",
          null,
          {
            blocking: true,
            primary: "Continue",
            pointer: "right",
            allowInside: "#mv-dlg-device-wizard",
          }
        ),
        click(
          "ts-dz-finish",
          "Finish",
          "Click <strong>Finish</strong> to save.",
          "#mvWizNext",
          "install-guide:wiz-uploaded",
          { pointer: "bottom", allowInside: "#mv-dlg-device-wizard" }
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
            allowInside: "#mv-dlg-advanced-params",
          }
        ),
        click(
          "ts-ap-adv-tab",
          "Advanced tab",
          "Click the <strong>Advanced</strong> tab.",
          '.mv-ap-tab[data-tab="adv"]',
          "install-guide:ap-tab-adv",
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-ap-auto-fe",
          "Auto False Echoes",
          "Set <strong>Auto False Echoes</strong> to <strong>Disable</strong> (Deactivated).",
          "#mvApAutoFalseEchoes",
          "install-guide:ap-auto-false-off",
          { pointer: "right", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-ap-beams-tab",
          "Beams Activation",
          "Click the <strong>Beams Activation</strong> tab.",
          '.mv-ap-tab[data-tab="beams"]',
          "install-guide:ap-tab-beams",
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-ap-beam-sel",
          "Auto Beam Selection",
          "Uncheck <strong>Auto Beam Selection</strong> and <strong>Automatic Beams Range</strong>, then click <strong>Select All</strong>.",
          "#mvApAutoBeamSel, #mvApAutoBeamRange, #mvApBeamSelectAll",
          "install-guide:ap-beam-sel-off",
          { pointer: "right", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-ap-upload",
          "Upload All",
          "Click <strong>Upload All</strong> to apply all changes, then Close.",
          "#mvApUploadAll",
          "install-guide:ap-uploaded",
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        ),
        click(
          "ts-ap-close",
          "Close",
          "Click <strong>Close</strong>.",
          "#mvApClose",
          "install-guide:ap-closed",
          { pointer: "bottom", allowInside: "#mv-dlg-advanced-params" }
        ),
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
