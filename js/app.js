(function () {
  "use strict";

  const POLLING_MAX = 63;
  const DEFAULT_PORTS = ["COM4", "COM17", "COM3", "COM16"];
  const DEFAULT_SERVER_ADDRESS = "127.0.0.1";
  const DEFAULT_SERVER_PORT = "22222";

  const navRadios = document.querySelectorAll('input[name="nav-view"]');
  const viewPanels = document.querySelectorAll(".view-panel");
  const connectionRadios = document.querySelectorAll('input[name="connection-type"]');
  const rs485Section = document.getElementById("rs485-section");
  const tcpipSection = document.getElementById("tcpip-section");
  const pollingSelect = document.getElementById("polling-address");
  const portSelect = document.getElementById("serial-port");
  const tcpConnectionList = document.getElementById("tcp-connection-list");
  const converterIp = document.getElementById("converter-ip");
  const converterPort = document.getElementById("converter-port");
  const btnTcpAdd = document.getElementById("btn-tcp-add");
  const btnTcpDelete = document.getElementById("btn-tcp-delete");
  const btnConnect = document.getElementById("btn-connect");
  const btnExit = document.getElementById("btn-exit");
  const btnClose = document.getElementById("btn-close");
  const advancedExpander = document.getElementById("advanced-expander");
  const advancedExpanderBody = document.getElementById("advanced-expander-body");
  const serverNameSelect = document.getElementById("server-name");
  const demoServerNameSelect = document.getElementById("demo-server-name");
  const serverConfigOverlay = document.getElementById("server-config-overlay");
  const cfgServerName = document.getElementById("cfg-server-name");
  const cfgServerAddress = document.getElementById("cfg-server-address");
  const cfgServerPort = document.getElementById("cfg-server-port");
  const btnConfigOk = document.getElementById("btn-config-ok");
  const btnConfigCancel = document.getElementById("btn-config-cancel");
  const btnConfigClose = document.getElementById("btn-config-close");
  const editServerButtons = document.querySelectorAll(".btn-open-server-config");
  const menuFile = document.getElementById("menu-file");
  const fileMenu = document.getElementById("file-menu");
  const menuHelp = document.getElementById("menu-help");
  const helpMenu = document.getElementById("help-menu");
  const menuOperationalManual = document.getElementById("menu-operational-manual");
  const menuAbout = document.getElementById("menu-about");
  const aboutOverlay = document.getElementById("about-overlay");
  const btnAboutOk = document.getElementById("btn-about-ok");
  const btnAboutClose = document.getElementById("btn-about-close");
  const exitConfirmOverlay = document.getElementById("exit-confirm-overlay");
  const btnExitConfirmYes = document.getElementById("btn-exit-confirm-yes");
  const btnExitConfirmNo = document.getElementById("btn-exit-confirm-no");
  const btnExitConfirmClose = document.getElementById("btn-exit-confirm-close");
  const connectErrorOverlay = document.getElementById("connect-error-overlay");
  const connectErrorText = document.getElementById("connectErrorText");
  const btnConnectErrorOk = document.getElementById("btn-connect-error-ok");
  const btnConnectErrorClose = document.getElementById("btn-connect-error-close");
  const userNameInput = document.getElementById("user-name");
  const passwordInput = document.getElementById("password");

  const VALID_LOGINS = [
    { user: "admin", password: "admin", displayUser: "admin" },
    { user: "stech", password: "techS", displayUser: "stech" },
  ];

  const OPERATIONAL_MANUAL_URL = "http://www.binmaster.com/";

  let activeServerSelect = serverNameSelect;
  let tcpConnections = [];

  function populatePollingAddresses() {
    const fragment = document.createDocumentFragment();
    for (let i = 0; i <= POLLING_MAX; i++) {
      const option = document.createElement("option");
      option.value = String(i);
      option.textContent = String(i);
      fragment.appendChild(option);
    }
    pollingSelect.appendChild(fragment);
  }

  function populateSerialPorts() {
    DEFAULT_PORTS.forEach(function (port) {
      const option = document.createElement("option");
      option.value = port;
      option.textContent = port;
      portSelect.appendChild(option);
    });
  }

  function switchNav(targetView) {
    viewPanels.forEach(function (panel) {
      panel.classList.toggle("active", panel.id === "view-" + targetView);
    });
  }

  function switchConnectionType(type) {
    rs485Section.classList.toggle("visible", type === "rs485" || type === "hart");
    tcpipSection.classList.toggle("visible", type === "tcpip");
  }

  function renderTcpConnectionList() {
    if (!tcpConnectionList) {
      return;
    }

    const selectedId = tcpConnectionList.value;
    tcpConnectionList.innerHTML = "";

    if (tcpConnections.length === 0) {
      const emptyOption = document.createElement("option");
      emptyOption.value = "";
      emptyOption.textContent = "";
      tcpConnectionList.appendChild(emptyOption);
      if (btnTcpDelete) {
        btnTcpDelete.disabled = true;
      }
      return;
    }

    tcpConnections.forEach(function (connection) {
      const option = document.createElement("option");
      option.value = connection.id;
      option.textContent = connection.name;
      tcpConnectionList.appendChild(option);
    });

    if (btnTcpDelete) {
      btnTcpDelete.disabled = false;
    }

    const stillExists = tcpConnections.some(function (connection) {
      return connection.id === selectedId;
    });

    if (stillExists) {
      tcpConnectionList.value = selectedId;
    } else {
      tcpConnectionList.selectedIndex = 0;
    }

    loadSelectedTcpConnection();
  }

  function loadSelectedTcpConnection() {
    if (!tcpConnectionList || !converterIp || !converterPort) {
      return;
    }

    const selected = tcpConnections.find(function (connection) {
      return connection.id === tcpConnectionList.value;
    });

    if (selected) {
      converterIp.value = selected.ip;
      converterPort.value = selected.port;
    }
  }

  function addTcpConnection() {
    if (!converterIp || !converterPort) {
      return;
    }

    const ip = converterIp.value.trim() || DEFAULT_SERVER_ADDRESS;
    const port = converterPort.value.trim() || DEFAULT_SERVER_PORT;
    const name = window.prompt("Connection name:", "Connection " + (tcpConnections.length + 1));

    if (name === null) {
      return;
    }

    const trimmedName = name.trim();
    if (!trimmedName) {
      return;
    }

    const connection = {
      id: "conn-" + Date.now(),
      name: trimmedName,
      ip: ip,
      port: port,
    };

    tcpConnections.push(connection);
    renderTcpConnectionList();
    tcpConnectionList.value = connection.id;
    loadSelectedTcpConnection();
  }

  function deleteTcpConnection() {
    if (!tcpConnectionList || tcpConnections.length === 0) {
      return;
    }

    const selectedId = tcpConnectionList.value;
    tcpConnections = tcpConnections.filter(function (connection) {
      return connection.id !== selectedId;
    });
    renderTcpConnectionList();
  }

  function getActiveServerSelect() {
    const activeNav = document.querySelector('input[name="nav-view"]:checked');
    if (activeNav && activeNav.value === "demo") {
      return demoServerNameSelect;
    }
    return serverNameSelect;
  }

  function openServerConfig() {
    activeServerSelect = getActiveServerSelect();
    cfgServerName.value = activeServerSelect.value;
    cfgServerAddress.value = DEFAULT_SERVER_ADDRESS;
    cfgServerPort.value = DEFAULT_SERVER_PORT;
    serverConfigOverlay.hidden = false;
  }

  function closeServerConfig() {
    serverConfigOverlay.hidden = true;
  }

  function setMenuOpen(trigger, popup, open) {
    if (!trigger || !popup) {
      return;
    }
    trigger.setAttribute("aria-expanded", open ? "true" : "false");
    popup.hidden = !open;
  }

  function closeAllMenus() {
    setMenuOpen(menuFile, fileMenu, false);
    setMenuOpen(menuHelp, helpMenu, false);
  }

  function openAboutDialog() {
    closeAllMenus();
    if (aboutOverlay) {
      aboutOverlay.hidden = false;
    }
  }

  window.openAboutDialog = openAboutDialog;

  function closeAboutDialog() {
    if (aboutOverlay) {
      aboutOverlay.hidden = true;
    }
  }

  function openExitConfirm() {
    closeAllMenus();
    if (exitConfirmOverlay) {
      exitConfirmOverlay.hidden = false;
    }
  }

  function closeExitConfirm() {
    if (exitConfirmOverlay) {
      exitConfirmOverlay.hidden = true;
    }
  }

  function confirmExitApplication() {
    closeExitConfirm();
    if (typeof window.closeMultiVision === "function") {
      window.closeMultiVision();
    }
    if (typeof window.closeVisionClient === "function") {
      window.closeVisionClient();
      return;
    }
    window.close();
  }

  function getActiveNavView() {
    const activeNav = document.querySelector('input[name="nav-view"]:checked');
    return activeNav ? activeNav.value : null;
  }

  function validateAdvancedLogin(userName, password) {
    return (
      VALID_LOGINS.find(function (entry) {
        return entry.user === userName && entry.password === password;
      }) || null
    );
  }

  function openConnectError(message) {
    closeAllMenus();
    if (connectErrorText) {
      connectErrorText.textContent = message;
    }
    if (connectErrorOverlay) {
      connectErrorOverlay.hidden = false;
    }
  }

  function closeConnectError() {
    if (connectErrorOverlay) {
      connectErrorOverlay.hidden = true;
    }
  }

  function openOperationalManual() {
    closeAllMenus();
    window.open(OPERATIONAL_MANUAL_URL, "_blank", "noopener,noreferrer");
  }

  function saveServerConfig() {
    activeServerSelect.value = cfgServerName.value;
    if (serverNameSelect && demoServerNameSelect) {
      serverNameSelect.value = cfgServerName.value;
      demoServerNameSelect.value = cfgServerName.value;
    }
    closeServerConfig();
  }

  navRadios.forEach(function (radio) {
    radio.addEventListener("change", function () {
      if (radio.checked) {
        switchNav(radio.value);
      }
    });
  });

  connectionRadios.forEach(function (radio) {
    radio.addEventListener("change", function () {
      if (radio.checked) {
        switchConnectionType(radio.value);
      }
    });
  });

  if (tcpConnectionList) {
    tcpConnectionList.addEventListener("change", loadSelectedTcpConnection);
  }

  if (btnTcpAdd) {
    btnTcpAdd.addEventListener("click", addTcpConnection);
  }

  if (btnTcpDelete) {
    btnTcpDelete.addEventListener("click", deleteTcpConnection);
  }

  editServerButtons.forEach(function (btn) {
    btn.addEventListener("click", openServerConfig);
  });

  btnConfigOk.addEventListener("click", saveServerConfig);
  btnConfigCancel.addEventListener("click", closeServerConfig);
  btnConfigClose.addEventListener("click", closeServerConfig);

  if (menuFile && fileMenu) {
    menuFile.addEventListener("click", function (event) {
      event.stopPropagation();
      const open = menuFile.getAttribute("aria-expanded") === "true";
      closeAllMenus();
      setMenuOpen(menuFile, fileMenu, !open);
    });
  }

  fileMenu.querySelectorAll(".menu-popup-item").forEach(function (item) {
    item.addEventListener("click", function () {
      closeAllMenus();
    });
  });

  if (menuHelp && helpMenu) {
    menuHelp.addEventListener("click", function (event) {
      event.stopPropagation();
      const open = menuHelp.getAttribute("aria-expanded") === "true";
      closeAllMenus();
      setMenuOpen(menuHelp, helpMenu, !open);
    });
  }

  if (menuOperationalManual) {
    menuOperationalManual.addEventListener("click", openOperationalManual);
  }

  if (menuAbout) {
    menuAbout.addEventListener("click", openAboutDialog);
  }

  if (btnAboutOk) {
    btnAboutOk.addEventListener("click", closeAboutDialog);
  }

  if (btnAboutClose) {
    btnAboutClose.addEventListener("click", closeAboutDialog);
  }

  document.addEventListener("click", function (event) {
    const inFileMenu = menuFile && (menuFile.contains(event.target) || (fileMenu && fileMenu.contains(event.target)));
    const inHelpMenu = menuHelp && (menuHelp.contains(event.target) || (helpMenu && helpMenu.contains(event.target)));
    if (inFileMenu || inHelpMenu) {
      return;
    }
    closeAllMenus();
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      closeAllMenus();
      closeAboutDialog();
      closeServerConfig();
      closeExitConfirm();
      closeConnectError();
    }
  });

  btnConnect.addEventListener("click", function () {
    const navView = getActiveNavView();
    if (navView !== "advanced" && navView !== "demo") {
      openConnectError("Select Advanced Connection or Demo Mode, then connect.");
      return;
    }

    const serverHost =
      (cfgServerAddress.value || DEFAULT_SERVER_ADDRESS) +
      ":" +
      (cfgServerPort.value || DEFAULT_SERVER_PORT);

    if (typeof window.openMultiVisionFromConnect !== "function") {
      openConnectError("3D MultiVision is not available.");
      return;
    }

    // Demo Mode: simulated environment (DemoManager.IsDemoRun) — no login required
    if (navView === "demo") {
      window.openMultiVisionFromConnect({
        userName: "demoUser",
        serverHost: serverHost,
        viewTitle: "Aggregates",
        isDemo: true,
      });
      return;
    }

    const userName = userNameInput ? userNameInput.value.trim() : "";
    const password = passwordInput ? passwordInput.value : "";
    const login = validateAdvancedLogin(userName, password);

    if (!login) {
      openConnectError("Invalid user name or password.");
      return;
    }

    window.openMultiVisionFromConnect({
      userName: login.displayUser,
      serverHost: serverHost,
      viewTitle: "(No Project)",
      isDemo: false,
      blankProject: true,
    });
  });

  function exitApplication() {
    openExitConfirm();
  }

  btnExit.addEventListener("click", exitApplication);

  btnClose.addEventListener("click", exitApplication);

  const menuFileExit = document.getElementById("menu-file-exit");
  if (menuFileExit) {
    menuFileExit.addEventListener("click", exitApplication);
  }

  if (btnExitConfirmYes) {
    btnExitConfirmYes.addEventListener("click", confirmExitApplication);
  }

  if (btnExitConfirmNo) {
    btnExitConfirmNo.addEventListener("click", closeExitConfirm);
  }

  if (btnExitConfirmClose) {
    btnExitConfirmClose.addEventListener("click", closeExitConfirm);
  }

  if (btnConnectErrorOk) {
    btnConnectErrorOk.addEventListener("click", closeConnectError);
  }

  if (btnConnectErrorClose) {
    btnConnectErrorClose.addEventListener("click", closeConnectError);
  }

  if (advancedExpander && advancedExpanderBody) {
    advancedExpander.addEventListener("click", function () {
      const expanded = advancedExpander.getAttribute("aria-expanded") === "true";
      const nextExpanded = !expanded;
      advancedExpander.setAttribute("aria-expanded", nextExpanded ? "true" : "false");
      advancedExpanderBody.classList.toggle("is-open", nextExpanded);
    });
  }

  populatePollingAddresses();
  populateSerialPorts();
  renderTcpConnectionList();
  switchConnectionType("rs485");
})();
