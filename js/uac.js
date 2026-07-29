/* UAC — adapted from eBob Tutorial ebob-sim.js */
(function () {
  "use strict";

  var backdrop = document.getElementById("backdropUac");
  var uacApp = document.getElementById("uacApp");
  var uacPub = document.getElementById("uacPub");
  var uacDetails = document.getElementById("uacDetails");
  var uacMore = document.getElementById("uacMoreDetails");
  var uacProgramLoc = document.getElementById("uacProgramLoc");

  function hideUac() {
    if (!backdrop) {
      return;
    }
    backdrop.removeAttribute("data-uac-context");
    backdrop.classList.remove("show");
    backdrop.setAttribute("aria-hidden", "true");
    if (uacDetails && uacMore) {
      uacDetails.hidden = true;
      uacMore.setAttribute("aria-expanded", "false");
      uacMore.textContent = "Show more details";
    }
  }

  function showInstallerUac() {
    if (!backdrop) {
      return;
    }
    backdrop.setAttribute("data-uac-context", "installer");
    if (uacApp) {
      uacApp.textContent = "BinMaster 3DVision_3.1.010.exe";
    }
    if (uacPub) {
      uacPub.textContent = "Verified publisher: APM Automation Solutions Ltd.";
    }
    if (uacProgramLoc) {
      uacProgramLoc.textContent = "C:\\Users\\UserProfile\\Downloads\\BinMaster 3DVision_3.1.010.exe";
    }
    backdrop.classList.add("show");
    backdrop.setAttribute("aria-hidden", "false");
    window.dispatchEvent(new CustomEvent("install-guide:uac-shown"));
  }

  function wire() {
    var yesBtn = document.getElementById("uacYes");
    var noBtn = document.getElementById("uacNo");
    var closeBtn = document.getElementById("uacClose");

    if (yesBtn) {
      yesBtn.addEventListener("click", function () {
        var ctx = backdrop ? backdrop.getAttribute("data-uac-context") : null;
        hideUac();
        if (ctx === "installer") {
          window.dispatchEvent(new CustomEvent("install-guide:installer-started"));
          if (typeof window.startInstaller === "function") {
            window.startInstaller();
          }
        } else if (typeof window.showServicesMsc === "function") {
          window.showServicesMsc();
        }
      });
    }
    if (noBtn) {
      noBtn.addEventListener("click", hideUac);
    }
    if (closeBtn) {
      closeBtn.addEventListener("click", hideUac);
    }
    if (uacMore && uacDetails) {
      uacMore.addEventListener("click", function () {
        uacDetails.hidden = !uacDetails.hidden;
        uacMore.setAttribute("aria-expanded", uacDetails.hidden ? "false" : "true");
        uacMore.textContent = uacDetails.hidden ? "Show more details" : "Hide details";
      });
    }
    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape" && backdrop && backdrop.classList.contains("show")) {
        hideUac();
      }
    });
  }

  window.showInstallerUac = showInstallerUac;
  window.hideUac = hideUac;

  wire();
})();
