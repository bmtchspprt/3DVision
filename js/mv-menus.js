/**
 * MultiVision STech menubar — File / Communication / Edit / Device / Tools(+Demo) / Help
 * Labels from APMRes.MenusRes.Menus.resx; structure from MainScreen.Create*Menu (multi-project).
 */
(function (global) {
  "use strict";

  var menubar = null;
  var openPopups = [];

  /** @typedef {{ id?: string, label?: string, accel?: string, disabled?: boolean, checked?: boolean, sep?: boolean, children?: object[], action?: string }} MenuNode */

  /** @type {MenuNode[]} */
  var MENU_TREE = [
    {
      id: "file",
      label: "File",
      children: [
        { id: "file-new", label: "New Project...", action: "file-new" },
        { id: "file-open", label: "Open Project...", action: "file-open" },
        { sep: true },
        { id: "file-save", label: "Save Project", accel: "Ctrl+S", action: "file-save" },
        { id: "file-saveas", label: "Save Project As...", action: "file-saveas" },
        { sep: true },
        { id: "file-export", label: "Export Project from Server...", action: "file-export" },
        { id: "file-import", label: "Import Project to Server...", action: "file-import" },
        { id: "file-delete", label: "Delete Project", action: "file-delete" },
        { sep: true },
        { id: "file-browse", label: "Browse to Local Folder...", accel: "Ctrl+B", action: "file-browse" },
        { id: "file-browse-server", label: "Browse to Server Local Folder...", action: "file-browse-server" },
        { sep: true },
        { id: "file-exit", label: "Exit", action: "file-exit" },
      ],
    },
    {
      id: "comm",
      label: "Communication",
      children: [
        { id: "comm-connect-all", label: "Connect All", action: "comm-connect-all" },
        { id: "comm-disconnect-all", label: "Disconnect All", action: "comm-disconnect-all" },
        { id: "comm-load-vessels", label: "Load from Vessels", action: "comm-load-vessels" },
        { sep: true },
        { id: "comm-connect", label: "Connect Vessel", action: "comm-connect" },
        { id: "comm-disconnect", label: "Disconnect Vessel", action: "comm-disconnect" },
        { id: "comm-load", label: "Load from Vessel", action: "comm-load" },
      ],
    },
    {
      id: "edit",
      label: "Edit",
      children: [
        {
          id: "edit-add",
          label: "Add",
          children: [
            { id: "edit-add-site", label: "Site", action: "edit-add-site" },
            { id: "edit-add-vessel", label: "Vessel", action: "edit-add-vessel" },
            { id: "edit-add-scanner", label: "Scanner", action: "edit-add-scanner" },
          ],
        },
        {
          id: "edit-delete",
          label: "Delete",
          children: [
            { id: "edit-del-site", label: "Site", action: "edit-del-site" },
            { id: "edit-del-vessel", label: "Vessel", action: "edit-del-vessel" },
            { id: "edit-del-scanner", label: "Scanner", action: "edit-del-scanner" },
          ],
        },
        {
          id: "edit-props",
          label: "Properties",
          children: [
            { id: "edit-prop-site", label: "Site", action: "edit-prop-site" },
            { id: "edit-prop-vessel", label: "Vessel", action: "edit-prop-vessel" },
            { id: "edit-prop-figures", label: "Vessel graphic figures", action: "edit-prop-figures" },
          ],
        },
        { id: "edit-project", label: "Edit Project...", action: "edit-project" },
        { sep: true },
        { id: "edit-cfg-save", label: "Save Selected Vessel Configuration As...", action: "edit-cfg-save" },
        { id: "edit-cfg-online", label: "Load Vessel Configuration Online...", action: "edit-cfg-online" },
        {
          id: "edit-cfg-offline",
          label: "Offline Configuration",
          children: [
            { id: "edit-cfg-load-off", label: "Manual Load to Selected Vessel...", action: "edit-cfg-load-off" },
            { id: "edit-cfg-unload-off", label: "Cancel Manual Load from All Vessels", action: "edit-cfg-unload-off" },
            { id: "edit-cfg-browse-off", label: "Browse to Vessel AutoSaved File Folder...", action: "edit-cfg-browse-off" },
          ],
        },
      ],
    },
    {
      id: "device",
      label: "Device",
      children: [
        { id: "dev-wizard", label: "Device Configuration Wizard...", accel: "F4", action: "dev-wizard" },
        { id: "dev-advanced", label: "Advanced Parameters...", accel: "F3", action: "dev-advanced" },
        { sep: true },
        { id: "dev-curr-sim", label: "Device Current Simulation Settings...", accel: "F6", action: "dev-curr-sim" },
        { id: "dev-out-curr", label: "Device Output Current...", accel: "F8", action: "dev-out-curr" },
        { id: "dev-out-set", label: "Device Output Settings...", accel: "F7", action: "dev-out-set" },
        { sep: true },
        { id: "dev-echo", label: "Echo Curve Analysis...", accel: "Ctrl+Z", action: "dev-echo" },
        { id: "dev-echo-viewer", label: "Echo Curve Analyze Viewer...", accel: "Ctrl+V", action: "dev-echo-viewer" },
        { sep: true },
        { id: "dev-false-echo", label: "Device False Echo Mapping...", action: "dev-false-echo" },
        { sep: true },
        { id: "dev-act", label: "Devices Activations...", action: "dev-act" },
        { sep: true },
        { id: "dev-model", label: "Update Model...", disabled: true, action: "dev-model" },
      ],
    },
    {
      id: "tools",
      label: "Tools",
      children: [
        {
          id: "tools-reports",
          label: "Reports",
          children: [
            { id: "rep-wizard", label: "Reports Definition Wizard...", accel: "F9", action: "rep-wizard" },
            { id: "rep-export", label: "Export Present Project Reports from Server", action: "rep-export" },
            { id: "rep-browse", label: "Browse to selected project report folder", action: "rep-browse" },
            { sep: true },
            {
              id: "rep-vessel",
              label: "Generate report for selected vessel (logs data)",
              children: [
                { id: "rep-vessel-local", label: "Select logs directory from local folder...", action: "rep-vessel-local" },
                { id: "rep-vessel-dl", label: "Download from server...", action: "rep-vessel-dl" },
              ],
            },
            { sep: true },
            { id: "rep-inv", label: "Hardware Inventory Table...", action: "rep-inv" },
            { id: "rep-meas", label: "Measurement Summary Table...", action: "rep-meas" },
            { sep: true },
            { id: "rep-write", label: "Write selected vessel to file...", action: "rep-write" },
            { sep: true },
            { id: "rep-events", label: "Events Log Viewer...", action: "rep-events" },
          ],
        },
        { sep: true },
        { id: "tools-materials", label: "Material Configuration...", action: "tools-materials" },
        { sep: true },
        { id: "tools-server", label: "Server Options...", action: "tools-server" },
        { sep: true },
        { id: "tools-connect", label: "Connect to Server...", action: "tools-connect" },
        { sep: true },
        { id: "tools-signout", label: "Sign Out", action: "tools-signout" },
        { id: "tools-switch", label: "Switch User..", action: "tools-switch" },
        { id: "tools-users", label: "Users Management....", disabled: true, action: "tools-users" },
        { sep: true },
        { id: "tools-client", label: "Client Options...", action: "tools-client" },
        { sep: true },
        { id: "tools-refresh", label: "Refresh Display", accel: "F5", action: "tools-refresh" },
        { sep: true },
        {
          id: "tools-demo",
          label: "Demo",
          children: [
            { id: "demo-start", label: "Start Demo Running", action: "demo-start" },
            { id: "demo-restart", label: "Restart Demo Run", action: "demo-restart" },
            { sep: true },
            { id: "demo-fast", label: "Fast Run", checked: true, action: "demo-fast" },
            { id: "demo-normal", label: "Normal Run", action: "demo-normal" },
            { id: "demo-slow", label: "Slow Run", action: "demo-slow" },
            { sep: true },
            { id: "demo-reset", label: "Reset Demo Data (Server)", action: "demo-reset" },
          ],
        },
      ],
    },
    {
      id: "help",
      label: "Help",
      children: [
        { id: "help-quick", label: "Quick Start Manual", action: "help-quick" },
        { id: "help-manual", label: "Operational Manual", action: "help-manual" },
        { sep: true },
        { id: "help-about", label: "About", action: "help-about" },
      ],
    },
  ];

  var menuBarActive = false;

  function closeAllMenus() {
    if (!menubar) return;
    menubar.querySelectorAll(".mv-menu-popup").forEach(function (p) {
      p.hidden = true;
    });
    menubar.querySelectorAll(".mv-menu-trigger").forEach(function (t) {
      t.setAttribute("aria-expanded", "false");
    });
    menubar.querySelectorAll(".mv-menu-item.is-open").forEach(function (i) {
      i.classList.remove("is-open");
    });
    openPopups = [];
    menuBarActive = false;
  }

  function openTopMenu(trigger) {
    if (!trigger || !menubar) return;
    var dropdown = trigger.closest(".mv-menu-dropdown");
    if (!dropdown || !menubar.contains(dropdown)) return;
    var popup = null;
    for (var i = 0; i < dropdown.children.length; i++) {
      if (dropdown.children[i].classList.contains("mv-menu-popup")) {
        popup = dropdown.children[i];
        break;
      }
    }
    if (!popup) return;
    // Close other top menus / nested popups without clearing menuBarActive.
    menubar.querySelectorAll(".mv-menu-popup").forEach(function (p) {
      p.hidden = true;
    });
    menubar.querySelectorAll(".mv-menu-trigger").forEach(function (t) {
      t.setAttribute("aria-expanded", "false");
    });
    menubar.querySelectorAll(".mv-menu-item.is-open").forEach(function (it) {
      it.classList.remove("is-open");
    });
    popup.hidden = false;
    trigger.setAttribute("aria-expanded", "true");
    menuBarActive = true;
    updateCommHeaders();
    if (trigger.id === "mv-menu-edit") {
      updateEditingMenuEnabling();
    }
  }

  /** MainScreen.OnMenuEditOpened / EditingMenuEnabling */
  function updateEditingMenuEnabling() {
    if (!menubar) return;
    var state =
      typeof global.mvGetEditingMenuState === "function"
        ? global.mvGetEditingMenuState()
        : null;
    if (!state) return;
    var map = {
      "edit-add-site": state.addSite,
      "edit-add-vessel": state.addVessel,
      "edit-add-scanner": state.addScanner,
      "edit-del-site": state.deleteSite,
      "edit-del-vessel": state.deleteVessel,
      "edit-del-scanner": state.deleteScanner,
    };
    Object.keys(map).forEach(function (id) {
      var btn = menubar.querySelector('[data-mv-menu-id="' + id + '"]');
      if (btn) btn.disabled = !map[id];
    });
  }

  function isTopMenuOpen() {
    return menuBarActive;
  }

  function renderItem(node) {
    if (node.sep) {
      return '<div class="mv-menu-sep" role="separator"></div>';
    }
    var hasSub = node.children && node.children.length;
    var cls = "mv-menu-item" + (hasSub ? " mv-menu-has-sub" : "");
    var disabled = node.disabled ? " disabled" : "";
    var check =
      '<span class="mv-menu-check" aria-hidden="true">' +
      (node.checked ? "✓" : "") +
      "</span>";
    var accel = node.accel ? '<span class="mv-menu-accel">' + node.accel + "</span>" : "";
    var arrow = hasSub ? '<span class="mv-menu-arrow">▶</span>' : "";
    var html =
      '<button type="button" class="' +
      cls +
      '" role="menuitem" data-mv-menu-id="' +
      (node.id || "") +
      '"' +
      (node.action ? ' data-mv-menu-action="' + node.action + '"' : "") +
      (hasSub ? ' aria-haspopup="true"' : "") +
      disabled +
      ">" +
      check +
      '<span class="mv-menu-label">' +
      node.label +
      "</span>" +
      accel +
      arrow +
      "</button>";
    if (hasSub) {
      html =
        '<div class="mv-menu-dropdown mv-menu-has-sub" data-mv-sub="' +
        (node.id || "") +
        '">' +
        html +
        '<div class="mv-menu-popup mv-menu-submenu" role="menu" hidden>' +
        node.children.map(renderItem).join("") +
        "</div></div>";
    }
    return html;
  }

  function buildMenubar() {
    menubar = document.getElementById("mvMenubar");
    if (!menubar) return;
    menubar.innerHTML = MENU_TREE.map(function (top) {
      return (
        '<div class="mv-menu-dropdown" data-mv-top="' +
        top.id +
        '">' +
        '<button type="button" class="mv-menu-trigger" id="mv-menu-' +
        top.id +
        '" aria-haspopup="menu" aria-expanded="false">' +
        top.label +
        "</button>" +
        '<div class="mv-menu-popup" id="mv-popup-' +
        top.id +
        '" role="menu" hidden>' +
        top.children.map(renderItem).join("") +
        "</div></div>"
      );
    }).join("");
  }

  function updateDemoChecks(speed) {
    if (!menubar) return;
    ["demo-fast", "demo-normal", "demo-slow"].forEach(function (id) {
      var btn = menubar.querySelector('[data-mv-menu-id="' + id + '"]');
      if (!btn) return;
      var want =
        (id === "demo-fast" && speed === "Fast") ||
        (id === "demo-normal" && speed === "Normal") ||
        (id === "demo-slow" && speed === "Slow");
      var check = btn.querySelector(".mv-menu-check");
      if (!check) {
        btn.insertAdjacentHTML(
          "afterbegin",
          '<span class="mv-menu-check" aria-hidden="true"></span>'
        );
        check = btn.querySelector(".mv-menu-check");
      }
      if (check) {
        check.textContent = want ? "✓" : "";
      }
    });
  }

  function updateCommHeaders() {
    if (!menubar) return;
    var scanner = typeof global.mvIsScannerContext === "function" && global.mvIsScannerContext();
    var map = scanner
      ? {
          "comm-connect": "Connect Scanner",
          "comm-disconnect": "Disconnect Scanner",
          "comm-load": "Load from Scanner",
        }
      : {
          "comm-connect": "Connect Vessel",
          "comm-disconnect": "Disconnect Vessel",
          "comm-load": "Load from Vessel",
        };
    Object.keys(map).forEach(function (id) {
      var item = menubar.querySelector('[data-mv-menu-id="' + id + '"]');
      if (!item) return;
      var label = item.querySelector(".mv-menu-label");
      if (label) {
        label.textContent = map[id];
      }
    });
  }

  function D() {
    return global.MvDialogs;
  }

  function runAction(action) {
    closeAllMenus();
    if (!action) return;
    var dlg = D();

    switch (action) {
      case "file-new":
        dlg.open("mv-dlg-project-wizard");
        window.dispatchEvent(new CustomEvent("install-guide:new-project-opened"));
        break;
      case "file-open":
        dlg.open("mv-dlg-project-open");
        break;
      case "file-save":
        dlg.status("Project saved.");
        break;
      case "file-saveas":
        dlg.open("mv-dlg-project-saveas");
        break;
      case "file-export":
        dlg.showMessage("Export Project from Server — demo: project package prepared.", "Export Project");
        break;
      case "file-import":
        dlg.showMessage("Import Project to Server — demo: select a project package to import.", "Import Project");
        break;
      case "file-delete":
        dlg.showMessage("Delete Project requires confirmation on the server. Demo: not deleted.", "Delete Project");
        break;
      case "file-browse":
        if (typeof global.openBrowseFolderDialog === "function") {
          global.openBrowseFolderDialog();
        } else if (typeof global.showBrowseFolder === "function") {
          global.showBrowseFolder();
        } else {
          dlg.showMessage("Browse to Local Folder...", "File");
        }
        break;
      case "file-browse-server":
        dlg.showMessage("Browse to Server Local Folder...\nC:\\ProgramData\\BinMaster\\3DVision", "File");
        break;
      case "file-exit":
        if (typeof global.mvRequestClose === "function") {
          global.mvRequestClose();
        } else if (typeof global.closeMultiVision === "function") {
          global.closeMultiVision();
        }
        break;

      case "comm-connect-all":
        if (typeof global.mvConnectAll === "function") global.mvConnectAll();
        else dlg.status("Connect All completed.");
        break;
      case "comm-disconnect-all":
        if (typeof global.mvDisconnectAll === "function") global.mvDisconnectAll();
        else dlg.status("Disconnect All completed.");
        break;
      case "comm-load-vessels":
        dlg.status("Load from Vessels completed.");
        break;
      case "comm-connect":
        if (typeof global.mvConnectSelected === "function") global.mvConnectSelected();
        else dlg.status("Vessel connected.");
        break;
      case "comm-disconnect":
        if (typeof global.mvDisconnectSelected === "function") global.mvDisconnectSelected();
        else dlg.status("Vessel disconnected.");
        break;
      case "comm-load":
        dlg.status("Load from Vessel completed.");
        break;

      case "edit-add-site":
        dlg.open("mv-dlg-project-wizard", { mode: "site" });
        break;
      case "edit-add-vessel":
        dlg.open("mv-dlg-project-wizard", { mode: "vessel" });
        break;
      case "edit-add-scanner":
        if (typeof global.mvAddScanner === "function") {
          global.mvAddScanner();
        } else {
          dlg.status("Scanner added.");
        }
        break;
      case "edit-del-site":
      case "edit-del-vessel":
      case "edit-del-scanner":
        dlg.showMessage("Delete " + action.replace("edit-del-", "") + " — confirm required. Demo: not deleted.", "Edit");
        break;
      case "edit-prop-site":
        dlg.showMessage("Site Properties — Aggregat", "Properties");
        break;
      case "edit-prop-vessel":
        if (typeof global.mvOpenSelectedProperties === "function") global.mvOpenSelectedProperties();
        else dlg.showMessage("Select a vessel to edit properties.", "Properties");
        break;
      case "edit-prop-figures":
        dlg.open("mv-dlg-graphic-figures");
        break;
      case "edit-project":
        dlg.open("mv-dlg-edit-project");
        break;
      case "edit-cfg-save":
        dlg.showMessage("Save Selected Vessel Configuration As...", "Edit");
        break;
      case "edit-cfg-online":
        dlg.status("Load Vessel Configuration Online completed.");
        break;
      case "edit-cfg-load-off":
        dlg.showMessage("Manual Load to Selected Vessel...", "Offline Configuration");
        break;
      case "edit-cfg-unload-off":
        dlg.status("Cancel Manual Load from All Vessels completed.");
        break;
      case "edit-cfg-browse-off":
        dlg.showMessage("Browse to Vessel AutoSaved File Folder...", "Offline Configuration");
        break;

      case "dev-wizard":
        dlg.open("mv-dlg-device-wizard");
        break;
      case "dev-advanced":
        dlg.open("mv-dlg-advanced-params");
        break;
      case "dev-curr-sim":
        dlg.open("mv-dlg-current-sim");
        break;
      case "dev-out-curr":
        dlg.open("mv-dlg-output-current");
        break;
      case "dev-out-set":
        dlg.open("mv-dlg-output-settings");
        break;
      case "dev-echo":
        if (typeof dlg.openEchoCurveAnalysis === "function") {
          dlg.openEchoCurveAnalysis();
        } else {
          dlg.open("mv-dlg-echo-curve");
        }
        break;
      case "dev-echo-viewer":
        dlg.open("mv-dlg-echo-viewer");
        break;
      case "dev-false-echo":
        dlg.open("mv-dlg-false-echo");
        break;
      case "dev-act":
        dlg.open("mv-dlg-devices-act");
        break;
      case "dev-model":
        break;

      case "rep-wizard":
        dlg.open("mv-dlg-report-wizard");
        break;
      case "rep-export":
        dlg.status("Export Present Project Reports from Server completed.");
        break;
      case "rep-browse":
        dlg.showMessage("Browse to selected project report folder", "Reports");
        break;
      case "rep-vessel-local":
      case "rep-vessel-dl":
        dlg.status("Generate report for selected vessel — demo complete.");
        break;
      case "rep-inv":
        dlg.open("mv-dlg-inventory-table");
        break;
      case "rep-meas":
        dlg.open("mv-dlg-meas-table");
        break;
      case "rep-write":
        dlg.showMessage("Write selected vessel to file...", "Reports");
        break;
      case "rep-events":
        dlg.open("mv-dlg-events-log");
        break;

      case "tools-materials":
        dlg.open("mv-dlg-materials");
        break;
      case "tools-server":
        dlg.open("mv-dlg-server-options");
        break;
      case "tools-connect":
        dlg.open("mv-dlg-connect-server");
        break;
      case "tools-signout":
        if (typeof global.mvSignOutToConnect === "function") global.mvSignOutToConnect();
        break;
      case "tools-switch":
        dlg.open("mv-dlg-switch-user");
        break;
      case "tools-users":
        break;
      case "tools-client":
        dlg.open("mv-dlg-client-options");
        break;
      case "tools-refresh":
        if (typeof global.mvRefreshDisplay === "function") global.mvRefreshDisplay();
        else dlg.status("Display refreshed.");
        break;

      case "demo-start":
        dlg.setDemoRunning(true);
        dlg.status("Demo run started.");
        break;
      case "demo-restart":
        dlg.setDemoRunning(true);
        dlg.status("Demo run restarted.");
        break;
      case "demo-fast":
        dlg.setDemoRunSpeed("Fast");
        updateDemoChecks("Fast");
        dlg.status("Demo speed: Fast Run");
        break;
      case "demo-normal":
        dlg.setDemoRunSpeed("Normal");
        updateDemoChecks("Normal");
        dlg.status("Demo speed: Normal Run");
        break;
      case "demo-slow":
        dlg.setDemoRunSpeed("Slow");
        updateDemoChecks("Slow");
        dlg.status("Demo speed: Slow Run");
        break;
      case "demo-reset":
        dlg.showMessage(
          "Demo data will be changed to the installation data. This operation will take number of minutes. Are you sure?",
          "Reset Demo Data (Server)"
        );
        break;

      case "help-quick":
        global.open("http://www.binmaster.com/", "_blank", "noopener,noreferrer");
        break;
      case "help-manual":
        global.open("http://www.binmaster.com/", "_blank", "noopener,noreferrer");
        break;
      case "help-about":
        if (typeof global.openAboutDialog === "function") {
          global.openAboutDialog();
        } else {
          var about = document.getElementById("about-overlay");
          if (about) about.hidden = false;
        }
        break;

      case "tools-vdc":
        dlg.open("mv-dlg-vdc");
        break;

      default:
        dlg.status(action);
    }
  }

  function wireMenubar() {
    if (!menubar) return;

    menubar.addEventListener("click", function (e) {
      var trigger = e.target.closest(".mv-menu-trigger");
      if (trigger && menubar.contains(trigger)) {
        e.stopPropagation();
        var alreadyOpen = trigger.getAttribute("aria-expanded") === "true";
        if (alreadyOpen) {
          closeAllMenus();
        } else {
          openTopMenu(trigger);
        }
        return;
      }

      var subBtn = e.target.closest(".mv-menu-item.mv-menu-has-sub");
      if (subBtn) {
        e.stopPropagation();
        var parent = subBtn.parentElement;
        var subPopup = parent && parent.classList.contains("mv-menu-has-sub")
          ? parent.querySelector(".mv-menu-popup")
          : null;
        if (subPopup) {
          var wasHidden = subPopup.hidden;
          var menuRoot = subBtn.closest(".mv-menu-popup");
          if (menuRoot) {
            menuRoot.querySelectorAll(".mv-menu-has-sub > .mv-menu-popup").forEach(function (p) {
              if (p !== subPopup) p.hidden = true;
            });
            menuRoot.querySelectorAll(".mv-menu-item.is-open").forEach(function (it) {
              if (it !== subBtn) it.classList.remove("is-open");
            });
          }
          subPopup.hidden = !wasHidden;
          subBtn.classList.toggle("is-open", !subPopup.hidden);
          if (!subPopup.hidden && (subBtn.getAttribute("data-mv-menu-id") === "edit-add" || subBtn.getAttribute("data-mv-menu-id") === "edit-delete")) {
            updateEditingMenuEnabling();
          }
        }
        return;
      }

      var item = e.target.closest("[data-mv-menu-action]");
      if (item && !item.disabled) {
        e.stopPropagation();
        runAction(item.getAttribute("data-mv-menu-action"));
      }
    });

    // Win32 menubar: once a top menu is open, hovering another top item switches to it.
    menubar.addEventListener("mouseover", function (e) {
      var trigger = e.target.closest(".mv-menu-trigger");
      if (trigger && menubar.contains(trigger) && isTopMenuOpen()) {
        if (trigger.getAttribute("aria-expanded") !== "true") {
          openTopMenu(trigger);
        }
        return;
      }

      // Nested flyout menus open on hover while parent popup is visible.
      var item = e.target.closest(".mv-menu-item.mv-menu-has-sub");
      if (!item) return;
      var parent = item.parentElement;
      if (!parent || !parent.classList.contains("mv-menu-has-sub")) return;
      var popup = parent.querySelector(".mv-menu-popup");
      if (!popup) return;
      var menuRoot = item.closest(".mv-menu-popup");
      if (menuRoot) {
        menuRoot.querySelectorAll(".mv-menu-has-sub > .mv-menu-popup").forEach(function (p) {
          if (p !== popup) p.hidden = true;
        });
        menuRoot.querySelectorAll(".mv-menu-item.is-open").forEach(function (it) {
          if (it !== item) it.classList.remove("is-open");
        });
      }
      popup.hidden = false;
      item.classList.add("is-open");
      if (
        item.getAttribute("data-mv-menu-id") === "edit-add" ||
        item.getAttribute("data-mv-menu-id") === "edit-delete"
      ) {
        updateEditingMenuEnabling();
      }
    });
  }

  function wireToolbar() {
    var bar = document.querySelector(".mv-toolbar");
    if (!bar) return;
    bar.addEventListener("click", function (e) {
      var btn = e.target.closest(".mv-toolbar-btn");
      if (!btn) return;
      var label = (btn.textContent || "").trim();
      if (label === "Connect") runAction("comm-connect");
      else if (label === "Disconnect") runAction("comm-disconnect");
      else if (label.indexOf("Load") === 0) runAction("comm-load");
      else if (label.indexOf("Echo") === 0) runAction("dev-echo");
      else if (label === "Wizard") runAction("dev-wizard");
      else if (label === "VDC") runAction("tools-vdc");
      else if (label === "Distance" || label === "Level" || (btn.id === "mvBtnLevelDistance")) {
        if (typeof global.mvToggleDistanceLevel === "function") global.mvToggleDistanceLevel();
      }
    });
  }

  function wireShortcuts() {
    document.addEventListener("keydown", function (e) {
      var shell = document.getElementById("multiVisionShell");
      if (!shell || shell.hidden) return;
      if (e.key === "F5") {
        e.preventDefault();
        runAction("tools-refresh");
      } else if (e.key === "F3") {
        e.preventDefault();
        runAction("dev-advanced");
      } else if (e.key === "F4") {
        e.preventDefault();
        runAction("dev-wizard");
      } else if (e.key === "F6") {
        e.preventDefault();
        runAction("dev-curr-sim");
      } else if (e.key === "F7") {
        e.preventDefault();
        runAction("dev-out-set");
      } else if (e.key === "F8") {
        e.preventDefault();
        runAction("dev-out-curr");
      } else if (e.key === "F9") {
        e.preventDefault();
        runAction("rep-wizard");
      } else if (e.ctrlKey && (e.key === "z" || e.key === "Z")) {
        e.preventDefault();
        runAction("dev-echo");
      } else if (e.ctrlKey && (e.key === "v" || e.key === "V")) {
        // Real app: Echo Curve Analyze Viewer (Ctrl+V). Avoid clobbering OS paste in inputs.
        var tag = (e.target && e.target.tagName) || "";
        if (tag === "INPUT" || tag === "TEXTAREA" || (e.target && e.target.isContentEditable)) {
          return;
        }
        e.preventDefault();
        runAction("dev-echo-viewer");
      } else if (e.ctrlKey && (e.key === "s" || e.key === "S")) {
        e.preventDefault();
        runAction("file-save");
      } else if (e.ctrlKey && (e.key === "b" || e.key === "B")) {
        e.preventDefault();
        runAction("file-browse");
      }
    });
  }

  function init() {
    buildMenubar();
    wireMenubar();
    wireToolbar();
    wireShortcuts();
    if (D() && D().init) D().init();

    document.addEventListener("click", function (e) {
      if (menubar && !menubar.contains(e.target)) {
        closeAllMenus();
      }
    });
  }

  // Extend vessel context menu actions to open real dialogs
  var prevHandler = global.mvHandleContextAction;
  global.mvHandleMenuAction = runAction;

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})(window);
