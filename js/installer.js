(function () {
  "use strict";

  var LOGO = "assets/images/logo_icon.ico";
  var START_MENU_FOLDERS = [
    "7-Zip", "Accessibility", "Accessories", "Administrative Tools", "Cisco", "Cursor",
    "Datexel s.r.l", "Debian", "Intercontrol Terminal", "Locator", "Logi",
  ];

  var USER_PROFILE = "C:\\Users\\UserProfile";
  var DEFAULT_SERVER_LOCAL_PATH = USER_PROFILE + "\\AppData\\Local";

  var CDRIVE_FOLDERS = [
    { name: "Backup", created: "3/12/2024 2:15 PM", expandable: true },
    { name: "PerfLogs", created: "4/10/2022 7:00 AM" },
    { name: "Program Files", created: "4/10/2022 7:00 AM" },
    { name: "Program Files (x86)", created: "4/10/2022 7:00 AM" },
    { name: "Temp", created: "7/6/2026 6:00 AM" },
    { name: "Users", created: "4/10/2022 7:00 AM" },
    { name: "Windows", created: "4/10/2022 7:00 AM" },
  ];

  var BROWSE_ICON = {
    folder: "folder",
    desktop: "desktop",
    documents: "documents",
    downloads: "downloads",
    music: "music",
    pictures: "pictures",
    videos: "videos",
    gallery: "pictures",
    onedrive: "onedrive",
    drive: "drive",
    pc: "pc",
    library: "library",
    network: "network",
  };

  function browseNode(id, label, path, icon, children, created, expandable) {
    return {
      id: id,
      label: label,
      path: path || null,
      icon: icon || "folder",
      children: children || null,
      created: created || null,
      expandable: expandable || false,
    };
  }

  function getBrowseRoots() {
    return [
      browseNode("desktop", "Desktop", USER_PROFILE + "\\Desktop", "desktop", [
        browseNode("gallery", "Gallery", null, "gallery"),
        browseNode("onedrive-qa", "OneDrive", null, "onedrive"),
        browseNode("desktop-link", "Desktop", USER_PROFILE + "\\Desktop", "desktop"),
        browseNode("documents-qa", "Documents", USER_PROFILE + "\\Documents", "documents"),
        browseNode("downloads-qa", "Downloads", USER_PROFILE + "\\Downloads", "downloads"),
        browseNode("music-qa", "Music", USER_PROFILE + "\\Music", "music"),
        browseNode("pictures-qa", "Pictures", USER_PROFILE + "\\Pictures", "pictures"),
        browseNode("videos-qa", "Videos", USER_PROFILE + "\\Videos", "videos"),
        browseNode("user-profile", "UserProfile", USER_PROFILE, "folder", [
          browseNode("profile-cache", ".cache", USER_PROFILE + "\\.cache"),
          browseNode("profile-config", ".config", USER_PROFILE + "\\.config"),
          browseNode("profile-dotnet", ".dotnet", USER_PROFILE + "\\.dotnet"),
          browseNode("profile-appdata", "AppData", USER_PROFILE + "\\AppData", "folder", [
            browseNode("profile-local", "Local", USER_PROFILE + "\\AppData\\Local"),
            browseNode("profile-locallow", "LocalLow", USER_PROFILE + "\\AppData\\LocalLow"),
            browseNode("profile-roaming", "Roaming", USER_PROFILE + "\\AppData\\Roaming"),
          ]),
          browseNode("profile-desktop", "Desktop", USER_PROFILE + "\\Desktop", "desktop"),
          browseNode("profile-documents", "Documents", USER_PROFILE + "\\Documents", "documents"),
          browseNode("profile-downloads", "Downloads", USER_PROFILE + "\\Downloads", "downloads"),
          browseNode("profile-favorites", "Favorites", USER_PROFILE + "\\Favorites"),
          browseNode("profile-links", "Links", USER_PROFILE + "\\Links"),
          browseNode("profile-music", "Music", USER_PROFILE + "\\Music", "music"),
          browseNode("profile-onedrive", "OneDrive", USER_PROFILE + "\\OneDrive", "onedrive"),
          browseNode("profile-pictures", "Pictures", USER_PROFILE + "\\Pictures", "pictures"),
          browseNode("profile-savedgames", "Saved Games", USER_PROFILE + "\\Saved Games"),
          browseNode("profile-usb", "usb_driver", USER_PROFILE + "\\usb_driver"),
          browseNode("profile-videos", "Videos", USER_PROFILE + "\\Videos", "videos"),
        ]),
      ]),
      browseNode("this-pc", "This PC", null, "pc", [
        browseNode("c-drive", "Local Disk (C:)", "C:\\", "drive", getCDriveTreeChildren()),
      ]),
      browseNode("libraries", "Libraries", null, "library", [
        browseNode("lib-docs", "Documents", null, "documents"),
        browseNode("lib-music", "Music", null, "music"),
        browseNode("lib-pictures", "Pictures", null, "pictures"),
        browseNode("lib-videos", "Videos", null, "videos"),
      ]),
      browseNode("network", "Network", null, "network"),
    ];
  }

  function getCDriveTreeChildren() {
    return CDRIVE_FOLDERS.map(function (folder) {
      return browseNode(
        "c-" + folder.name.toLowerCase().replace(/[^a-z0-9]+/g, "-"),
        folder.name,
        "C:\\" + folder.name,
        "folder",
        folder.expandable ? [] : null,
        folder.created,
        folder.expandable
      );
    });
  }

  var COMPONENT_DESC = {
    client: "Client application files required to connect to 3DVision servers.",
    server: "Server application files for hosting 3DVision data and services.",
  };

  var backdropLang = document.getElementById("backdropInstallerLang");
  var backdropWizard = document.getElementById("backdropInstaller");
  var backdropBrowse = document.getElementById("backdropBrowseFolder");
  var backdropMsg = document.getElementById("backdropInstallerMsg");
  var wizardEl = document.querySelector(".installer-wizard");
  var wizardBody = document.getElementById("installerWizardMain");
  var wizardFooter = document.getElementById("installerWizardFooter");

  var state = {
    language: "English",
    setupType: "full",
    licenseAccepted: false,
    users: "all",
    clientComponent: true,
    serverComponent: true,
    runAsService: "service",
    serverLocalPath: DEFAULT_SERVER_LOCAL_PATH,
    installPath: "C:\\Program Files (x86)\\BinMaster 3DVision",
    startMenuFolder: "BinMaster 3DVision",
    noShortcuts: false,
    selectedComponent: "client",
    stepIndex: 0,
    browseTarget: null,
    browseSelectionPath: DEFAULT_SERVER_LOCAL_PATH,
    browseExpanded: {},
    browseCreatedFolders: {},
    browseRenaming: null,
    browseCtxTarget: null,
  };

  var steps = [];

  function spaceRequiredMb() {
    return state.serverComponent ? 1013.9 : 230.4;
  }

  function rebuildSteps() {
    if (state.setupType === "full") {
      state.clientComponent = true;
      state.serverComponent = true;
    }
    steps = ["welcome", "setupType", "license", "users"];
    if (state.setupType === "custom") {
      steps.push("components");
    }
    if (state.serverComponent) {
      steps.push("runAsService", "serverLocalPath");
    }
    steps.push("installLocation", "startMenu", "installing", "finish");
  }

  function showLangDialog() {
    if (backdropLang) {
      backdropLang.classList.add("show");
      backdropLang.setAttribute("aria-hidden", "false");
    }
  }

  function hideLangDialog() {
    if (backdropLang) {
      backdropLang.classList.remove("show");
      backdropLang.setAttribute("aria-hidden", "true");
    }
  }

  function showWizard() {
    rebuildSteps();
    state.stepIndex = 0;
    if (backdropWizard) {
      backdropWizard.classList.add("show");
      backdropWizard.setAttribute("aria-hidden", "false");
    }
    renderStep();
  }

  function hideWizard() {
    if (backdropWizard) {
      backdropWizard.classList.remove("show");
      backdropWizard.setAttribute("aria-hidden", "true");
    }
  }

  function currentStepId() {
    return steps[state.stepIndex];
  }

  function setDefaultBtn(btn) {
    if (!wizardFooter) {
      return;
    }
    wizardFooter.querySelectorAll(".installer-wiz-btn").forEach(function (b) {
      b.classList.remove("installer-wiz-btn--default");
    });
    if (btn) {
      btn.classList.add("installer-wiz-btn--default");
    }
  }

  function renderFooter(buttons, showBrand) {
    if (!wizardFooter) {
      return;
    }
    if (showBrand === undefined) {
      showBrand = showBrandFooter();
    }
    wizardFooter.innerHTML = "";
    if (showBrand) {
      var brandRow = document.createElement("div");
      brandRow.className = "installer-wizard-footer-brand";
      brandRow.innerHTML =
        '<span class="installer-wizard-brand">Garner Industries, Inc.</span>' +
        '<span class="installer-wizard-brand-line" aria-hidden="true"></span>';
      wizardFooter.appendChild(brandRow);
    }
    var btnRow = document.createElement("div");
    btnRow.className = "installer-wizard-footer-btns";
    buttons.forEach(function (spec) {
      var btn = document.createElement("button");
      btn.type = "button";
      btn.className = "installer-wiz-btn";
      btn.textContent = spec.label;
      btn.disabled = !!spec.disabled;
      if (spec.default) {
        btn.classList.add("installer-wiz-btn--default");
      }
      btn.addEventListener("click", spec.onClick);
      btnRow.appendChild(btn);
    });
    wizardFooter.appendChild(btnRow);
  }

  function updateWizardChrome(step) {
    if (!wizardEl) {
      return;
    }
    var isWelcomeOrFinish = step === "welcome" || step === "finish";
    wizardEl.classList.toggle("installer-wizard--welcome", isWelcomeOrFinish);
    wizardEl.classList.toggle("installer-wizard--inner", !isWelcomeOrFinish);
  }

  function showBrandFooter() {
    var step = currentStepId();
    return step !== "welcome" && step !== "finish";
  }

  function goNext() {
    rebuildSteps();
    if (state.stepIndex < steps.length - 1) {
      state.stepIndex += 1;
      renderStep();
    }
  }

  function goBack() {
    if (state.stepIndex > 0) {
      state.stepIndex -= 1;
      rebuildSteps();
      renderStep();
    }
  }

  function cancelInstaller() {
    hideWizard();
    hideLangDialog();
  }

  function renderStep() {
    if (!wizardBody) {
      return;
    }
    var step = currentStepId();
    updateWizardChrome(step);
    wizardBody.innerHTML = "";

    if (step === "welcome") {
      renderWelcome();
    } else if (step === "setupType") {
      renderSetupType();
    } else if (step === "license") {
      renderLicense();
    } else if (step === "users") {
      renderUsers();
    } else if (step === "components") {
      renderComponents();
    } else if (step === "runAsService") {
      renderRunAsService();
      window.dispatchEvent(new CustomEvent("install-guide:service-step"));
    } else if (step === "serverLocalPath") {
      renderServerLocalPath();
    } else if (step === "installLocation") {
      renderInstallLocation();
    } else if (step === "startMenu") {
      renderStartMenu();
    } else if (step === "installing") {
      renderInstalling();
    } else if (step === "finish") {
      renderFinish();
    }
  }

  function wizardWelcomeHeader(title) {
    return (
      '<div class="installer-wizard-header installer-wizard-header--welcome">' +
      "<h2>" + title + "</h2>" +
      "</div>"
    );
  }

  function wizardHeader(title, subtitle) {
    return (
      '<div class="installer-wizard-header">' +
      '<div class="installer-wizard-header-text">' +
      "<h2>" + title + "</h2>" +
      (subtitle ? "<p>" + subtitle + "</p>" : "") +
      "</div>" +
      '<img class="installer-wizard-logo" src="' + LOGO + '" width="36" height="36" alt="">' +
      "</div>" +
      '<hr class="installer-wizard-header-rule">'
    );
  }

  function renderWelcome() {
    wizardBody.innerHTML =
      wizardWelcomeHeader("Welcome to the BinMaster 3DVision Setup Wizard") +
      '<div class="installer-wizard-main">' +
      "<p>This wizard will guide you through the installation of BinMaster 3DVision.</p>" +
      "<p>It is recommended that you close all other applications before starting Setup. " +
      "This will make it possible to update relevant system files without having to reboot your computer.</p>" +
      "<p>Click <strong>Next</strong> to continue.</p></div>";
    renderFooter([
      { label: "< Back", disabled: true, onClick: function () {} },
      { label: "Next >", default: true, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderSetupType() {
    wizardBody.innerHTML =
      wizardHeader("Setup type", "Choose setup options") +
      '<div class="installer-wizard-main installer-wizard-main--radio-spaced">' +
      "<p>Choose preferred installation type and click Next.</p>" +
      '<div class="installer-radio-block installer-radio-block--setup">' +
      '<label><input type="radio" name="setupType" value="full"' +
      (state.setupType === "full" ? " checked" : "") +
      "> Full install" +
      '<span class="installer-radio-desc">Server and client applications will be installed to default destination folder.</span></label>' +
      '<label><input type="radio" name="setupType" value="custom"' +
      (state.setupType === "custom" ? " checked" : "") +
      "> Custom install" +
      '<span class="installer-radio-desc">You may choose individual options to be installed. Recommended for experienced users only.</span></label>' +
      "</div></div>";

    wizardBody.querySelectorAll('input[name="setupType"]').forEach(function (radio) {
      radio.addEventListener("change", function () {
        state.setupType = radio.value;
        if (state.setupType === "full") {
          state.serverComponent = true;
          state.clientComponent = true;
        }
      });
    });

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, onClick: function () {
        if (state.setupType === "full") {
          state.clientComponent = true;
          state.serverComponent = true;
        }
        goNext();
      }},
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderLicense() {
    wizardBody.innerHTML =
      wizardHeader(
        "License Agreement",
        "Please review the license terms before installing BinMaster 3DVision."
      ) +
      '<div class="installer-wizard-main">' +
      "<p>Press Page Down to see the rest of the agreement.</p>" +
      '<textarea class="installer-license-box" readonly>' +
      "Terms of Use & End User License Agreement\n\n" +
      "This is a legal agreement between you, a user or purchaser of the Product (defined below) " +
      '("End-User" or "You"), and A.P.M Automation Solutions Ltd. ("APM") regarding the software ' +
      "program accompanying this agreement and is a part of the 3DLevelScanner product of APM purchased by you " +
      '("the Product"), including the APM proprietary software program embedded in the Product ("the Software"), ' +
      "the related documentation, and any updates provided by APM.\n\n" +
      "BY INSTALLING OR USING THE SOFTWARE YOU AGREE TO BE BOUND BY THE TERMS OF THIS AGREEMENT. " +
      "IF YOU DO NOT AGREE TO THE TERMS OF THIS AGREEMENT, DO NOT INSTALL OR USE THE SOFTWARE." +
      "</textarea>" +
      "<p>If you accept the terms of the agreement, select the first option below. " +
      "You must accept the agreement to install BinMaster 3DVision. Click Next to continue.</p>" +
      '<div class="installer-radio-block">' +
      '<label><input type="radio" name="license" value="accept"' +
      (state.licenseAccepted ? " checked" : "") +
      "> I accept the terms of the License Agreement</label>" +
      '<label><input type="radio" name="license" value="decline"' +
      (!state.licenseAccepted ? " checked" : "") +
      "> I do not accept the terms of the License Agreement</label>" +
      "</div></div>";

    var nextBtn;
    function updateLicense() {
      state.licenseAccepted = wizardBody.querySelector('input[name="license"]:checked').value === "accept";
      if (nextBtn) {
        nextBtn.disabled = !state.licenseAccepted;
      }
    }

    wizardBody.querySelectorAll('input[name="license"]').forEach(function (radio) {
      radio.addEventListener("change", updateLicense);
    });

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, disabled: !state.licenseAccepted, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
    nextBtn = wizardFooter.querySelector(".installer-wizard-footer-btns .installer-wiz-btn:nth-child(2)");
  }

  function renderUsers() {
    wizardBody.innerHTML =
      wizardHeader(
        "Choose users",
        "Choose for which users you want to install BinMaster 3DVision"
      ) +
      '<div class="installer-wizard-main installer-wizard-main--radio-spaced">' +
      "<p>Select whether you want to install BinMaster 3DVision for yourself only or for all users of this computer. " +
      "Click Next to continue.</p>" +
      '<div class="installer-radio-block installer-radio-block--users">' +
      '<label><input type="radio" name="users" value="all"' +
      (state.users === "all" ? " checked" : "") +
      "> Install for all users</label>" +
      '<label><input type="radio" name="users" value="current"' +
      (state.users === "current" ? " checked" : "") +
      "> Install for current user</label>" +
      "</div></div>";

    wizardBody.querySelectorAll('input[name="users"]').forEach(function (radio) {
      radio.addEventListener("change", function () {
        state.users = radio.value;
      });
    });

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderComponents() {
    var placeholderDesc = "Position your mouse over a component to see its description.";

    wizardBody.innerHTML =
      wizardHeader(
        "Choose Components",
        "Choose which features of BinMaster 3DVision you want to install."
      ) +
      '<div class="installer-wizard-main installer-wizard-main--components">' +
      "<p>Check the components you want to install and uncheck the components you don't want to install. " +
      "Click Next to continue.</p>" +
      '<div class="installer-components-wrap">' +
      '<div class="installer-components-aside">' +
      '<label class="installer-components-label">Select components to install:</label>' +
      '<div class="installer-space-info">Space required: <span id="spaceRequired"></span></div>' +
      "</div>" +
      '<div class="installer-components-center">' +
      '<div class="installer-listbox" id="componentList"></div>' +
      "</div>" +
      '<div class="installer-desc-group">' +
      '<span class="installer-desc-legend">Description</span>' +
      '<div class="installer-desc-panel installer-desc-panel--placeholder" id="componentDesc">' +
      placeholderDesc +
      "</div></div></div></div>";

    var list = wizardBody.querySelector("#componentList");
    var desc = wizardBody.querySelector("#componentDesc");
    var spaceEl = wizardBody.querySelector("#spaceRequired");

    function showPlaceholderDesc() {
      desc.textContent = placeholderDesc;
      desc.classList.add("installer-desc-panel--placeholder");
    }

    function showComponentDesc(id) {
      desc.textContent = COMPONENT_DESC[id] || placeholderDesc;
      desc.classList.remove("installer-desc-panel--placeholder");
    }

    function updateSpace() {
      spaceEl.textContent = spaceRequiredMb().toFixed(1) + "MB";
    }

    function renderList() {
      list.innerHTML = "";
      [
        { id: "client", label: "Client app files", checked: true, disabled: true },
        { id: "server", label: "Server app files", checked: state.serverComponent, disabled: state.setupType === "full" },
      ].forEach(function (item) {
        var row = document.createElement("div");
        row.className = "installer-listbox-item";
        if (state.selectedComponent === item.id) {
          row.classList.add("installer-listbox-item--sel");
        }
        row.innerHTML =
          '<input type="checkbox"' +
          (item.checked ? " checked" : "") +
          (item.disabled ? " disabled" : "") +
          ' id="comp-' + item.id + '">' +
          "<span>" + item.label + "</span>";
        row.addEventListener("mouseenter", function () {
          showComponentDesc(item.id);
        });
        row.addEventListener("mouseleave", function () {
          showPlaceholderDesc();
        });
        row.addEventListener("click", function (event) {
          if (event.target.tagName === "INPUT" && !item.disabled) {
            state.serverComponent = event.target.checked;
            rebuildSteps();
            updateSpace();
            return;
          }
          state.selectedComponent = item.id;
          renderList();
        });
        list.appendChild(row);
      });
    }

    renderList();
    showPlaceholderDesc();
    updateSpace();

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderRunAsService() {
    wizardBody.innerHTML =
      wizardHeader("Run as Service", "Choose whether to run server in background") +
      '<div class="installer-wizard-main installer-wizard-main--radio-spaced">' +
      "<p>You may choose to run BinMaster 3DVision server as service, which means it will start automatically " +
      "when Windows restarts. Note that the service will use the Local System account.</p>" +
      '<div class="installer-radio-block installer-radio-block--run-as">' +
      '<label><input type="radio" name="runAs" value="app"' +
      (state.runAsService === "app" ? " checked" : "") +
      "> Install BinMaster 3DVision server as Application</label>" +
      '<label><input type="radio" name="runAs" value="service"' +
      (state.runAsService === "service" ? " checked" : "") +
      "> Install BinMaster 3DVision server as Service</label>" +
      "</div></div>";

    wizardBody.querySelectorAll('input[name="runAs"]').forEach(function (radio) {
      radio.addEventListener("change", function () {
        state.runAsService = radio.value;
      });
    });

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function isAppDataLocalPath(path) {
    var localRoot = normalizeBrowsePath(DEFAULT_SERVER_LOCAL_PATH).toLowerCase();
    var normalized = normalizeBrowsePath(path).toLowerCase();
    return normalized === localRoot || normalized.indexOf(localRoot + "\\") === 0;
  }

  function showInstallerMessage(text) {
    var msgText = document.getElementById("installerMsgText");
    if (msgText) {
      msgText.textContent = text;
    }
    if (backdropMsg) {
      backdropMsg.classList.add("show");
      backdropMsg.setAttribute("aria-hidden", "false");
    }
  }

  function hideInstallerMessage() {
    if (backdropMsg) {
      backdropMsg.classList.remove("show");
      backdropMsg.setAttribute("aria-hidden", "true");
    }
  }

  function tryServerLocalPathNext() {
    if (state.runAsService === "service" && isAppDataLocalPath(state.serverLocalPath)) {
      showInstallerMessage("Folder cannot be selected, please select a general folder.");
      return;
    }
    goNext();
  }

  function renderServerLocalPath() {
    wizardBody.innerHTML =
      wizardHeader(
        "Choose Server Local Path Location",
        "Choose the folder in which the 3DVision Server will create its files."
      ) +
      '<div class="installer-wizard-main installer-wizard-main--server-path">' +
      "<p>3DVision server output files will be created in the following folder. " +
      "To install in a different folder, click Browse and select another folder. Click Next to continue.</p>" +
      '<fieldset class="installer-fieldset installer-fieldset--spaced"><legend>Destination Folder</legend>' +
      '<div class="installer-path-row">' +
      '<input type="text" id="serverPathInput" class="installer-path-input--readonly" readonly value="' +
      state.serverLocalPath +
      '">' +
      '<div class="installer-path-btns">' +
      '<button type="button" id="btnBrowseServer">Browse...</button>' +
      '<button type="button" id="btnServerDefault">Set to default</button>' +
      "</div></div></fieldset></div>";

    wizardBody.querySelector("#btnBrowseServer").addEventListener("click", function () {
      openBrowseDialog("server");
    });
    wizardBody.querySelector("#btnServerDefault").addEventListener("click", function () {
      state.serverLocalPath = DEFAULT_SERVER_LOCAL_PATH;
      wizardBody.querySelector("#serverPathInput").value = state.serverLocalPath;
    });

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, onClick: tryServerLocalPathNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderInstallLocation() {
    wizardBody.innerHTML =
      wizardHeader(
        "Choose Install Location",
        "Choose the folder in which to install BinMaster 3DVision."
      ) +
      '<div class="installer-wizard-main installer-wizard-main--install-location">' +
      "<p>Setup will install BinMaster 3DVision in the following folder. " +
      "To install in a different folder, click Browse and select another folder. Click Next to continue.</p>" +
      '<div class="installer-install-location-bottom">' +
      '<fieldset class="installer-fieldset"><legend>Destination Folder</legend>' +
      '<div class="installer-path-row">' +
      '<input type="text" id="installPathInput" value="' + state.installPath + '">' +
      '<button type="button" id="btnBrowseInstall">Browse...</button>' +
      "</div></fieldset>" +
      '<div class="installer-space-info">' +
      "Space required: " + spaceRequiredMb().toFixed(1) + "MB<br>" +
      "Space available: 458.3GB</div></div></div>";

    wizardBody.querySelector("#installPathInput").addEventListener("input", function (event) {
      state.installPath = event.target.value;
    });
    wizardBody.querySelector("#btnBrowseInstall").addEventListener("click", function () {
      openBrowseDialog("install");
    });

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Next >", default: true, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderStartMenu() {
    wizardBody.innerHTML =
      wizardHeader(
        "Choose Start Menu Folder",
        "Choose a Start Menu folder for the BinMaster 3DVision shortcuts."
      ) +
      '<div class="installer-wizard-main">' +
      "<p>Select the Start Menu folder in which you would like to create the program's shortcuts. " +
      "You can also enter a name to create a new folder.</p>" +
      '<input type="text" class="installer-startmenu-input" id="startMenuInput" value="' + state.startMenuFolder + '">' +
      '<div class="installer-startmenu-list" id="startMenuList"></div>' +
      '<label class="installer-startmenu-noshortcuts">' +
      '<input type="checkbox" id="noShortcuts"' + (state.noShortcuts ? " checked" : "") + "> Do not create shortcuts</label>" +
      "</div>";

    var list = wizardBody.querySelector("#startMenuList");
    var input = wizardBody.querySelector("#startMenuInput");

    function renderList() {
      list.innerHTML = "";
      var allFolders = START_MENU_FOLDERS.slice();
      if (allFolders.indexOf(state.startMenuFolder) === -1) {
        allFolders.unshift(state.startMenuFolder);
      }
      allFolders.forEach(function (name) {
        var btn = document.createElement("button");
        btn.type = "button";
        btn.textContent = name;
        if (name === state.startMenuFolder) {
          btn.classList.add("is-selected");
        }
        btn.addEventListener("click", function () {
          state.startMenuFolder = name;
          input.value = name;
          renderList();
        });
        list.appendChild(btn);
      });
    }

    input.addEventListener("input", function () {
      state.startMenuFolder = input.value;
      renderList();
    });
    wizardBody.querySelector("#noShortcuts").addEventListener("change", function (event) {
      state.noShortcuts = event.target.checked;
    });
    renderList();

    renderFooter([
      { label: "< Back", onClick: goBack },
      { label: "Install", default: true, onClick: goNext },
      { label: "Cancel", onClick: cancelInstaller },
    ]);
  }

  function renderInstalling() {
    wizardBody.innerHTML =
      wizardHeader("Installing", "Please wait while BinMaster 3DVision is being installed.") +
      '<div class="installer-wizard-main">' +
      '<p class="installer-extract-label" id="installExtractLabel">Extract: dotNetFx40_Full_x86_x64.exe</p>' +
      '<div class="installer-progress-wrap">' +
      '<div class="installer-progress-bar installer-progress-bar--green"><div class="installer-progress-fill" id="installProgress"></div></div>' +
      "</div>" +
      '<button type="button" class="installer-show-details" id="installShowDetails">Show details</button>' +
      "</div>";

    renderFooter([
      { label: "< Back", disabled: true, onClick: function () {} },
      { label: "Next >", disabled: true, onClick: function () {} },
      { label: "Cancel", onClick: cancelInstaller },
    ]);

    var fill = wizardBody.querySelector("#installProgress");
    var label = wizardBody.querySelector("#installExtractLabel");
    var extracts = [
      "dotNetFx40_Full_x86_x64.exe",
      "client_setup.msi",
      "server_setup.msi",
      "logo_icon.ico",
    ];
    var pct = 0;
    var extractIdx = 0;
    var timer = window.setInterval(function () {
      pct += 6 + Math.random() * 10;
      if (pct >= 100) {
        pct = 100;
        window.clearInterval(timer);
        window.setTimeout(goNext, 400);
      }
      if (fill) {
        fill.style.width = pct + "%";
      }
      if (label && pct > extractIdx * 20 && extractIdx < extracts.length) {
        label.textContent = "Extract: " + extracts[extractIdx];
        extractIdx += 1;
      }
    }, 220);
  }

  function renderFinish() {
    wizardBody.innerHTML =
      wizardWelcomeHeader("Completing the BinMaster 3DVision Setup Wizard") +
      '<div class="installer-wizard-main">' +
      "<p>BinMaster 3DVision has been installed on your computer.</p>" +
      "<p>Click <strong>Finish</strong> to close this wizard.</p>" +
      '<label style="display:block;margin-top:16px;">' +
      '<input type="checkbox" id="launchClient"> Run BinMaster 3DVision client?</label>' +
      "</div>";

    renderFooter([
      { label: "< Back", disabled: true, onClick: function () {} },
      { label: "Finish", default: true, onClick: completeInstall },
      { label: "Cancel", disabled: true, onClick: function () {} },
    ]);
  }

  function completeInstall() {
    var launch = wizardBody.querySelector("#launchClient");
    var shouldLaunch = !launch || launch.checked;
    hideWizard();
    if (typeof window.onInstallComplete === "function") {
      window.onInstallComplete(shouldLaunch);
    }
  }

  function normalizeBrowsePath(path) {
    if (!path) {
      return "";
    }
    return path.replace(/\//g, "\\").replace(/\\+$/, "");
  }

  function pathsEqual(a, b) {
    return normalizeBrowsePath(a).toLowerCase() === normalizeBrowsePath(b).toLowerCase();
  }

  function joinBrowsePath(parent, name) {
    var base = normalizeBrowsePath(parent);
    if (!base) {
      return name;
    }
    if (base === "C:") {
      return "C:\\" + name;
    }
    return base + "\\" + name;
  }

  function getNodeChildren(node) {
    var children = node.children ? node.children.slice() : [];
    if (!node.path) {
      return children;
    }
    var created = state.browseCreatedFolders[node.path] || [];
    created.forEach(function (folder, index) {
      var child = browseNode(
        "created-" + node.id + "-" + index,
        folder.name,
        joinBrowsePath(node.path, folder.name),
        "folder",
        null,
        folder.created
      );
      child.isUserCreated = true;
      child.createdParent = node.path;
      child.createdIndex = index;
      children.push(child);
    });
    return children;
  }

  function nodeHasChildren(node) {
    if (node.expandable) {
      return true;
    }
    var children = getNodeChildren(node);
    return children.length > 0;
  }

  function findBrowseNode(nodes, path, ancestors) {
    ancestors = ancestors || [];
    for (var i = 0; i < nodes.length; i++) {
      var node = nodes[i];
      var trail = ancestors.concat(node);
      if (node.path && pathsEqual(node.path, path)) {
        return { node: node, ancestors: ancestors };
      }
      var children = getNodeChildren(node);
      if (children.length) {
        var found = findBrowseNode(children, path, trail);
        if (found) {
          return found;
        }
      }
    }
    return null;
  }

  function ensureExpandedForPath(path) {
    var roots = getBrowseRoots();
    var found = findBrowseNode(roots, path);
    if (!found) {
      return;
    }
    found.ancestors.forEach(function (ancestor) {
      state.browseExpanded[ancestor.id] = true;
    });
    if (found.node.id) {
      state.browseExpanded[found.node.id] = true;
    }
  }

  function setDefaultBrowseExpanded() {
    state.browseExpanded = {
      desktop: true,
      "user-profile": true,
      "profile-appdata": true,
    };
  }

  function getChildNamesForPath(path) {
    var names = [];
    if (pathsEqual(path, "C:\\")) {
      CDRIVE_FOLDERS.forEach(function (folder) {
        names.push(folder.name.toLowerCase());
      });
    } else {
      var roots = getBrowseRoots();
      var found = findBrowseNode(roots, path);
      if (found) {
        getNodeChildren(found.node).forEach(function (child) {
          names.push(child.label.toLowerCase());
        });
      }
    }
    var created = state.browseCreatedFolders[path] || [];
    created.forEach(function (folder) {
      names.push(folder.name.toLowerCase());
    });
    return names;
  }

  function makeBrowseFolder() {
    hideBrowseCtxMenu();
    var parentPath = state.browseSelectionPath;
    if (!parentPath || !/^C:\\/i.test(parentPath)) {
      parentPath = "C:\\";
    }
    if (!state.browseCreatedFolders[parentPath]) {
      state.browseCreatedFolders[parentPath] = [];
    }
    var name = "New folder";
    var existing = getChildNamesForPath(parentPath);
    var counter = 2;
    while (existing.indexOf(name.toLowerCase()) >= 0) {
      name = "New folder (" + counter + ")";
      counter += 1;
    }
    state.browseCreatedFolders[parentPath].push({
      name: name,
      created: new Date().toLocaleString(),
    });
    var newIndex = state.browseCreatedFolders[parentPath].length - 1;
    state.browseRenaming = { parentPath: parentPath, index: newIndex };
    state.browseSelectionPath = joinBrowsePath(parentPath, name);
    ensureExpandedForPath(parentPath);
    renderBrowseTree(true);
  }

  function startBrowseRename(parentPath, index) {
    hideBrowseCtxMenu();
    state.browseRenaming = { parentPath: parentPath, index: index };
    var folder = state.browseCreatedFolders[parentPath][index];
    if (folder) {
      state.browseSelectionPath = joinBrowsePath(parentPath, folder.name);
    }
    renderBrowseTree();
  }

  function commitBrowseRename(parentPath, index, newName) {
    var folders = state.browseCreatedFolders[parentPath];
    if (!folders || !folders[index]) {
      state.browseRenaming = null;
      return;
    }
    var folder = folders[index];
    var oldName = folder.name;
    var trimmed = newName.trim();
    if (!trimmed) {
      state.browseRenaming = null;
      renderBrowseTree();
      return;
    }
    if (trimmed !== oldName) {
      var siblings = getChildNamesForPath(parentPath).filter(function (sibling) {
        return sibling !== oldName.toLowerCase();
      });
      if (siblings.indexOf(trimmed.toLowerCase()) >= 0) {
        state.browseRenaming = null;
        renderBrowseTree();
        return;
      }
      folder.name = trimmed;
      if (pathsEqual(state.browseSelectionPath, joinBrowsePath(parentPath, oldName))) {
        state.browseSelectionPath = joinBrowsePath(parentPath, trimmed);
      }
    }
    state.browseRenaming = null;
    renderBrowseTree();
  }

  function cancelBrowseRename() {
    state.browseRenaming = null;
    renderBrowseTree();
  }

  function isBrowseNodeRenaming(node) {
    if (!state.browseRenaming || !node.isUserCreated) {
      return false;
    }
    return (
      node.createdParent === state.browseRenaming.parentPath &&
      node.createdIndex === state.browseRenaming.index
    );
  }

  function showBrowseCtxMenu(x, y, parentPath, index) {
    var menu = document.getElementById("browseFolderCtxMenu");
    if (!menu) {
      return;
    }
    state.browseCtxTarget = { parentPath: parentPath, index: index };
    menu.hidden = false;
    menu.setAttribute("aria-hidden", "false");
    menu.style.left = Math.min(x, window.innerWidth - 180) + "px";
    menu.style.top = Math.min(y, window.innerHeight - 40) + "px";
  }

  function hideBrowseCtxMenu() {
    var menu = document.getElementById("browseFolderCtxMenu");
    if (menu) {
      menu.hidden = true;
      menu.setAttribute("aria-hidden", "true");
    }
    state.browseCtxTarget = null;
  }

  function openBrowseDialog(target) {
    state.browseTarget = target;
    if (!backdropBrowse) {
      return;
    }
    var currentPath =
      target === "server"
        ? state.serverLocalPath
        : state.installPath.replace(/\\BinMaster 3DVision$/i, "");
    state.browseSelectionPath = currentPath || DEFAULT_SERVER_LOCAL_PATH;
    setDefaultBrowseExpanded();
    ensureExpandedForPath(state.browseSelectionPath);
    state.browseRenaming = null;
    hideBrowseCtxMenu();
    backdropBrowse.classList.add("show");
    backdropBrowse.setAttribute("aria-hidden", "false");
    renderBrowseTree(true);
  }

  function closeBrowseDialog() {
    if (backdropBrowse) {
      backdropBrowse.classList.remove("show");
      backdropBrowse.setAttribute("aria-hidden", "true");
    }
    hideBrowseTooltip();
    hideBrowseCtxMenu();
    state.browseRenaming = null;
  }

  function hideBrowseTooltip() {
    var tip = document.getElementById("browseTooltip");
    if (tip) {
      tip.hidden = true;
    }
  }

  function renderBrowseTree(scrollToSelection) {
    var tree = document.getElementById("browseFolderTree");
    if (!tree) {
      return;
    }
    var scrollTop = tree.scrollTop;
    tree.innerHTML = "";
    var roots = getBrowseRoots();
    roots.forEach(function (node) {
      renderBrowseNode(tree, node, 0);
    });
    requestAnimationFrame(function () {
      if (scrollToSelection) {
        var selected = tree.querySelector(".browse-tree-item--sel");
        if (selected) {
          selected.scrollIntoView({ block: "nearest" });
          return;
        }
      }
      tree.scrollTop = scrollTop;
    });
  }

  function renderBrowseNode(container, node, depth) {
    var children = getNodeChildren(node);
    var hasChildren = nodeHasChildren(node);
    var expanded = !!state.browseExpanded[node.id];
    var selected = node.path && pathsEqual(node.path, state.browseSelectionPath);
    var row = document.createElement("div");
    row.className = "browse-tree-item";
    if (selected) {
      row.classList.add("browse-tree-item--sel");
    }
    row.style.paddingLeft = 6 + depth * 16 + "px";

    var chevron = document.createElement("button");
    chevron.type = "button";
    chevron.className = "browse-tree-chevron";
    if (!hasChildren) {
      chevron.classList.add("browse-tree-chevron--empty");
    } else if (expanded) {
      chevron.classList.add("browse-tree-chevron--open");
    }
    chevron.setAttribute("aria-label", expanded ? "Collapse" : "Expand");
    chevron.addEventListener("click", function (event) {
      event.stopPropagation();
      if (!hasChildren) {
        return;
      }
      state.browseExpanded[node.id] = !expanded;
      renderBrowseTree();
    });

    var icon = document.createElement("span");
    icon.className = "browse-tree-icon browse-tree-icon--" + (BROWSE_ICON[node.icon] || "folder");

    var label = document.createElement("span");
    label.className = "browse-tree-label";
    label.textContent = node.label;

    var renaming = isBrowseNodeRenaming(node);
    if (renaming) {
      row.classList.add("browse-tree-item--renaming");
      if (selected) {
        row.classList.remove("browse-tree-item--sel");
      }
      var renameInput = document.createElement("input");
      renameInput.type = "text";
      renameInput.className = "browse-tree-rename-input";
      renameInput.value = node.label;
      row.appendChild(chevron);
      row.appendChild(icon);
      row.appendChild(renameInput);
      renameInput.addEventListener("click", function (event) {
        event.stopPropagation();
      });
      renameInput.addEventListener("mousedown", function (event) {
        event.stopPropagation();
      });
      renameInput.addEventListener("keydown", function (event) {
        event.stopPropagation();
        if (event.key === "Enter") {
          event.preventDefault();
          commitBrowseRename(node.createdParent, node.createdIndex, renameInput.value);
        } else if (event.key === "Escape") {
          event.preventDefault();
          cancelBrowseRename();
        }
      });
      renameInput.addEventListener("blur", function () {
        commitBrowseRename(node.createdParent, node.createdIndex, renameInput.value);
      });
      requestAnimationFrame(function () {
        renameInput.focus();
        renameInput.select();
      });
    } else {
      row.appendChild(chevron);
      row.appendChild(icon);
      row.appendChild(label);
    }

    if (!renaming) {
      row.addEventListener("click", function () {
        if (node.path) {
          state.browseSelectionPath = node.path;
        }
        if (hasChildren) {
          state.browseExpanded[node.id] = true;
        }
        renderBrowseTree();
      });
    }

    if (node.isUserCreated && !renaming) {
      row.addEventListener("contextmenu", function (event) {
        event.preventDefault();
        event.stopPropagation();
        hideBrowseTooltip();
        if (node.path) {
          state.browseSelectionPath = node.path;
        }
        showBrowseCtxMenu(event.clientX, event.clientY, node.createdParent, node.createdIndex);
        renderBrowseTree();
      });
    }

    if (node.created && !renaming) {
      row.addEventListener("mouseenter", function (event) {
        var tip = document.getElementById("browseTooltip");
        if (!tip) {
          return;
        }
        tip.hidden = false;
        tip.textContent = "Date created: " + node.created;
        tip.style.left = event.clientX + 12 + "px";
        tip.style.top = event.clientY + 12 + "px";
        row.classList.add("browse-tree-item--hover");
      });
      row.addEventListener("mouseleave", function () {
        hideBrowseTooltip();
        row.classList.remove("browse-tree-item--hover");
      });
    }

    container.appendChild(row);

    if (hasChildren && expanded) {
      children.forEach(function (child) {
        renderBrowseNode(container, child, depth + 1);
      });
    }
  }

  function applyBrowseSelection() {
    var path = state.browseSelectionPath;
    if (!path) {
      closeBrowseDialog();
      return;
    }
    if (state.browseTarget === "server") {
      state.serverLocalPath = path;
      var input = document.getElementById("serverPathInput");
      if (input) {
        input.value = path;
      }
    } else if (state.browseTarget === "install") {
      state.installPath = path + "\\BinMaster 3DVision";
      var installInput = document.getElementById("installPathInput");
      if (installInput) {
        installInput.value = state.installPath;
      }
    }
    closeBrowseDialog();
  }

  function wireLangDialog() {
    var okBtn = document.getElementById("installerLangOk");
    var cancelBtn = document.getElementById("installerLangCancel");
    var closeBtn = document.getElementById("installerLangClose");
    var select = document.getElementById("installerLangSelect");

    if (okBtn) {
      okBtn.addEventListener("click", function () {
        if (select) {
          state.language = select.value;
        }
        hideLangDialog();
        showWizard();
      });
    }
    if (cancelBtn) {
      cancelBtn.addEventListener("click", hideLangDialog);
    }
    if (closeBtn) {
      closeBtn.addEventListener("click", hideLangDialog);
    }
  }

  function wireBrowseDialog() {
    var okBtn = document.getElementById("browseFolderOk");
    var cancelBtn = document.getElementById("browseFolderCancel");
    var closeBtn = document.getElementById("browseFolderClose");
    var newBtn = document.getElementById("browseFolderNew");
    var ctxMenu = document.getElementById("browseFolderCtxMenu");

    if (okBtn) {
      okBtn.addEventListener("click", applyBrowseSelection);
    }
    if (cancelBtn) {
      cancelBtn.addEventListener("click", closeBrowseDialog);
    }
    if (closeBtn) {
      closeBtn.addEventListener("click", closeBrowseDialog);
    }
    if (newBtn) {
      newBtn.addEventListener("click", makeBrowseFolder);
    }
    if (ctxMenu) {
      ctxMenu.addEventListener("click", function (event) {
        var btn = event.target.closest("button[data-action]");
        if (!btn || !state.browseCtxTarget) {
          return;
        }
        if (btn.getAttribute("data-action") === "rename") {
          startBrowseRename(state.browseCtxTarget.parentPath, state.browseCtxTarget.index);
        }
      });
    }
    document.addEventListener("click", function (event) {
      if (!ctxMenu || ctxMenu.hidden) {
        return;
      }
      if (!ctxMenu.contains(event.target)) {
        hideBrowseCtxMenu();
      }
    });
  }

  function wireInstallerMessage() {
    var okBtn = document.getElementById("installerMsgOk");
    var closeBtn = document.getElementById("installerMsgClose");

    if (okBtn) {
      okBtn.addEventListener("click", hideInstallerMessage);
    }
    if (closeBtn) {
      closeBtn.addEventListener("click", hideInstallerMessage);
    }
  }

  function wireWizardClose() {
    var closeBtn = document.getElementById("installerWizardClose");
    if (closeBtn) {
      closeBtn.addEventListener("click", cancelInstaller);
    }
  }

  window.startInstaller = function () {
    showLangDialog();
  };

  window.openBrowseFolderDialog = function () {
    openBrowseDialog("server");
  };

  window.onInstallComplete = function (shouldLaunch) {
    if (state.serverComponent && state.runAsService === "service" && typeof window.register3DVisionService === "function") {
      window.register3DVisionService();
    }
    var desktopIcon = document.getElementById("desktopVisionIcon");
    var taskbarBtn = document.getElementById("taskbarBtnVision");
    if (desktopIcon) {
      desktopIcon.hidden = false;
    }
    if (taskbarBtn) {
      taskbarBtn.hidden = false;
    }
    document.body.classList.add("ig-installed");
    if (typeof window.closeFileExplorer === "function") {
      window.closeFileExplorer();
    }
    window.dispatchEvent(
      new CustomEvent("install-guide:install-complete", {
        detail: { runAsService: state.runAsService, shouldLaunch: !!shouldLaunch },
      })
    );
    if (shouldLaunch && typeof window.launchVisionFromDesktop === "function") {
      window.launchVisionFromDesktop();
    }
  };

  wireLangDialog();
  wireBrowseDialog();
  wireInstallerMessage();
  wireWizardClose();
})();
