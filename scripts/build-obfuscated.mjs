/**
 * Pack Install Guide into a single obfuscated HTML for distribution.
 * - Inlines CSS (minified) with assets as data URIs
 * - Embeds assets in a runtime map; rewrites paths in HTML
 * - Obfuscates app JS (three.min.js prepended as-is)
 * - Writes dist/index.html
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import JavaScriptObfuscator from "javascript-obfuscator";
import CleanCSS from "clean-css";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const DIST = path.join(ROOT, "dist");

const CSS_FILES = [
  "css/styles.css",
  "css/desktop.css",
  "css/ebob-backdrop.css",
  "css/ebob-filechooser.css",
  "css/ebob-services.css",
  "css/ebob-startmenu.css",
  "css/ebob-uac.css",
  "css/installer.css",
  "css/multivision.css",
  "css/browser.css",
  "css/install-guide.css",
];

const JS_LOCATOR = [
  "js/locator/constants.js",
  "js/locator/defs.js",
  "js/locator/balls.js",
  "js/locator/matrix.js",
  "js/locator/algo-error-estimation.js",
  "js/locator/geometry.js",
  "js/locator/fuzzy.js",
  "js/locator/fuzzy-tables.js",
  "js/locator/search-radius.js",
  "js/locator/error-estimation-calc.js",
  "js/locator/error-estimation.js",
  "js/locator/vessel-adapter.js",
  "js/locator/exhaustive-search.js",
  "js/locator/placement-full-flow.js",
  "js/locator/placement-api.js",
];

const JS_APP = [
  "js/mv-overview-3d.js",
  "js/mv-wizard-3d.js",
  ...JS_LOCATOR,
  "js/desktop.js",
  "js/startmenu.js",
  "js/filechooser.js",
  "js/uac.js",
  "js/services.js",
  "js/installer.js",
  "js/browser.js",
  "js/multivision.js",
  "js/mv-echo-beams.js",
  "js/mv-dialogs.js",
  "js/mv-menus.js",
  "js/app.js",
  "js/install-guide.js",
];

const THREE = "js/vendor/three.min.js";

const MIME = {
  ".png": "image/png",
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".gif": "image/gif",
  ".svg": "image/svg+xml",
  ".ico": "image/x-icon",
  ".bmp": "image/bmp",
  ".webp": "image/webp",
};

function read(rel) {
  return fs.readFileSync(path.join(ROOT, rel), "utf8");
}

function exists(rel) {
  return fs.existsSync(path.join(ROOT, rel));
}

function normalizeAssetPath(p) {
  return p.replace(/\\/g, "/").replace(/^\.\.\//, "").replace(/^\.\//, "");
}

function toDataUri(absPath) {
  const ext = path.extname(absPath).toLowerCase();
  const mime = MIME[ext] || "application/octet-stream";
  const buf = fs.readFileSync(absPath);
  return `data:${mime};base64,${buf.toString("base64")}`;
}

function collectPathsFromText(text) {
  const found = new Set();
  const re =
    /(?:\.\.\/)?assets\/[A-Za-z0-9_./\-]+\.(?:png|jpg|jpeg|gif|svg|ico|bmp|webp|PNG|JPG|JPEG|GIF|SVG|ICO)/g;
  let m;
  while ((m = re.exec(text))) {
    found.add(normalizeAssetPath(m[0]));
  }
  return found;
}

function expandAssetConcat(js) {
  // Handles both clean ASSET + 'file.png' and the panel HTML form:
  // ASSET + 'led_small_green.png" alt="" ...>'
  return js.replace(
    /ASSET\s*\+\s*'([^']*)'/g,
    (_, rest) => {
      const m = rest.match(
        /^([A-Za-z0-9_.-]+\.(?:png|jpe?g|gif|svg|ico|PNG|JPG|JPEG|GIF|SVG|ICO))([\s\S]*)$/
      );
      if (!m) {
        return `"assets/images/multivision/" + '${rest.replace(/\\/g, "\\\\").replace(/'/g, "\\'")}'`;
      }
      const file = m[1];
      const tail = m[2];
      if (!tail) {
        return `"assets/images/multivision/${file}"`;
      }
      return (
        `"assets/images/multivision/${file}" + '` +
        tail.replace(/\\/g, "\\\\").replace(/'/g, "\\'") +
        `'`
      );
    }
  ).replace(
    /ASSET\s*\+\s*"([^"]*)"/g,
    (_, rest) => {
      const m = rest.match(
        /^([A-Za-z0-9_.-]+\.(?:png|jpe?g|gif|svg|ico|PNG|JPG|JPEG|GIF|SVG|ICO))([\s\S]*)$/
      );
      if (!m) {
        return `"assets/images/multivision/" + ${JSON.stringify(rest)}`;
      }
      if (!m[2]) {
        return `"assets/images/multivision/${m[1]}"`;
      }
      return `"assets/images/multivision/${m[1]}" + ${JSON.stringify(m[2])}`;
    }
  );
}

function rewriteCssUrls(css, cssRel, assetMap) {
  const cssDir = path.dirname(path.join(ROOT, cssRel));
  return css.replace(/url\(\s*(['"]?)([^'")]+)\1\s*\)/g, (full, q, raw) => {
    if (raw.startsWith("data:") || raw.startsWith("http")) return full;
    const resolved = path.normalize(path.join(cssDir, raw));
    const rel = path.relative(ROOT, resolved).replace(/\\/g, "/");
    if (!rel.startsWith("assets/")) return full;
    if (!assetMap[rel]) {
      if (exists(rel)) assetMap[rel] = toDataUri(path.join(ROOT, rel));
      else {
        console.warn("  missing css asset:", rel);
        return full;
      }
    }
    return `url(${assetMap[rel]})`;
  });
}

function replaceHtmlAssets(html, assetMap) {
  const keys = Object.keys(assetMap).sort((a, b) => b.length - a.length);
  let out = html;
  for (const key of keys) {
    const esc = key.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    out = out.replace(new RegExp(esc, "g"), () => assetMap[key]);
  }
  return out;
}

function stripHtmlHeadLinksAndScripts(html) {
  let body = html;
  body = body.replace(/<link\s+rel=["']stylesheet["'][^>]*>\s*/gi, "");
  body = body.replace(/<script\b[^>]*src=["'][^"']+["'][^>]*>\s*<\/script>\s*/gi, "");
  return body;
}

/** Runtime shim: rewrite asset paths used by JS to embedded data URIs. */
function buildAssetRuntime(assetMap) {
  const json = JSON.stringify(assetMap);
  return `
(function(){
  var __AM = ${json};
  function __resolve(u) {
    if (!u || typeof u !== "string") return u;
    if (u.indexOf("data:") === 0 || u.indexOf("blob:") === 0 || u.indexOf("http") === 0) return u;
    if (__AM[u]) return __AM[u];
    return u;
  }
  function __rewriteHtml(html) {
    if (!html || typeof html !== "string" || html.indexOf("assets/") < 0) return html;
    return html.replace(/assets\\/[A-Za-z0-9_./\\-]+\\.(?:png|jpg|jpeg|gif|svg|ico|bmp|webp|PNG|JPG|JPEG|GIF|SVG|ICO)/g, function (m) {
      return __AM[m] || m;
    });
  }
  var imgDesc = Object.getOwnPropertyDescriptor(HTMLImageElement.prototype, "src");
  if (imgDesc && imgDesc.set) {
    Object.defineProperty(HTMLImageElement.prototype, "src", {
      configurable: true,
      enumerable: true,
      get: function () { return imgDesc.get.call(this); },
      set: function (v) { imgDesc.set.call(this, __resolve(v)); }
    });
  }
  var setAttr = Element.prototype.setAttribute;
  Element.prototype.setAttribute = function (name, value) {
    var n = name ? String(name).toLowerCase() : "";
    if ((n === "src" || n === "href") && typeof value === "string") {
      value = __resolve(value);
    }
    return setAttr.call(this, name, value);
  };
  function patchHtmlProp(proto, prop) {
    var d = Object.getOwnPropertyDescriptor(proto, prop);
    if (!d || !d.set) return;
    Object.defineProperty(proto, prop, {
      configurable: true,
      enumerable: d.enumerable,
      get: d.get ? function () { return d.get.call(this); } : undefined,
      set: function (v) { d.set.call(this, __rewriteHtml(v)); }
    });
  }
  patchHtmlProp(Element.prototype, "innerHTML");
  if (typeof HTMLElement !== "undefined") patchHtmlProp(HTMLElement.prototype, "outerHTML");
  var iah = Element.prototype.insertAdjacentHTML;
  if (iah) {
    Element.prototype.insertAdjacentHTML = function (pos, html) {
      return iah.call(this, pos, __rewriteHtml(html));
    };
  }
  var origSetProperty = CSSStyleDeclaration.prototype.setProperty;
  CSSStyleDeclaration.prototype.setProperty = function (name, value, priority) {
    if (typeof value === "string" && value.indexOf("assets/") >= 0) {
      value = __rewriteHtml(value);
    }
    return origSetProperty.call(this, name, value, priority);
  };
  window.__resolveAsset = __resolve;
})();
`;
}

async function main() {
  console.log("Building obfuscated single-file dist…");
  fs.mkdirSync(DIST, { recursive: true });

  let html = read("index.html");

  // Collect asset paths from sources
  let appJs = JS_APP.map((rel) => `;\n/* ${rel} */\n` + expandAssetConcat(read(rel))).join(
    "\n"
  );

  const pathSet = new Set();
  for (const p of collectPathsFromText(html)) pathSet.add(p);
  for (const p of collectPathsFromText(appJs)) pathSet.add(p);
  for (const rel of CSS_FILES) {
    for (const p of collectPathsFromText(read(rel))) pathSet.add(p);
  }

  const extras = [
    "assets/images/logo_icon.ico",
    "assets/images/logoBinMaster.PNG",
    "assets/images/apm_logo.png",
    "assets/images/bg_login.png",
    "assets/images/ImagesBin/WizardLogo.JPG",
    "assets/images/multivision/led_small_green.png",
    "assets/images/multivision/led_small_gray.png",
    "assets/images/multivision/led_large_green.png",
    "assets/images/multivision/led_large_gray.png",
    "assets/images/multivision/icon_level.png",
    "assets/images/multivision/icon_distance.png",
    "assets/images/multivision/icon_new_project.png",
    "assets/images/multivision/icon_recent_project.png",
    "assets/images/multivision/info-icon-Basic.png",
    "assets/desktop/chromium-icon.svg",
    "assets/desktop/folder-icon.svg",
    "assets/desktop/network-tray-icon.svg",
  ];
  extras.forEach((p) => pathSet.add(p));

  const assetMap = {};
  let embedded = 0;
  let embeddedBytes = 0;
  for (const rel of pathSet) {
    if (!exists(rel)) {
      console.warn("  skip missing:", rel);
      continue;
    }
    const abs = path.join(ROOT, rel);
    assetMap[rel] = toDataUri(abs);
    embedded += 1;
    embeddedBytes += fs.statSync(abs).size;
  }
  console.log(
    `Embedded ${embedded} assets (${(embeddedBytes / 1024 / 1024).toFixed(2)} MB raw)`
  );

  // CSS: inline with data URIs
  let cssBundle = "";
  for (const rel of CSS_FILES) {
    cssBundle += `/* ${rel} */\n` + rewriteCssUrls(read(rel), rel, assetMap) + "\n";
  }
  const minCss = new CleanCSS({ level: 1 }).minify(cssBundle);
  if (minCss.errors?.length) console.warn("CSS minify warnings:", minCss.errors);
  cssBundle = minCss.styles || cssBundle;

  // HTML: bake assets as data URIs (attributes only; safe in HTML)
  html = replaceHtmlAssets(html, assetMap);
  html = stripHtmlHeadLinksAndScripts(html);

  console.log("Obfuscating application JavaScript…");
  // Keep original asset path strings in JS; runtime map resolves them.
  const obfuscated = JavaScriptObfuscator.obfuscate(appJs, {
    compact: true,
    controlFlowFlattening: true,
    controlFlowFlatteningThreshold: 0.55,
    deadCodeInjection: true,
    deadCodeInjectionThreshold: 0.12,
    debugProtection: false,
    disableConsoleOutput: false,
    identifierNamesGenerator: "hexadecimal",
    renameGlobals: false,
    selfDefending: false,
    stringArray: true,
    stringArrayEncoding: ["base64"],
    stringArrayThreshold: 0.75,
    transformObjectKeys: true,
    unicodeEscapeSequence: false,
    splitStrings: false,
  }).getObfuscatedCode();

  const threeJs = read(THREE);
  const assetRuntime = buildAssetRuntime(assetMap);
  const finalScript =
    "/* assets */\n" +
    assetRuntime +
    "\n/* three.js */\n" +
    threeJs +
    "\n/* app (obfuscated) */\n" +
    obfuscated;

  html = html.replace(
    "</head>",
    `  <style>\n${cssBundle}\n  </style>\n</head>`
  );
  html = html.replace(
    "</body>",
    `  <script>\n${finalScript}\n  </script>\n</body>`
  );

  const outFile = path.join(DIST, "index.html");
  fs.writeFileSync(outFile, html, "utf8");
  const outSize = fs.statSync(outFile).size;

  // Copy locator worker + modules so Calculate can run off the main thread when Pages
  // serves the folder (single-file HTML falls back to sync via placement-api).
  const locDist = path.join(DIST, "js", "locator");
  fs.mkdirSync(locDist, { recursive: true });
  for (const rel of [
    ...JS_LOCATOR.filter((r) => !r.endsWith("placement-api.js")),
    "js/locator/placement-worker.js",
  ]) {
    const name = path.basename(rel);
    fs.copyFileSync(path.join(ROOT, rel), path.join(locDist, name));
  }
  const fuzzyDist = path.join(DIST, "data", "FuzzyTables");
  fs.mkdirSync(fuzzyDist, { recursive: true });
  const fuzzySrc = path.join(ROOT, "data", "FuzzyTables");
  if (fs.existsSync(fuzzySrc)) {
    for (const f of fs.readdirSync(fuzzySrc)) {
      fs.copyFileSync(path.join(fuzzySrc, f), path.join(fuzzyDist, f));
    }
  }

  // Keep dist/ free of README/BUILD sidecars.
  for (const extra of ["README.md", "BUILD.txt"]) {
    const p = path.join(DIST, extra);
    if (fs.existsSync(p)) fs.unlinkSync(p);
  }

  console.log(`Wrote ${outFile} (${(outSize / 1024 / 1024).toFixed(2)} MB)`);
  console.log("Also copied js/locator/ + data/FuzzyTables/ for worker Calculate.");
  console.log("Upload dist/ to GitHub / GitHub Pages.");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
