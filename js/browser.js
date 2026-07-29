/* Simulated browser — download BinMaster 3DVision installer */
(function () {
  "use strict";

  var shell = document.getElementById("browserShell");
  var btnClose = document.getElementById("btn-browser-close");
  var downloadBtn = document.getElementById("browserDownloadBtn");
  var downloadStatus = document.getElementById("browserDownloadStatus");
  var taskbarBtn = document.getElementById("taskbarBtnBrowser");
  var downloaded = false;

  function bringToFront() {
    if (!shell) return;
    var z = 120;
    document.querySelectorAll(".app-shell").forEach(function (node) {
      var n = parseInt(node.style.zIndex || "0", 10);
      if (n > z) z = n;
    });
    shell.style.zIndex = String(z + 1);
    document.querySelectorAll(".app-shell.app-shell--focused").forEach(function (node) {
      if (node !== shell) node.classList.remove("app-shell--focused");
    });
    shell.classList.add("app-shell--focused");
  }

  function openBrowser() {
    if (!shell) return;
    shell.hidden = false;
    shell.classList.remove("app-shell--minimized");
    if (!shell.dataset.positioned) {
      shell.style.left = "48px";
      shell.style.top = "36px";
      shell.dataset.positioned = "true";
    }
    bringToFront();
    window.dispatchEvent(new CustomEvent("install-guide:browser-opened"));
  }

  function closeBrowser() {
    if (!shell) return;
    shell.hidden = true;
    shell.classList.add("app-shell--minimized");
    shell.classList.remove("app-shell--focused");
  }

  function completeDownload() {
    if (downloaded) return;
    downloaded = true;
    if (downloadBtn) {
      downloadBtn.disabled = true;
      downloadBtn.textContent = "Downloaded";
    }
    if (downloadStatus) {
      downloadStatus.textContent =
        "Saved to Downloads: BinMaster 3DVision_3.1.010.exe";
    }
    if (typeof window.addInstallerDownload === "function") {
      window.addInstallerDownload();
    }
    window.dispatchEvent(new CustomEvent("install-guide:downloaded"));
  }

  function wire() {
    if (btnClose) {
      btnClose.addEventListener("click", closeBrowser);
    }
    if (downloadBtn) {
      downloadBtn.addEventListener("click", completeDownload);
    }
    if (taskbarBtn) {
      taskbarBtn.addEventListener("click", openBrowser);
    }
    if (shell) {
      shell.addEventListener("mousedown", bringToFront);
    }
  }

  wire();
  window.openBrowser = openBrowser;
  window.closeBrowser = closeBrowser;
  window.isInstallerDownloaded = function () {
    return downloaded;
  };
})();
