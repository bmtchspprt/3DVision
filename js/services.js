/* Services console — adapted from eBob Tutorial ebob-sim.js wireServicesMscConsole() */
(function () {
  "use strict";

  var SERVICES_MSC_SEED = [
    { id: "3dvision-server", name: "3DVisionServerService", description: "Garner Industries, Inc.", running: false, startup: "Automatic", logOn: "Local System" },
    { id: "appinf", name: "Application Information", description: "Facilitates the running of interactive applications with additional administrative privileges.", running: true, startup: "Manual (Trigger Start)", logOn: "Local Service" },
    { id: "audio", name: "Audio", description: "Manages audio for system programs.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "bfe", name: "Base Filtering Engine", description: "Manages firewall and Internet Protocol security.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "cryptsvc", name: "Cryptographic Services", description: "Provides management of certificates, cryptographic keys, and encryption.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "dhcp", name: "DHCP Client", description: "Registers and updates IP addresses and DNS records for this computer.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "dcom", name: "DCOM Server Process Launcher", description: "Launches COM and DCOM servers in response to object activation requests.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "gpsvc", name: "Group Policy Client", description: "Applies Group Policy settings for this computer and users.", running: true, startup: "Automatic", logOn: "Local System" },
    { id: "lanmanserver", name: "Server", description: "Supports file, print, and named-pipe sharing over the network.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "mpssvc", name: "Defender Firewall", description: "Helps protect your PC by blocking unauthorized access.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "plugplay", name: "Plug and Play", description: "Enables a computer to recognize and adapt to hardware changes.", running: true, startup: "Manual", logOn: "Local System" },
    { id: "power", name: "Power", description: "Manages power policy and power policy notification delivery.", running: true, startup: "Automatic", logOn: "Local System" },
    { id: "rpcss", name: "Remote Procedure Call (RPC)", description: "The RPCSS service is the Service Control Manager for COM and DCOM servers.", running: true, startup: "Automatic", logOn: "Network Service" },
    { id: "schedule", name: "Task Scheduler", description: "Enables a user to configure and schedule automated tasks on this computer.", running: true, startup: "Automatic", logOn: "Local System" },
    { id: "spooler", name: "Print Spooler", description: "Spools print jobs and handles interaction with the printer.", running: true, startup: "Automatic", logOn: "Local System" },
    { id: "w32time", name: "Time", description: "Maintains date and time synchronization on all clients and servers in the network.", running: true, startup: "Automatic", logOn: "Local Service" },
    { id: "wuauserv", name: "Update", description: "Enables the detection, download, and installation of updates.", running: true, startup: "Manual (Trigger Start)", logOn: "Local System" },
    { id: "wsearch", name: "Search", description: "Provides content indexing and search results for files and other content.", running: true, startup: "Automatic (Delayed Start)", logOn: "Local System" },
  ];

  function cloneSeed() {
    return SERVICES_MSC_SEED.map(function (s) {
      return {
        id: s.id,
        name: s.name,
        description: s.description,
        running: s.running,
        startup: s.startup,
        logOn: s.logOn,
      };
    });
  }

  var backdropUac = document.getElementById("backdropUac");
  var backdropSvc = document.getElementById("backdropServicesMsc");
  var mscState = { services: [], selectedId: null, ctxServiceId: null };

  function getSvcMscTbody() {
    return backdropSvc ? backdropSvc.querySelector("#svcMscTbody") : null;
  }

  function getSvcMscTableEl() {
    return backdropSvc ? backdropSvc.querySelector("#svcMscTable") : null;
  }

  function getService(id) {
    for (var i = 0; i < mscState.services.length; i++) {
      if (mscState.services[i].id === id) {
        return mscState.services[i];
      }
    }
    return null;
  }

  function hideCtxMenu() {
    var menu = document.getElementById("svcCtxMenu");
    if (menu) {
      menu.hidden = true;
      menu.setAttribute("aria-hidden", "true");
    }
    mscState.ctxServiceId = null;
  }

  function showServicesUac() {
    if (!backdropUac) {
      return;
    }
    backdropUac.removeAttribute("data-uac-context");
    var app = document.getElementById("uacApp");
    var pub = document.getElementById("uacPub");
    var loc = document.getElementById("uacProgramLoc");
    if (app) {
      app.textContent = "Management Console";
    }
    if (pub) {
      pub.textContent = "Verified publisher: System";
    }
    if (loc) {
      loc.textContent = "C:\\Windows\\System32\\mmc.exe";
    }
    backdropUac.classList.add("show");
    backdropUac.setAttribute("aria-hidden", "false");
  }

  function showServicesMsc() {
    if (!backdropSvc) {
      return;
    }
    mscState.services = cloneSeed();
    mscState.selectedId = mscState.services.length ? mscState.services[0].id : null;
    renderServicesTable();
    updateDescAndToolbar();
    backdropSvc.classList.remove("backdrop-services--minimized");
    backdropSvc.classList.add("show");
    backdropSvc.setAttribute("aria-hidden", "false");
    var taskbarBtn = document.getElementById("taskbarBtnServices");
    if (taskbarBtn) {
      taskbarBtn.classList.add("win-taskbar-services--active");
    }
    hideCtxMenu();
  }

  function hideServicesMsc() {
    if (!backdropSvc) {
      return;
    }
    backdropSvc.classList.remove("show", "backdrop-services--minimized");
    backdropSvc.setAttribute("aria-hidden", "true");
    hideCtxMenu();
    var taskbarBtn = document.getElementById("taskbarBtnServices");
    if (taskbarBtn) {
      taskbarBtn.classList.remove("win-taskbar-services--active");
    }
  }

  function minimizeServicesMsc() {
    if (!backdropSvc) {
      return;
    }
    backdropSvc.classList.remove("show");
    backdropSvc.classList.add("backdrop-services--minimized");
    backdropSvc.setAttribute("aria-hidden", "true");
    hideCtxMenu();
  }

  function restoreServicesMsc() {
    if (!backdropSvc) {
      return;
    }
    backdropSvc.classList.remove("backdrop-services--minimized");
    backdropSvc.classList.add("show");
    backdropSvc.setAttribute("aria-hidden", "false");
  }

  function statusText(s) {
    return s.running ? "Running" : "";
  }

  function renderServicesTable() {
    var tb = getSvcMscTbody();
    if (!tb) {
      return;
    }
    tb.innerHTML = "";
    mscState.services.forEach(function (s) {
      var tr = document.createElement("tr");
      tr.className = "svc-row" + (mscState.selectedId === s.id ? " svc-row-selected" : "");
      tr.setAttribute("data-service-id", s.id);
      tr.innerHTML =
        '<td><span class="svc-msc-name-text">' + s.name + "</span></td>" +
        '<td><span class="svc-msc-desc-text">' + s.description + "</span></td>" +
        '<td class="svc-col-status">' + statusText(s) + "</td>" +
        "<td>" + s.startup + "</td>" +
        "<td>" + s.logOn + "</td>";
      tb.appendChild(tr);
    });
  }

  function selectService(id) {
    if (!getService(id)) {
      return;
    }
    mscState.selectedId = id;
    renderServicesTable();
    updateDescAndToolbar();
  }

  function updateDescAndToolbar() {
    var s = mscState.selectedId ? getService(mscState.selectedId) : null;
    var title = document.getElementById("svcMscDescTitle");
    var body = document.getElementById("svcMscDescBody");
    var links = document.getElementById("svcMscDescLinks");
    if (title) {
      title.textContent = s ? s.name : "—";
    }
    if (body) {
      body.textContent = s ? s.description : "Select a service in the list to see its description.";
    }
    if (links) {
      links.hidden = !s;
    }
    var canStart = s && !s.running;
    var canStop = s && s.running;
    var startBtn = document.getElementById("svcTbStart");
    var stopBtn = document.getElementById("svcTbStop");
    var restartBtn = document.getElementById("svcTbRestart");
    if (startBtn) {
      startBtn.disabled = !canStart;
    }
    if (stopBtn) {
      stopBtn.disabled = !canStop;
    }
    if (restartBtn) {
      restartBtn.disabled = !s;
    }
  }

  function applyStatusToRow(id) {
    var s = getService(id);
    var tb = getSvcMscTbody();
    var row = tb ? tb.querySelector('[data-service-id="' + id + '"]') : null;
    if (row && s) {
      var cell = row.querySelector(".svc-col-status");
      if (cell) {
        cell.textContent = statusText(s);
      }
    }
  }

  function startService(id) {
    var s = getService(id);
    if (!s || s.running) {
      return;
    }
    s.running = true;
    applyStatusToRow(id);
    updateDescAndToolbar();
  }

  function stopService(id) {
    var s = getService(id);
    if (!s || !s.running) {
      return;
    }
    s.running = false;
    applyStatusToRow(id);
    updateDescAndToolbar();
  }

  function restartService(id) {
    var s = getService(id);
    if (!s) {
      return;
    }
    if (s.running) {
      stopService(id);
      window.setTimeout(function () {
        startService(id);
      }, 250);
    } else {
      startService(id);
    }
  }

  function wire() {
    var table = getSvcMscTableEl();
    var ctxMenu = document.getElementById("svcCtxMenu");
    var taskbarBtn = document.getElementById("taskbarBtnServices");

    if (table) {
      table.addEventListener("click", function (event) {
        var tr = event.target.closest("tr[data-service-id]");
        if (tr) {
          selectService(tr.getAttribute("data-service-id"));
        }
      });
      table.addEventListener("contextmenu", function (event) {
        var tr = event.target.closest("tr[data-service-id]");
        if (!tr) {
          return;
        }
        event.preventDefault();
        var id = tr.getAttribute("data-service-id");
        selectService(id);
        mscState.ctxServiceId = id;
        if (ctxMenu) {
          var s = getService(id);
          document.getElementById("svcCtxStart").disabled = !s || s.running;
          document.getElementById("svcCtxStop").disabled = !s || !s.running;
          document.getElementById("svcCtxRestart").disabled = !s;
          ctxMenu.hidden = false;
          ctxMenu.style.left = Math.min(event.clientX, window.innerWidth - 180) + "px";
          ctxMenu.style.top = Math.min(event.clientY, window.innerHeight - 200) + "px";
        }
      });
    }

    document.getElementById("svcMscClose").addEventListener("click", hideServicesMsc);
    document.getElementById("svcMscMin").addEventListener("click", minimizeServicesMsc);
    document.getElementById("svcMscMax").addEventListener("click", function () {
      document.getElementById("servicesMscShell").classList.toggle("modal-services-msc--max");
    });
    document.getElementById("svcTbStart").addEventListener("click", function () {
      if (mscState.selectedId) {
        startService(mscState.selectedId);
      }
    });
    document.getElementById("svcTbStop").addEventListener("click", function () {
      if (mscState.selectedId) {
        stopService(mscState.selectedId);
      }
    });
    document.getElementById("svcTbRestart").addEventListener("click", function () {
      if (mscState.selectedId) {
        restartService(mscState.selectedId);
      }
    });
    document.getElementById("svcTbRefresh").addEventListener("click", function () {
      mscState.services = cloneSeed();
      renderServicesTable();
      updateDescAndToolbar();
    });

    document.getElementById("svcCtxStart").addEventListener("click", function () {
      var id = mscState.ctxServiceId || mscState.selectedId;
      if (id) {
        startService(id);
      }
      hideCtxMenu();
    });
    document.getElementById("svcCtxStop").addEventListener("click", function () {
      var id = mscState.ctxServiceId || mscState.selectedId;
      if (id) {
        stopService(id);
      }
      hideCtxMenu();
    });
    document.getElementById("svcCtxRestart").addEventListener("click", function () {
      var id = mscState.ctxServiceId || mscState.selectedId;
      if (id) {
        restartService(id);
      }
      hideCtxMenu();
    });

    if (taskbarBtn) {
      taskbarBtn.addEventListener("click", function () {
        if (backdropSvc.classList.contains("show")) {
          return;
        }
        if (backdropSvc.classList.contains("backdrop-services--minimized")) {
          restoreServicesMsc();
        } else if (typeof window.showServicesUac === "function") {
          window.showServicesUac();
        } else {
          showServicesMsc();
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
    }, true);
  }

  window.register3DVisionService = function () {
    var svc = getService("3dvision-server");
    if (svc) {
      svc.running = true;
    }
  };

  window.get3DVisionService = function () {
    return getService("3dvision-server");
  };

  window.showServicesMsc = showServicesMsc;
  window.showServicesUac = showServicesUac;
  window.hideServicesMsc = hideServicesMsc;

  wire();
})();
