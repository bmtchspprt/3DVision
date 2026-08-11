/**
 * Smoke-test Locator placement full flow (Node).
 * Usage: node scripts/smoke-locator-placement.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import vm from "vm";
import { parseFuzzyXml } from "./tiny-fuzzy-dom.mjs";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");

function DOMParser() {}
DOMParser.prototype.parseFromString = function (xml) {
  return parseFuzzyXml(xml);
};

const files = [
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
];

const sandbox = {
  console,
  Math,
  Date,
  Array,
  Object,
  Number,
  String,
  Boolean,
  Error,
  parseFloat,
  parseInt,
  isNaN,
  Infinity,
  NaN,
  JSON,
  DOMParser,
  self: null,
  window: null,
  globalThis: null,
};
sandbox.self = sandbox;
sandbox.window = sandbox;
sandbox.globalThis = sandbox;

const ctx = vm.createContext(sandbox);
for (const rel of files) {
  const code = fs.readFileSync(path.join(ROOT, rel), "utf8");
  vm.runInContext(code, ctx, { filename: rel });
}

const LP = sandbox.LocatorPlacement;
if (!LP || !LP.runPlacementFullFlow) {
  console.error("LocatorPlacement.runPlacementFullFlow missing");
  process.exit(1);
}

const vessel = LP.createVessel({
  topShape: "flat",
  topH: 0,
  topD: 0,
  centerShape: "cylinder",
  centerH: 10,
  centerD: 12,
  bottomShape: "flat",
  bottomH: 0,
  fillPoints: [{ x: 0, y: 0 }],
});

console.log("Running placement (1 scanner only for smoke)…");
const t0 = Date.now();
const result = LP.runPlacementFullFlow({
  vessel,
  fillPoints: [{ x: 0, y: 0 }],
  numScanners: 1,
  maxScanners: 1,
  allSteps: true,
  onProgress: function (p) {
    if (p.current && p.total && p.current % 50 === 0) {
      process.stdout.write(".");
    }
  },
});
console.log("\nDone in", ((Date.now() - t0) / 1000).toFixed(1), "s");
console.log(
  JSON.stringify(
    {
      numScanners: result.numScanners,
      maxError: result.maxError,
      scanners: result.scanners,
    },
    null,
    2
  )
);
if (!result.scanners || !result.scanners.length) {
  console.error("No scanners returned");
  process.exit(1);
}
console.log("OK");
