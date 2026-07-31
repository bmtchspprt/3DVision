/* Simulated browser — blank New Tab + BinMaster downloads navigation */
(function () {
  "use strict";

  var shell = document.getElementById("browserShell");
  var btnClose = document.getElementById("btn-browser-close");
  var downloadBtn = document.getElementById("browserDownloadBtn");
  var downloadStatus = document.getElementById("browserDownloadStatus");
  var taskbarBtn = document.getElementById("taskbarBtnBrowser");
  var urlInput = document.getElementById("browserUrl");
  var urlWrap = document.getElementById("browserUrlWrap");
  var urlGhost = document.getElementById("browserUrlGhost");
  var blankPage = document.getElementById("browserPageBlank");
  var downloadsPage = document.getElementById("browserPageDownloads");
  var titleText = shell ? shell.querySelector(".title-bar-text") : null;
  var tabText = shell ? shell.querySelector(".browser-tab") : null;
  var downloaded = false;
  var currentView = "blank";
  var typingCoach = false;

  var DOWNLOADS_HOST = "support.binmaster.com";
  var DOWNLOADS_PATH = "/downloads";
  var TYPE_TARGET = "support.binmaster.com/downloads";

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

  function normalizeUrl(raw) {
    var s = String(raw || "").trim();
    if (!s) return "";
    s = s.replace(/^\s+|\s+$/g, "");
    if (!/^https?:\/\//i.test(s)) {
      s = "https://" + s.replace(/^\/+/, "");
    }
    try {
      var u = new URL(s);
      var host = (u.hostname || "").toLowerCase().replace(/^www\./, "");
      var path = (u.pathname || "/").replace(/\/+$/, "") || "";
      if (path === "") path = "/";
      return { href: u.href, host: host, path: path };
    } catch (err) {
      return null;
    }
  }

  function isDownloadsUrl(raw) {
    var n = normalizeUrl(raw);
    if (!n) return false;
    return n.host === DOWNLOADS_HOST && (n.path === DOWNLOADS_PATH || n.path === DOWNLOADS_PATH + "/");
  }

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
  }

  function updateUrlGhost() {
    if (!urlGhost || !urlInput || !typingCoach) return;
    var typed = urlInput.value;
    var html = "";
    var i = 0;
    var matched = true;
    for (; i < typed.length && i < TYPE_TARGET.length; i++) {
      var want = TYPE_TARGET.charAt(i);
      var got = typed.charAt(i);
      if (matched && got.toLowerCase() === want.toLowerCase()) {
        html += '<span class="g-ok">' + escapeHtml(got) + "</span>";
      } else {
        matched = false;
        html += '<span class="g-bad">' + escapeHtml(got) + "</span>";
      }
    }
    // Extra typed chars beyond target
    for (; i < typed.length; i++) {
      html += '<span class="g-bad">' + escapeHtml(typed.charAt(i)) + "</span>";
    }
    if (typed.length < TYPE_TARGET.length) {
      html += '<span class="g-next">' + escapeHtml(TYPE_TARGET.charAt(typed.length)) + "</span>";
      if (typed.length + 1 < TYPE_TARGET.length) {
        html +=
          '<span class="g-rest">' + escapeHtml(TYPE_TARGET.slice(typed.length + 1)) + "</span>";
      }
    }
    urlGhost.innerHTML = html || '<span class="g-next">' + escapeHtml(TYPE_TARGET.charAt(0)) + "</span>" +
      '<span class="g-rest">' + escapeHtml(TYPE_TARGET.slice(1)) + "</span>";
  }

  function setUrlTypingCoach(on) {
    typingCoach = !!on;
    if (!urlWrap || !urlInput) return;
    if (typingCoach) {
      urlWrap.classList.add("is-typing");
      urlInput.placeholder = "";
      urlInput.value = "";
      updateUrlGhost();
      try {
        urlInput.focus();
      } catch (err) {
        /* ignore */
      }
    } else {
      urlWrap.classList.remove("is-typing");
      urlInput.placeholder = "Search Google or type a URL";
      if (urlGhost) urlGhost.innerHTML = "";
    }
  }

  function showBlank() {
    currentView = "blank";
    if (blankPage) blankPage.hidden = false;
    if (downloadsPage) downloadsPage.hidden = true;
    if (titleText) titleText.textContent = "New Tab";
    if (tabText) tabText.textContent = "New Tab";
  }

  function showDownloads() {
    currentView = "downloads";
    setUrlTypingCoach(false);
    if (blankPage) blankPage.hidden = true;
    if (downloadsPage) downloadsPage.hidden = false;
    if (titleText) titleText.textContent = "Tools & Downloads — BinMaster Support";
    if (tabText) tabText.textContent = "Tools & Downloads";
    if (urlInput) {
      urlInput.value = "https://support.binmaster.com/downloads";
    }
    window.dispatchEvent(new CustomEvent("install-guide:downloads-page"));
  }

  function navigateFromUrlBar() {
    if (!urlInput) return;
    var raw = urlInput.value;
    if (isDownloadsUrl(raw) || raw.toLowerCase() === TYPE_TARGET) {
      urlInput.value = "https://support.binmaster.com/downloads";
      showDownloads();
      return;
    }
    showBlank();
    if (titleText) titleText.textContent = "Page not available";
    if (tabText) tabText.textContent = "Unavailable";
  }

  function resetBrowserForGuide() {
    downloaded = false;
    if (downloadBtn) {
      downloadBtn.disabled = false;
      var label = downloadBtn.querySelector(".bm-dl-item-text span");
      if (label) {
        label.textContent = "3DVision Software - Version 3.1.010";
      }
    }
    if (downloadStatus) {
      downloadStatus.hidden = true;
      downloadStatus.textContent = "";
    }
    if (urlInput) {
      urlInput.value = "";
    }
    showBlank();
  }

  function placeBrowserLeft() {
    if (!shell) return;
    shell.style.left = "20px";
    shell.style.top = "36px";
    shell.dataset.positioned = "true";
  }

  function openBrowser(opts) {
    opts = opts || {};
    if (!shell) return;
    shell.hidden = false;
    shell.classList.remove("app-shell--minimized");
    placeBrowserLeft();
    bringToFront();
    if (opts.blank) {
      resetBrowserForGuide();
      if (opts.typingCoach) {
        setUrlTypingCoach(true);
      }
      if (urlInput) {
        setTimeout(function () {
          try {
            urlInput.focus();
          } catch (err) {
            /* ignore */
          }
        }, 40);
      }
    } else if (opts.downloads) {
      showDownloads();
    }
    window.dispatchEvent(new CustomEvent("install-guide:browser-opened"));
  }

  function closeBrowser() {
    if (!shell) return;
    setUrlTypingCoach(false);
    shell.hidden = true;
    shell.classList.add("app-shell--minimized");
    shell.classList.remove("app-shell--focused");
  }

  function completeDownload() {
    if (currentView !== "downloads") return;
    if (downloaded) return;
    downloaded = true;
    if (downloadBtn) {
      downloadBtn.disabled = true;
      var label = downloadBtn.querySelector(".bm-dl-item-text span");
      if (label) {
        label.textContent = "Downloaded — BinMaster 3DVision_3.1.010.exe";
      }
    }
    if (downloadStatus) {
      downloadStatus.hidden = false;
      downloadStatus.textContent = "Saved to Downloads: BinMaster 3DVision_3.1.010.exe";
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
      taskbarBtn.addEventListener("click", function () {
        openBrowser({
          blank: currentView === "blank" && !(urlInput && isDownloadsUrl(urlInput.value)),
        });
      });
    }
    if (shell) {
      shell.addEventListener("mousedown", bringToFront);
    }
    if (urlInput) {
      urlInput.addEventListener("keydown", function (e) {
        if (e.key === "Enter") {
          e.preventDefault();
          navigateFromUrlBar();
        }
      });
      urlInput.addEventListener("input", function () {
        if (typingCoach) updateUrlGhost();
        if (isDownloadsUrl(urlInput.value) || urlInput.value.toLowerCase() === TYPE_TARGET) {
          window.dispatchEvent(
            new CustomEvent("install-guide:url-typed", {
              detail: { value: urlInput.value, ready: true },
            })
          );
        }
      });
    }
  }

  wire();
  showBlank();

  window.openBrowser = openBrowser;
  window.closeBrowser = closeBrowser;
  window.resetBrowserForGuide = resetBrowserForGuide;
  window.navigateBrowserUrl = navigateFromUrlBar;
  window.setBrowserUrlTypingCoach = setUrlTypingCoach;
  window.getBrowserUrlTypeTarget = function () {
    return TYPE_TARGET;
  };
  window.isBrowserDownloadsPage = function () {
    return currentView === "downloads";
  };
  window.isInstallerDownloaded = function () {
    return downloaded;
  };
  window.isDownloadsUrlInput = function (raw) {
    return isDownloadsUrl(raw == null && urlInput ? urlInput.value : raw);
  };
})();
