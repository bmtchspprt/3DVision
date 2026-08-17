/**
 * Parse a .bm4 grades file using BeamDataParser / HartParserNew rules
 * (decompiled ApplMngr + Parser — decode only, not firmware DSP).
 *
 * Usage: node parse-bm4.mjs <path-to.bm4> [--json out.json]
 *
 * NOTE: Example captures are FORMAT references only — not quality standards.
 */
import fs from "fs";
import path from "path";

function u32(buf, i) {
  return buf.readUInt32LE(i);
}
function i32(buf, i) {
  return buf.readInt32LE(i);
}
function u16(buf, i) {
  return buf.readUInt16LE(i);
}
function f32(buf, i) {
  return buf.readFloatLE(i);
}

/** HartParserNew.ConvertFract32ToSingle */
function fract32ToSingle(x) {
  return (Number(x) / Math.pow(2, 31)) * 1000;
}

/** BeamDataParser.ArrayToFract */
function arrayToFract(outcome) {
  const num = outcome >>> 0;
  // ExtractIntFromString 2 bytes → unsigned then treated as int in ArrayToFract
  const asInt = outcome & 0xffff;
  let n = asInt;
  if (n > 32768) {
    return (65536 - n) / 32768;
  }
  return n / 32768;
}

function readTag(buf, off) {
  let s = "";
  for (let j = 8; j < 19 && off + j < buf.length && buf[off + j] !== 0; j++) {
    s += String.fromCharCode(buf[off + j]);
  }
  return s.trim();
}

function parseBm4(buf, { fastParsing = false, logScale = false } = {}) {
  let p = 0;
  const field0 = u32(buf, p); p += 4; // unused in parser beyond read
  let numSeries = Number(i32(buf, p)); p += 4;
  const numBeams = Number(i32(buf, p)); p += 4;
  const beamStride = Number(i32(buf, p)); p += 4;

  const headersAll = [];
  for (let i = 0; i < numSeries; i++) {
    const base = p;
    headersAll.push({
      Offset_from_fileStart: Number(i32(buf, base)),
      length: Number(i32(buf, base + 4)),
      representation_tag: readTag(buf, base),
      representation_offset: fract32ToSingle(i32(buf, base + 20)),
      representation_resulotion: fract32ToSingle(i32(buf, base + 24)),
      Offset_to_Gain: Number(i32(buf, base + 28)),
      raw: {
        offsetFract: i32(buf, base + 20),
        resFract: i32(buf, base + 24),
      },
    });
    p += 32;
  }

  // PC UI caps series used for charting at 6
  let numSeriesUsed = numSeries;
  if (numSeriesUsed > 6) numSeriesUsed = 6;
  const headers = headersAll.slice(0, numSeriesUsed);

  const unknownAfterHeaders = u32(buf, p); // num8 in parser
  p += 4;
  const afterHeadersPos = p;

  const beams = [];
  const beamsHasData = [];
  const beamLines = [];
  let maxH = 0;

  for (let k = 0; k < numBeams; k++) {
    beamsHasData.push(false);
    const seriesList = [];
    const lines = [];
    beamLines.push(lines);

    for (let i = 0; i < numSeriesUsed; i++) {
      const h = headers[i];
      const dataOff = h.Offset_from_fileStart + k * beamStride;
      const gainOff = h.Offset_to_Gain + k * beamStride;
      const gain = f32(buf, gainOff);
      const pts = [];

      if (i === 0) {
        const measured = fract32ToSingle(i32(buf, dataOff - 4));
        if (measured > maxH) maxH = measured;
        lines.push({ color: "Orange", val: measured, beamIndex: k });
      }

      if (!(gain > 0)) {
        seriesList.push({ tag: h.representation_tag, gain, points: [] });
        continue;
      }

      for (let n = 0; n < h.length; n++) {
        const dist = h.representation_offset + n * h.representation_resulotion;
        if (fastParsing && dist > maxH) break;
        const raw = u16(buf, dataOff + n * 2);
        let amp = arrayToFract(raw) * gain;
        if (i === 0 && amp !== 0) beamsHasData[k] = true;
        if (logScale) {
          if (amp !== 0) amp = Math.log10(amp);
          if (amp < -20) amp = -20;
        }
        pts.push({ h: dist, f: amp, raw });
      }
      seriesList.push({ tag: h.representation_tag, gain, points: pts });
    }
    beams.push(seriesList);
  }

  // Trailer: noise + cyan/black lines (bm4) — best-effort from parser
  let trailer = { noise: null, extraLines: [] };
  let tp = headers[numSeriesUsed - 1].Offset_to_Gain + beamStride * (numBeams - 1) + 8;
  if (tp + 2 < buf.length) {
    const a = u16(buf, tp) - 1;
    tp += 2;
    let b = u16(buf, tp) - 1;
    tp += 2;
    if (a === 8 && b === 11) {
      b += 1;
      const noise = [];
      for (let k = 0; k < numBeams; k++) {
        const row = [];
        for (let w = 0; w < b; w++) {
          row.push(f32(buf, tp));
          tp += 4;
        }
        noise.push(row);
      }
      trailer.noise = { windows: b, beams: noise };
    }
  }

  // Reset to afterHeaders for marker block (parser uses num9)
  // Full marker parse needs num8/num19 — leave summary hooks
  trailer.note =
    "Orange lines parsed per beam. Cyan/Black markers require post-noise block (see BeamDataParser).";

  return {
    meta: {
      fileSize: buf.length,
      field0,
      numSeriesHeaders: numSeries,
      numSeriesUsedByPcUi: numSeriesUsed,
      numBeams,
      beamStride,
      unknownAfterHeaders,
      afterHeadersPos,
      MaxHValue: maxH,
      bVersion4: true,
      qualityNote:
        "FORMAT EXAMPLE ONLY — not a quality reference for echo curves.",
    },
    headersAll,
    headersUsed: headers,
    beamsHasData,
    beamLines,
    beamsSummary: beams.map((seriesList, bi) => ({
      beamIndex: bi,
      hasData: beamsHasData[bi],
      orangeM: beamLines[bi][0] ? beamLines[bi][0].val : null,
      series: seriesList.map((s) => ({
        tag: s.tag,
        gain: s.gain,
        samples: s.points.length,
        maxF: s.points.reduce((m, p) => Math.max(m, p.f), 0),
        maxH: s.points.length ? s.points[s.points.length - 1].h : 0,
      })),
    })),
    trailer,
    // keep full sample arrays optional via flag
    beams,
  };
}

function main() {
  const args = process.argv.slice(2);
  if (!args[0]) {
    console.error("Usage: node parse-bm4.mjs <file.bm4> [--json out.json] [--full]");
    process.exit(1);
  }
  const file = args[0];
  const full = args.includes("--full");
  const ji = args.indexOf("--json");
  const jsonOut = ji >= 0 ? args[ji + 1] : null;

  const buf = fs.readFileSync(file);
  const parsed = parseBm4(buf);
  if (!full) delete parsed.beams;

  const text = JSON.stringify(parsed, null, 2);
  if (jsonOut) {
    fs.writeFileSync(jsonOut, text);
    console.log("wrote", jsonOut);
  }
  console.log(
    JSON.stringify(
      {
        meta: parsed.meta,
        headersUsed: parsed.headersUsed,
        beamsHasData: parsed.beamsHasData,
        beamsSummary: parsed.beamsSummary,
      },
      null,
      2
    )
  );
}

main();
