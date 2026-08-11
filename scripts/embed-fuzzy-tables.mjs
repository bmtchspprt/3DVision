import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const base = path.join(ROOT, "data", "FuzzyTables");
const outPath = path.join(ROOT, "js", "locator", "fuzzy-tables.js");

const map = {
  "Fuzzy_Dome.xml": "Dome",
  "Fuzzy_SF.xml": "SF",
  "Fuzzy_SFCenterSECenter.xml": "SFCenterSECenter",
  "Fuzzy_SFCenterSENoCenter.xml": "SFCenterSENoCenter",
  "Fuzzy_SFNoCenterSECenter.xml": "SFNoCenterSECenter",
  "Fuzzy_SFNoCenterSENoCenter.xml": "SFNoCenterSENoCenter",
  "Fuzzy_NoSymAndCons.xml": "NoSymAndCons",
  "Fuzzy_MFSECenter.xml": "MFSECenter",
  "Fuzzy_MFSENoCenter.xml": "MFSENoCenter",
};

let out =
  "(function (global) {\n" +
  '  "use strict";\n' +
  "  var NS = global.LocatorPlacement = global.LocatorPlacement || {};\n" +
  "  var FM = NS.FuzzyManager;\n" +
  "  if (!FM) return;\n" +
  "  FM.FuzzyTableXmlByType = FM.FuzzyTableXmlByType || {};\n" +
  "  var T = FM.FuzzyTableXmlByType;\n";

for (const [file, type] of Object.entries(map)) {
  const xml = fs.readFileSync(path.join(base, file), "utf8");
  out += "  T." + type + " = " + JSON.stringify(xml) + ";\n";
}
out +=
  '})(typeof self !== "undefined" ? self : (typeof globalThis !== "undefined" ? globalThis : this));\n';

fs.writeFileSync(outPath, out);
console.log("Wrote", outPath, "(" + out.length + " bytes)");
