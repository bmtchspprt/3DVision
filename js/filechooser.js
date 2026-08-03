/* Downloads folder browser — adapted from eBob Tutorial sim-open-dat-shell (ebob-sim.js) */
(function () {
  "use strict";

  var INSTALLER_EXE = "BinMaster 3DVision_3.1.010.exe";
  var backdrop = document.getElementById("backdropDownloads");
  var tbody = document.getElementById("downloadsFileTbody");
  var ctxMenu = document.getElementById("downloadsCtxMenu");
  var selectedFile = null;

  var INSTALLER_ICON = "assets/images/logo_icon.ico";
  var INSTALLER_ICON_HTML =
    '<img class="ofi-file-ico-img" src="' + INSTALLER_ICON + '" width="16" height="16" alt="" decoding="async">';

  var files = [];

  function openDownloads() {
    if (!backdrop) {
      return;
    }
    backdrop.classList.add("show");
    backdrop.setAttribute("aria-hidden", "false");
    if (files.length && !selectedFile) {
      selectedFile = files[0].name;
    }
    renderList();
    window.dispatchEvent(new CustomEvent("install-guide:downloads-opened"));
  }

  function closeDownloads() {
    if (backdrop) {
      backdrop.classList.remove("show");
      backdrop.setAttribute("aria-hidden", "true");
    }
    hideCtxMenu();
  }

  var lastRowClickAt = 0;
  var lastRowClickName = "";
  var launchLockUntil = 0;

  function updateRowSelection() {
    if (!tbody) {
      return;
    }
    tbody.querySelectorAll(".sim-open-dat-row").forEach(function (row) {
      row.classList.toggle(
        "sim-open-dat-row--sel",
        row.getAttribute("data-file-name") === selectedFile
      );
    });
  }

  function launchSelectedInstaller() {
    var now = Date.now();
    if (now < launchLockUntil) {
      return;
    }
    if (selectedFile !== INSTALLER_EXE || typeof window.showInstallerUac !== "function") {
      return;
    }
    launchLockUntil = now + 700;
    window.showInstallerUac();
  }

  function onInstallerRowActivate(fileName) {
    selectedFile = fileName;
    updateRowSelection();
    launchSelectedInstaller();
  }

  function renderList() {
    if (!tbody) {
      return;
    }
    tbody.innerHTML = "";
    if (!files.length) {
      var empty = document.createElement("tr");
      empty.innerHTML =
        '<td colspan="4" style="padding:24px;text-align:center;color:#666">This folder is empty. Download the 3DVision installer first.</td>';
      tbody.appendChild(empty);
      return;
    }
    files.forEach(function (file) {
      var tr = document.createElement("tr");
      tr.className = "sim-open-dat-row";
      if (file.name === selectedFile) {
        tr.classList.add("sim-open-dat-row--sel");
      }
      tr.setAttribute("data-file-name", file.name);
      tr.innerHTML =
        "<td>" +
        '<div class="ofi-name-cell">' +
        '<span class="ofi-file-ico">' +
        INSTALLER_ICON_HTML +
        "</span>" +
        '<span class="sim-open-dat-name">' +
        file.name +
        "</span>" +
        "</div></td>" +
        "<td>" +
        file.modified +
        "</td>" +
        "<td>" +
        file.type +
        "</td>" +
        "<td>" +
        file.size +
        "</td>";
      // Avoid rebuilding the row on every click — Firefox loses dblclick when the
      // first click destroys/recreates the <tr>.
      tr.addEventListener("click", function () {
        var now = Date.now();
        var sameRow = lastRowClickName === file.name && now - lastRowClickAt < 450;
        lastRowClickAt = now;
        lastRowClickName = file.name;
        selectedFile = file.name;
        updateRowSelection();
        if (sameRow) {
          launchSelectedInstaller();
        }
      });
      tr.addEventListener("dblclick", function (event) {
        event.preventDefault();
        onInstallerRowActivate(file.name);
      });
      tr.addEventListener("contextmenu", function (event) {
        event.preventDefault();
        selectedFile = file.name;
        updateRowSelection();
        showCtxMenu(event.clientX, event.clientY, file.name === INSTALLER_EXE);
      });
      tbody.appendChild(tr);
    });
  }

  function showCtxMenu(x, y, enabled) {
    if (!ctxMenu) {
      return;
    }
    ctxMenu.hidden = false;
    ctxMenu.querySelector('[data-action="open"]').disabled = !enabled;
    ctxMenu.querySelector('[data-action="admin"]').disabled = !enabled;
    ctxMenu.style.left = Math.min(x, window.innerWidth - 200) + "px";
    ctxMenu.style.top = Math.min(y, window.innerHeight - 180) + "px";
  }

  function hideCtxMenu() {
    if (ctxMenu) {
      ctxMenu.hidden = true;
    }
  }

  function addInstallerDownload() {
    if (files.some(function (f) {
      return f.name === INSTALLER_EXE;
    })) {
      return;
    }
    files.push({
      name: INSTALLER_EXE,
      modified: new Date().toLocaleString(undefined, {
        month: "numeric",
        day: "numeric",
        year: "numeric",
        hour: "numeric",
        minute: "2-digit",
      }),
      type: "Application",
      size: "98.2 MB",
    });
    selectedFile = INSTALLER_EXE;
    renderList();
  }

  function wire() {
    var closeBtn = document.getElementById("downloadsCapClose");

    if (closeBtn) {
      closeBtn.addEventListener("click", closeDownloads);
    }
    if (ctxMenu) {
      ctxMenu.addEventListener("click", function (event) {
        var btn = event.target.closest("button[data-action]");
        if (!btn || btn.disabled) {
          return;
        }
        hideCtxMenu();
        if (typeof window.showInstallerUac === "function") {
          window.showInstallerUac();
        }
      });
    }
    document.addEventListener("click", function (event) {
      if (!ctxMenu || ctxMenu.hidden) {
        return;
      }
      if (!ctxMenu.contains(event.target)) {
        hideCtxMenu();
      }
    });
    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape" && backdrop && backdrop.classList.contains("show")) {
        closeDownloads();
      }
    });
  }

  wire();
  window.openFileExplorer = openDownloads;
  window.closeFileExplorer = closeDownloads;
  window.addInstallerDownload = addInstallerDownload;
})();
