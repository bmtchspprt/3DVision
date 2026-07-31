/**
 * MultiVision STech settings windows (ported from MainScreen / APM.WPF.*.xaml).
 * Layouts match connected STech server sessions — not Demo Mode restrictions.
 */
(function (global) {
  "use strict";

  var host = null;
  var openIds = [];
  var windowZ = 1350;

  function bringToFront(id) {
    var el = $(id);
    if (!el || el.hidden) return;
    windowZ += 1;
    el.style.zIndex = String(windowZ);
    var i = openIds.indexOf(id);
    if (i >= 0) openIds.splice(i, 1);
    openIds.push(id);
  }

  function wireWindowStacking(root) {
    if (!root || root.__mvStackWired) return;
    root.__mvStackWired = true;
    root.addEventListener(
      "mousedown",
      function (e) {
        if (e.target.closest(".mv-dialog")) {
          bringToFront(root.id);
        }
      },
      true
    );
  }
  var demoRunSpeed = "Fast";
  var demoRunning = true;
  var clientSettings = {
    rows: "2",
    cols: "2",
    minW: "80",
    maxW: "160",
    minH: "100",
    maxH: "200",
    nameMinW: "90",
    nameMaxH: "180",
    reduced: false,
    enlargeText: false,
    enlargeSites: false,
    vesselsBySite: true,
    autoSave: false,
    saveWarn: true,
    logo: "",
    lowRes: false,
    lockScreen: false,
    showVesselOnly: false,
    autoAspect: true,
    secondaryScreen: false,
  };

  function $(id) {
    return document.getElementById(id);
  }

  function ensureHost() {
    if (!host) host = $("mvDialogHost");
    return host;
  }

  function showMessage(text, title) {
    var overlay = $("mvMsgOverlay");
    var t = $("mvMsgTitle");
    var p = $("mvMsgText");
    var ok = $("btn-mv-msg-ok");
    var yes = $("btn-mv-msg-yes");
    var no = $("btn-mv-msg-no");
    if (t) t.textContent = title || "3D MultiVision";
    if (p) p.textContent = text || "";
    if (ok) ok.hidden = false;
    if (yes) yes.hidden = true;
    if (no) no.hidden = true;
    overlay.__mvMsgOnYes = null;
    overlay.__mvMsgOnNo = null;
    if (overlay) overlay.hidden = false;
  }

  /** APMMessageBox.ShowQuestionMessage — Yes/No + Exclamation caption. */
  function showQuestion(text, title, onYes, onNo) {
    var overlay = $("mvMsgOverlay");
    var t = $("mvMsgTitle");
    var p = $("mvMsgText");
    var ok = $("btn-mv-msg-ok");
    var yes = $("btn-mv-msg-yes");
    var no = $("btn-mv-msg-no");
    if (t) t.textContent = title || "3D MultiVision";
    if (p) p.textContent = text || "";
    if (ok) ok.hidden = true;
    if (yes) yes.hidden = false;
    if (no) no.hidden = false;
    if (overlay) {
      overlay.__mvMsgOnYes = typeof onYes === "function" ? onYes : null;
      overlay.__mvMsgOnNo = typeof onNo === "function" ? onNo : null;
      overlay.hidden = false;
    }
  }

  function hideMessage() {
    var overlay = $("mvMsgOverlay");
    if (overlay) {
      overlay.hidden = true;
      overlay.__mvMsgOnYes = null;
      overlay.__mvMsgOnNo = null;
    }
    var ok = $("btn-mv-msg-ok");
    var yes = $("btn-mv-msg-yes");
    var no = $("btn-mv-msg-no");
    if (ok) ok.hidden = false;
    if (yes) yes.hidden = true;
    if (no) no.hidden = true;
  }

  function status(msg) {
    if (typeof global.mvSetStatusText === "function") {
      global.mvSetStatusText(msg);
    } else {
      showMessage(msg);
    }
  }

  function closeDialog(id) {
    var el = $(id);
    if (el) {
      el.hidden = true;
      var i = openIds.indexOf(id);
      if (i >= 0) openIds.splice(i, 1);
    }
    if (id === "mv-dlg-device-wizard" && global.MvWizard3D) {
      global.MvWizard3D.destroy();
    }
  }

  function closeAllDialogs() {
    openIds.slice().forEach(closeDialog);
    hideMessage();
  }

  function openDialog(id) {
    ensureDialog(id);
    var el = $(id);
    if (!el) return;
    el.hidden = false;
    if (openIds.indexOf(id) < 0) openIds.push(id);
    bringToFront(id);
    wireWindowStacking(el);
    if (id === "mv-dlg-device-wizard" && typeof el.__mvWizRefresh === "function") {
      // New wizard session → DeviceDefinType starts Unknown (RotateFromTop only on first Vessel→Device).
      el.__mvWizDeviceDefin = "unknown";
      el.__mvWizDeviceDefinPrev = "unknown";
      el.__mvWizPrevStep = 1;
      if (typeof el.__mvWizGoStep === "function") {
        el.__mvWizGoStep(1);
      } else {
        setTimeout(function () {
          el.__mvWizRefresh();
        }, 40);
      }
    }
    if (id === "mv-dlg-project-wizard" && typeof el.__mvProjWizReset === "function") {
      el.__mvProjWizReset();
    }
    if (id === "mv-dlg-adv-summary") {
      populateAdvSummary(el);
    }
  }

  function titleBar(title, closeId) {
    return (
      '<div class="title-bar">' +
      '<img class="title-bar-icon" src="assets/images/logo_icon.ico" alt="" width="16" height="16">' +
      '<span class="title-bar-text">' +
      title +
      "</span>" +
      '<div class="title-bar-controls">' +
      '<button class="title-btn close" type="button" data-mv-dlg-close="' +
      closeId +
      '" aria-label="Close">&#10005;</button>' +
      "</div></div>"
    );
  }

  function footerOkCancel(id, okLabel, cancelLabel) {
    return (
      '<div class="mv-dialog-footer">' +
      '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="' +
      id +
      '">' +
      (okLabel || "OK") +
      "</button>" +
      '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="' +
      id +
      '">' +
      (cancelLabel || "Cancel") +
      "</button></div>"
    );
  }

  function wrapDialog(id, title, width, bodyHtml, footerHtml) {
    return (
      '<div class="modal-overlay mv-modal-overlay" id="' +
      id +
      '" hidden>' +
      '<div class="mv-dialog" role="dialog" aria-modal="true" style="width:' +
      width +
      'px">' +
      titleBar(title, id) +
      '<div class="mv-dialog-body">' +
      bodyHtml +
      "</div>" +
      (footerHtml == null ? footerOkCancel(id) : footerHtml) +
      "</div></div>"
    );
  }

  function sessionInfo() {
    if (typeof global.mvGetSession === "function") {
      return global.mvGetSession();
    }
    return {
      userName: "stech",
      serverHost: "127.0.0.1:22222",
      viewTitle: "Aggregates",
      isDemo: false,
    };
  }

  function vesselsOptionsHtml() {
    var list =
      typeof global.mvGetVessels === "function" ? global.mvGetVessels() : [];
    if (!list.length) {
      return '<option>Coke (MV)</option><option>Lime Stone (MV)</option>';
    }
    return list
      .map(function (v) {
        return "<option value=\"" + v.id + "\">" + (v.name || v.short) + "</option>";
      })
      .join("");
  }

  function deviceOptionsHtml() {
    // AdvParams combo shows scanner display + poll/scada addr, e.g. "Carmel Ulpinim (1)".
    var list =
      typeof global.mvGetVessels === "function" ? global.mvGetVessels() : [];
    if (!list.length) {
      return '<option selected>Carmel Ulpinim (1)</option>';
    }
    return list
      .map(function (v, i) {
        var name = v.scannerName || v.short || v.name || "Device";
        var addr = v.scadaId != null ? v.scadaId : v.poll != null ? v.poll : i + 1;
        return (
          "<option" +
          (i === 0 ? " selected" : "") +
          ">" +
          name +
          " (" +
          addr +
          ")</option>"
        );
      })
      .join("");
  }

  /** GroupViewUC shell: caption + left radio nav + content panes (from WPFStuff.GroupView). */
  function groupViewBody(caption, panes) {
    var nav = panes
      .map(function (p, i) {
        return (
          '<label class="' +
          (i === 0 ? "is-active" : "") +
          '"><input type="radio" name="mvGvNav" data-pane="' +
          p.id +
          '"' +
          (i === 0 ? " checked" : "") +
          "> " +
          p.label +
          "</label>"
        );
      })
      .join("");
    var content = panes
      .map(function (p, i) {
        return (
          '<div class="mv-groupview-pane" data-pane="' +
          p.id +
          '"' +
          (i === 0 ? "" : " hidden") +
          ">" +
          p.html +
          "</div>"
        );
      })
      .join("");
    return (
      '<div class="mv-groupview">' +
      '<div class="mv-groupview-caption">' +
      caption +
      "</div>" +
      '<div class="mv-groupview-body">' +
      '<div class="mv-groupview-nav" role="radiogroup">' +
      nav +
      "</div>" +
      '<div class="mv-groupview-content">' +
      content +
      "</div></div></div>"
    );
  }

  var builders = {
    "mv-dlg-client-options": function () {
      var c = clientSettings;
      var panes = [
        {
          id: "site",
          label: "Site - Vessel",
          html:
            "<fieldset><legend>Site View Manual Layout</legend>" +
            '<div class="mv-dialog-row"><label>Number rows:</label><input type="text" id="mvCfgRows" value="' +
            c.rows +
            '" style="width:80px"></div>' +
            '<div class="mv-dialog-row"><label>Number columns:</label><input type="text" id="mvCfgCols" value="' +
            c.cols +
            '" style="width:80px"></div></fieldset>' +
            "<fieldset><legend>Site View Manual (Advanced - Vessel)</legend>" +
            '<div class="mv-dialog-row"><label>Vessel width limits (min, max):</label>' +
            '<span class="mv-gv-pair"><input type="text" id="mvCfgMinW" value="' +
            c.minW +
            '"><input type="text" id="mvCfgMaxW" value="' +
            c.maxW +
            '"></span></div>' +
            '<div class="mv-dialog-row"><label>Vessel height limits (min, max):</label>' +
            '<span class="mv-gv-pair"><input type="text" id="mvCfgMinH" value="' +
            c.minH +
            '"><input type="text" id="mvCfgMaxH" value="' +
            c.maxH +
            '"></span></div>' +
            '<div class="mv-dialog-row"><label>Group by name/material/site name<br>limits (min width, max height):</label>' +
            '<span class="mv-gv-pair"><input type="text" id="mvCfgNameMinW" value="' +
            c.nameMinW +
            '"><input type="text" id="mvCfgNameMaxH" value="' +
            c.nameMaxH +
            '"></span></div>' +
            '<label class="mv-check"><input type="checkbox" id="mvCfgReduced"' +
            (c.reduced ? " checked" : "") +
            "> Reduced vessel display (hide text on right)</label>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgEnlargeText"' +
            (c.enlargeText ? " checked" : "") +
            "> Enlarge text area width in vessel display</label></fieldset>" +
            "<fieldset><legend>Multi Sites Display</legend>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgEnlargeSites"' +
            (c.enlargeSites ? " checked" : "") +
            "> Enlarge Sites tool bar to maximum</label>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgVesselsBySite"' +
            (c.vesselsBySite ? " checked" : "") +
            "> Show vessels chart lines according to site</label></fieldset>" +
            '<div class="mv-groupview-apply-row"><button class="btn mv-params-btn" type="button" data-mv-dlg-apply="client-site" style="width:75px">Apply</button></div>',
        },
        {
          id: "project",
          label: "Project",
          html:
            '<label class="mv-check"><input type="checkbox" id="mvCfgAutoSave"' +
            (c.autoSave ? " checked" : "") +
            "> Auto save project on vessel change</label>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgSaveWarn"' +
            (c.saveWarn ? " checked" : "") +
            "> Show save project warning on vessel change</label>" +
            '<div class="mv-dialog-row" style="margin-top:16px"><label style="min-width:96px">Logo Image File:</label>' +
            '<input type="text" id="mvCfgLogo" value="' +
            c.logo +
            '" style="flex:1;min-width:180px"><button class="btn mv-params-btn" type="button" style="min-width:24px;width:24px;padding:0">...</button></div>' +
            '<div class="mv-groupview-apply-row"><button class="btn mv-params-btn" type="button" data-mv-dlg-apply="client-project" style="width:80px">OK</button></div>',
        },
        {
          id: "language",
          label: "Change Language",
          html:
            '<div class="mv-dialog-row" style="margin-top:12px"><label style="min-width:120px">Select Language:</label>' +
            '<select id="mvCfgLang" style="width:217px"><option>English</option><option>German - Deutsche</option><option>Spanish (Mexico) - Español (México)</option><option>Portuguese - Portugués</option><option>Russian - Русский</option><option>Chinese - 中文</option><option>Hebrew - עברית</option></select></div>' +
            '<p style="margin-top:16px;color:#697477">Please close and restart the application for changes to take effect.</p>',
        },
        {
          id: "servermode",
          label: "Server Connection Mode",
          html:
            '<fieldset style="width:172px;margin-top:12px"><legend>Server Connection Mode</legend>' +
            '<div style="display:flex;flex-direction:column;align-items:center;gap:14px;padding:12px 0">' +
            '<button class="btn mv-params-btn" type="button" style="width:77px">Multiple</button>' +
            '<button class="btn mv-params-btn" type="button" style="width:77px">Single</button>' +
            "</div></fieldset>",
        },
        {
          id: "filter",
          label: "Sites/Vessels Filtering",
          html:
            '<div style="border:1px solid #a0a0a0;background:#fff;min-height:360px;padding:8px;font-size:12px">' +
            '<div class="node site"><label class="mv-check"><input type="checkbox" checked> Aggregat</label></div>' +
            '<div style="padding-left:16px"><label class="mv-check"><input type="checkbox" checked> Lime Stone</label></div>' +
            '<div style="padding-left:16px"><label class="mv-check"><input type="checkbox" checked> Coke</label></div>' +
            '<div style="padding-left:16px"><label class="mv-check"><input type="checkbox" checked> Sand</label></div>' +
            '<div style="padding-left:16px"><label class="mv-check"><input type="checkbox" checked> Lime</label></div>' +
            "</div>" +
            '<div style="display:flex;justify-content:space-between;margin-top:8px">' +
            '<button class="btn mv-params-btn" type="button" style="width:75px">Select All</button>' +
            '<button class="btn mv-params-btn" type="button" data-mv-dlg-apply="client-filter" style="width:75px">Apply</button></div>',
        },
        {
          id: "display",
          label: "Display and Resolution",
          html:
            '<fieldset style="width:389px"><legend>Main Display</legend>' +
            '<label class="mv-check"><input type="checkbox" id="mvCfgLowRes"' +
            (c.lowRes ? " checked" : "") +
            "> Low Resolution</label>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgLock"' +
            (c.lockScreen ? " checked" : "") +
            "> Lock screen by client</label></fieldset>" +
            '<fieldset style="width:391px"><legend>3D Image</legend>' +
            '<label class="mv-check"><input type="checkbox" id="mvCfgVesselOnly"' +
            (c.showVesselOnly ? " checked" : "") +
            "> Show vessel only</label>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgAutoAspect"' +
            (c.autoAspect ? " checked" : "") +
            "> Automatic aspect ratio (Floating window)</label>" +
            '<label class="mv-check"><input type="checkbox" id="mvCfgSecondary"' +
            (c.secondaryScreen ? " checked" : "") +
            "> Show on Secondary screen (Floating window)</label></fieldset>" +
            '<div class="mv-groupview-apply-row"><button class="btn mv-params-btn" type="button" data-mv-dlg-apply="client-display" style="width:75px">Apply</button></div>',
        },
      ];
      return wrapDialog(
        "mv-dlg-client-options",
        "Client Settings",
        650,
        groupViewBody("Client Settings", panes),
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-client-options" style="width:85px">Close</button></div>'
      );
    },

    "mv-dlg-server-options": function () {
      var panes = [
        {
          id: "summary",
          label: "Summary",
          html:
            "<fieldset><legend>Server Summary Information</legend>" +
            '<div class="mv-dialog-row"><label>Server:</label><span>' +
            sessionInfo().serverHost +
            "</span></div>" +
            '<div class="mv-dialog-row"><label>Version:</label><span>3.1.010</span></div>' +
            '<div class="mv-dialog-row"><label>Status:</label><span>Connected</span></div>' +
            '<div class="mv-dialog-row"><label>Project:</label><span>' +
            sessionInfo().viewTitle +
            "</span></div>" +
            '<div class="mv-dialog-row"><label>User:</label><span>' +
            sessionInfo().userName +
            " (STech)</span></div></fieldset>",
        },
        {
          id: "config",
          label: "Configuration",
          html:
            "<fieldset><legend>Configuration</legend>" +
            '<div class="mv-dialog-row"><label>Poll interval (sec):</label><input type="text" value="20" style="width:80px"></div>' +
            '<div class="mv-dialog-row"><label>Log path:</label><input type="text" value="C:\\ProgramData\\BinMaster\\3DVision\\Logs" style="flex:1;min-width:220px"></div>' +
            '<label class="mv-check"><input type="checkbox" checked> Enable event logging</label></fieldset>',
        },
        {
          id: "scada",
          label: "Scada Configuration",
          html:
            "<fieldset><legend>Scada Configuration</legend>" +
            '<div class="mv-dialog-row"><label>Protocol:</label><select><option>Modbus TCP</option><option>OPC</option></select></div>' +
            '<div class="mv-dialog-row"><label>Port:</label><input type="text" value="502" style="width:80px"></div></fieldset>',
        },
        {
          id: "license",
          label: "License Key",
          html:
            "<fieldset><legend>License Key</legend>" +
            '<div class="mv-dialog-row"><label>License:</label><input type="text" value="****-****-****-DEMO" style="flex:1;min-width:200px"></div>' +
            '<button class="btn mv-params-btn" type="button">Apply License</button></fieldset>',
        },
        {
          id: "clients",
          label: "Logged In Clients",
          html:
            '<table class="mv-dialog-table"><thead><tr><th>User</th><th>IP</th><th>Last Connection</th></tr></thead>' +
            "<tbody><tr><td>" +
            sessionInfo().userName +
            "</td><td>127.0.0.1</td><td>Now</td></tr></tbody></table>",
        },
        {
          id: "tcp",
          label: "Active Tcp Connections",
          html:
            '<table class="mv-dialog-table"><thead><tr><th>Local</th><th>Remote</th><th>State</th></tr></thead>' +
            "<tbody><tr><td>127.0.0.1:22222</td><td>127.0.0.1</td><td>Established</td></tr></tbody></table>",
        },
        {
          id: "listen",
          label: "Active Tcp Listeners",
          html:
            '<table class="mv-dialog-table"><thead><tr><th>Address</th><th>Port</th><th>Protocol</th></tr></thead>' +
            "<tbody><tr><td>0.0.0.0</td><td>22222</td><td>TCP</td></tr></tbody></table>",
        },
      ];
      return wrapDialog(
        "mv-dlg-server-options",
        "Server Configuration",
        750,
        groupViewBody("Server Config.", panes),
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-server-options" style="width:85px">Close</button></div>'
      );
    },

    "mv-dlg-materials": function () {
      var mats = [
        { name: "Lime Stone", color: "#a8a090" },
        { name: "Coke", color: "#6e6e6e" },
        { name: "Sand", color: "#c2b280" },
        { name: "Lime", color: "#e8e4d0" },
      ];
      var list = mats
        .map(function (m, i) {
          return (
            '<div class="mat-item' +
            (i === 1 ? " is-selected" : "") +
            '"><span class="mv-mat-swatch" style="background:' +
            m.color +
            '"></span>' +
            m.name +
            "</div>"
          );
        })
        .join("");
      var body =
        '<div class="mv-mat-layout">' +
        '<div style="grid-column:1;grid-row:1;font-size:14px;font-weight:700;margin-bottom:4px">Available Materials</div>' +
        '<div class="mv-mat-list" id="mvMatList">' +
        list +
        "</div>" +
        '<div class="mv-mat-preview" title="Vessel preview"></div>' +
        '<div class="mv-mat-edit">' +
        '<div style="font-weight:700;margin-bottom:6px">Add/Edit Material</div>' +
        '<div class="mv-dialog-row"><label style="min-width:100px">Material Name:</label>' +
        '<input type="text" id="mvMatName" value="Coke" style="width:200px"></div>' +
        '<div class="mv-dialog-row"><label style="min-width:100px">Color</label>' +
        '<span class="mv-mat-swatch" id="mvMatSwatch" style="width:41px;height:23px;background:#6e6e6e"></span>' +
        '<input type="color" id="mvMatColor" value="#6e6e6e" style="width:31px;height:29px;padding:0;border:none">' +
        '<button class="btn mv-params-btn" type="button" style="width:56px">Add</button>' +
        '<button class="btn mv-params-btn" type="button" style="width:56px">Edit</button>' +
        '<button class="btn mv-params-btn" type="button" style="width:56px">Delete</button></div>' +
        "</div></div>";
      return wrapDialog("mv-dlg-materials", "Material Configuration", 665, body);
    },

    // WizardWindowProject (720×600) + WizardStepProjBase / WizardStepSite
    "mv-dlg-project-wizard": function () {
      var stepGeneral =
        '<div class="mv-proj-wiz-pane" data-proj-pane="1">' +
        '<div class="mv-proj-wiz-row">' +
        '<label for="mvProjName">Name:</label>' +
        '<input type="text" id="mvProjName" value="New_Project" autocomplete="off">' +
        "</div>" +
        '<div class="mv-proj-wiz-row">' +
        '<label for="mvProjNumSites"># Sites:</label>' +
        '<input type="text" id="mvProjNumSites" value="1" autocomplete="off">' +
        "</div></div>";
      var stepSite =
        '<div class="mv-proj-wiz-pane" data-proj-pane="2" hidden>' +
        '<fieldset class="mv-proj-wiz-box"><legend>General</legend>' +
        '<div class="mv-proj-wiz-row">' +
        '<label for="mvProjSiteName">Site name:</label>' +
        '<input type="text" id="mvProjSiteName" value="Site1" maxlength="16" autocomplete="off">' +
        "</div>" +
        '<div class="mv-proj-wiz-row">' +
        '<label for="mvProjNumVessels"># Vessels in site:</label>' +
        '<input type="text" id="mvProjNumVessels" value="1" autocomplete="off">' +
        "</div>" +
        '<div class="mv-proj-wiz-row">' +
        '<label for="mvProjNumDevices"># Devices in vessel:</label>' +
        '<input type="text" id="mvProjNumDevices" value="1" autocomplete="off">' +
        "</div></fieldset>" +
        '<fieldset class="mv-proj-wiz-box"><legend>Connection Type</legend>' +
        '<div class="mv-proj-wiz-radios" id="mvProjConTypes">' +
        '<label class="mv-proj-wiz-radio"><input type="radio" name="mvProjConType" value="hart"> HART</label>' +
        '<label class="mv-proj-wiz-radio"><input type="radio" name="mvProjConType" value="rs485" checked> RS-485</label>' +
        '<label class="mv-proj-wiz-radio"><input type="radio" name="mvProjConType" value="tcp"> TCP/IP</label>' +
        "</div></fieldset>" +
        '<fieldset class="mv-proj-wiz-box" id="mvProjConfigBox"><legend>Configuration</legend>' +
        '<div class="mv-proj-wiz-row">' +
        '<label for="mvProjSerialPort">Serial Port:</label>' +
        // FTDI / SiLabs USB↔RS-485 adapters are preferred first (SimpleClientHelper.MoveFTDIBusAsDefault).
        '<select id="mvProjSerialPort">' +
        '<option value="COM3" selected>COM3</option>' +
        '<option value="COM4">COM4</option>' +
        '<option value="COM1">COM1</option>' +
        '<option value="COM2">COM2</option>' +
        "</select></div></fieldset>" +
        '<fieldset class="mv-proj-wiz-box is-hidden" id="mvProjAddConfigBox"><legend>Additional Configuration</legend>' +
        '<div class="mv-proj-wiz-row">' +
        "<label>Server IP Address:</label>" +
        '<input type="text" id="mvProjTcpHost" value="" autocomplete="off">' +
        "</div>" +
        '<div class="mv-proj-wiz-row">' +
        "<label>Server IP Port:</label>" +
        '<input type="text" id="mvProjTcpPort" value="10001" autocomplete="off">' +
        "</div></fieldset></div>";
      var body =
        '<div class="mv-proj-wiz" data-proj-step="1">' +
        '<div class="mv-proj-wiz-cols">' +
        '<div class="mv-proj-wiz-left">' +
        // OEM binMaster: ResomBase.ClientRunImagesDir = ImagesBin → WizardLogo.JPG
        '<img class="mv-proj-wiz-logo" src="assets/images/ImagesBin/WizardLogo.JPG" alt="BinMaster">' +
        "</div>" +
        '<div class="mv-proj-wiz-right">' +
        '<div class="mv-proj-wiz-step-header" id="mvProjWizStepTitle">Project General</div>' +
        '<div class="mv-proj-wiz-step-body" id="mvProjWizStepBody">' +
        stepGeneral +
        stepSite +
        "</div></div></div></div>";
      return wrapDialog(
        "mv-dlg-project-wizard",
        "Wizard",
        720,
        body,
        '<div class="mv-dialog-footer mv-proj-wiz-footer">' +
          '<button class="btn mv-params-btn" type="button" id="mvProjWizBack" disabled>&lt; Back</button>' +
          '<button class="btn mv-params-btn" type="button" id="mvProjWizNext">Next &gt;</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-project-wizard">Cancel</button></div>'
      );
    },

    "mv-dlg-project-open": function () {
      return wrapDialog(
        "mv-dlg-project-open",
        "Open Project...",
        520,
        '<p style="margin-bottom:8px">Select a project:</p>' +
          '<select size="10" style="width:100%;height:220px"><option selected>Aggregates</option><option>Sample Plant</option><option>Training Project</option></select>'
      );
    },

    "mv-dlg-project-saveas": function () {
      return wrapDialog(
        "mv-dlg-project-saveas",
        "Save Project As...",
        480,
        '<div class="mv-dialog-row"><label>File name:</label><input type="text" value="Aggregates" style="flex:1"></div>' +
          '<div class="mv-dialog-row"><label>Folder:</label><input type="text" value="C:\\ProgramData\\BinMaster\\3DVision\\Projects" style="flex:1"></div>'
      );
    },

    "mv-dlg-edit-project": function () {
      // EditProjectWin 400x500
      return wrapDialog(
        "mv-dlg-edit-project",
        "Edit Project",
        400,
        '<div class="mv-edit-project-tree">' +
          '<div class="node site">Aggregat</div>' +
          '<div class="node vessel">Lime Stone</div>' +
          '<div class="node scanner">Scanner 0 (Poll 0)</div>' +
          '<div class="node vessel">Coke</div>' +
          '<div class="node scanner">Scanner 1 (Poll 1)</div>' +
          '<div class="node vessel">Sand</div>' +
          '<div class="node scanner">Scanner 2 (Poll 2)</div>' +
          '<div class="node vessel">Lime</div>' +
          '<div class="node scanner">Scanner 3 (Poll 3)</div></div>' +
          '<div style="display:flex;gap:6px;margin-top:8px;flex-wrap:wrap">' +
          '<button class="btn mv-params-btn" type="button">Summary</button>' +
          '<button class="btn mv-params-btn" type="button">Save As...</button>' +
          '<button class="btn mv-params-btn" type="button">Open...</button></div>',
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-edit-project">OK</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-edit-project">Cancel</button></div>'
      );
    },

    "mv-dlg-add-entity": function () {
      // WndEditName-style for Add
      return wrapDialog(
        "mv-dlg-add-entity",
        "Edit Base Properties",
        389,
        '<div class="mv-dialog-row"><label style="min-width:90px">Type:</label><select id="mvAddType"><option>Site</option><option>Vessel</option><option>Scanner</option></select></div>' +
          '<div class="mv-dialog-row"><label style="min-width:90px">Name:</label><input type="text" id="mvAddName" value="New Item" style="flex:1"></div>' +
          '<div class="mv-dialog-row"><label style="min-width:90px">Description:</label><input type="text" value="" style="flex:1"></div>'
      );
    },

    "mv-dlg-rename": function () {
      return wrapDialog(
        "mv-dlg-rename",
        "Edit Base Properties",
        389,
        '<div class="mv-dialog-row"><label style="min-width:90px">Name:</label><input type="text" id="mvRenameName" style="flex:1"></div>' +
          '<div class="mv-dialog-row"><label style="min-width:90px">Description:</label><input type="text" value="" style="flex:1"></div>'
      );
    },

    "mv-dlg-device-wizard": function () {
      // WizardWindowDevice: Vessel → Device Position → Filling Points → Full Empty Calibration (4 steps).
      // 3D pane stays mounted; left pane swaps like WizardStepVessel / WizardStepDevice.
      function dimRow(id, label, val, hidden) {
        return (
          '<div class="mv-wiz-field' +
          (hidden ? " is-hidden" : "") +
          '" id="' +
          id +
          '"><label>' +
          label +
          '</label><input type="text" value="' +
          val +
          '"></div>'
        );
      }
      var preview =
        '<div class="mv-wiz-vessel-preview">' +
        '<div class="mv-wiz-3d-wrap">' +
        '<div class="mv-wiz-3d" id="mvWiz3d"></div>' +
        '<div class="mv-overview-controls mv-wiz-3d-controls">' +
        '<div class="mv-overview-zoom">' +
        '<button type="button" class="mv-ov-zoom-btn" id="mvWizZoomIn" title="Zoom in">+</button>' +
        '<input type="range" id="mvWizZoom" min="0" max="50" value="25" aria-label="Zoom">' +
        '<button type="button" class="mv-ov-zoom-btn" id="mvWizZoomOut" title="Zoom out">&minus;</button>' +
        "</div>" +
        '<div class="mv-overview-dpad" aria-label="Rotate view">' +
        '<button type="button" class="mv-ov-pad mv-ov-up" id="mvWizRotUp" title="Tilt up"></button>' +
        '<button type="button" class="mv-ov-pad mv-ov-left" id="mvWizRotLeft" title="Rotate left"></button>' +
        '<button type="button" class="mv-ov-pad mv-ov-center" id="mvWizRotReset" title="Reset"></button>' +
        '<button type="button" class="mv-ov-pad mv-ov-right" id="mvWizRotRight" title="Rotate right"></button>' +
        '<button type="button" class="mv-ov-pad mv-ov-down" id="mvWizRotDown" title="Tilt down"></button>' +
        "</div></div></div></div>";
      var step1 =
        '<div class="mv-wiz-step-pane is-active" data-wiz-step="1">' +
        '<fieldset><legend>General</legend>' +
        '<div class="mv-wiz-field"><label>Distance:</label><select id="mvWizDist"><option selected>m</option><option>ft</option></select></div>' +
        '<div class="mv-wiz-field"><label>Temperature:</label><select id="mvWizTemp"><option selected>Celsius</option><option>Fahrenheit</option></select></div>' +
        "</fieldset>" +
        '<div class="mv-wiz-dim-title">Vessel Dimension</div>' +
        '<fieldset><legend>Top Shape</legend>' +
        '<div class="mv-wiz-field"><label>Shape:</label><select id="mvWizTopShape">' +
        '<option value="flat">Flat</option><option value="cone" selected>Cone</option>' +
        '<option value="dome">Dome</option></select></div>' +
        dimRow("mvWizTopH", "Height:", "1.000", false) +
        dimRow("mvWizTopD", "Diameter:", "0", false) +
        dimRow("mvWizTopX", "X:", "0", true) +
        dimRow("mvWizTopY", "Y:", "0", true) +
        "</fieldset>" +
        '<fieldset><legend>Center Shape</legend>' +
        '<div class="mv-wiz-field"><label>Shape:</label><select id="mvWizCenShape">' +
        '<option value="cylinder" selected>Cylinder</option><option value="cube">Cube</option></select></div>' +
        dimRow("mvWizCenH", "Height:", "16", false) +
        dimRow("mvWizCenD", "Diameter:", "9", false) +
        dimRow("mvWizCenX", "X:", "9", true) +
        dimRow("mvWizCenY", "Y:", "9", true) +
        "</fieldset>" +
        '<fieldset><legend>Bottom Shape</legend>' +
        '<div class="mv-wiz-field"><label>Shape:</label><select id="mvWizBotShape">' +
        '<option value="flat">Flat</option>' +
        '<option value="cone" selected>Cone</option>' +
        '<option value="cone2">2 Cones</option>' +
        '<option value="dome">Dome</option>' +
        '<option value="pyramid">Pyramid</option>' +
        '<option value="inverted">Inverted Cone</option></select></div>' +
        dimRow("mvWizBotH", "Height:", "1.000", false) +
        dimRow("mvWizBotD", "Diameter:", "0", false) +
        dimRow("mvWizBotX", "X:", "0", true) +
        dimRow("mvWizBotY", "Y:", "0", true) +
        dimRow("mvWizBotXPos", "X Position:", "0", false) +
        dimRow("mvWizBotYPos", "Y Position:", "0", false) +
        "</fieldset></div>";
      var step2 =
        '<div class="mv-wiz-step-pane" data-wiz-step="2" hidden>' +
        // groupBoxDevPosition Height=200; SetSingleScannerConfiguration → 110 (single scanner).
        '<fieldset class="mv-wiz-box mv-wiz-devpos-box">' +
        "<legend>Device Position</legend>" +
        '<div class="mv-wiz-devpos">' +
        '<label class="mv-wiz-check"><input type="checkbox" id="mvWizAngleManual"> Set device angle manually</label>' +
        '<div class="mv-wiz-grid-wrap">' +
        '<table class="mv-wiz-table mv-wiz-device-table" id="mvWizDeviceTable"><thead><tr>' +
        "<th>Name</th><th>X</th><th>Y</th><th>Z</th><th>Offset</th><th>Angle</th><th>Addr.</th>" +
        "</tr></thead><tbody>" +
        '<tr class="is-selected"><td class="mv-wiz-name">Coke_1</td>' +
        '<td><input id="mvWizDevX" value="0"></td><td><input id="mvWizDevY" value="0"></td>' +
        // DevicePositionUC.xaml: Z/Angle/Name/Addr IsReadOnly; Offset editable in XAML.
        // DevicePositionUC.SetEditableCells: Offset locked only when NOT APM Technician+;
        // remake has no auth gate → keep Offset editable (tech path). Offset changes Z.
        '<td><input id="mvWizDevZ" value="18" readonly></td><td><input id="mvWizDevOff" value="0"></td>' +
        '<td><input id="mvWizDevAng" value="180" readonly></td><td class="mv-wiz-addr">1</td></tr>' +
        "</tbody></table></div></div></fieldset></div>";
      // WizardStepDevice.xaml groupBoxFillPoints Height=180: table row * + button row 32.
      var step3 =
        '<div class="mv-wiz-step-pane" data-wiz-step="3" hidden>' +
        '<fieldset class="mv-wiz-box mv-wiz-fill-box"><legend>Filling Points</legend>' +
        '<div class="mv-wiz-fill-grid">' +
        '<div class="mv-wiz-fill-table-wrap">' +
        '<table class="mv-wiz-table" id="mvWizFillTable"><thead><tr><th>X</th><th>Y</th></tr></thead>' +
        "<tbody></tbody></table></div>" +
        '<div class="mv-wiz-table-btns">' +
        '<button type="button" class="mv-wiz-btn" id="mvWizFillAdd">Add</button>' +
        '<button type="button" class="mv-wiz-btn" id="mvWizFillDel">Delete</button>' +
        '<button type="button" class="mv-wiz-btn" id="mvWizFillClear">Clear</button>' +
        "</div></div></fieldset></div>";
      // WizardStepDevice.xaml groupBoxFullemptyCalib Height=200: calib * + buttons 32.
      var step4 =
        '<div class="mv-wiz-step-pane" data-wiz-step="4" hidden>' +
        '<fieldset class="mv-wiz-box mv-wiz-calib-box"><legend>Full Empty Calibration</legend>' +
        '<div class="mv-wiz-fill-grid">' +
        '<div class="mv-wiz-fill-table-wrap">' +
        '<table class="mv-wiz-table mv-wiz-calib-table"><thead><tr>' +
        "<th></th><th>Level (Bottom)</th><th></th><th>Distance (Top)</th><th></th><th>Vessel Height</th>" +
        "</tr></thead><tbody>" +
        '<tr><td>Full Calib</td><td><input id="mvWizFullLevel" value="17"></td><td>+</td>' +
        '<td><input id="mvWizFullDist" value="1"></td><td>=</td><td><input id="mvWizFullH" value="18" readonly></td></tr>' +
        '<tr><td>Empty Calib</td><td><input id="mvWizEmptyLevel" value="0"></td><td>+</td>' +
        '<td><input id="mvWizEmptyDist" value="18"></td><td>=</td><td><input id="mvWizEmptyH" value="18" readonly></td></tr>' +
        "</tbody></table></div>" +
        '<div class="mv-wiz-table-btns">' +
        '<button type="button" class="mv-wiz-btn" id="mvWizCalibDefault">Default</button>' +
        '<button type="button" class="mv-wiz-btn" id="mvWizCalibTable">View Table</button>' +
        "</div></div></fieldset></div>";
      var body =
        '<div class="mv-wiz-device" data-wiz-current="1">' +
        // WizardStepDevice/Vessel OnStepName() return ""; AddStep → " Step N/4".
        '<div class="mv-wiz-step-label" id="mvWizStepLabel">' +
        '<span class="mv-wiz-step-num">Step 1/4</span>' +
        '<span class="mv-wiz-step-name" id="mvWizStepName"></span></div>' +
        '<div class="mv-wiz-vessel-form">' +
        step1 +
        step2 +
        step3 +
        step4 +
        "</div>" +
        preview +
        "</div>";
      // Wider than design 660 so 3D pane has room; left col stays 400 (formats unchanged).
      return wrapDialog(
        "mv-dlg-device-wizard",
        "Coke - Configuration Wizard",
        980,
        body,
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" id="mvWizBack" disabled>&lt; Back</button>' +
          '<button class="btn mv-params-btn" type="button" id="mvWizNext">Next &gt;</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-device-wizard">Cancel</button></div>'
      );
    },

    "mv-dlg-advanced-params": function () {
      // Port of AdvParamsWindow + AdvParams1Vessel/1Scanner + AdvBeamActivation (STech):
      //   Window 439×577; gridLeft 415×400; no Extra / Advanced-Cont.
      //   CheckB_apm: 13×13, check Fill #2C9524; disabled bg #C3C3C3 bullet #9A9A9A.
      //   AdvBeamActivation.Enabled(): gridManual.IsEnabled = !AutoBeamSelection.
      var info =
        '<img class="mv-ap-info-img" src="assets/images/multivision/info-icon-Basic.png" alt="" width="12" height="12">';
      function apRow(label, control, unit, showInfo) {
        return (
          '<div class="mv-ap-row">' +
          '<span class="mv-ap-label">' +
          label +
          "</span>" +
          control +
          '<span class="mv-ap-unit">' +
          (unit || "") +
          "</span>" +
          (showInfo === false ? '<span class="mv-ap-info-slot"></span>' : info) +
          "</div>"
        );
      }
      var tb = function (val) {
        return '<input class="mv-ap-input" type="text" value="' + val + '">';
      };
      var cb = function (opts, sel) {
        return (
          '<select class="mv-ap-combo">' +
          opts
            .map(function (o) {
              return (
                "<option" + (o === sel ? " selected" : "") + ">" + o + "</option>"
              );
            })
            .join("") +
          "</select>"
        );
      };
      function apCheck(label, checked, name) {
        return (
          '<label class="mv-ap-check">' +
          '<input type="checkbox"' +
          (name ? ' data-ap-beam="' + name + '"' : "") +
          (checked ? " checked" : "") +
          "> <span>" +
          label +
          "</span></label>"
        );
      }
      var vesselPanel =
        '<div data-panel="vessel" class="mv-ap-tab-pane">' +
        // Single scanner: groupBoxVessel.Header = "" (SetSingleScannerConfiguration).
        '<div class="mv-ap-groupbox mv-ap-groupbox-vessel">' +
        apRow("Output Damping Time:", tb("300"), "sec") +
        apRow("Steepest Material Slope:", tb("35"), "°") +
        apRow("Max. Capacity:", tb("100"), "mass") +
        apRow("Max. Emptying Rate:", tb("10"), "mass/h") +
        apRow("Max. Filling Rate:", tb("10"), "mass/h") +
        apRow("Minimal SNR", tb("13"), "dB", false) +
        "</div></div>";
      // AdvParams1Scanner rows 0–10 (IsReducedDisplay drops 11+; SeniorTech-only hidden).
      // IsVisibleTechMode Visible for Senior Tech → Side/Bottom/Restrain shown.
      var advPanel =
        '<div data-panel="adv" class="mv-ap-tab-pane" hidden>' +
        '<fieldset class="mv-ap-gb mv-ap-gb-scanner">' +
        "<legend>Device Specific</legend>" +
        apRow("Angle Adaptor", tb("0"), "°") +
        apRow("Side Margin", tb("1"), "m") +
        apRow("Bottom Margin", tb("1"), "m") +
        apRow("Restrain Coefficient", tb("10"), "%") +
        apRow("Threshold Sensitivity", tb("9"), "dB", false) +
        apRow("Threshold Width", tb("0"), "", false) +
        apRow("After transmission mask %", tb("0"), "%", false) +
        apRow("User False Echoes", cb(["Enable", "Disable"], "Enable")) +
        apRow("User False Echoes Sensitivity", tb("1.2"), "", false) +
        apRow("Auto False Echoes", cb(["Enable", "Disable"], "Enable")) +
        apRow("Auto False Echoes Sensitivity", tb("1.2"), "", false) +
        "</fieldset></div>";
      // AdvBeamActivation.xaml — Manual Height=180; cols 5|120|120|120; rows 30.
      var beamsPanel =
        '<div data-panel="beams" class="mv-ap-tab-pane mv-ap-beams-pane" hidden>' +
        '<fieldset class="mv-ap-gb mv-ap-gb-manual" id="mvApBeamManual">' +
        "<legend>Manual</legend>" +
        '<img class="mv-ap-beams-manual-info" src="assets/images/multivision/info-icon-Basic.png" alt="" width="12" height="12">' +
        '<div class="mv-ap-beams-grid">' +
        '<span class="mv-ap-beams-spacer"></span>' +
        apCheck("High Frequency", true, "freq") +
        apCheck("30 degrees", true, "dir") +
        apCheck("210 degrees", true, "dir") +
        '<span class="mv-ap-beams-spacer"></span>' +
        apCheck("Med Frequency", true, "freq") +
        apCheck("90 degrees", true, "dir") +
        apCheck("270 degrees", true, "dir") +
        '<span class="mv-ap-beams-spacer"></span>' +
        apCheck("Low Frequency", true, "freq") +
        apCheck("150 degrees", true, "dir") +
        apCheck("330 degrees", true, "dir") +
        "</div>" +
        '<div class="mv-ap-beam-btns">' +
        '<button class="mv-ap-simple-btn" type="button" id="mvApBeamSelectAll" style="width:100px">Select All</button>' +
        '<button class="mv-ap-simple-btn" type="button" id="mvApBeamClearAll" style="width:100px">Clear All</button></div>' +
        "</fieldset>" +
        '<fieldset class="mv-ap-gb mv-ap-gb-auto">' +
        "<legend>Automatic</legend>" +
        '<div class="mv-ap-auto-row">' +
        '<label class="mv-ap-check"><input type="checkbox" id="mvApAutoBeamSel" checked> <span>Auto Beam Selection</span></label>' +
        info +
        "</div>" +
        '<div class="mv-ap-auto-row">' +
        '<label class="mv-ap-check"><input type="checkbox" id="mvApAutoBeamRange" checked> <span>Automatic Beams Range</span></label>' +
        info +
        "</div>" +
        "</fieldset></div>";
      var body =
        '<div class="mv-ap-win">' +
        '<div class="mv-ap-top">' +
        '<label class="mv-ap-device-label" id="mvApDeviceLabel">Device:</label>' +
        '<select class="mv-ap-device-combo" id="mvApDeviceCombo">' +
        deviceOptionsHtml() +
        "</select></div>" +
        '<div class="mv-ap-main">' +
        '<div class="mv-ap-tabs mv-params-tabs" role="tablist">' +
        '<div class="mv-ap-tab mv-params-tab is-active" role="tab" tabindex="0" data-tab="vessel">Vessel</div>' +
        '<div class="mv-ap-tab mv-params-tab" role="tab" tabindex="0" data-tab="adv">Advanced</div>' +
        '<div class="mv-ap-tab mv-params-tab" role="tab" tabindex="0" data-tab="beams">Beams Activation</div></div>' +
        '<div class="mv-ap-tab-body mv-params-panels">' +
        vesselPanel +
        advPanel +
        beamsPanel +
        "</div></div></div>";
      return wrapDialog(
        "mv-dlg-advanced-params",
        "Advanced Parameters",
        439,
        body,
        '<div class="mv-dialog-footer mv-ap-footer-stech">' +
          '<button class="mv-ap-simple-btn" type="button" style="width:94px" id="mvApDownloadAll">Download All</button>' +
          '<button class="mv-ap-simple-btn" type="button" style="width:94px" id="mvApUploadAll">Upload All</button>' +
          '<button class="mv-ap-simple-btn" type="button" style="width:75px" id="mvApSummary">Summary</button>' +
          '<button class="mv-ap-simple-btn" type="button" style="width:70px" data-mv-dlg-close="mv-dlg-advanced-params">Close</button></div>'
      );
    },

    // AdvancedParamsSummaryWin.xaml — 1169×337; STech/Senior: Advanced + Beams Activation tabs.
    "mv-dlg-adv-summary": function () {
      function th(label, w) {
        return (
          '<th style="min-width:' +
          w +
          'px;width:' +
          w +
          'px">' +
          label +
          "</th>"
        );
      }
      // Headers match AdvParamsRes / XAML DataGridTextColumn Header (Width=80 except Name).
      var advHead =
        "<tr>" +
        th("Name", 80) +
        th("Output Damping Time:", 80) +
        th("Steepest Material Slope:", 80) +
        th("Max. Capacity:", 80) +
        th("Max. Emptying Rate:", 80) +
        th("Max. Filling Rate:", 80) +
        th("Minimal SNR", 80) +
        th("Mechanics Type", 80) +
        th("Threshold Sensitivity", 80) +
        th("Threshold Width", 80) +
        th("Restrain Coefficient", 80) +
        th("Side Margin", 80) +
        th("Bottom Margin", 80) +
        th("Top Dead Band", 80) +
        th("After transmission mask %", 80) +
        th("User False Echoes", 80) +
        th("User False Echoes Sensitivity", 80) +
        th("Auto False Echoes", 80) +
        th("Auto False Echoes Sensitivity", 80) +
        th("Exceeding Filling Rate After Echo Loss", 80) +
        th("Angle Adaptor", 80) +
        "</tr>";
      var beamsHead =
        "<tr>" +
        th("Name", 100) +
        th("High Frequency", 100) +
        th("Med Frequency", 100) +
        th("Low Frequency", 100) +
        th("30 degrees", 100) +
        th("90 degrees", 100) +
        th("150 degrees", 100) +
        th("210 degrees", 100) +
        th("270 degrees", 100) +
        th("330 degrees", 100) +
        th("Auto Beam Selection", 100) +
        th("Automatic Beams Range", 100) +
        "</tr>";
      var body =
        '<div class="mv-ap-sum">' +
        '<div class="mv-ap-sum-tabs mv-params-tabs" role="tablist">' +
        '<div class="mv-ap-tab mv-params-tab is-active" role="tab" tabindex="0" data-tab="sum-adv">Advanced</div>' +
        '<div class="mv-ap-tab mv-params-tab" role="tab" tabindex="0" data-tab="sum-beams">Beams Activation</div></div>' +
        '<div class="mv-ap-sum-panels mv-params-panels">' +
        '<div data-panel="sum-adv" class="mv-ap-sum-pane">' +
        '<div class="mv-ap-sum-grid-wrap">' +
        '<table class="mv-ap-sum-grid" id="mvApSumAdv"><thead>' +
        advHead +
        "</thead><tbody></tbody></table></div></div>" +
        '<div data-panel="sum-beams" class="mv-ap-sum-pane" hidden>' +
        '<div class="mv-ap-sum-grid-wrap">' +
        '<table class="mv-ap-sum-grid" id="mvApSumBeams"><thead>' +
        beamsHead +
        "</thead><tbody></tbody></table></div></div>" +
        "</div></div>";
      return wrapDialog("mv-dlg-adv-summary", "Advanced Params Summary Table", 1169, body, "");
    },

    // TDLM.WPFStuff.ProgressGui.ProgressWindow — Batch upload/download wait (190×366).
    "mv-dlg-progress": function () {
      var body =
        '<div class="mv-prog-win" id="mvProgWin">' +
        '<textarea class="mv-prog-status" id="mvProgStatus" rows="3"></textarea>' +
        '<div class="mv-prog-bar" id="mvProgBar" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">' +
        '<div class="mv-prog-fill" id="mvProgFill"></div></div>' +
        '<div class="mv-prog-btns" id="mvProgBtns">' +
        // StringsApplic.WarningCanceDeviceOperationButton (leading/trailing spaces intentional)
        '<button type="button" class="mv-ap-simple-btn mv-prog-cancel" id="mvProgCancel"> Cancel Operation  </button>' +
        "</div></div>";
      return wrapDialog("mv-dlg-progress", "Progress", 366, body, "");
    },

    "mv-dlg-output-settings": function () {
      // Port of APM.WPF.MiscViews.OutputSettingsNewUC / OutputSettingsNewWin (560x565)
      var body =
        '<div class="mv-out-settings">' +
        '<fieldset class="mv-out-material"><legend>Material Name</legend>' +
        '<div class="mv-out-material-row">' +
        '<select id="mvOutMat">' +
        "<option>Lime Stone</option><option selected>Coke</option><option>Sand</option><option>Lime</option>" +
        '</select>' +
        '<button class="btn mv-params-btn" type="button" data-mv-dlg-open="mv-dlg-materials" style="width:61px;height:28px">Edit...</button>' +
        "</div></fieldset>" +
        '<fieldset style="height:150px"><legend>Calculation Using</legend>' +
        '<div class="mv-out-calc-grid">' +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="silo" checked> Silo Structure</label><span></span>' +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="lmt"> Level-Mass Table</label>' +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="lv"> Level-Volume Table</label><span></span>' +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="dmt"> Distance-Mass Table</label>' +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="dv"> Distance-Volume Table</label><span></span>' +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="lvbd"> Level-Variable Bulk Density</label>' +
        "<span></span><span></span>" +
        '<label class="mv-radio"><input type="radio" name="mvOutCalc" value="dvbd"> Distance-Variable Bulk Density</label>' +
        "</div></fieldset>" +
        "<fieldset><legend>Measurement Units</legend>" +
        '<div class="mv-out-units-top">' +
        "<label>Distance:</label><select style=\"width:92px\"><option>m</option><option>ft</option></select>" +
        "<label>Temperature:</label><select style=\"width:92px\"><option>Celsius</option><option>Fahrenheit</option></select>" +
        "</div>" +
        '<div class="mv-out-units-nested">' +
        '<fieldset><legend>Mass</legend>' +
        '<div class="mv-out-unit-row"><span>Display Units:</span><select><option>Tons (Metric)</option><option>Pounds</option><option>Kilograms</option></select></div>' +
        '<div class="mv-out-mass-density"><span>Density</span><input type="text" value="0" style="width:70px"><select><option>lb/ft^3</option><option>kg/m^3</option><option>ton/m^3</option></select></div>' +
        "</fieldset>" +
        '<fieldset><legend>Volume</legend>' +
        '<div class="mv-out-unit-row"><span>Display Units:</span><select><option>meter^3</option><option>ft^3</option><option>liter</option></select></div>' +
        '<div class="mv-out-unit-row"><span>Max Scale</span><input type="text" value="1039.08" readonly disabled style="width:100%"></div>' +
        "</fieldset></div></fieldset></div>";
      return wrapDialog(
        "mv-dlg-output-settings",
        "Output Settings...",
        560,
        body,
        '<div class="mv-dialog-footer mv-out-footer">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-open="mv-dlg-edit-table" style="width:120px">Edit Table...</button>' +
          '<div class="mv-out-footer-right">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-output-settings" style="width:100px">OK</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-output-settings" style="width:100px">Close</button>' +
          "</div></div>"
      );
    },

    "mv-dlg-edit-table": function () {
      return wrapDialog(
        "mv-dlg-edit-table",
        "Linearization Table",
        520,
        "<p style=\"margin:0 0 8px;color:#697477\">Level / Volume / Mass linearization points for the selected calculation mode.</p>" +
          '<table class="mv-dialog-table"><thead><tr><th>#</th><th>Level (m)</th><th>Volume (m³)</th><th>Mass (ton)</th></tr></thead><tbody>' +
          "<tr><td>1</td><td>0.00</td><td>0.00</td><td>0.00</td></tr>" +
          "<tr><td>2</td><td>4.00</td><td>254.47</td><td>0.00</td></tr>" +
          "<tr><td>3</td><td>8.00</td><td>508.94</td><td>0.00</td></tr>" +
          "<tr><td>4</td><td>12.00</td><td>763.41</td><td>0.00</td></tr>" +
          "<tr><td>5</td><td>16.00</td><td>1039.08</td><td>0.00</td></tr>" +
          "</tbody></table>",
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-edit-table" style="width:100px">Close</button></div>'
      );
    },

    "mv-dlg-output-current": function () {
      // OutputCurrentWin 410x400 + OutputCurrentMainUC tabs
      var body =
        '<div class="mv-params-tabs" role="tablist">' +
        '<button type="button" class="mv-params-tab is-active" data-tab="oc">Output Current</button>' +
        '<button type="button" class="mv-params-tab" data-tab="fault">Fault Current</button>' +
        '<button type="button" class="mv-params-tab" data-tab="hart">HART Command #3</button></div>' +
        '<div class="mv-params-panels" style="min-height:220px">' +
        '<div data-panel="oc">' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Output Mode</label><select style="width:186px"><option>Automatic</option><option>Fixed</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Current Output Type</label><select style="width:186px"><option>Volume %</option><option>Level</option><option>Distance</option><option>Mass</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Fixed Current Value:</label><input type="text" value="12.00" style="width:186px"><span>mA</span></div>' +
        '<label class="mv-check"><input type="checkbox"> Synchronize Current in Multi Scanner System</label></div>' +
        '<div data-panel="fault" hidden>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Fault Current:</label><select style="width:186px"><option>3.6 mA</option><option>22 mA</option><option>Hold</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Fault Indication:</label><select style="width:186px"><option>Off</option><option>On</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Volume %</label><input type="text" value="0" style="width:186px"></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">Restore Time:</label><input type="text" value="0" style="width:186px"><span>seconds</span></div></div>' +
        '<div data-panel="hart" hidden>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">PV:</label><select style="width:186px"><option>Level</option><option>Volume</option><option>Mass</option><option>Distance</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">SV:</label><select style="width:186px"><option>Volume</option><option>Level</option><option>Mass</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">TV:</label><select style="width:186px"><option>Mass</option><option>Volume</option><option>Level</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:140px">QV:</label><select style="width:186px"><option>Temperature</option><option>SNR</option></select></div>' +
        '<div class="mv-groupview-apply-row"><button class="btn mv-params-btn" type="button" style="width:100px">Default</button></div></div></div>';
      return wrapDialog(
        "mv-dlg-output-current",
        "Output Current Settings",
        410,
        body,
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-output-current" style="width:100px">Upload</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-output-current" style="width:100px">Close</button></div>'
      );
    },

    "mv-dlg-current-sim": function () {
      // CurrentOutputSetWin 345x290 + CurrentOutputSetUC
      var body =
        '<div class="mv-dialog-row"><label style="min-width:131px">Selection:</label><select style="width:158px">' +
        vesselsOptionsHtml() +
        "</select></div>" +
        '<fieldset style="height:207px"><legend>Current Simulation</legend>' +
        '<select style="width:160px;margin:6px 0"><option>Off</option><option>Fixed Current</option><option>Fixed Volume %</option></select>' +
        '<div class="mv-dialog-row"><input type="text" value="12.00" style="width:160px"><span>mA</span></div>' +
        '<div class="mv-dialog-row"><input type="text" value="" style="width:160px" disabled><span>%</span></div>' +
        '<div style="display:flex;gap:8px;margin-top:24px">' +
        '<button class="btn mv-params-btn" type="button" style="width:90px">Apply</button>' +
        '<button class="btn mv-params-btn" type="button" style="width:90px">Stop</button>' +
        '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-current-sim" style="width:90px">Close</button>' +
        "</div></fieldset>";
      return wrapDialog(
        "mv-dlg-current-sim",
        "Current Simulation Settings",
        345,
        body,
        ""
      );
    },

    "mv-dlg-false-echo": function () {
      var body =
        '<div class="mv-false-echo">' +
        '<div class="mv-dialog-row"><label style="min-width:131px">Selection:</label><select style="width:158px">' +
        vesselsOptionsHtml() +
        "</select></div>" +
        '<fieldset><legend>False Echoes Mapping</legend>' +
        '<div class="mv-dialog-row"><label style="min-width:75px">Action Type:</label><select style="width:213px"><option>Learn</option><option>Delete</option><option>Show</option></select></div>' +
        '<div class="mv-dialog-row"><label style="min-width:75px">From:</label><input type="text" value="0.50" style="width:101px"><span style="width:43px">m</span></div>' +
        '<div class="mv-dialog-row"><label style="min-width:75px">To:</label><input type="text" value="2.00" style="width:101px"><span style="width:43px">m</span></div>' +
        '<div class="mv-dialog-row"><label style="min-width:75px">Threshold:</label><input type="text" value="10" style="width:101px"></div>' +
        '<div class="mv-fe-beams">' +
        '<label class="mv-check"><input type="checkbox" checked> All</label>' +
        '<label class="mv-check"><input type="checkbox" checked> High</label>' +
        '<label class="mv-check"><input type="checkbox" checked> Medium</label>' +
        '<label class="mv-check"><input type="checkbox"> Low</label>' +
        '<label class="mv-check"><input type="checkbox"> 30</label>' +
        '<label class="mv-check"><input type="checkbox"> 90</label>' +
        '<label class="mv-check"><input type="checkbox"> 150</label>' +
        '<label class="mv-check"><input type="checkbox"> 210</label>' +
        '<label class="mv-check"><input type="checkbox"> 270</label>' +
        '<label class="mv-check"><input type="checkbox"> 330</label>' +
        "</div></fieldset></div>";
      return wrapDialog(
        "mv-dlg-false-echo",
        "False Echoes Mapping",
        459,
        body,
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-false-echo" style="width:150px">Reset Mapping</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-false-echo" style="width:72px">Close</button></div>'
      );
    },

    "mv-dlg-devices-act": function () {
      var body =
        '<div class="mv-device-act">' +
        '<div class="mv-device-act-tree">' +
        '<div class="node site">Aggregat</div>' +
        '<div class="node vessel">Lime Stone</div>' +
        '<div class="node scanner is-selected">Scanner 0</div>' +
        '<div class="node vessel">Coke</div>' +
        '<div class="node scanner">Scanner 1</div>' +
        '<div class="node vessel">Sand</div>' +
        '<div class="node scanner">Scanner 2</div>' +
        '<div class="node vessel">Lime</div>' +
        '<div class="node scanner">Scanner 3</div></div>' +
        '<div class="mv-device-act-tabs">' +
        '<div class="mv-params-tabs" role="tablist">' +
        '<button type="button" class="mv-params-tab is-active" data-tab="reset">Devices Reset</button>' +
        '<button type="button" class="mv-params-tab" data-tab="fw">Update Firmware</button>' +
        '<button type="button" class="mv-params-tab" data-tab="com">Com. Quality</button></div>' +
        '<div class="mv-params-panels" style="flex:1;padding:12px">' +
        '<div data-panel="reset">' +
        '<label class="mv-check"><input type="radio" name="mvDevReset" checked> Reset (Restart) Device</label>' +
        '<label class="mv-check"><input type="radio" name="mvDevReset"> Reset to Factory Defaults</label>' +
        '<label class="mv-check"><input type="radio" name="mvDevReset"> Reset Advanced Parameters and False Echoes</label>' +
        '<div style="margin-top:16px"><button class="btn mv-params-btn" type="button" style="width:80px">Reset</button></div></div>' +
        '<div data-panel="fw" hidden>' +
        '<p style="color:#c00;font-weight:700;margin:0 0 4px">Warning!</p>' +
        '<p style="color:#c00;margin:0 0 12px">Do not turn off the device or disconnect during firmware update.</p>' +
        '<div class="mv-dialog-row"><label>File Name:</label><input type="text" style="flex:1"><button class="btn mv-params-btn" type="button" style="width:32px">...</button></div>' +
        '<label class="mv-check"><input type="checkbox"> Recovery Mode</label>' +
        '<div class="mv-dialog-row"><button class="btn mv-params-btn" type="button">Firmware Summary...</button></div>' +
        '<div style="height:12px;background:#e0e0e0;border:1px solid #a0a0a0;margin:10px 0"><div style="width:0%;height:100%;background:#4a90b8"></div></div>' +
        '<select size="4" style="width:100%;height:80px"></select>' +
        '<div style="display:flex;gap:8px;margin-top:10px">' +
        '<button class="btn mv-params-btn" type="button">Start Update</button>' +
        '<button class="btn mv-params-btn" type="button">Cancel Update</button>' +
        '<button class="btn mv-params-btn" type="button">Show Log</button></div></div>' +
        '<div data-panel="com" hidden>' +
        '<div style="height:12px;background:#e0e0e0;border:1px solid #a0a0a0;margin:0 0 10px"><div style="width:0%;height:100%;background:#4a90b8"></div></div>' +
        '<div class="mv-dialog-row"><label>Num cycles:</label><input type="text" value="10" style="width:80px"></div>' +
        '<div class="mv-dialog-row"><label>Data length:</label><input type="text" value="256" style="width:80px"></div>' +
        '<select size="6" style="width:100%;height:120px;margin:8px 0"></select>' +
        '<div style="display:flex;gap:8px">' +
        '<button class="btn mv-params-btn" type="button">Start Test</button>' +
        '<button class="btn mv-params-btn" type="button">Stop Test</button>' +
        '<button class="btn mv-params-btn" type="button">Show Log</button></div></div>' +
        "</div></div></div>";
      return wrapDialog(
        "mv-dlg-devices-act",
        "Devices Activation",
        700,
        body,
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-devices-act" style="width:85px">Close</button></div>'
      );
    },

    "mv-dlg-echo-curve": function () {
      var body =
        '<div class="mv-beams-toolbar">' +
        '<label class="mv-check" style="margin:0"><input type="checkbox" id="mvEchoFuzzy"> Show Fuzzy</label>' +
        '<button class="btn mv-params-btn" type="button" title="Zoom Undo" style="width:24px;min-width:24px;padding:0">↶</button>' +
        '<select style="width:76px"><option>m</option><option>ft</option></select>' +
        '<label class="mv-check" style="margin:0"><input type="checkbox"> Map out False Echoes</label>' +
        '<label class="mv-check" style="margin:0"><input type="checkbox" checked> After Transmission Ratio Only</label></div>' +
        '<div class="mv-params-tabs" role="tablist">' +
        '<button type="button" class="mv-params-tab is-active" data-tab="all">All Beams</button></div>' +
        '<div class="mv-beams-chart"><canvas id="mvEchoCanvas" width="760" height="250"></canvas></div>' +
        '<div class="mv-beams-lower">' +
        '<div class="mv-params-tabs" role="tablist">' +
        '<button type="button" class="mv-params-tab is-active" data-tab="online">On Line</button>' +
        '<button type="button" class="mv-params-tab" data-tab="files">Downloaded Files</button>' +
        '<button type="button" class="mv-params-tab" data-tab="noise">Noise</button></div>' +
        '<div class="mv-params-panels" style="min-height:140px;border:1px solid #b0b0b0;background:#fff;padding:8px">' +
        '<div data-panel="online"><div class="mv-dialog-row"><label>Vessel / Scanner:</label><select style="width:220px">' +
        vesselsOptionsHtml() +
        '</select><button class="btn mv-params-btn" type="button" id="mvEchoStart">Start</button></div>' +
        "<div>SNR: 36.4 dB &nbsp; Distance: 2.53 m &nbsp; Level: 13.47 m</div></div>" +
        '<div data-panel="files" hidden><p style="color:#697477">No downloaded beam files.</p></div>' +
        '<div data-panel="noise" hidden><table class="mv-dialog-table"><thead><tr><th>#</th><th>0</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th></tr></thead>' +
        "<tbody><tr><td>1</td><td>0.12</td><td>0.18</td><td>0.09</td><td>0.21</td><td>0.15</td><td>0.11</td><td>0.17</td><td>0.14</td><td>0.10</td></tr></tbody></table></div>" +
        "</div></div>";
      return wrapDialog(
        "mv-dlg-echo-curve",
        "Echo Curve",
        800,
        body,
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-echo-curve">Close</button></div>'
      );
    },

    "mv-dlg-echo-viewer": function () {
      return wrapDialog(
        "mv-dlg-echo-viewer",
        "Echo Curve",
        800,
        '<div class="mv-beams-toolbar">' +
          '<label class="mv-check" style="margin:0"><input type="checkbox"> Show Fuzzy</label>' +
          '<select style="width:76px"><option>m</option><option>ft</option></select></div>' +
          '<div class="mv-dialog-row"><label>File:</label><input type="text" value="" style="flex:1"><button class="btn mv-params-btn" type="button">Browse...</button></div>' +
          '<div class="mv-beams-chart" style="height:280px"></div>' +
          '<p style="margin-top:8px;color:#697477">Load a saved echo curve (.grd / beam file) for offline analysis.</p>',
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-echo-viewer">Close</button></div>'
      );
    },

    "mv-dlg-report-wizard": function () {
      var body =
        '<div style="display:flex;min-height:520px;border:1px solid #8a8a8a;background:#fff">' +
        '<div class="mv-wizard-steps">' +
        "<h2>Reports</h2>" +
        '<div class="step is-active">Report Type</div>' +
        '<div class="step">Information</div>' +
        '<div class="step">Population</div>' +
        '<div class="step">Data Collection</div>' +
        '<div class="step">Data Output Type</div>' +
        '<div class="step">Schedule</div>' +
        '<div class="step">Output</div></div>' +
        '<div style="flex:1;padding:16px">' +
        "<fieldset><legend>Report Type</legend>" +
        '<label class="mv-check"><input type="radio" name="rwType" checked> Inventory</label>' +
        '<label class="mv-check"><input type="radio" name="rwType"> Measurement</label>' +
        '<label class="mv-check"><input type="radio" name="rwType"> Events</label></fieldset>' +
        "<fieldset><legend>Information</legend>" +
        '<div class="mv-dialog-row"><label>Report name:</label><input type="text" value="Daily Inventory" style="flex:1"></div>' +
        '<div class="mv-dialog-row"><label>Description:</label><input type="text" value="" style="flex:1"></div></fieldset>' +
        "</div></div>";
      return wrapDialog(
        "mv-dlg-report-wizard",
        "Reports Wizard",
        840,
        body,
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" title="Settings">Settings</button>' +
          '<button class="btn mv-params-btn" type="button" disabled>&lt; Previous</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-report-wizard">Next &gt;</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-report-wizard">Cancel</button></div>'
      );
    },

    "mv-dlg-inventory-table": function () {
      return wrapDialog(
        "mv-dlg-inventory-table",
        "Hardware Inventory",
        1000,
        '<table class="mv-dialog-table"><thead><tr><th>Vessel</th><th>S/N</th><th>Hardware</th><th>Firmware</th><th>Poll Adr</th><th>Device</th><th>Con Type</th><th>Port</th><th>Chain ID</th><th>Vessel Scada</th><th>Scanner Scada</th></tr></thead><tbody>' +
          "<tr><td>Lime Stone</td><td>709001467</td><td>16</td><td>2.9.986</td><td>0</td><td>MV</td><td>TCP/IP</td><td>10001</td><td>0</td><td>—</td><td>—</td></tr>" +
          "<tr><td>Coke</td><td>709001468</td><td>16</td><td>2.9.986</td><td>1</td><td>MV</td><td>TCP/IP</td><td>10001</td><td>0</td><td>—</td><td>—</td></tr>" +
          "<tr><td>Sand</td><td>709001469</td><td>16</td><td>2.9.986</td><td>2</td><td>MV</td><td>TCP/IP</td><td>10001</td><td>0</td><td>—</td><td>—</td></tr>" +
          "<tr><td>Lime</td><td>709001470</td><td>16</td><td>2.9.986</td><td>3</td><td>MV</td><td>TCP/IP</td><td>10001</td><td>0</td><td>—</td><td>—</td></tr>" +
          "</tbody></table>",
        '<div class="mv-dialog-footer"><span style="margin-right:auto;color:#697477">4 devices</span>' +
          '<button class="btn mv-params-btn" type="button">Refresh</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-inventory-table">Close</button></div>'
      );
    },

    "mv-dlg-meas-table": function () {
      return wrapDialog(
        "mv-dlg-meas-table",
        "Measurement Summary",
        1000,
        '<table class="mv-dialog-table"><thead><tr><th>Vessel</th><th>Volume %</th><th>Volume</th><th>Volume Unit</th><th>Mass</th><th>Mass Unit</th><th>Alert</th></tr></thead><tbody>' +
          "<tr><td>Lime Stone</td><td>75.41</td><td>783.60</td><td>meter^3</td><td>0.00</td><td>Tons (Metric)</td><td></td></tr>" +
          "<tr><td>Coke</td><td>75.41</td><td>783.60</td><td>meter^3</td><td>0.00</td><td>Tons (Metric)</td><td></td></tr>" +
          "<tr><td>Sand</td><td>49.60</td><td>515.40</td><td>meter^3</td><td>0.00</td><td>Tons (Metric)</td><td></td></tr>" +
          "<tr><td>Lime</td><td>39.22</td><td>407.50</td><td>meter^3</td><td>0.00</td><td>Tons (Metric)</td><td></td></tr>" +
          "</tbody></table>",
        '<div class="mv-dialog-footer"><span style="margin-right:auto;color:#697477">4 vessels</span>' +
          '<button class="btn mv-params-btn" type="button">Refresh</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-meas-table">Close</button></div>'
      );
    },

    "mv-dlg-events-log": function () {
      return wrapDialog(
        "mv-dlg-events-log",
        "Event Log Viewer",
        1100,
        '<div style="display:flex;min-height:480px;border:1px solid #8a8a8a;background:#fff">' +
          '<div style="width:200px;border-right:1px solid #8a8a8a;padding:8px;background:#f4f7f9">' +
          "<div style=\"font-weight:700;margin-bottom:8px\">Filter</div>" +
          '<label class="mv-check"><input type="checkbox" checked> Errors</label>' +
          '<label class="mv-check"><input type="checkbox" checked> Warnings</label>' +
          '<label class="mv-check"><input type="checkbox" checked> Info</label>' +
          '<label class="mv-check"><input type="checkbox" checked> Debug</label>' +
          '<div class="mv-dialog-row" style="margin-top:12px"><button class="btn mv-params-btn" type="button">Reload</button></div></div>' +
          '<div style="flex:1;display:flex;flex-direction:column;min-width:0">' +
          '<table class="mv-dialog-table" style="flex:1"><thead><tr><th>Time</th><th></th><th>Severity</th><th>Client</th><th>Message</th></tr></thead><tbody>' +
          "<tr><td>2:04:29 PM</td><td></td><td>Info</td><td>Scanners</td><td>General Data retrieve: Completed</td></tr>" +
          "<tr><td>2:03:35 PM</td><td></td><td>Info</td><td>Scanners</td><td>Poll cycle completed</td></tr>" +
          "<tr><td>1:58:12 PM</td><td></td><td>Warning</td><td>Coke</td><td>SNR below preferred threshold</td></tr>" +
          "</tbody></table>" +
          '<textarea readonly style="height:90px;border:none;border-top:1px solid #b0b0b0;padding:8px;resize:none;font:inherit">SNR below preferred threshold</textarea>' +
          "</div></div>",
        '<div class="mv-dialog-footer"><button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-events-log">Close</button></div>'
      );
    },

    "mv-dlg-connect-server": function () {
      // WindowConnectToServer 291x237 — Server Connection
      return wrapDialog(
        "mv-dlg-connect-server",
        "Server Connection",
        320,
        '<div class="mv-connect-form">' +
          '<div class="mv-dialog-row"><label>Server Name:</label><select style="width:160px"><option>Local Server</option><option>Plant Server</option></select></div>' +
          '<div class="mv-dialog-row"><label>Server Address:</label><input type="text" value="127.0.0.1" style="width:160px"></div>' +
          '<div class="mv-dialog-row"><label>Server Port:</label><input type="text" value="22222" style="width:80px"></div>' +
          '<label class="mv-check"><input type="checkbox"> Slow Connection</label>' +
          '<label class="mv-check"><input type="checkbox" checked> Auto Reconnect</label></div>',
        '<div class="mv-dialog-footer" style="justify-content:space-between">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-connect-server" style="width:90px">Connect</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-connect-server" style="width:90px">Exit</button></div>'
      );
    },

    "mv-dlg-switch-user": function () {
      // WindowUserLogin 426x223 — Login
      return wrapDialog(
        "mv-dlg-switch-user",
        "Login",
        426,
        '<div class="mv-login-form">' +
          '<div class="mv-login-logo"></div>' +
          "<div style=\"flex:1\">" +
          '<div class="mv-dialog-row"><label style="min-width:90px">User Name:</label><input type="text" id="mvSwitchUser" value="stech" style="width:160px"></div>' +
          '<div class="mv-dialog-row"><label style="min-width:90px">Password:</label><input type="password" id="mvSwitchPass" value="techS" style="width:160px"></div>' +
          '<div class="mv-dialog-row"><label style="min-width:90px">Type:</label><select style="width:160px"><option>STech</option><option>Admin</option><option>Operator</option></select></div>' +
          '<label class="mv-check"><input type="checkbox"> Stay Signed In</label></div></div>',
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-switch-user" style="width:105px">OK</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-switch-user" style="width:105px">Cancel</button></div>'
      );
    },

    "mv-dlg-vdc": function () {
      return wrapDialog(
        "mv-dlg-vdc",
        "Vessel Data Collector",
        520,
        "<fieldset><legend>Collection</legend>" +
          '<div class="mv-dialog-row"><label>Vessel:</label><select style="width:200px">' +
          vesselsOptionsHtml() +
          "</select></div>" +
          '<label class="mv-check"><input type="checkbox" checked> Measurements</label>' +
          '<label class="mv-check"><input type="checkbox" checked> Mapping points</label>' +
          '<label class="mv-check"><input type="checkbox"> Echo curves</label></fieldset>' +
          '<div class="mv-dialog-row"><button class="btn mv-params-btn" type="button">Start Collection</button>' +
          '<button class="btn mv-params-btn" type="button">Stop</button></div>'
      );
    },

    "mv-dlg-graphic-figures": function () {
      // FeaturesWindow 620x300
      return wrapDialog(
        "mv-dlg-graphic-figures",
        "Vessel graphic figures",
        620,
        '<table class="mv-dialog-table mv-features-grid"><thead><tr><th>#</th><th>Type</th><th>Content</th><th>X</th><th>Y</th><th>Z</th></tr></thead><tbody>' +
          "<tr><td>1</td><td>Text</td><td>Coke</td><td>0.0</td><td>0.0</td><td>16.0</td></tr>" +
          "<tr><td>2</td><td>Line</td><td>—</td><td>0.0</td><td>0.0</td><td>0.0</td></tr>" +
          "</tbody></table>" +
          '<div style="display:flex;gap:6px;margin-top:8px">' +
          '<button class="btn mv-params-btn" type="button">Add</button>' +
          '<button class="btn mv-params-btn" type="button">Edit</button>' +
          '<button class="btn mv-params-btn" type="button">Delete</button>' +
          '<button class="btn mv-params-btn" type="button">Clear</button>' +
          '<button class="btn mv-params-btn" type="button">Import</button>' +
          '<button class="btn mv-params-btn" type="button">Export</button></div>',
        '<div class="mv-dialog-footer">' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-graphic-figures">Apply</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-ok="mv-dlg-graphic-figures">OK</button>' +
          '<button class="btn mv-params-btn" type="button" data-mv-dlg-close="mv-dlg-graphic-figures">Cancel</button></div>'
      );
    },
  };

  function ensureDialog(id) {
    var existing = $(id);
    if (existing) {
      // Rebuild so refreshed XAML ports replace earlier stubs in the same session.
      existing.remove();
    }
    var h = ensureHost();
    if (!h || !builders[id]) return;
    h.insertAdjacentHTML("beforeend", builders[id]());
    wireDialogChrome($(id));
  }

  function activatePane(root, pane) {
    if (!root || !pane) return;
    root.querySelectorAll(".mv-groupview-nav label").forEach(function (lab) {
      var inp = lab.querySelector("input[data-pane]");
      lab.classList.toggle("is-active", !!(inp && inp.getAttribute("data-pane") === pane));
    });
    root.querySelectorAll(".mv-groupview-pane").forEach(function (p) {
      p.hidden = p.getAttribute("data-pane") !== pane;
    });
    root.querySelectorAll(".mv-dialog-side-nav > nav button").forEach(function (b) {
      b.classList.toggle("is-active", b.getAttribute("data-pane") === pane);
    });
    root.querySelectorAll(".mv-dialog-pane").forEach(function (p) {
      p.hidden = p.getAttribute("data-pane") !== pane;
    });
  }

  function wireSideNav(root) {
    if (!root) return;
    var gvNav = root.querySelector(".mv-groupview-nav");
    if (gvNav) {
      gvNav.addEventListener("change", function (e) {
        var inp = e.target.closest("input[data-pane]");
        if (inp) activatePane(root, inp.getAttribute("data-pane"));
      });
      gvNav.addEventListener("click", function (e) {
        var lab = e.target.closest("label");
        if (!lab || !gvNav.contains(lab)) return;
        var inp = lab.querySelector("input[data-pane]");
        if (inp) {
          inp.checked = true;
          activatePane(root, inp.getAttribute("data-pane"));
        }
      });
    }
    var nav = root.querySelector(".mv-dialog-side-nav > nav");
    if (!nav) return;
    nav.addEventListener("click", function (e) {
      var btn = e.target.closest("button[data-pane]");
      if (!btn) return;
      activatePane(root, btn.getAttribute("data-pane"));
    });
  }

  function wireInnerTabs(root) {
    if (!root) return;
    root.querySelectorAll(".mv-params-tabs").forEach(function (tablist) {
      var panelsHost = tablist.nextElementSibling;
      if (!panelsHost || !panelsHost.classList.contains("mv-params-panels")) return;
      var tabs = tablist.querySelectorAll(".mv-params-tab[data-tab]");
      tabs.forEach(function (tab) {
        tab.addEventListener("click", function () {
          var name = tab.getAttribute("data-tab");
          tabs.forEach(function (t) {
            t.classList.toggle("is-active", t === tab);
          });
          panelsHost.querySelectorAll("[data-panel]").forEach(function (p) {
            p.hidden = p.getAttribute("data-panel") !== name;
          });
        });
      });
    });
  }

  /** AdvBeamActivation.Enabled / SelectClearAll — Manual.enabled = !AutoBeamSelection. */
  function wireAdvParamsBeams(root) {
    if (!root || root.id !== "mv-dlg-advanced-params" || root.__mvApBeamsWired) return;
    root.__mvApBeamsWired = true;

    // Upload/Download All → MainScreenMngr.BatchStartSetParameters → ProgressWindow
    var uploadBtn = root.querySelector("#mvApUploadAll");
    var downloadBtn = root.querySelector("#mvApDownloadAll");
    var summaryBtn = root.querySelector("#mvApSummary");
    if (uploadBtn) {
      uploadBtn.addEventListener("click", function () {
        runBatchSetParamsProgress("upload");
      });
    }
    if (downloadBtn) {
      downloadBtn.addEventListener("click", function () {
        runBatchSetParamsProgress("download");
      });
    }
    if (summaryBtn) {
      // AdvParamsWindow.OnSummaryClick → AdvancedParamsSummaryWin.Show() (non-modal)
      summaryBtn.addEventListener("click", function () {
        open("mv-dlg-adv-summary");
      });
    }

    var manual = root.querySelector("#mvApBeamManual");
    var autoSel = root.querySelector("#mvApAutoBeamSel");
    var selectAll = root.querySelector("#mvApBeamSelectAll");
    var clearAll = root.querySelector("#mvApBeamClearAll");
    if (!manual || !autoSel) return;

    function setManualChecks(select) {
      manual.querySelectorAll('input[type="checkbox"]').forEach(function (cb) {
        cb.checked = select;
      });
    }
    function syncManualEnabled() {
      // AdvBeamActivation.Enabled(): only Auto Beam Selection gates Manual.
      var on = !!autoSel.checked;
      manual.classList.toggle("is-disabled", on);
      manual.querySelectorAll("input, button").forEach(function (el) {
        el.disabled = on;
      });
    }

    autoSel.addEventListener("click", syncManualEnabled);
    if (selectAll) {
      selectAll.addEventListener("click", function () {
        setManualChecks(true);
      });
    }
    if (clearAll) {
      clearAll.addEventListener("click", function () {
        setManualChecks(false);
      });
    }
    syncManualEnabled();
  }

  /**
   * MainScreenMngr.OpenProgressSetBatchWindow + RetrieveBatchSetParamsCompletedImplBatch.
   * ProgressWindow (DifferentStuff): title Progress; upload/download message + "N %";
   * cancel button = StringsApplic.WarningCanceDeviceOperationButton.
   * Virtualizes BatchCommandLastBatchPercentageCompleted polling (no server).
   */
  var batchProgressState = null;

  function runBatchSetParamsProgress(retrieveType, onDone) {
    // retrieveType: "upload" | "download" (BatchCommandRetrieveType)
    var baseMsg =
      retrieveType === "download"
        ? "Performing parameters download."
        : "Performing parameters upload.";

    if (batchProgressState && batchProgressState.timer) {
      clearTimeout(batchProgressState.timer);
      batchProgressState = null;
    }

    openDialog("mv-dlg-progress");
    var statusEl = $("mvProgStatus");
    var fillEl = $("mvProgFill");
    var barEl = $("mvProgBar");
    var cancelBtn = $("mvProgCancel");
    var btns = $("mvProgBtns");

    if (statusEl) statusEl.value = baseMsg;
    if (fillEl) fillEl.style.width = "0%";
    if (barEl) barEl.setAttribute("aria-valuenow", "0");
    if (btns) btns.hidden = false;
    if (cancelBtn) {
      cancelBtn.textContent = " Cancel Operation  ";
      cancelBtn.disabled = false;
    }

    var state = {
      retrieveType: retrieveType,
      baseMsg: baseMsg,
      pct: 0,
      cancelled: false,
      timer: null,
      onDone: typeof onDone === "function" ? onDone : null,
    };
    batchProgressState = state;

    function finish(ok) {
      if (state.timer) {
        clearTimeout(state.timer);
        state.timer = null;
      }
      if (batchProgressState === state) batchProgressState = null;
      closeDialog("mv-dlg-progress");
      if (state.onDone) state.onDone(ok);
    }

    function setProgress(pct) {
      state.pct = pct;
      // Exact C#: message + (int)percentageCompleted + " %"  (no space after period)
      if (statusEl) statusEl.value = state.baseMsg + (pct | 0) + " %";
      if (fillEl) fillEl.style.width = Math.max(0, Math.min(100, pct)) + "%";
      if (barEl) barEl.setAttribute("aria-valuenow", String(pct | 0));
    }

    function tick() {
      if (state.cancelled || batchProgressState !== state) return;
      // Virtualize server BatchCommandLastBatchPercentageCompleted increments.
      var step = 4 + Math.floor(Math.random() * 11);
      var next = Math.min(100, state.pct + step);
      setProgress(next);
      if (next >= 100) {
        state.timer = setTimeout(function () {
          finish(true);
        }, 180);
        return;
      }
      state.timer = setTimeout(tick, 160 + Math.floor(Math.random() * 240));
    }

    if (cancelBtn && !cancelBtn.__mvProgWired) {
      cancelBtn.__mvProgWired = true;
      cancelBtn.addEventListener("click", function () {
        // OnProgressWindowSetBatchCancelActionPressed → APMMessageBox.ShowQuestionMessage
        showQuestion(
          "Are you sure you want to cancel device current operation ?",
          "3D MultiVision",
          function () {
            // Yes → BatchCommandsStop → completion closes ProgressWindow
            if (batchProgressState) {
              batchProgressState.cancelled = true;
              if (batchProgressState.timer) {
                clearTimeout(batchProgressState.timer);
                batchProgressState.timer = null;
              }
              var done = batchProgressState.onDone;
              batchProgressState = null;
              closeDialog("mv-dlg-progress");
              if (done) done(false);
            }
          },
          null
        );
      });
    }

    // Title-bar X: ProgressWindow.IsUserCanCloseMe default true → Close allowed.
    var overlay = $("mv-dlg-progress");
    if (overlay && !overlay.__mvProgCloseWired) {
      overlay.__mvProgCloseWired = true;
      overlay.addEventListener(
        "click",
        function (e) {
          var closeBtn = e.target.closest('[data-mv-dlg-close="mv-dlg-progress"]');
          if (!closeBtn) return;
          if (batchProgressState) {
            batchProgressState.cancelled = true;
            if (batchProgressState.timer) {
              clearTimeout(batchProgressState.timer);
              batchProgressState.timer = null;
            }
            batchProgressState = null;
          }
        },
        true
      );
    }

    state.timer = setTimeout(tick, 120);
  }

  /**
   * AdvancedParamsSummaryWin.SetVessel + grid bind.
   * Reads live values from open AdvParams form when present; else defaults.
   */
  function populateAdvSummary(root) {
    if (!root) return;
    var ap = $("mv-dlg-advanced-params");
    function apInputs(panel) {
      if (!ap) return [];
      var pane = ap.querySelector('.mv-ap-tab-pane[data-panel="' + panel + '"]');
      if (!pane) return [];
      return Array.prototype.map.call(
        pane.querySelectorAll(".mv-ap-input, .mv-ap-combo"),
        function (el) {
          return el.value;
        }
      );
    }
    var vesselVals = apInputs("vessel");
    var advVals = apInputs("adv");
    // Vessel: OutputDamping, Steepest, MaxCap, MaxEmpty, MaxFill, MinSNR
    var v = {
      damp: vesselVals[0] != null ? vesselVals[0] : "300",
      slope: vesselVals[1] != null ? vesselVals[1] : "35",
      cap: vesselVals[2] != null ? vesselVals[2] : "100",
      empty: vesselVals[3] != null ? vesselVals[3] : "10",
      fill: vesselVals[4] != null ? vesselVals[4] : "10",
      snr: vesselVals[5] != null ? vesselVals[5] : "13",
    };
    // Adv rows: Angle, Side, Bottom, Restrain, ThreshSens, ThreshWidth, Mask%, UserFE, UserSens, AutoFE, AutoSens
    var a = {
      angle: advVals[0] != null ? advVals[0] : "0",
      side: advVals[1] != null ? advVals[1] : "1",
      bottom: advVals[2] != null ? advVals[2] : "1",
      restrain: advVals[3] != null ? advVals[3] : "10",
      threshSens: advVals[4] != null ? advVals[4] : "9",
      threshWidth: advVals[5] != null ? advVals[5] : "0",
      mask: advVals[6] != null ? advVals[6] : "0",
      userFe: advVals[7] != null ? advVals[7] : "Enable",
      userSens: advVals[8] != null ? advVals[8] : "1.2",
      autoFe: advVals[9] != null ? advVals[9] : "Enable",
      autoSens: advVals[10] != null ? advVals[10] : "1.2",
    };
    function apCheckByLabel(text) {
      if (!ap) return null;
      var labels = ap.querySelectorAll(".mv-ap-check");
      for (var i = 0; i < labels.length; i++) {
        var span = labels[i].querySelector("span");
        if (span && span.textContent.trim() === text) {
          var inp = labels[i].querySelector("input");
          return inp ? !!inp.checked : null;
        }
      }
      return null;
    }
    function bOr(label, def) {
      var val = apCheckByLabel(label);
      return val == null ? def : val;
    }
    var autoSel = ap ? ap.querySelector("#mvApAutoBeamSel") : null;
    var autoRange = ap ? ap.querySelector("#mvApAutoBeamRange") : null;
    var beams = {
      freqH: bOr("High Frequency", true),
      freqM: bOr("Med Frequency", true),
      freqL: bOr("Low Frequency", true),
      d30: bOr("30 degrees", true),
      d90: bOr("90 degrees", true),
      d150: bOr("150 degrees", true),
      d210: bOr("210 degrees", true),
      d270: bOr("270 degrees", true),
      d330: bOr("330 degrees", true),
      autoSel: autoSel ? !!autoSel.checked : true,
      autoRange: autoRange ? !!autoRange.checked : true,
    };

    var list =
      typeof global.mvGetVessels === "function" ? global.mvGetVessels() : [];
    if (!list.length) {
      list = [{ scannerName: "Coke_1", short: "Coke_1", name: "Coke" }];
    }

    function td(val) {
      return "<td>" + (val == null ? "" : String(val)) + "</td>";
    }
    function boolCell(b) {
      return td(b ? "True" : "False");
    }

    var advBody = root.querySelector("#mvApSumAdv tbody");
    var beamsBody = root.querySelector("#mvApSumBeams tbody");
    if (advBody) {
      advBody.innerHTML = list
        .map(function (ves) {
          var name = ves.scannerName || ves.short || ves.name || "Device";
          return (
            "<tr>" +
            td(name) +
            td(v.damp) +
            td(v.slope) +
            td(v.cap) +
            td(v.empty) +
            td(v.fill) +
            td(v.snr) +
            td("II") +
            td(a.threshSens) +
            td(a.threshWidth) +
            td(a.restrain) +
            td(Number(a.side).toFixed ? Number(a.side).toFixed(3) : a.side) +
            td(Number(a.bottom).toFixed ? Number(a.bottom).toFixed(3) : a.bottom) +
            td("Do not Discard") +
            td(a.mask) +
            td(a.userFe) +
            td(a.userSens) +
            td(a.autoFe) +
            td(a.autoSens) +
            td("No") +
            td(a.angle) +
            "</tr>"
          );
        })
        .join("");
    }
    if (beamsBody) {
      beamsBody.innerHTML = list
        .map(function (ves) {
          var name = ves.scannerName || ves.short || ves.name || "Device";
          return (
            "<tr>" +
            td(name) +
            boolCell(beams.freqH) +
            boolCell(beams.freqM) +
            boolCell(beams.freqL) +
            boolCell(beams.d30) +
            boolCell(beams.d90) +
            boolCell(beams.d150) +
            boolCell(beams.d210) +
            boolCell(beams.d270) +
            boolCell(beams.d330) +
            boolCell(beams.autoSel) +
            boolCell(beams.autoRange) +
            "</tr>"
          );
        })
        .join("");
    }
  }

  function wireWizardVessel(root) {
    if (!root || root.id !== "mv-dlg-device-wizard" || root.__mvWizWired) return;
    root.__mvWizWired = true;

    function show(el, on) {
      if (!el) return;
      el.classList.toggle("is-hidden", !on);
    }
    function val(id) {
      var el = root.querySelector("#" + id);
      if (!el) return "";
      var input = el.querySelector("input") || el;
      return input.value;
    }
    function setLabel(rowId, text) {
      var el = root.querySelector("#" + rowId);
      if (!el) return;
      var lab = el.querySelector("label");
      if (lab) lab.textContent = text;
    }

    // WizardStepVessel.UpdateDisplayShape + ModelWPFGeometry.ListShape*Type
    function fillShapeSelect(sel, opts, keep) {
      if (!sel) return;
      var cur = keep || sel.value;
      sel.innerHTML = opts
        .map(function (o) {
          return '<option value="' + o.v + '"' + (o.v === cur ? " selected" : "") + ">" + o.l + "</option>";
        })
        .join("");
      if (!opts.some(function (o) {
        return o.v === sel.value;
      })) {
        sel.value = opts[0].v;
      }
    }
    function syncShapeLists() {
      var cen = (root.querySelector("#mvWizCenShape") || {}).value || "cylinder";
      var topSel = root.querySelector("#mvWizTopShape");
      var botSel = root.querySelector("#mvWizBotShape");
      if (cen === "cube") {
        fillShapeSelect(topSel, [
          { v: "flat", l: "Flat" },
          { v: "pyramid", l: "Pyramid" },
        ]);
        fillShapeSelect(botSel, [
          { v: "flat", l: "Flat" },
          { v: "pyramid", l: "Pyramid" },
          { v: "pyramid2", l: "2 Pyramids" },
          { v: "cone", l: "Cone" },
        ]);
      } else {
        fillShapeSelect(topSel, [
          { v: "flat", l: "Flat" },
          { v: "cone", l: "Cone" },
          { v: "dome", l: "Dome" },
        ]);
        fillShapeSelect(botSel, [
          { v: "flat", l: "Flat" },
          { v: "cone", l: "Cone" },
          { v: "cone2", l: "2 Cones" },
          { v: "dome", l: "Dome" },
          { v: "pyramid", l: "Pyramid" },
          { v: "inverted", l: "Inverted Cone" },
        ]);
      }
    }
    function syncTopFields() {
      var shape = (root.querySelector("#mvWizTopShape") || {}).value || "cone";
      show(root.querySelector("#mvWizTopH"), shape === "cone" || shape === "dome" || shape === "pyramid");
      show(root.querySelector("#mvWizTopD"), shape === "cone");
      setLabel("mvWizTopD", "Diameter:");
      show(root.querySelector("#mvWizTopX"), shape === "pyramid");
      show(root.querySelector("#mvWizTopY"), shape === "pyramid");
      if (shape === "pyramid") {
        setLabel("mvWizTopX", "X:");
        setLabel("mvWizTopY", "Y:");
      }
    }
    function syncCenFields() {
      var shape = (root.querySelector("#mvWizCenShape") || {}).value || "cylinder";
      show(root.querySelector("#mvWizCenH"), true);
      show(root.querySelector("#mvWizCenD"), shape === "cylinder");
      setLabel("mvWizCenD", "Diameter:");
      show(root.querySelector("#mvWizCenX"), shape === "cube");
      show(root.querySelector("#mvWizCenY"), shape === "cube");
      if (shape === "cube") {
        setLabel("mvWizCenX", "X:");
        setLabel("mvWizCenY", "Y:");
      }
    }
    function syncBotFields() {
      var shape = (root.querySelector("#mvWizBotShape") || {}).value || "cone";
      var needsH = shape === "cone" || shape === "cone2" || shape === "dome" || shape === "pyramid" || shape === "pyramid2" || shape === "inverted";
      show(root.querySelector("#mvWizBotH"), needsH);
      show(root.querySelector("#mvWizBotD"), shape === "cone" || shape === "cone2");
      setLabel("mvWizBotD", "Diameter:");
      show(root.querySelector("#mvWizBotX"), shape === "pyramid" || shape === "pyramid2" || shape === "inverted");
      show(root.querySelector("#mvWizBotY"), shape === "pyramid" || shape === "pyramid2" || shape === "inverted");
      if (shape === "inverted") {
        setLabel("mvWizBotX", "Bottom Diam:");
        setLabel("mvWizBotY", "Top Diam:");
      } else if (shape === "pyramid" || shape === "pyramid2") {
        setLabel("mvWizBotX", "X:");
        setLabel("mvWizBotY", "Y:");
      }
      // X/Y Position for Cone / Pyramid family (WizardStepVessel showPositionXY)
      var showPos = shape === "cone" || shape === "cone2" || shape === "pyramid" || shape === "pyramid2";
      show(root.querySelector("#mvWizBotXPos"), showPos);
      show(root.querySelector("#mvWizBotYPos"), showPos);
    }

    function vesselTotalHeight() {
      var topH = parseFloat(val("mvWizTopH"));
      var cenH = parseFloat(val("mvWizCenH"));
      var botH = parseFloat(val("mvWizBotH"));
      var topShape = (root.querySelector("#mvWizTopShape") || {}).value || "cone";
      var botShape = (root.querySelector("#mvWizBotShape") || {}).value || "cone";
      if (isNaN(topH)) topH = 0;
      if (isNaN(cenH)) cenH = 16;
      if (isNaN(botH)) botH = 0;
      if (topShape === "flat") topH = 0;
      if (botShape === "flat" || botShape === "inverted") botH = 0;
      return topH + cenH + botH;
    }

    function bottomCenterHeightM() {
      var cenH = parseFloat(val("mvWizCenH"));
      var botH = parseFloat(val("mvWizBotH"));
      var botShape = (root.querySelector("#mvWizBotShape") || {}).value || "cone";
      if (isNaN(cenH)) cenH = 16;
      if (isNaN(botH)) botH = 0;
      if (botShape !== "flat" && botShape !== "inverted") cenH += botH;
      return cenH;
    }

    function centerDiameterM() {
      var cenShape = (root.querySelector("#mvWizCenShape") || {}).value || "cylinder";
      if (cenShape === "cube") {
        return Math.max(parseFloat(val("mvWizCenX")) || 9, parseFloat(val("mvWizCenY")) || 9);
      }
      var d = parseFloat(val("mvWizCenD"));
      return isNaN(d) ? 9 : d;
    }

    /** Vessel.AutoCalculateZFromVesselCircular / Square — Z from vessel bottom at (x,y). */
    function autoCalculateZFromVesselBottom(x, y) {
      var total = vesselTotalHeight();
      var cenShape = (root.querySelector("#mvWizCenShape") || {}).value || "cylinder";
      var topShape = (root.querySelector("#mvWizTopShape") || {}).value || "cone";
      var topH = parseFloat(val("mvWizTopH"));
      if (isNaN(topH) || topShape === "flat") topH = 0;
      var bch = bottomCenterHeightM();
      var diam = centerDiameterM();

      if (cenShape === "cube") {
        var diamX = parseFloat(val("mvWizCenX")) || diam;
        var diamY = parseFloat(val("mvWizCenY")) || diam;
        var topDX = parseFloat(val("mvWizTopX"));
        var topDY = parseFloat(val("mvWizTopY"));
        if (isNaN(topDX)) topDX = 0;
        if (isNaN(topDY)) topDY = 0;
        var nx = x / (diamX / 2);
        var ny = y / (diamY / 2);
        var w1 = -topDX / diamX;
        var u1 = -topDY / diamY;
        var w3 = topDX / diamX;
        var u3 = topDY / diamY;
        if (nx < w1) nx = (nx - w1) / (-1 - w1);
        else if (nx > w3) nx = (nx - w3) / (1 - w3);
        else nx = 0;
        if (ny < u1) ny = (ny - u1) / (-1 - u1);
        else if (ny > u3) ny = (ny - u3) / (1 - u3);
        else ny = 0;
        return bch + topH * (1 - Math.max(nx, ny));
      }

      if (topShape === "flat" || topH <= 0) return total;
      if (topShape === "dome") {
        var dd = (4 * (x * x + y * y)) / (diam * diam);
        if (dd > 1) dd = 1;
        return bch + topH * Math.sqrt(Math.max(0, 1 - dd));
      }
      if (topShape === "cone" || topShape === "pyramid") {
        var topDiam = parseFloat(val("mvWizTopD"));
        if (topShape === "pyramid") topDiam = parseFloat(val("mvWizTopX"));
        if (isNaN(topDiam)) topDiam = 0;
        var d = (4 * (x * x + y * y)) / (diam * diam);
        if (topDiam < diam) {
          if (d > 1) return bch;
          var w = (diam * topH) / (diam - topDiam);
          var zr = Math.sqrt(Math.max(0, d));
          return zr > topDiam / diam ? bch + (1 - zr) * w : bch + topH;
        }
        return total;
      }
      return total;
    }

    /** ScannerDeviceData.RecalculateScannersDirectiron — angle toward origin. */
    function autoCalculateAngle(x, y) {
      var angle = 0;
      if (x === 0) {
        if (y > 0) angle = 270;
        else if (y < 0) angle = 90;
        else angle = 180;
      } else if (y === 0) {
        if (x > 0) angle = 180;
        else if (x < 0) angle = 0;
      } else {
        angle = (Math.atan(y / x) * 180) / Math.PI;
        if (x > 0 && y > 0) angle += 180;
        else if (x < 0 && y > 0) angle += 360;
        else if (x > 0 && y < 0) angle += 180;
        if (angle < 0) angle += 360;
      }
      return angle;
    }

    function isAngleManual() {
      var cb = root.querySelector("#mvWizAngleManual");
      return !!(cb && cb.checked);
    }

    /** After X/Y (or Offset) change: recompute Z; recompute Angle unless manual. */
    function syncDeviceFromXY() {
      var xEl = root.querySelector("#mvWizDevX");
      var yEl = root.querySelector("#mvWizDevY");
      var zEl = root.querySelector("#mvWizDevZ");
      var offEl = root.querySelector("#mvWizDevOff");
      var angEl = root.querySelector("#mvWizDevAng");
      var x = xEl ? parseFloat(xEl.value) : 0;
      var y = yEl ? parseFloat(yEl.value) : 0;
      var off = offEl ? parseFloat(offEl.value) : 0;
      if (isNaN(x)) x = 0;
      if (isNaN(y)) y = 0;
      if (isNaN(off)) off = 0;
      var surfaceZ = autoCalculateZFromVesselBottom(x, y);
      // AutoCalculateZFromVesselBottomUseZOffsetAndUpdate (Offset ≈ 0 path).
      var z = surfaceZ + off;
      if (zEl) zEl.value = String(+z.toFixed(3));
      if (angEl && !isAngleManual()) {
        angEl.value = String(+autoCalculateAngle(x, y).toFixed(3));
      }
    }

    function syncCalibFromLevel() {
      var total = vesselTotalHeight();
      var fullLevel = root.querySelector("#mvWizFullLevel");
      var fullDist = root.querySelector("#mvWizFullDist");
      var emptyLevel = root.querySelector("#mvWizEmptyLevel");
      var emptyDist = root.querySelector("#mvWizEmptyDist");
      var fullH = root.querySelector("#mvWizFullH");
      var emptyH = root.querySelector("#mvWizEmptyH");
      var fl = fullLevel ? parseFloat(fullLevel.value) : NaN;
      var el = emptyLevel ? parseFloat(emptyLevel.value) : NaN;
      if (isNaN(fl)) fl = Math.max(0, total - 0.5);
      if (isNaN(el)) el = 0;
      fl = Math.max(0, Math.min(total, fl));
      el = Math.max(0, Math.min(total, el));
      if (fl < el) fl = el;
      if (fullLevel) fullLevel.value = String(+fl.toFixed(3));
      if (emptyLevel) emptyLevel.value = String(+el.toFixed(3));
      if (fullDist) fullDist.value = String(+Math.max(0, total - fl).toFixed(3));
      if (emptyDist) emptyDist.value = String(+Math.max(0, total - el).toFixed(3));
      if (fullH) fullH.value = String(+total.toFixed(3));
      if (emptyH) emptyH.value = String(+total.toFixed(3));
    }

    function syncCalibFromDist(which) {
      var total = vesselTotalHeight();
      var fullLevel = root.querySelector("#mvWizFullLevel");
      var fullDist = root.querySelector("#mvWizFullDist");
      var emptyLevel = root.querySelector("#mvWizEmptyLevel");
      var emptyDist = root.querySelector("#mvWizEmptyDist");
      if (which === "full" && fullDist && fullLevel) {
        var fd = parseFloat(fullDist.value);
        if (isNaN(fd)) fd = 0.5;
        fd = Math.max(0, Math.min(total, fd));
        fullLevel.value = String(+Math.max(0, total - fd).toFixed(3));
        fullDist.value = String(+fd.toFixed(3));
      }
      if (which === "empty" && emptyDist && emptyLevel) {
        var ed = parseFloat(emptyDist.value);
        if (isNaN(ed)) ed = total;
        ed = Math.max(0, Math.min(total, ed));
        emptyLevel.value = String(+Math.max(0, total - ed).toFixed(3));
        emptyDist.value = String(+ed.toFixed(3));
      }
      syncCalibFromLevel();
    }

    function syncCalibFields() {
      syncCalibFromLevel();
    }

    function readFillPoints() {
      var rows = [];
      root.querySelectorAll("#mvWizFillTable tbody tr").forEach(function (tr) {
        var inputs = tr.querySelectorAll("input");
        if (inputs.length < 2) return;
        var x = parseFloat(inputs[0].value);
        var y = parseFloat(inputs[1].value);
        rows.push({ x: isNaN(x) ? 0 : x, y: isNaN(y) ? 0 : y });
      });
      return rows;
    }

    function readParams() {
      var topShape = (root.querySelector("#mvWizTopShape") || {}).value || "cone";
      var cenShape = (root.querySelector("#mvWizCenShape") || {}).value || "cylinder";
      var botShape = (root.querySelector("#mvWizBotShape") || {}).value || "cone";
      var cenD = parseFloat(val("mvWizCenD"));
      if (isNaN(cenD)) cenD = 9;
      if (cenShape === "cube") {
        cenD = Math.max(parseFloat(val("mvWizCenX")) || 9, parseFloat(val("mvWizCenY")) || 9);
      }
      function num(id, fallback) {
        var n = parseFloat(val(id));
        return isNaN(n) ? fallback : n;
      }
      var total = vesselTotalHeight();
      var fullLevel = num("mvWizFullLevel", Math.max(0, total - 0.5));
      var emptyLevel = num("mvWizEmptyLevel", 0);
      return {
        top: {
          shape: topShape,
          height: num("mvWizTopH", 0),
          diameter: topShape === "pyramid" ? num("mvWizTopX", 0) : num("mvWizTopD", 0),
          x: num("mvWizTopX", 0),
          y: num("mvWizTopY", 0),
        },
        center: {
          shape: cenShape,
          height: num("mvWizCenH", 16),
          diameter: cenD,
          x: num("mvWizCenX", 9),
          y: num("mvWizCenY", 9),
        },
        bottom: {
          shape: botShape,
          height: num("mvWizBotH", 0),
          diameter: botShape === "pyramid" || botShape === "pyramid2" ? num("mvWizBotX", 0) : num("mvWizBotD", 0),
          x: num("mvWizBotX", 0),
          y: num("mvWizBotY", 0),
          xPos: num("mvWizBotXPos", 0),
          yPos: num("mvWizBotYPos", 0),
        },
        highlight: root.__mvWizHighlight || null,
        // ShowServerDeviceArrow stays on for ScannerPosition / FillPoints / ProcessDetails.
        showDeviceAxis: step >= 2,
        device: {
          x: num("mvWizDevX", 0),
          y: num("mvWizDevY", 0),
          z: num("mvWizDevZ", total),
          angle: num("mvWizDevAng", 180),
        },
        fillPoints: step >= 3 ? readFillPoints() : [],
        calibration: {
          show: step >= 4,
          fullLevel: fullLevel,
          emptyLevel: emptyLevel,
        },
      };
    }

    function refresh3d(opts) {
      opts = opts || {};
      syncTopFields();
      syncCenFields();
      syncBotFields();
      if (!global.MvWizard3D) return;
      var host = root.querySelector("#mvWiz3d");
      if (!host) return;
      global.MvWizard3D.mount(host);
      global.MvWizard3D.update(readParams(), opts);
      global.MvWizard3D.resize();
      // Re-apply zoom from slider only when view was refit; preserveView keeps camera as-is.
      if (!opts.preserveView) {
        var zoom = root.querySelector("#mvWizZoom");
        if (zoom) global.MvWizard3D.setZoom(zoom.value);
      }
    }

    function refresh3dKeepView() {
      refresh3d({ preserveView: true });
    }

    ["mvWizTopShape", "mvWizCenShape", "mvWizBotShape"].forEach(function (id) {
      var sel = root.querySelector("#" + id);
      if (!sel) return;
      sel.addEventListener("change", function () {
        if (id === "mvWizCenShape") syncShapeLists();
        refresh3d();
      });
    });
    // Highlight the section being edited (WizardStepVessel GotFocus → HightLightedShape).
    var form = root.querySelector(".mv-wiz-vessel-form");
    if (form) {
      form.addEventListener("focusin", function (e) {
        var fs = e.target.closest("fieldset");
        if (!fs) return;
        var leg = (fs.querySelector("legend") || {}).textContent || "";
        if (/Top/i.test(leg)) root.__mvWizHighlight = "top";
        else if (/Center/i.test(leg)) root.__mvWizHighlight = "center";
        else if (/Bottom/i.test(leg)) root.__mvWizHighlight = "bottom";
        else return;
        if (global.MvWizard3D) {
          global.MvWizard3D.update(readParams(), { preserveView: true });
        }
      });
      form.addEventListener("input", function (e) {
        if (!e.target || !(e.target.matches("input") || e.target.matches("select"))) return;
        if (step >= 2) syncDeviceFromXY();
        if (step >= 4) syncCalibFromLevel();
        refresh3d();
      });
      form.addEventListener("change", function (e) {
        if (!e.target || !(e.target.matches("input") || e.target.matches("select"))) return;
        if (step >= 2) syncDeviceFromXY();
        if (step >= 4) syncCalibFromLevel();
        refresh3d();
      });
    }

    // Real: canvasMain.MouseUp clears highlight after click/drag on the 3D model.
    // Only the vessel canvas — not zoom/d-pad, and not left-panel scroll.
    function clearWizHighlight() {
      if (!root.__mvWizHighlight) return;
      root.__mvWizHighlight = null;
      if (global.MvWizard3D) {
        global.MvWizard3D.update(readParams(), { preserveView: true });
      }
    }
    var host3d = root.querySelector("#mvWiz3d");
    if (host3d) {
      host3d.addEventListener("pointerup", function (e) {
        if (!e.target || e.target.tagName !== "CANVAS") return;
        clearWizHighlight();
      });
    }

    var zoom = root.querySelector("#mvWizZoom");
    if (zoom) {
      zoom.addEventListener("input", function () {
        if (global.MvWizard3D) global.MvWizard3D.setZoom(zoom.value);
      });
    }
    function bind(id, fn) {
      var b = root.querySelector("#" + id);
      if (b) b.addEventListener("click", fn);
    }
    bind("mvWizZoomIn", function () {
      if (!zoom) return;
      zoom.value = String(Math.min(50, Number(zoom.value) + 5));
      if (global.MvWizard3D) global.MvWizard3D.setZoom(zoom.value);
    });
    bind("mvWizZoomOut", function () {
      if (!zoom) return;
      zoom.value = String(Math.max(0, Number(zoom.value) - 5));
      if (global.MvWizard3D) global.MvWizard3D.setZoom(zoom.value);
    });
    bind("mvWizRotLeft", function () {
      if (global.MvWizard3D) global.MvWizard3D.nudge(-1, 0);
    });
    bind("mvWizRotRight", function () {
      if (global.MvWizard3D) global.MvWizard3D.nudge(1, 0);
    });
    bind("mvWizRotUp", function () {
      if (global.MvWizard3D) global.MvWizard3D.nudge(0, 1);
    });
    bind("mvWizRotDown", function () {
      if (global.MvWizard3D) global.MvWizard3D.nudge(0, -1);
    });
    bind("mvWizRotReset", function () {
      if (global.MvWizard3D) global.MvWizard3D.resetView();
      if (zoom) {
        zoom.value = "25";
        if (global.MvWizard3D) global.MvWizard3D.setZoom(25);
      }
    });

    // Step navigation: Vessel → Device Position → Filling Points → Full Empty Calibration.
    var step = 1;
    var totalSteps = 4;
    var backBtn = root.querySelector("#mvWizBack");
    var nextBtn = root.querySelector("#mvWizNext");
    var stepLabel = root.querySelector("#mvWizStepLabel");
    var shell = root.querySelector(".mv-wiz-device");

    function goStep(n) {
      step = Math.max(1, Math.min(totalSteps, n));
      if (shell) shell.setAttribute("data-wiz-current", String(step));
      // Real WizardStepDevice keeps Device Position visible on steps 2–4; sections accumulate.
      root.querySelectorAll(".mv-wiz-step-pane").forEach(function (pane) {
        var sn = Number(pane.getAttribute("data-wiz-step"));
        var on =
          (step === 1 && sn === 1) || (step >= 2 && sn >= 2 && sn <= step);
        pane.hidden = !on;
        pane.classList.toggle("is-active", on);
      });
      // WizardBaseWindow.AddStep: OnStepName() empty for Vessel/Device → header is " Step N/4".
      var numEl = root.querySelector(".mv-wiz-step-num");
      var nameEl = root.querySelector("#mvWizStepName");
      if (numEl) numEl.textContent = "Step " + step + "/" + totalSteps;
      if (nameEl) nameEl.textContent = "";
      if (stepLabel) {
        /* keep container; children updated above */
      }
      if (backBtn) backBtn.disabled = step <= 1;
      if (nextBtn) nextBtn.textContent = step >= totalSteps ? "Finish" : "Next >";

      if (step >= 4) {
        syncCalibFields();
      }
      if (step >= 2) {
        syncDeviceFromXY();
      }
      /**
       * Exact 1↔2(+device) camera from WizardWindowDevice / Set3DControlDisplay.
       * One update() with viewMode — never paintGeometry then flip (that double-frames).
       */
      var prevStep = root.__mvWizPrevStep || 1;
      if (root.__mvWizDeviceDefin == null) root.__mvWizDeviceDefin = "unknown";
      if (root.__mvWizDeviceDefinPrev == null) root.__mvWizDeviceDefinPrev = "unknown";

      function setDeviceDefinType(nextDefin) {
        root.__mvWizDeviceDefinPrev = root.__mvWizDeviceDefin;
        root.__mvWizDeviceDefin = nextDefin;
      }

      /** Set3DControlDisplay — returns viewMode for a single MvWizard3D.update. */
      function viewModeForSet3DControlDisplay(fromNextAction) {
        var firstEntry = root.__mvWizDeviceDefinPrev === "unknown";
        if (!fromNextAction) firstEntry = false;
        if (firstEntry && root.__mvWizDeviceDefin === "scanner") return "top";
        return "origin";
      }

      function paintOnce(viewMode) {
        if (!global.MvWizard3D) return;
        var host = root.querySelector("#mvWiz3d");
        if (!host) return;
        global.MvWizard3D.mount(host);
        var opts = viewMode ? { viewMode: viewMode } : { preserveView: true };
        global.MvWizard3D.update(readParams(), opts);
        global.MvWizard3D.resize();
        if (viewMode) {
          var zoom = root.querySelector("#mvWizZoom");
          if (zoom) {
            zoom.value = "25";
            global.MvWizard3D.setZoom(25);
          }
        }
      }

      if (step === 2 && prevStep === 1) {
        // NextStepView: DeviceDefinType=ScannerPosition; Update3DDisplay; Set3DControl(true)
        setDeviceDefinType("scanner");
        paintOnce(viewModeForSet3DControlDisplay(true));
      } else if (step === 3 && prevStep === 2) {
        setDeviceDefinType("fill");
        paintOnce(viewModeForSet3DControlDisplay(true));
      } else if (step === 4 && prevStep === 3) {
        setDeviceDefinType("calib");
        paintOnce(viewModeForSet3DControlDisplay(true));
      } else if (step === 3 && prevStep === 4) {
        setDeviceDefinType("fill");
        paintOnce(viewModeForSet3DControlDisplay(false));
      } else if (step === 2 && prevStep === 3) {
        setDeviceDefinType("scanner");
        paintOnce(viewModeForSet3DControlDisplay(false));
      } else if (step === 1 && prevStep === 2) {
        // Back: MovePrevious Set3DControlDisplay(false); vessel Set3DControl reparent only.
        // DeviceDefinType unchanged.
        paintOnce(viewModeForSet3DControlDisplay(false));
      } else if (step === 1) {
        // OnLoaded — RotateToOriginView
        paintOnce("origin");
      } else {
        paintOnce(null);
      }
      root.__mvWizPrevStep = step;
    }

    if (backBtn) {
      backBtn.addEventListener("click", function () {
        goStep(step - 1);
      });
    }
    if (nextBtn) {
      nextBtn.addEventListener("click", function () {
        if (step >= totalSteps) {
          // WizardWindowDevice.NextNewSiteDefin online path:
          // SendCommandsToServer → BatchStartSetParameters → ProgressWindow, then CloseWizard.
          closeDialog("mv-dlg-device-wizard");
          runBatchSetParamsProgress("upload", function (ok) {
            status(
              ok
                ? "Device configuration uploaded."
                : "Device configuration upload cancelled."
            );
          });
          return;
        }
        goStep(step + 1);
      });
    }

    var angleManual = root.querySelector("#mvWizAngleManual");
    if (angleManual) {
      angleManual.addEventListener("change", function () {
        var ang = root.querySelector("#mvWizDevAng");
        var manual = !!angleManual.checked;
        if (ang) ang.readOnly = !manual;
        // WizardStepDevice.checkBoxDeviceAngleManual_Click:
        // Unchecking → question StringsApplic.Wizard_ScannerAngleRecalculateWarning
        if (!manual) {
          showQuestion(
            "Scanners angle will be recalculated. Are you sure?",
            "3D MultiVision",
            function () {
              syncDeviceFromXY();
              refresh3dKeepView();
            },
            function () {
              // No: keep current Angle values; auto mode still on for later X/Y edits.
              refresh3dKeepView();
            }
          );
          return;
        }
        refresh3dKeepView();
      });
    }
    function wireFillTableLive() {
      var tb = root.querySelector("#mvWizFillTable");
      if (!tb || tb.__mvFillLive) return;
      tb.__mvFillLive = true;
      tb.addEventListener("input", function () {
        if (step >= 3) refresh3dKeepView();
      });
    }
    wireFillTableLive();
    bind("mvWizFillAdd", function () {
      var tb = root.querySelector("#mvWizFillTable tbody");
      if (!tb || tb.querySelectorAll("tr").length >= 9) return;
      var tr = document.createElement("tr");
      tr.innerHTML = '<td><input value="0"></td><td><input value="0"></td>';
      tb.appendChild(tr);
      refresh3dKeepView();
    });
    bind("mvWizFillDel", function () {
      var tb = root.querySelector("#mvWizFillTable tbody");
      if (!tb || !tb.querySelector("tr")) return;
      var last = tb.querySelector("tr:last-child");
      if (last) tb.removeChild(last);
      refresh3dKeepView();
    });
    bind("mvWizFillClear", function () {
      var tb = root.querySelector("#mvWizFillTable tbody");
      if (!tb) return;
      tb.innerHTML = "";
      refresh3dKeepView();
    });
    bind("mvWizCalibDefault", function () {
      // SetDefaultCalibration: Full = total−0.5, Empty = 0
      var total = vesselTotalHeight();
      var fullLevel = root.querySelector("#mvWizFullLevel");
      var emptyLevel = root.querySelector("#mvWizEmptyLevel");
      if (fullLevel) fullLevel.value = String(Math.max(0, +(total - 0.5).toFixed(3)));
      if (emptyLevel) emptyLevel.value = "0";
      syncCalibFromLevel();
      refresh3dKeepView();
      status("Full/Empty calibration reset to defaults.");
    });
    bind("mvWizCalibTable", function () {
      status("Calibration table view.");
    });

    // Device Position: X/Y/Offset → auto Z (+ auto Angle unless manual).
    // ScannerZOffset setter: Zpos = AutoCalculateZFromVesselBottom + Offset.
    ["mvWizDevX", "mvWizDevY", "mvWizDevOff"].forEach(function (id) {
      var el = root.querySelector("#" + id);
      if (!el) return;
      el.addEventListener("input", function () {
        syncDeviceFromXY();
        refresh3dKeepView();
      });
    });
    var angInp = root.querySelector("#mvWizDevAng");
    if (angInp) {
      angInp.addEventListener("input", function () {
        if (!isAngleManual()) return;
        refresh3dKeepView();
      });
    }

    // Full/Empty: Level ↔ Distance linked (Level + Distance = Vessel Height).
    var fullLevelEl = root.querySelector("#mvWizFullLevel");
    var emptyLevelEl = root.querySelector("#mvWizEmptyLevel");
    var fullDistEl = root.querySelector("#mvWizFullDist");
    var emptyDistEl = root.querySelector("#mvWizEmptyDist");
    if (fullLevelEl) {
      fullLevelEl.addEventListener("input", function () {
        syncCalibFromLevel();
        refresh3dKeepView();
      });
    }
    if (emptyLevelEl) {
      emptyLevelEl.addEventListener("input", function () {
        syncCalibFromLevel();
        refresh3dKeepView();
      });
    }
    if (fullDistEl) {
      fullDistEl.addEventListener("input", function () {
        syncCalibFromDist("full");
        refresh3dKeepView();
      });
    }
    if (emptyDistEl) {
      emptyDistEl.addEventListener("input", function () {
        syncCalibFromDist("empty");
        refresh3dKeepView();
      });
    }

    goStep(1);
    syncShapeLists();
    syncDeviceFromXY();

    // Mount after layout so the canvas gets real size.
    root.__mvWizRefresh = refresh3d;
    root.__mvWizGoStep = goStep;
    root.__mvWizDeviceDefin = "unknown";
    root.__mvWizDeviceDefinPrev = "unknown";
    root.__mvWizPrevStep = 1;
    setTimeout(refresh3d, 40);
    setTimeout(refresh3d, 200);
  }

  function wireMaterials(root) {
    if (!root || root.id !== "mv-dlg-materials") return;
    var list = root.querySelector("#mvMatList");
    var name = root.querySelector("#mvMatName");
    var color = root.querySelector("#mvMatColor");
    var swatch = root.querySelector("#mvMatSwatch");
    if (list) {
      list.addEventListener("click", function (e) {
        var item = e.target.closest(".mat-item");
        if (!item) return;
        list.querySelectorAll(".mat-item").forEach(function (it) {
          it.classList.toggle("is-selected", it === item);
        });
        if (name) name.value = item.textContent.trim();
        var sw = item.querySelector(".mv-mat-swatch");
        if (sw && color) {
          var bg = sw.style.backgroundColor || sw.style.background;
          // Keep hex input if present via data; otherwise leave color picker.
          if (swatch) swatch.style.background = bg;
        }
      });
    }
    if (color && swatch) {
      color.addEventListener("input", function () {
        swatch.style.background = color.value;
      });
    }
  }

  function drawEchoDemo(canvas) {
    if (!canvas || !canvas.getContext) return;
    var ctx = canvas.getContext("2d");
    var w = canvas.width;
    var h = canvas.height;
    ctx.fillStyle = "#f4f7fa";
    ctx.fillRect(0, 0, w, h);
    ctx.strokeStyle = "#c0c8d0";
    ctx.beginPath();
    for (var gx = 0; gx < w; gx += 40) {
      ctx.moveTo(gx, 0);
      ctx.lineTo(gx, h);
    }
    for (var gy = 0; gy < h; gy += 40) {
      ctx.moveTo(0, gy);
      ctx.lineTo(w, gy);
    }
    ctx.stroke();
    ctx.strokeStyle = "#1a6bb5";
    ctx.lineWidth = 2;
    ctx.beginPath();
    for (var x = 0; x < w; x++) {
      var t = x / w;
      var y =
        h * 0.55 -
        Math.sin(t * Math.PI * 6) * 40 * Math.exp(-Math.pow((t - 0.35) * 4, 2)) -
        Math.sin(t * Math.PI * 14) * 12;
      if (x === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    }
    ctx.stroke();
    ctx.strokeStyle = "#c0392b";
    ctx.setLineDash([4, 4]);
    ctx.beginPath();
    ctx.moveTo(w * 0.42, 0);
    ctx.lineTo(w * 0.42, h);
    ctx.stroke();
    ctx.setLineDash([]);
  }

  function applyClientSettings() {
    clientSettings.rows = ($("mvCfgRows") && $("mvCfgRows").value) || clientSettings.rows;
    clientSettings.cols = ($("mvCfgCols") && $("mvCfgCols").value) || clientSettings.cols;
    clientSettings.minW = ($("mvCfgMinW") && $("mvCfgMinW").value) || clientSettings.minW;
    clientSettings.maxW = ($("mvCfgMaxW") && $("mvCfgMaxW").value) || clientSettings.maxW;
    clientSettings.minH = ($("mvCfgMinH") && $("mvCfgMinH").value) || clientSettings.minH;
    clientSettings.maxH = ($("mvCfgMaxH") && $("mvCfgMaxH").value) || clientSettings.maxH;
    clientSettings.nameMinW = ($("mvCfgNameMinW") && $("mvCfgNameMinW").value) || clientSettings.nameMinW;
    clientSettings.nameMaxH = ($("mvCfgNameMaxH") && $("mvCfgNameMaxH").value) || clientSettings.nameMaxH;
    clientSettings.reduced = !!($("mvCfgReduced") && $("mvCfgReduced").checked);
    clientSettings.enlargeText = !!($("mvCfgEnlargeText") && $("mvCfgEnlargeText").checked);
    clientSettings.enlargeSites = !!($("mvCfgEnlargeSites") && $("mvCfgEnlargeSites").checked);
    clientSettings.vesselsBySite = !!($("mvCfgVesselsBySite") && $("mvCfgVesselsBySite").checked);
    clientSettings.autoSave = !!($("mvCfgAutoSave") && $("mvCfgAutoSave").checked);
    clientSettings.saveWarn = !!($("mvCfgSaveWarn") && $("mvCfgSaveWarn").checked);
    clientSettings.logo = ($("mvCfgLogo") && $("mvCfgLogo").value) || "";
    clientSettings.lowRes = !!($("mvCfgLowRes") && $("mvCfgLowRes").checked);
    clientSettings.lockScreen = !!($("mvCfgLock") && $("mvCfgLock").checked);
    clientSettings.showVesselOnly = !!($("mvCfgVesselOnly") && $("mvCfgVesselOnly").checked);
    clientSettings.autoAspect = !!($("mvCfgAutoAspect") && $("mvCfgAutoAspect").checked);
    clientSettings.secondaryScreen = !!($("mvCfgSecondary") && $("mvCfgSecondary").checked);
    status("Client settings applied.");
  }

  function wireProjectWizard(root) {
    if (!root || root.id !== "mv-dlg-project-wizard" || root.__mvProjWizWired) return;
    root.__mvProjWizWired = true;

    var shell = root.querySelector(".mv-proj-wiz");
    var titleEl = root.querySelector("#mvProjWizStepTitle");
    var backBtn = root.querySelector("#mvProjWizBack");
    var nextBtn = root.querySelector("#mvProjWizNext");
    var nameInput = root.querySelector("#mvProjName");
    var sitesInput = root.querySelector("#mvProjNumSites");
    var siteNameInput = root.querySelector("#mvProjSiteName");
    var vesselsInput = root.querySelector("#mvProjNumVessels");
    var devicesInput = root.querySelector("#mvProjNumDevices");
    var serialSel = root.querySelector("#mvProjSerialPort");
    var configBox = root.querySelector("#mvProjConfigBox");
    var addConfigBox = root.querySelector("#mvProjAddConfigBox");
    var step = 1;

    function selectedConType() {
      var checked = root.querySelector('input[name="mvProjConType"]:checked');
      return checked ? checked.value : "rs485";
    }

    function syncConnectionUi() {
      var type = selectedConType();
      var isSerial = type === "rs485" || type === "hart";
      var isTcp = type === "tcp";
      if (configBox) configBox.classList.toggle("is-hidden", !isSerial);
      if (addConfigBox) addConfigBox.classList.toggle("is-hidden", !isTcp);
      if (serialSel) serialSel.disabled = !isSerial;
    }

    function goStep(n) {
      step = n === 2 ? 2 : 1;
      if (shell) shell.setAttribute("data-proj-step", String(step));
      root.querySelectorAll(".mv-proj-wiz-pane").forEach(function (pane) {
        var sn = Number(pane.getAttribute("data-proj-pane"));
        pane.hidden = sn !== step;
      });
      if (titleEl) {
        titleEl.textContent =
          step === 1 ? "Project General" : "Site # 1 / 1";
      }
      // WizardWindowProject.CanBack is always false.
      if (backBtn) backBtn.disabled = true;
      if (nextBtn) nextBtn.textContent = step === 1 ? "Next >" : "Finish";
      if (step === 1 && nameInput) {
        nameInput.disabled = false;
        setTimeout(function () {
          nameInput.focus();
          nameInput.select();
        }, 30);
      }
      if (step === 2) {
        syncConnectionUi();
      }
    }

    function finishProject() {
      var projectName = (nameInput && nameInput.value.trim()) || "New_Project";
      var siteName = (siteNameInput && siteNameInput.value.trim()) || "Site1";
      var numVessels = vesselsInput ? parseInt(vesselsInput.value, 10) : 1;
      var numDevices = devicesInput ? parseInt(devicesInput.value, 10) : 1;
      if (isNaN(numVessels) || numVessels < 1) numVessels = 1;
      if (isNaN(numDevices) || numDevices < 1) numDevices = 1;
      var connType = selectedConType();
      var serialPort =
        serialSel && serialSel.value ? serialSel.value : "COM3";
      if (typeof global.mvCreateProjectFromGuide === "function") {
        global.mvCreateProjectFromGuide(projectName, {
          siteName: siteName,
          numVessels: numVessels,
          numDevices: numDevices,
          connType: connType,
          serialPort: serialPort,
        });
      }
      status("Project created.");
      closeDialog("mv-dlg-project-wizard");
    }

    function onNext() {
      if (step === 1) {
        var projectName = nameInput ? nameInput.value.trim() : "";
        if (!projectName) {
          showMessage("Project name is required.", "Wizard");
          return;
        }
        if (nameInput) nameInput.disabled = true;
        if (sitesInput) sitesInput.disabled = true;
        var numSites = sitesInput ? parseInt(sitesInput.value, 10) : 1;
        if (isNaN(numSites) || numSites < 1) numSites = 1;
        if (sitesInput) sitesInput.value = String(numSites);
        if (siteNameInput && !siteNameInput.value.trim()) {
          siteNameInput.value = "Site1";
        }
        if (vesselsInput) vesselsInput.value = "1";
        if (devicesInput) devicesInput.value = "1";
        var rs485 = root.querySelector('input[name="mvProjConType"][value="rs485"]');
        if (rs485) rs485.checked = true;
        if (serialSel) {
          serialSel.value = "COM3";
          if (serialSel.selectedIndex < 0) serialSel.selectedIndex = 0;
        }
        goStep(2);
        window.dispatchEvent(new CustomEvent("install-guide:project-general-next"));
        return;
      }
      finishProject();
    }

    if (nextBtn) nextBtn.addEventListener("click", onNext);
    root.querySelectorAll('input[name="mvProjConType"]').forEach(function (radio) {
      radio.addEventListener("change", syncConnectionUi);
    });

    root.__mvProjWizReset = function () {
      if (nameInput) {
        nameInput.disabled = false;
        nameInput.value = "New_Project";
      }
      if (sitesInput) {
        sitesInput.disabled = false;
        sitesInput.value = "1";
      }
      if (siteNameInput) siteNameInput.value = "Site1";
      if (vesselsInput) vesselsInput.value = "1";
      if (devicesInput) devicesInput.value = "1";
      if (serialSel) {
        serialSel.value = "COM3";
        if (serialSel.selectedIndex < 0) serialSel.selectedIndex = 0;
      }
      var rs485 = root.querySelector('input[name="mvProjConType"][value="rs485"]');
      if (rs485) rs485.checked = true;
      goStep(1);
    };

    goStep(1);
  }

  function onDialogOk(id) {
    if (id === "mv-dlg-device-wizard" || id === "mv-dlg-project-wizard") {
      // Next/Finish handled by wizard Next buttons — never close via generic OK path.
      return;
    }
    if (id === "mv-dlg-client-options") {
      applyClientSettings();
      return;
    }
    if (id === "mv-dlg-output-settings") {
      status("Output settings saved.");
      closeDialog(id);
      return;
    }
    if (id === "mv-dlg-materials") {
      status("Material configuration saved.");
      closeDialog(id);
      return;
    }
    if (id === "mv-dlg-switch-user") {
      closeDialog(id);
      if (typeof global.mvSignOutToConnect === "function") {
        global.mvSignOutToConnect();
      }
      showMessage("Signed out. Connect again to switch user.", "Switch User");
      return;
    }
    if (id === "mv-dlg-connect-server") {
      status("Connected to server.");
      closeDialog(id);
      return;
    }
    if (id === "mv-dlg-echo-curve" || id.indexOf("mv-dlg-") === 0) {
      status("Operation completed.");
      closeDialog(id);
    }
  }

  function wireDialogChrome(root) {
    if (!root || root.__mvWired) return;
    root.__mvWired = true;
    wireSideNav(root);
    wireInnerTabs(root);
    wireAdvParamsBeams(root);
    wireMaterials(root);
    wireWizardVessel(root);
    wireProjectWizard(root);
    root.addEventListener("click", function (e) {
      var closeBtn = e.target.closest("[data-mv-dlg-close]");
      if (closeBtn) {
        closeDialog(closeBtn.getAttribute("data-mv-dlg-close"));
        return;
      }
      var okBtn = e.target.closest("[data-mv-dlg-ok]");
      if (okBtn) {
        onDialogOk(okBtn.getAttribute("data-mv-dlg-ok"));
        return;
      }
      var applyBtn = e.target.closest("[data-mv-dlg-apply]");
      if (applyBtn) {
        applyClientSettings();
        return;
      }
      var openBtn = e.target.closest("[data-mv-dlg-open]");
      if (openBtn) {
        open(openBtn.getAttribute("data-mv-dlg-open"));
        return;
      }
      if (e.target.id === "mvEchoStart") {
        drawEchoDemo($("mvEchoCanvas"));
        status("Echo Curve Analysis started.");
      }
      var scanner = e.target.closest(".mv-device-act-tree .node.scanner");
      if (scanner) {
        root.querySelectorAll(".mv-device-act-tree .node.scanner").forEach(function (n) {
          n.classList.toggle("is-selected", n === scanner);
        });
      }
    });
  }

  function open(id) {
    openDialog(id);
    if (id === "mv-dlg-echo-curve") {
      setTimeout(function () {
        drawEchoDemo($("mvEchoCanvas"));
      }, 30);
    }
  }

  function init() {
    ensureHost();
    var msgOk = $("btn-mv-msg-ok");
    var msgClose = $("btn-mv-msg-close");
    var msgYes = $("btn-mv-msg-yes");
    var msgNo = $("btn-mv-msg-no");
    if (msgOk) msgOk.addEventListener("click", hideMessage);
    if (msgClose) msgClose.addEventListener("click", hideMessage);
    if (msgYes) {
      msgYes.addEventListener("click", function () {
        var overlay = $("mvMsgOverlay");
        var fn = overlay && overlay.__mvMsgOnYes;
        hideMessage();
        if (fn) fn();
      });
    }
    if (msgNo) {
      msgNo.addEventListener("click", function () {
        var overlay = $("mvMsgOverlay");
        var fn = overlay && overlay.__mvMsgOnNo;
        hideMessage();
        if (fn) fn();
      });
    }
    var msgOverlay = $("mvMsgOverlay");
    if (msgOverlay) {
      msgOverlay.addEventListener("click", function (e) {
        if (e.target === msgOverlay) {
          var fn = msgOverlay.__mvMsgOnNo;
          hideMessage();
          if (fn) fn();
        }
      });
    }
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") {
        if ($("mvMsgOverlay") && !$("mvMsgOverlay").hidden) {
          var ov = $("mvMsgOverlay");
          var fn = ov && ov.__mvMsgOnNo;
          hideMessage();
          if (fn) fn();
          return;
        }
        if (openIds.length) {
          closeDialog(openIds[openIds.length - 1]);
        }
      }
    });
  }

  global.MvDialogs = {
    init: init,
    open: open,
    close: closeDialog,
    closeAll: closeAllDialogs,
    showMessage: showMessage,
    showQuestion: showQuestion,
    runBatchSetParamsProgress: runBatchSetParamsProgress,
    status: status,
    getDemoRunSpeed: function () {
      return demoRunSpeed;
    },
    setDemoRunSpeed: function (s) {
      demoRunSpeed = s;
    },
    isDemoRunning: function () {
      return demoRunning;
    },
    setDemoRunning: function (v) {
      demoRunning = !!v;
    },
  };
})(window);
