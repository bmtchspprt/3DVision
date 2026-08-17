import fs from "fs";
import { createRequire } from "module";

function u32(b, i) { return b.readUInt32LE(i); }
function i32(b, i) { return b.readInt32LE(i); }
function u16(b, i) { return b.readUInt16LE(i); }
function f32(b, i) { return b.readFloatLE(i); }
function fract32(x) { return (Number(x) / 2 ** 31) * 1000; }
function arrayToFract(outcome) {
  const n = outcome & 0xffff;
  if (n > 32768) return (65536 - n) / 32768;
  return n / 32768;
}
function readTag(buf, off) {
  let s = "";
  for (let j = 8; j < 19 && buf[off + j]; j++) s += String.fromCharCode(buf[off + j]);
  return s.trim();
}

const file = process.argv[2];
const buf = fs.readFileSync(file);
let p = 16;
const numSeries = i32(buf, 4);
const numBeams = i32(buf, 8);
const stride = i32(buf, 12);
const headers = [];
p = 16;
for (let i = 0; i < numSeries; i++) {
  headers.push({
    data: i32(buf, p),
    length: i32(buf, p + 4),
    tag: readTag(buf, p),
    off: fract32(i32(buf, p + 20)),
    dh: fract32(i32(buf, p + 24)),
    gainOff: i32(buf, p + 28),
  });
  p += 32;
}

function series(beam, hi) {
  const h = headers[hi];
  const dataOff = h.data + beam * stride;
  const gain = f32(buf, h.gainOff + beam * stride);
  const amp = [];
  for (let n = 0; n < h.length; n++) {
    amp.push(arrayToFract(u16(buf, dataOff + n * 2)) * gain);
  }
  const orange = hi === 0 ? fract32(i32(buf, dataOff - 4)) : null;
  return { tag: h.tag, gain, dh: h.dh, orange, amp };
}

const g = series(0, 0);
const t = series(0, 1);
const afe = series(0, 2);
const peak = Math.max(...g.amp);
const bins = [];
for (let m = 0; m < 20; m++) {
  let mx = 0, sum = 0, c = 0;
  for (let i = 0; i < g.amp.length; i++) {
    const h = i * g.dh;
    if (h >= m && h < m + 1) {
      mx = Math.max(mx, g.amp[i]);
      sum += g.amp[i];
      c++;
    }
  }
  bins.push({ m, max: mx, mean: c ? sum / c : 0, peakFrac: peak ? mx / peak : 0 });
}
const nz = g.amp.filter((x) => x > 0).length;
const above10 = g.amp.filter((x) => x > peak * 0.1).length;
const above01 = g.amp.filter((x) => x > peak * 0.01).length;
let lastI = -1;
for (let i = 0; i < g.amp.length; i++) {
  const tv = t.amp[i >> 2] || 0;
  if (g.amp[i] * 1.01 > tv) lastI = i;
}
console.log(JSON.stringify({
  file,
  orange: g.orange,
  gainG: g.gain,
  gainT: t.gain,
  peakG: peak,
  peakT: Math.max(...t.amp),
  peakAfe: Math.max(...afe.amp),
  lastGtT_m: lastI * g.dh,
  nonzero: nz,
  above10pct: above10,
  above1pct: above01,
  n: g.amp.length,
  meterBins0to20: bins,
  gradeHead: g.amp.slice(0, 8),
  gradeAtOrange: g.amp.slice(Math.max(0, Math.round(g.orange / g.dh) - 3), Math.round(g.orange / g.dh) + 5),
}, null, 2));
