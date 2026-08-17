# HANDOFF — 3DLevelScanner firmware math recovery (read this first)

**Local notes in this repo** (`3DInstallGuide/docs/firmware/`). Start at
`../RESEARCH-CLOSED.md`. Do **not** edit the emulator remake. Do **not** put this
math into `js/` / `css/` / `dist/` unless asked this turn. Do **not** publish
Pages for note-only work.

**Audience: the next AI/agent picking up this work. Everything needed to continue is here or linked from here.**

## MISSION

Recover the **exact firmware-level math** of the BinMaster 3DLevelScanner (firmware
`3DLevelScannerM_4_5_452.ldr`, Blackfin ADSP-BF53x) for four areas:

1. **Echo / Grade curve calculation** — how the 5242-point amplitude curve ("Grade graph")
   is produced from raw ADC samples.
2. **Distance calculation** — how a bin index becomes a physical distance (m/mm), so a
   customer's measured distance-to-material can be compared against a `.bm4` recording.
3. **False Signal Suppression** (called **False Echo Mapping** in the 3D Vision software) —
   the firmware math that builds and applies the false-echo map.
4. **Advanced Parameters** — every parameter in the software's Advanced Parameters dialog
   (Dampening, Auto Beams, Max Capacity, Maximal Scanned Distance, MinimalSnr, CRAF*, etc.):
   where it lands in firmware and what math consumes it.

**Why:** support troubleshooting — given a `.bm4` file plus a customer's physical distance
measurement, we want to recompute exactly what the scanner computed and see why it reported
what it reported. End use is a faithful emulation (`buildBeamData` in the 3D Emulator remake).

**Hard rule:** no invented math. A formula ships only when proven from the firmware image
(static disassembly/decompile) and/or executed in the Blackfin simulator. See
`CERTAINTY.md` for the gate.

## WHERE THINGS LIVE

Paths are under `3DInstallGuide/docs/firmware/` unless noted.

| What | Path |
|---|---|
| This doc | `notes/HANDOFF.md` |
| **Finished research (read this)** | `../RESEARCH-CLOSED.md` |
| Certainty gate / proven-fact log | `CERTAINTY.md` |
| Grade pipeline | `DSP-GRADE.md` |
| Full boot map | `FULLMAP.md` |
| Instruction dumps (text) | `../evidence/dumps/` |
| Sim traces + scripts | `../evidence/traces/` |
| `.bm4` series layout | `BM4-FORMAT.md` |
| `.bm4` decode script | `parse-bm4.mjs` |

Not copied (large, unused by any app): Ghidra project, `fullmap/*.bin` sim images, `.ldr`. Re-running the Blackfin sim needs those; reading proven math does not.

Key decompiled sources for parameters/wire formats:
- `decompiled/locator/Data/TDLM/Data/Scanner/Advanced.cs` — base advanced params (HART cmd **172**)
- `decompiled/locator/Data/TDLM/Data/Scanner/Advanced173.cs` — extended advanced params (HART cmd **174**)
- `decompiled/locator/Packer/TDLM/Packer/HartPacker.cs` — exact byte packing of cmds 172/174/187
- `decompiled/locator/Parser/TDLM/Parser/HartParserNew.cs` — cmd 111/112 (grades export), 151 (false echo)
- `decompiled/locator/TDLMServerClientWrapper/TDML/ServerCommon/FalseEchoMappingData.cs`, `GradesData.cs`
- `decompiled/locator/ApplMngr/TDLM/ApplMngr/BeamDataParser.cs` — `.bm4` series headers, Orange line, axis fract32

## SCOPE SPLIT — echo math vs quality decisions

**Proven (Grade / echo curve generation):** pulse compression → 5242-point Grade at
`beam+0x44`. That is *how amplitudes are painted*.

**Not the same thing:** *how the product judges a curve* (good/bad), *which peak is
material*, *what Orange/reported distance means*, and *what to suppress as false echo*.
Pick, Orange, and map-in-pick are closed in `RESEARCH-CLOSED.md`. Do **not** brand a
false-echo recommender as firmware-faithful: pick does not apply maps.

**What can ship earlier (honest labeling):** a heuristic BM4 scorer using series already
in the file + optional customer tape distance (PC axis from `BM4-FORMAT.md`). Useful for
support; not a claim that FW would score the same way.

**Status (F18):** Support mission is **closed** — `RESEARCH-CLOSED.md`. Mix `a` is uninit (do not replay mix). Damping is not a metres IIR. T rewrite is the windowed walk (not `T[i]=f(Grade)`); neighbor mix uses AFE via `[FP−0x38]`. Maps do not skip this pick. ADC→Grade paint is `DSP-GRADE.md`, not the Install Guide.

## PROVEN MATH (consolidated)

### A. Grade curve pipeline (pulse compression) — PROVEN, see session doc

ADC DMA → L1 re/im `0xFF9000C0/0xFF9020C0` → **FFT fwd** (`0xFFA06688`, full butterfly math
recovered) → **matched filter** (`0xFFA05A56`: `X[k]·conj(Ref[k])` in place, `>>16`) →
**FFT inv** → **magnitude** (`0xFFA05CA0`: `sqrt(re²+im²)` per bin, float) → normalize →
int16 series at **`beam+0x44`**.

- Beam struct: `ctx + 0x578 + idx*0x5CFC`. Per-beam int16 series (matches BM4 tags in L1
  strings `@0xFF802EC8`):
  | Offset | Tag (L1 / BM4) | Length (int16) | Notes |
  |---|---|---|---|
  | `+0x44` | Grade | **5242** | echo curve |
  | `+0x2938` | Threshold | **1310** | `0x2938 = 0x44 + 2×5242` |
  | `+0x4D5C` | **AFE** | **655** (`0x51E` bytes) | Auto False Echo; memset + emit twin of Threshold |
  | `+0x5798` | **False E.** | **327** (`0x28E` bytes) | User False Echo |
  | `+0x5A26` | (327 twin) | **327** | back-to-back with `+0x5798`; flags/working copy — semantics OPEN |
  Float scales @ `+0x5CD4/+0x5CD8` (+`0x5CF0/0x5CF4`).
- FFT sizes per band: log2N = **10/10/11/12/12** (N=1024/1024/2048/4096/4096), field
  `hw+0x5774`; twiddle table `0xFF800100` = `round(sin(2πk/4096)·32767)`; bit-reversal
  index shift `[hw+0x577C] = 12 − log2N`. **Byte-exact verified in simulator (t38).**
- Chirp reference spectrum precompute: `0x202ecec8`; ref at `hw+0x1770`.
- Export/read path: `float = int16 · scale(beam+0x5CD4)` (convert-twin `0x20212bae`);
  HART export (`0x2021ffe4`) scales int16 × `32768.0f` etc. into float payloads (cmds 111/112).
- Grade/Threshold lengths: `([ctx+0x584] >>> 15)+1` / `>>> 17)+1`.

### B. Sin/cos table generator (chirp synthesis) — PROVEN 2026-08-06 (t45b clean disasm)

`0x202ec5de…`: loop k=0..N−1: `θ = acc·(2π·step)` (`2π = 0x40C90FDB`), two float tables
written via soft-float sin/cos at **`0xffa020d4`** and **`0xffa00da4`** (`[P4++]=f(θ)`,
`[P1++]=g(θ)`), `acc += [FP-0x4]`. Tables land at ~`0x202eb1e0..0x202ec6e3` — **this RAM
overlaps the generator's own init code tail** (reclaimed after one-time init). Consequence:
the simulator SIGILLs executing the overwritten tail — expected, not a bug in our harness.
`P4 = 0x202eaddc` is a second table base (`0x202ec732`).

### C. Soft-float library map — CORRECTED 2026-08-06 (t35/t46/t50 disasm)

| Address | Identity | How confirmed |
|---|---|---|
| `0xffa01688` | `__floatsisf` (int32→float) | t35 |
| `0xffa016d4` | `__floatunsisf` (uint32→float) | t35 |
| `0xffa01716` | `__addsf3` (float add; entry `0xffa01714` same fn) | t46: exponent-align + mantissa add |
| `0xffa01814` | **`__divsf3`** | t35: **subtracts** exponents, +127; x/x→1.0 shortcut |
| `0xffa018f0` | **`__mulsf3`** | t46: **adds** exponents, −127; 32×32 mantissa multiply |
| `0xffa014dc` | `__fixsfsi` (float→int32, sat at exp≥158) | t50 |
| `0xffa028c8` | float→**fract32 (Q31)**, saturating | t46: mantissa shift exp−119 |
| `0xffa0290c` | float→fract16/Q15 variant (shift exp−143) | t46 tail |
| `0xffa0248c` | **rsqrt** — 256-byte seed table `0xff80349c` + 3 Newton iters vs `0x30000000` (1.5 in Q29); ~1e-4 rel. error | t46 |
| `0xffa020d4`, `0xffa00da4` | sin/cos (soft-float, used by table generator) | t45b call pattern |
| `0xffa0165c`, `0xffa01630` | float compares (`__lesf2`/`__gesf2` family) | t47 call pattern |
| `0xffa01c74` | **`powf` / `__powsf3`** (`x^y`) | t35: 0^0→1.0, sign/inf specials, log/exp table `0xff80359c`; Ghidra `hot_ffa01c74.c` |

**Correction:** earlier notes said "normalize = value/41000 via `0xffa018f0`". `0xffa018f0`
is **multiply** — recheck any formula that used it as divide (FUN_ffa05ee4 semantics).

### D. Distance / range math — formula PROVEN, input semantics OPEN

- Bin conversion (`FUN_ffa0586c`): **`bin = (range_fixed × band_scale) >> 32`** (32×32→hi32,
  i.e. Q31/Q32 fixed multiply; loads scale from `[cfg+0x4EC]`).
- Band scale computation (function containing `0x2020f9dc…0x2020fb7a`; stores at
  `0x2020faf8 / 0x2020fb04 / 0x2020fb6e`):
  ```
  n_mm       = int(param_float × 1000.0f)          ; -> [cfg+0x4E0]; [cfg+0x4DC] tracks max
  band_scale = fract32_sat( 331.2998f / 1000.0f * rsqrt(n_mm × 273118.6f + 1.0f) )  ; -> [cfg+0x4EC]
  ```
  Constants: `331.2998f = 0x43A5A666` (**speed of sound at 0 °C**, m/s),
  `273118.6f = 0x48855FC0`, `1000.0f = 0x447A0000`.
  **Verified numerically in-sim (t54):** with n_mm forced to 0 the whole chain returns
  `0x2A6809C0` = Q31(0.3312998 × rsqrt(1.0)≈1.00008) — exact match of the formula shape.
- `param_float` comes from a table search over float entries **`{0.25f, 1.0f, 200.0f}`**
  (built on stack at `0x2020f9dc`, loop with early exit) driven by a ratio computed from a
  float param struct at **`0x20214ff4`** (`[P3],[P3+4],[P3+8],[P3+C],[P3+14]`); that ratio
  involves `999424.0f = 0x49740000` and `10.0f` compares.
- **Scale values per anchor** (from the proven formula, computed):
  | anchor | n_mm | sqrt(n·K+1) | band_scale (Q31) |
  |---|---|---|---|
  | 0.25 m | 250 | 8 263 | **86 083** |
  | 1.0 m | 1 000 | 16 533 | **43 043** |
  | 200 m | 200 000 | 233 718 | **3 044** |
- **Temperature calibration context** (same function, `0x2020f8c6..0x2020f9d0`): sums
  **10 × 12-bit ADC reads** (`W[I0++] & 0xFFF`, via `CALL 0x20205d42`), averages
  (`CALL 0xffa01038` with R1=10), keeps signed-12-bit, compares vs calibration word at
  **`0xff802d34`** (L1 data) → flag byte at **`0xff900000`**. Then
  `ratio = (3·norm(4096, adc) · [P3+4]) / (([P3+0x14] + 3·norm) · [P3])` — a
  resistor-divider/NTC-style temperature→voltage formula (4096 = 12-bit full scale, 3 ≈
  reference). This ties the band scale to the **temperature channel** — consistent with
  speed-of-sound compensation (`FixedTemperatureForMeasurements` is the manual override).
- Acquisition window min/max seen as Q28 meters: **0.64 / 0.638** at `0x2021ea84/0x2021ea88`.

**Scale consumers (fn_20213000, static):**
- `0x202136b0`: computes **`≈59.0 × band_scale`** (48-bit fixed multiplier `R6:R0` =
  59 − 9.5e-7), then **×10** → `[P3+0x38]`; `max(([P0+0x14]>>>17)−1, …)<<17` → `[P3+0x10]`;
  only on path where byte `[P1+0x2a] == 100` (percent dispatch, <100 / ==100 / >100 split).
- `0x202136ec`: `FUN_ffa05ee4(6, 0x1194=4500)` normalize, then `CALL FUN_ffa0586c`
  (range→bin) with `R1=[FP-0x54]`; result **`>>> 17`** → `W[P3+0xC]`.
- `(bin>>17 × byte[P0+0x2B]) ÷ 3` via magic **`0x55555556`** (÷3) chain.
- Range constant **`5242×1023 = 5 362 566`** (`0x51E786`-family at `0x20213028/0x2021303a`):
  `max(R6, (R7 − 5 359 494)>>18)` — links the 5242-point curve to a Q18 range value.
- **OPEN:** exact `range_fixed` format into `FUN_ffa0586c` (Q28-meters candidate:
  0.64 m ↔ `0x0A3D70A4`; but >>17 scaling at consumers suggests Q17-ish bin indexes);
  what the 59.0 multiplier is physically; mapping of bins → 5242 displayed points;
  which anchor (0.25/1.0/200) is selected per band in practice; temperature-comp site of c.

### E. Advanced Parameters (software side — COMPLETE, byte-exact wire layouts)

Byte offsets below are payload byte index (after the length byte). Floats are IEEE-754 LE,
appended via `AppendFloat`. Source: `HartPacker.cs` `PackCommand172/174/187`.

**HART cmd 172 — `Advanced` (length byte 30):**
| Off | Field | Type |
|---|---|---|
| 0 | MechanicsType | byte (0=Type1,1=Type2) |
| 1 | ActivateExtrapolation | byte (0/2) |
| 2–5 | UserFalseEchoesSensitivity | float |
| 6 | GradesFilter | byte |
| 7 | MinSnrEndFirstWindow | byte |
| 8 | MinSnrBlockingDistance | byte |
| 9 | TopDeadBandDiscard | byte (0/1) |
| 10 | RestrainCoefficient | byte |
| 11 | FirstTimeActivation | byte (0/1) |
| 12–15 | RTimeGradesWatermarkLevel | float |
| 16 | RRateGradesWatermarkPercent | byte |
| 17–20 | MaxEmptyingRate | float |
| 21–24 | MaxFillingRate | float |
| 25–28 | **MaxCapacity** | float |
| 29 | ExceedingFillingRateAfterEchoLoss | byte (0/1) |

**HART cmd 174 — `Advanced173` (length byte 34):**
| Off | Field | Type |
|---|---|---|
| 0 | ElectronicSwivelingHolder | byte (0/1) |
| 1–4 | STBeamTheta | float |
| 5–8 | MaximalSiloHeight | float |
| 9 | SiloType | byte |
| 10 | **MinimalSnr** | byte |
| 11 | CRAFSensitivity | byte |
| 12 | CRAFWidth | byte |
| 13 | beam-direction mask | byte: bit5=30°, bit4=90°, bit3=150°, bit2=210°, bit1=270°, bit0=330° |
| 14 | DistancePowerDependency | byte |
| 15 | FixedTemperatureForMeasurements | byte |
| 16 | auto-range + freq mask | byte: bit3=FreqHigh, bit2=FreqMed, bit1=FreqLow, bit0=**AutoBeamRange** (ListBeamAuto[3]) |
| 17 | DelayAfterEchoLoss | byte |
| 18 | false-echo + auto-beam mask | byte: bit4=**UseFalseEchoes**, bit3=**AutoFalseEchoes**, bit2..0=ListBeamAuto[0..2] |
| 19 | SwivelingHolderAngle | byte |
| 20 | AntennaBitPhaseDiff | byte |
| 21 | SoftDecisionDump | byte |
| 22 | SoftDecisionNegativeValues | byte |
| 23 | RatioLimits min/max | byte (two packed ints) |
| 24–27 | **TrackFilterDampingFactor** (Dampening) | float |
| 28 | TransmissionPower | byte (0=Auto,1=High,2=Med,3=Low) |
| 29 | RMinimalSNR | byte |
| 30–33 | **MaximalScannedDistance** | float (meters) |

**HART cmd 187 — `MappingParams` (length byte 32):**
| Off | Field | Type |
|---|---|---|
| 0 | MinimalEchoSNR | byte |
| 1 | MinimalDirSNR | byte |
| 2 | MaxMappedEchoes | byte |
| 3 | ThetaResolution | byte |
| 4 | PhiResolution | byte |
| 5 | MusicRestrainCoef | byte |
| 6 | AngularFilter | byte |
| 7–10 | ThetaToleranceFromSiloWall | float |
| 11–14 | ThetaToleranceHysteresis | float |
| 15–18 | PhiToleranceHysteresis | float |
| 19–22 | **AutoFalseEchoesSensitivity** | float |
| 23–26 | SideMargins | float |
| 27–30 | BottomMargins | float |
| 31 | 0 (pad) | byte |

**Firmware consumers of cmd 172/174/187:** landings + the gates in F11/F15 (SNR byte, CRAF==13,
UseFalseEchoes copy, Scan `w/=3`, DistancePowerDependency on `12A64`, damping **copy**).
No jump-table cmd number scan. Remaining fields have no pick math in this image.

### E2. HART cmd 151 — False Echo Mapping **wire layout PROVEN** (PC packer)

Source: `HartPacker.PackCommand151`. Length byte **16**. Payload after length:

| Off | Field |
|---|---|
| 0–3 | **FalseEchoTo** (float, meters) |
| 4 | **action opcode** (see below — *not* the C# enum ordinal) |
| 5 | mapping-start flag: `0` if `MappingStarted`, else `1` |
| 6–9 | **FalseEchoFrom** (float, meters) |
| 10–13 | **FalseEchoThreshold** (float; amplitude units) |
| 14–15 | beam mask: `0xFFFF` = all beams; else bit per internal beam index |

**Action opcodes actually put on the wire** (`switch` in packer — firmware numbers):

| Opcode | UI action | Payload zeros |
|---|---|---|
| **4** | Scan (auto map) | Threshold forced `0` |
| **5** | Reset user **and** auto | From=To=Threshold=`0` |
| **6** | ManualScan | From/To/Threshold all sent |
| **7** | Reset user only | From=To=Threshold=`0` |
| **8** | Reset auto only | From=To=Threshold=`0` |

C# enum ordinals (0=Scan … 4=ResetAuto) are **UI only**; do not search firmware for 0–4.

PC already has a ManualScan path from the echo chart: zoom-rectangle → From/To from X
range, Threshold from Y max (clamped 1000…500000) → cmd 151 opcode 6
(`ViewBeamsMain.ActivateFalseEchoWindowMinMax`).

Parse side (`ParseCommand151`) only watches HART response codes **33/34** = in-flow,
then Completed — no map payload comes back on 151.

### F. False Signal Suppression / False Echo Mapping — layout PINNED, apply math open

**BM4 / PC axis (proven in `docs/grades/BM4-FORMAT.md`, example file) — not yet proven
identical to FW bin→meters:** ~**80 m** full span. Steps (example):

| Series | N | Δh (m) | N×Δh | vs Grade |
|---|---|---|---|---|
| Grade | 5242 | ≈0.01526 | ~80 | 1× |
| Threshold | 1310 | ≈0.0610 | ~80 | ÷4 |
| AFE | 655 | ≈0.122 | ~80 | ÷8 |
| False E. | 327 | ≈0.244 | ~80 | ÷16 |

So user/auto maps are **the same range window as Grade, coarsely sampled**. Sample i on
False E. ≈ Grade index `i×16` (within a few bins; 327×16=5232 vs 5242).

**Firmware series (see table in §A):** AFE `@+0x4D5C` (655), User False E. `@+0x5798` (327),
twin `@+0x5A26` (327). Emit `0xffa04766..0xffa047c4` exports both 327 series × float scales.

**Fill/quantize (user map):**
- `0xffa04dec`: `fract16(float ÷ scale)` → `W[beam+0x5A26+2i]`.
- Scan orchestrator after `acquire`: `0x202246f0` — first sample **`0x7FFF`** (Q15 +1.0),
  then LC=`0x146` loop: `int16→float` (`0xffa01688`) × **R7** (`mulsf3`) → `fixsfsi`
  (`0xffa014dc`) → `STORE W [P4 ++ P3]`. OPEN: R7/P3 meaning (in-place rescale vs copy).
- `[FP+0x28]==7` branch: 327-loop **AND vs a table** (`R4 = R0 & R3`) — per-bin flags.

**Peak / accept (partial, not full pick formula):** `0xFFA038E2` walks Grade (`P3=0x44`)
and Threshold (`P4=0x2938`) with stride `0x5CFC`, converts via `0xffa02948` × scales, extra
× **`1.01f`** (`0x3F8147AE`), then float compares (incl. vs −Inf `0xFF800000`). Callers
`0x20212F1C`, `0x2022DB02`. See **F4** for last_i → Orange packing and that this helper
does **not** read maps.

**Distance-power compensation (partial):** `FUN_20212a64` (ends `0x20212b30`):
- Gate byte **`B[P5+0x30]`** — candidate **DistancePowerDependency** (cmd 174 off 14).
- Piecewise on range vs `[P4+0x528]` / `[P4+0x52c]`; offset `+0x20C49B`;
  `powf(ratio, 1.5f | 2.0f | 1.0f)` via `0xffa01c74`; × `[P4+0x530]` / `[P4+0x534]`;
  also `×1000.0f` paths. OPEN: exact range units into R0; confirm P5+0x30 is the HART byte.

### F2. Formulas (math, not just offsets) — mixed proven / reconstructed

**Bin ↔ meters (PC / `.bm4` axis — use this until FW `range_fixed` is closed):**

```
h(i) = offset + i × (1000 / 65536)     // meters, Grade i = 0..5241
```

Threshold / AFE / False E. sample `j` lines up with Grade `floor(j × 5242 / N)`.

**Peak helper `0xFFA038E2` (proven loop shape):**

```
G = int16_to_float(Grade[i]) × scale_G × 1.01
T = int16_to_float(Threshold[i>>2]) × scale_T
if G > T (and finite):  acc += G²;  last_i = i
return rsqrt(acc / uint16[hw+0x5770])     // 0xffa0248c; divisor is NOT sample count
optional store last_i                     // farthest bin above threshold
```

Correction vs earlier F2 note: accumulator is **G²**, not (G−T)².

**Distance-power (proven `FUN_20212a64`):**
`K = 0x20C49B`. `d` = DistancePowerDependency byte. `r` = range integer.

```
if d == 0:
  if r <= T0:     gain = (fixed_to_float(r+K) × 1000)²
  elif r <= T1:   gain = ((r+K)/(T0+K))^1.5 × s1
  else:           gain = ((r+K)/(T1+K))^1.0 × s2
else:
  gain = (fixed_to_float(r+K) × 1000)^(d/2)
```

**Cmd 151 ManualScan (proven wire):** fill user map bins whose `h` ∈ [From, To] with amplitude ≥ Threshold.

**AFE Scan build (reconstructed, not CERTAINTY):** empty-vessel Grade block-max onto 655 bins × AutoFalseEchoesSensitivity.
**F9/F10 supersede that reconstruction for the Scan→`8F4C`→`4D5C` path.** Do not use the reconstructed line as math.

**Apply (reconstructed, not CERTAINTY):** pick ignores bins with `G ≤ max(AFE, UserFalseE)` when those maps are enabled. Displayed Grade is not zeroed (maps are separate series).

**Dampening (UI-proven unit = meters; FW consumer OPEN):** track gate `[prev−D, prev+D]` then slew-limit `|Δ| ≤ D`. Implemented in `js/fw-echo-math.js` (Install Guide).

### F3. Open-item progress (2026-08-17) — additive; details in CERTAINTY addendum

- **Lengths from one `range` word:** `n_G=(r>>15)+1`, `n_T=(r>>17)+1`, `n_AFE=(r>>18)+1`.
- **Thresh/AFE int16:** `float_to_i16(f / scale)` at `0x20214350` / `0x202143c6` (same as Grade emit). Float *source* still the magnitude/convert buffers.
- **AFE `0x20224492`:** `memset(+0x4D5C, 0, 0x51E)` — clear, not Scan build.
- **`0x20214ff4` ratio** selects 0.25/1/200 **m** anchors for `n_mm` (range bands). 331.3 is c(0 °C) in that scale, not yet patched by the NTC ratio at `0x2020f8c6`.
- **DMA:** wait `0xFFA06008` / `0xFF806EE0`; dest L1 `0xFF9000C0`/`0xFF9020C0`. Channel poke still open.
- **Maps `0x20204044`:** flash persist AFE/user records (`0x522`/`0x292` bytes), not apply.

### F4. Threshold / Orange / maps (2026-08-17, additive)

**Threshold float buffer `0x20215060+0x51E8`:** written by convert-twin at `0x20212CD4` —
`T_float[j] = int16_to_float(beam+0x2938[j]) × scale`. **`0x2021F97A` does not write it**
(magnitude → `ctx+0x4EB08` Grade floats only). Emit `0x20214350` is the reverse:
`beam+0x2938[j] = float_to_i16(T_float[j]/scale)`. `0x20213A26` / `0x20214496` **zero**
Threshold. **Still OPEN:** first-time T floats from Grade (no downsample writer found).

**Peak callers → Orange:**

- `0xFFA038E2` stores `last_i` to the int16 out-pointer (caller `P3+0x8a` from `0x20212F1C`).
  Second pointer `P3+0x88` gets the second-pass index. `0x2022DB02` passes **null** out
  pointers (quality path); stack `0.1f` is an extra G scale on that call, not damping.
- After `0x20212F1C`: `last_i << 15` mixed with `beam+0x3c` range word; AFE-bin
  `last_i>>3` stored at workobj−4; later `<< 18` restores **`last_i << 15`**.
- PC Orange: `metres = (fract32 / 2^31) × 1000`. If fract32 = `last_i << 15`, that is
  **exactly** `last_i × (1000/65536)` — same as the BM4 Grade axis. Packer byte copy
  into `GradeDataOff−4` still not walked in `0x202B5066`.
- Accept gate `0x2020F27C` is a **predicate** (5242×1023 compare), not a metres convert.
- Range→bin at `0xffa04844`: `FUN_ffa05ee4(W[…], 41000)` then `FUN_ffa0586c`; mode 7
  does `>>19`. Window fract32 ≡ BM4 80 m axis (**F5**); `ffa05c38` returns a 0..11
  **slot**, not Grade `last_i`.

**Map sites `0x2020421e` / `0x20204634`:** `memcpy`/`memset` of `beam+0x5A26` (`0x28E`
bytes) via `0xFFA05F92` / `0xFFA05F2E` inside persist `FUN_20204044`. **Not pick-apply.**
`0xFFA038E2` never loads `+0x5798` / `+0x5A26`. Convert/export of maps is `0x20212E50`
and `0xFFA047AC` (plus AutoFalseEchoesSensitivity byte `+0x521` divide-by-3.0 when 0).
Apply (skip / clip Grade / raise T) **still OPEN**.

**Fix recommendation (guide, labeled heuristic):** last G>T runs closer than Orange →
cmd **151 opcode 6** From/To/Threshold. Do not claim firmware apply until OPEN 3.

### F5. Acquire windows, 41000, cmd 174 dest, AFE Scan (2026-08-17, additive)

**Fract32 metres (same as BM4 Orange / axis):** `m = (x / 2^31) × 1000`. Constant
`0x0A3D70A3` ≈ **80 m** (not Q28 0.64 m — that was a misread of the same bits).
`last_i << 15` for i≈5242 lands on the same 80 m. Tape vs Orange on the PC axis is
therefore the same encoding the unit uses for acquire **From/To clamps**.

**Acquire `FUN_20220636` `param_6` = cmd-151 opcode:**
- **4 or 5:** From/To = `*(param_7+8/+0xc) − *(param_2+0x18)`, clamp to `0x0A3570A3`;
  then `FUN_ffa05c38(From)` / `FUN_ffa05c38(To)`.
- **7:** To-clamp `0x0A3570A3`, From = `*(param_2+0x68)`.
- **6:** copy 10 words from `param_5+0xb17a` (ManualScan side path).
- Inner 4/5 body after the window is **not** AFE fill. Ghidra C `halt_unimplemented`
  is a parallel-issue truncate. Asm: skip beams whose bit is clear in
  `packet+0x14` (`(1<<beam_i) & mask`), then the same `FUN_20210be6` /
  `FUN_ffa05c38` path as other opcodes. See **F6**.
- `0x20224492` remains memset-clear of AFE; `0x202246f0` is **user-map** rescale at
  `+0x5A26` (`÷1000` of `beam+0x5cf8`, first sample `0x7FFF`), after opcode 7.

**`FUN_ffa05ee4(a, 41000)`:** signed integer magnitude ratio / Q-split (not float÷41000).
**`FUN_ffa05c38(window, ctx)`:** walk ≤12 ladder slots:
`bin = ffa0586c( ffa05ee4(hw+0x57c0, 41000) + acc[ctx+0x548] )` until `window <= bin`;
**returns slot index 0..11**, not Grade `last_i`. Do not equate that index with Orange.

**L1 emit after Grade (`0xFFA04B90`):** next loops write `beam+0x3374` and `+0x3DB0` at
`>>18` length (655), **not** Threshold `+0x2938`. Threshold int16 still only the SDRAM
emit/zero/convert round-trip. **T-from-Grade first fill remains OPEN.**

**Cmd 174 RAM dest (unpack `0x202B683E`, not the compare math):**
`dest+0x2C/0x2D/0x2E` ← bytes at src `+0x8/+0x9/+0xA` (MinimalSnr / CRAFSensitivity /
CRAFWidth **candidates**). `dest+0x58` bit4 = **UseFalseEchoes**; if set `dest+0x24 =
[src+0x4]`, else 0. Peak helper still does not test these. Damping float consumer still
OPEN (`0x202130B0` MAC is a separate Q15 mix, not metres IIR).

### F6. Cmd-151 Scan sequence and AFE envelope (2026-08-17, additive)

**Handler `0x20224400` (not the C dump):** if start-flag `e8+3`: for each selected
beam, `memset(beam+0x4D5C, 0, 0x51E)`. If `e8+2`: write From/To on the cmd object.
Then memset user False E `+0x5798` (`0x28E`) for selected beams. If mask `e8+0x14`
nonzero: **3×** `FUN_20220636` opcode **4**, then opcode **5**, then opcode **7**,
then per-beam rescale of twin `+0x5A26`, then persist `FUN_20204044`.

**`FUN_2022e118`:** opcodes 4, 5, and 7 share the window setup then
`FUN_2022d6dc` (Grade window at `beam+0x44`, length cap `0x1100`) and
`FUN_ffa0467e`.

**`FUN_ffa0467e` envelope (opcodes 3/4/5 join at `0xFFA04F6E`):**
- Grade/window index **`>> 3`** → 655-bin plane (second plane at **`+0xA3C`**
  bytes = 655 floats).
- `0xFFA0165C` float compare; `IF CC` keep the other arg → **running max** of
  plane0, plane1, and a per-beam scratch float.
- When the `>>3` bin **changes**: mix with **8.0f** (`0x41000000`), `rsqrt`
  (`0xFFA0248C`), add/div into the plane, copy to `+0xA3C`. Exact RMS algebra
  not reduced to one line yet — do not ship that blend as CERTAINTY math.
- Opcode **5** (and **7**) also convert int16 maps `+0x5A26` / `+0x5798` to
  floats (327 pts) at the top of this function; opcode **4** skips that convert.
- AutoFalseEchoesSensitivity still at `ctx+0x521` (÷3.0f when 0).

**Float dest (layout proven, corrected F8/F9):** Scan IIR writes `@0x20215060+0x6660/+0x709C/+0x7AD8`
(mid twins). AFE export floats are `+0x8F4C`. Int16 emit `0x202143C6` reads `+0x8F4C` → `beam+0x4D5C`.

**Still OPEN:** T walker closed form; mix addend; SNR/CRAF **curve** compare; damping metres IIR.
Map **pick-apply** is closed-negative (F14): peak never loads maps.

### F7. Scan bin-change mix (2026-08-17, additive)

Float arena `@0x20215060` has a **third** 655-float plane at **`+0x7AD8`**
(`+0x709C + 0xA3C`). `0xFFA0467E` keeps that pointer at `FP−0x50`.

**Weight `w`:** `w = uint32_to_float(uint16[obj+0x46])` (`0xFFA016D4`). If
`ctx+0x521` (AutoFalseEchoesSensitivity) is **0**, `w = w / 3.0f`. Stored at
work `+0x1c`. Opcode 4 Scan zeros Threshold on the **wire**; this `w` is not
that Threshold float.

**Same `>>3` bin:** max of L1 scratch `0xFF804918[beam]` vs `0xFF8048D0[beam]`
into `0x4918` (`0xFFA0165C`; CC keep → max if compare is ≥).

**Bin change** (`0xFFA050E0`…`0xFFA051BC`), `α = 8·w`:

```
aux[prev] = α * aux[prev]
j = (L1 0xFF8048AC[beam]) >> 3
aux[j] = aux[j] + rsqrt(|L1 0xFF804918[beam]|)
aux[j] = aux[j] / (α + 1)
plane1[j] = plane0[j]
plane0[j] = L1 0xFF804918[beam]
```

`plane0/1` = `+0x6660` / `+0x709C`. One-pole smooth of `aux` plus scratch onto
plane0. **F8:** those slots are the float twins of mid series `+0x3374/+0x3892/+0x3DB0`,
not the AFE export buffer `+0x8F4C`. Emit `0x202143C6` reads `+0x8F4C`.

### F8. Float-arena map, AFE emit src, Threshold walker (2026-08-17, additive)

**Same function `FUN_20212BAE` … `0x2021441C`:** int16→float convert, then later
float→int16 emit. `FP−0x38` is set to **`@0x20215060+0x8F4C`** (`0x20212DBC`) and
is **not** overwritten before AFE emit `0x202143C6`. Emit is `fdiv`/`float_to_i16`
of **`+0x8F4C`** into `beam+0x4D5C` (count `(range>>18)+1`). Reverse convert:
`beam+0x4D5C` → `+0x8F4C` (`0x20212DE0`). First word at `+0x8F4C` also gets
`1000.0f` before a 655-pt max (`0x202142B4`).

**`FUN_2022D05E`:** after Grade `+0x44` → arena `+0`:

| Float offset | Int16 source | Count |
|--------------|--------------|-------|
| `+0x6660` | `beam+0x3374` | 655 (`>>18`) |
| `+0x709C` | `beam+0x3892` | 655 |
| `+0x7AD8` | `beam+0x3DB0` | 655 |

F6/F7 Scan IIR **reuses** those three slots. F9: Scan emit `+0x3DB0` then `FUN_20212BAE`
writes `+0x8F4C` and emits `beam+0x4D5C`.

False E. convert: `+0x8514` ← `beam+0x5798` (327). Twin `+0x5A26` rescale after
opcode 7 is unchanged (F5).

**Threshold:** emit `0x20214350` reads `+0x51E8`. Zero fill `0x20213A26` writes
`beam+0x2938` (`>>17`). Grade-float walker `0x2021380E`…: `rsqrt` + `fadd` into
work `+0x2C`/`+0x38`; windows use `range>>17` and **`ctx+0x2B`**. Not max-of-4.
Cmd-174 MinimalSnr **byte** at `dest+0x2C` is not this float.

**Still not in pick:** maps, SNR/CRAF bytes, damping metres. `ffa05c38` still 0..11.

### F9. Scan aux → AFE float writes (2026-08-17, additive)

Scan IIR emit in `0xFFA0467E`: `+0x6660`→`beam+0x3374`, `+0x709C`→`+0x3892`,
`+0x7AD8`→`+0x3DB0` (`ffa04c32` / `ffa04c74` / `ffa04ce8`). No `0x4D5C` store there.

`FUN_20212BAE` after `4D5C`→`8F4C` convert:

- `0x2021320C` loads int16 **`beam+0x3DB0`** (Scan aux).
- `0x20213350` `STORE` into `8F4C[i]` (add/mul/add/div; `[FP−0x3c]` source OPEN).
- `0x202133A6` / `0x20213462`: Grade-float vs `8F4C[i>>3]` **max**, `STORE` `0x202133E8` / `0x202134B8`.

Then emit `0x202143C6` writes that buffer to `beam+0x4D5C`. Persist `FUN_20204044` copies RAM AFE (`parent+0x52D4`) to flash; it does not build it.

This is **not** proven as the peak-pick map apply (`0xFFA038E2` still only Grade/T).

### F10. `12BAE` order, `0xFFA02948`, T float store site (2026-08-17, additive)

**Same function, call order (not a pick formula):**

1. Convert Grade / T / AFE / False E. int16 → arena floats.
2. `CALL 0xFFA038E2` at `0x20212F1C` (Grade vs Threshold peak).
3. AFE `8F4C` mix/`>>3` max (`0x20213350` / `0x202133E8` / `0x202134B8`).
4. Zero T floats `I0=FP−0x50` (`+0x51E8`) then zero T int16 (`0x20213A02` / `0x20213A26`).
5. Loop `0x20213A66`…`0x20214200`: `STORE [P1]=R3` at `0x202141D0` with `P0=+0x51E8`.
6. `memset` tail of T floats (`0x20214220` / `0x2021424A`, `0xFFA05F2E`).
7. T emit `0x20214350`; AFE emit `0x202143C6`.

Peak on this call therefore uses **T/AFE already in RAM**, not the T/AFE this function writes afterward.

**`0xFFA02948`:** if R0==0 return 0; else abs, `signbits`, exp `0x87−shift`, pack float (`ffa02948.asm`). Peak and the `+0x3DB0` gate use this, not `0xFFA01688`.

**`0xFFA01714`:** same function as `0xFFA01716` (`__addsf3`). Not a subtract. `0x20213350` chain is add / mul / add / div then store; `[FP−0x3c]` at first mix is **not** stored earlier in this function’s dump — mix not one-lined.

**T loop** uses `mulsf3` by **`1.2f` (`0x3F99999A`)** (`0x202140C0`). Closed T sample formula still OPEN (F12).

### F11. Peak aux read, MinimalSnr/CRAF byte gates (2026-08-17, additive)

**After** `0x2022DB02` peak: if the `R1==5` path is taken, load int16
`beam+0x3DB0[(W[..]>>3)]`, `0xFFA02948`, `× beam+0x5CE4`, `STORE` at `obj+0x58`
(`site_2022da20.asm` `0x2022DB88`…`0x2022DBD6`). This is Scan **aux**, not `+0x4D5C`.
Not a proven skip/clip of Grade vs AFE.

**MinimalSnr** RAM byte `dest+0x2c`: `B[root+0x74+0x2c]`; if `> 0` then return `1`
(`int16_to_float_2d05e.asm` `0x2022D01C`…`0x2022D028`). Not a Grade-SNR compare.

**CRAF** bytes `dest+0x2d` / `+0x2e`: compare each to **13**; mismatch jumps
`0x20225C0E` (`dig_outer_acquire_fill_loops.txt` `0x20224A66`…`0x20224A7A`).
Not a CRAF-width filter on the curve.

Peak `last_i` stores: `STORE W` to out-pointers at `0xFFA03AE8` / `0xFFA03C34`
(`l1_ffa038e2_147a.asm`). Acc still `G×G` then `rsqrt(acc / uint16[hw+0x5770])`.

**Still not proven:** T closed form (more pieces in F13); mix **addend**; AFE/`5798` **apply**
in pick; damping **IIR**; remaining Adv Params consumers.

### F13. Orange `last_i<<15`, live `586c` input, T `/4` `/2` (2026-08-17, additive)

Sim `t58` (`../evidence/traces/trace_t58_disasm.txt`) + `g_20220260.asm` / `l1_05c40.asm`.

**Orange word (encoding closed):** at `0x20220628`…`0x2022062C` (in `FUN_2021FFE4`, called
from acquire `0x20221262`):

```
R2 = int16 [P0]
R2 <<= 15
STORE [P2 − 4] = R2
```

PC Orange is fract32→m: `(x/2^31)×1000`. So **`Orange_m = last_i × (1000/65536)`** (offset 0).
That is the same Δh the packer writes at `file+0x28` (`0x8000`). Grade samples sit at
`file+0x5BC`, so `dataOff−4 = 0x5B8` is this word **when the file is filled from this
export buffer**. Header fill `0x202B51E0` does not store it; this acquire/export path does.

Gates before the store: `|W[P2]−W[P0]| < 20`, both words `> 20`, and a count vs 5 (`0x202205EC`…).
Do not treat every peak as Orange — only this gated path writes the word.

**Live `FUN_ffa0586c` input (not the BM4 axis):** at `0x2022405E`…`0x20224084`:

```
x = FUN_ffa05ee4( [hw + 0x57c0], 41000 )
bin = FUN_ffa0586c( x + acc, R7 )
STORE [P4 + 0x10] = bin
```

Same shape as ladder `0xFFA05C38` (F5). `hw+0x57c0` is an **integer accumulator** updated
from DMA desc spans: `57c0 += ([desc+0x14] − [desc+0x1c] − 1) × [desc+0x8]` (`0x20210ED2`…
`0x20210EE6`). That is sample/pointer math, **not** tape metres. Tape vs **Orange/Grade
index** uses F13/F12 (`last_i × 1000/65536`). Do not use `586c` as the tape formula.

**Threshold extra ops (still not T[i]=):** after the `rsqrt` windows: `÷ 4.0f`
(`0x40800000` at `0x20213D8A`), linear mix of neighbor Grade floats (`0x20213DDC`…
`0x20213E22`), then `÷ 2.0f` (`BITSET bit30` = `0x40000000` at `0x20213E80`). Then the
F12 `×1.2f` / `0.25f` select into `+0x51E8`. Window also uses `ctx+0x2B` as
`((work+0x10)×byte) / 2` (`0x20213C5C`…`0x20213C6A`). Not proven as CRAFWidth.

**Damping / maps / mix addend:** unchanged from F12.

### F14. Pick tree complete; map apply is not in pick (2026-08-17, additive)

Image sites already dumped: `l1_ffa038e2_147a.asm`, `fn_20213000.asm`, `dump_147a_l1.txt` (`0x2020F27C`), `ffa0467e_full.asm`, unpack `trace_t55_disasm.txt`. No new sim run.

**Peak `0xFFA038E2` (the pick math):**

- Lengths: Grade walk `(range>>15)`, Threshold length field `(range>>17)` at work `+0x4`.
- Pointers: Grade `beam+0x44`, Threshold `beam+0x2938`. Scales `beam+0x5CD4` / `+0x5CD8`.
- Per sample: `G = floatsisf(Grade[i]) × scale_G × 1.01f` (`0x3F8147AE` at `0xFFA0395C`).
  `T = floatsisf(T[i>>2]) × scale_T`. Soft-float `>` via `0xFFA01714` then IEEE compare.
- If `G>T`: `acc += G×G` (`0xFFA018F0` then `0xFFA01716` at `0xFFA03ACE`…`0xFFA03AD8`); keep `last_i`.
- Else skip. Return `rsqrt(acc / uint16[hw+0x5770])`. Out-pointer `STORE W last_i`.
- Callers: **only** `0x20212F1C` (`FUN_20212BAE`) and `0x2022DB02`. Neither loads AFE/`5798`/`4D5C`.

**After peak in `FUN_20212BAE` (accept / mix, not a second pick):**

- `FUN_2020F27C(R0,R1)`: if `[R1+0x744C]<=0` return 0; else byte `[table+0x10]` vs `B[R0−0x3EA]`; then
  `CC = ([R1+0x744C]+0x51EB86) < [R0−0x3E0]`. If that returns nonzero and `[ctx+0x4FC20] > 0x51EB86`,
  `last_i = max(last_i, (val−0x51EB86)>>18)` and `STORE 6.0f` (`0x40C00000`) at the work slot (`w_20213000.c`).
- Reject (`JUMP 0x202146D8`) if `[obj+0x5C]` is 0 / Inf / sign-bit, or `last_i < R5`.
- If accepted: `STORE B [obj+0x60]=1`; `FUN_ffa05C38` slot (0..11, not Grade index); AFE mix into `8F4C`
  from Scan aux `beam+0x3DB0`; then T rewrite + emit. Mix uses `[FP−0x3C]` **before** that slot is stored
  in this function (first store `0x20213FEA` in the T loop). Do not invent addend=0.

**Scan `0xFFA0467E` loop `0xFFA049D4`:** float max across mid planes `+0x6660/+0x709C/+0x7AD8`
(`FP−0x4C/−0x54/−0x50`). That is **not** Grade vs user False E. False E convert to `+0x8514` is
export/IIR input, not pick.

**UseFalseEchoes:** unpack bit4; if set `dest+0x24=[rx+0x4]` else 0 (`0x202B680E`…`0x202B6824`).
Peak does not read `dest+0x24`. No Grade-compare consumer of that word is pinned.

**Damping:** `2022E876` reads `P3+0x58` into a 3D direction/MAC path (sin/cos + Q15). Acquire also
`STORE [P5+0x58]` from `ffa0586c` **bin** (`0x20221AA2`). Same offset, different objects. Not a
metres IIR on TrackFilterDampingFactor.

**What “why it reported X” is, from this image:**

1. Walk Grade vs Threshold; last index with `G>T` is `last_i`.
2. If post-peak gates pass and Orange export runs: **`X_m = last_i × (1000/65536)`** (F13).
3. AFE/False E series in the file are **not** inputs to that walk. They are built/stored/exported
   separately (Scan + `12BAE` max/mix + persist).

### F15. Mission closeout — remaining logic from the image (2026-08-17, additive)

No new sim. Same dumps as F12–F14 plus Grade emit `f2i_ffa04baa.asm` and `dig_20224500_full.txt`.

**Grade int16 (item 6):** `0xFFA04B90`: `count=(range>>15)+1`; `v=float_to_i16(grade_f[i] / scale)` (`fdiv` `0xFFA01814` then `0xFFA0290C`); `STORE W beam+0x44+2i`. Proven.

**Tape vs file (items 1, 9, 10):** use `h = last_i × (1000/65536)` m. Live `ffa0586c` is DMA/window integer math, not the tape axis. Stop treating `range_fixed` as the recording formula.

**Threshold rewrite (item 2) — operations, not `T[i]=`:** zero T int16 (`0x20213A26`); loop `0x20213A66`…`0x202141D0` while `i ≤ min((range>>17), 0x51D)`:
window from `ctx+0x2B` and `work+0x10`; `rsqrt` into `work+0x2C`; neighbor Grade interp; `÷4.0f`; `÷2.0f`; `×1.2f`; select vs `0.25f`; `STORE` T float `+0x51E8`; tail `memset`; emit int16. That **is** the T logic. A single closed `T[i]=f(G)` is not in the image.

**AFE mix addend:** `8F4C[i] = ((f + a) × 8F4C[i] + work+0x94) / f` with `f=floatsisf(aux+1)×[work+0x4]`. `a=[FP−0x3C]` has **no store** before the first mix (`LINK 0x6C` local). First store of that slot is the T loop (`0x20213FEA`). Do not invent `a=0`. Formula is complete; `a` is not defined by this function.

**User-map twin `+0x5A26`:** after Scan, `0x202246F0`: first sample `0x7FFF`; then `fixsfsi(floatsisf(W)×R7)` in place (`R7` from the compare just above, stored `[P5+0x4]`). Persist copies AFE; this loop rescales the 327 twin. Opcode **6** ManualScan is From/To/Threshold **window copy**, not a Grade clip in pick.

**UseFalseEchoes `dest+0x24`:** unpack store only (`0x202B6824`). `0x202B69DA` `[P1+0x24]>>>1` is a **different** object (integer halves into `P5+0x3C/+0x40` with `+0x20`). No Grade compare of unpack `dest+0x24` in the dumps.

**Damping (item 4):** `[rx+0x28]→adv+0x1C→obj+0x58`. `2022E876` uses a `+0x58` in 3D direction MAC. Acquire writes `ffa0586c` **bin** to another `+0x58`. No `new = old + d·(new−old)` on metres.

**Adv Params (item 5) — consumers that exist:**

| Field | What firmware does |
|---|---|
| MinimalSnr `dest+0x2C` | if `>0` predicate return 1 (not Grade-SNR) |
| CRAF `+0x2D/+0x2E` | compare to **13** (jump, not curve width) |
| UseFalseEchoes bit4 | copy `[rx+0x4]` or 0 → `dest+0x24` |
| AutoFalseEchoes bit3 / sensitivity `ctx+0x521` | Scan weight `w/=3` when 0 |
| DistancePowerDependency `B[+0x30]` | gate on `FUN_20212A64` pow path |
| Damping float | copy to `+0x1C` / `+0x58` only |
| Other 172/174/187 fields | landings; no pick math |

**False-echo recommend:** not in this image’s pick. Heuristic From/To on the file axis stays labeled heuristic.

**`buildBeamData` (item 7):** **not the Install Guide.** Document here only.

### F16. Mix `a`, damping MAC, maps vs pick (2026-08-17, additive)

**Mix addend:** `LOAD R1=[FP−0x3C]` at `0x2021330C` then `f+a`. No `STORE [FP−0x3C]` from `LINK` through that load. Next stores are the T loop (`0x20213FEA`). `a` is an uninitialized local, not a firmware constant. Do not ship `a=0`.

**Damping:** `0x2022F752` `MAC` of `[P3+0x58]` × a spatial delta, then `ffa05ee4`. Same family as `2022E876` (sin/cos + Q15). Not `orange := old + d·(new−old)`.

**Maps vs pick:** T rewrite `0x20213A66`…`0x202141D0` does not load `8F4C`/`4D5C`/`5798`. Opcode 6 fills the user-map **series** and acquire window words; it does not make the peak helper skip bins. “FW would suppress this peak” from maps is **false** for pick.

Do not edit Install Guide JS for this.

### F17. Mix `k`, synthesis spec (2026-08-17, additive)

Store catalog `dig_20212c_float_convert_chain.txt` `0x20212BAE`…`0x20212F1C`: every `STORE [FP+…]` before peak. **None** are `[FP−0x3C]`. GDB `trace_t55` mix is `R1=[FP−0x3C]` then `addsf3`. `a` is leftover stack, not a parameter.

**Mix (AFE floats `8F4C`), when the accept path runs:**

```
k starts 0                    // STORE [P5+0x94]=0 at 0x20213148
k = max(k, 8F4C[window])      // 0x2021319A…0x202131E4
f = floatsisf(aux+1) × [work+0x4]
8F4C[i] = ((f + a) × 8F4C[i] + k) / f
```

Then Grade vs AFE `i>>3` **max** into `8F4C` (F9). Replay of mix needs `a`; do not use 0. Replay of **max** does not.

**Damping:** the word that received the cmd-174 float is used as **Q15 MAC** on a 3D spatial delta (`0x2022F752`), not on Orange metres. There is no `orange := old + d·(new−old)` in this image. Finished: do not apply a metres smoother.

**Maps vs a peak:** pick never loads maps. Opcode 6 writes the user-map **series** and acquire From/To words. Finished: firmware pick does **not** suppress a Grade peak because a map sample is high. (T rewrite pointer to AFE: F18.)

**Synthesis spec (docs only — not Install Guide JS):**

| Step | Do | Do not |
|---|---|---|
| Axis | `h(i)=i×(1000/65536)` m | live `586c` as tape |
| Pick | last `G>T` with `G=amp×1.01`, `T=T[i>>2]` | clip vs AFE/False E; SNR as Grade delta; damping slew |
| Orange | `last_i<<15` → same metres | every peak |
| AFE series | `AFE[i>>3]=max(AFE, Grade[i])` | mix with `a=0` |
| User map | opcode 6 fills 327-pt series | assume pick reads it |
| Grade paint | ADC→FFT→match→IFFT→mag if you have ADC | invent a gaussian as firmware Grade |

File+tape “why X”: walk Grade vs Threshold **in the file**.

### F18. Research closed (2026-08-17, additive)

Canonical write-up: **`RESEARCH-CLOSED.md`**. Do not re-open pick, tape axis, mix-`a` as 0, damping-as-metres, map-skip-this-peak, or Install Guide Grade paint.

**T neighbor is AFE, not Grade.** Last `STORE [FP−0x38]` in `12BAE` is `0x20212DBC` (`P4+0x8F4C`). T loop loads that pointer at `0x20213DAA` / `13DF8` / `13E52`. Index `idx = W[work+0xe]`; `j = idx>>1`; linear mix of `8F4C[j]` and `8F4C[j±1]`; then `÷2`. F16/F17 “T rewrite never loads 8F4C” meant no **immediate**; the **base is AFE**. That can move **next** T, not this pick.

**T procedure** is the walk in `RESEARCH-CLOSED.md` §6 (`0x20213A26`…`0x202141D0`). Still not `T[i]=c·G[i]`. Support uses T **in the file**.

**Mix `a`:** uninit; AFE synthesis = **max** path only.

**Damping:** Q15 3D MAC (`0x2022F752`), not Orange IIR.

**ADC→Grade:** `DSP-GRADE.md`. Not this website.

### F12. Packer axis, mix slots, T `1.2f`, damping copy (2026-08-17, additive)

Sim disasm `t56`/`t57` (`../evidence/traces/trace_t56_disasm.txt`, `trace_t57_disasm.txt`) plus
`bm4_pack_full.asm` / `fn_20213000.asm`.

**`.bm4` packer `0x202B51E0` (file image, R0==0 path):**

- `[file+0]` = `0x0004FC78`; `[+4]=7` series; `[+8]=9` beams; later `[+0xC]=0x5CFC` stride
  (`0x202B542A`).
- Grade series: `[file+0x10]=0x5BC` (sample start); `[+0x14]=5242`; tag memcpy 6 bytes from
  L1 strings (`FP−0x38` = `0xFF802F24`, src `+ (−0x5C)` → `0xFF802EC8`).
- **`[file+0x28]=0x8000`** (`0x202B5252`) = series `representation_resulotion` fract32.
  `0x8000/2^31×1000 = 1000/65536` m. Firmware **writes** the same Grade Δh the PC parser uses.
- Orange at `0x5BC−4=0x5B8` is **not** stored in this header-fill window. Sample payload is
  filled later (`CALL 0x20220636` at `0x202B5492`). Do not equate that word to `last_i<<15`
  until a store to `file+0x5B8` is dumped.
- Related (already F4): after peak `0x20212F1C`, `last_i` (`W[P3+0x8A]`) `<<= 15` is mixed with
  `beam+0x3C` into `[P3+0x80]` (`0x20212F38`…`0x20212F54`). Other packer path copies
  `[src+0x3C]` (`0x202B51CA`).

**AFE mix `0x20213350` (register-complete ops, addend slot empty):**

```
f     = floatsisf( int16(beam+0x3DB0[i]) + 1 ) × [work+0x4]
num   = (f + [FP−0x3c]) × 8F4C[i] + [work+0x94]
8F4C[i] = num / f     ; divisor is R5 = f (CALL 0xFFA01814 at 0x2021334C)
```

`[work+0x94]` is zeroed then a float-max (`0x20213148` / `0x202131E4`). **`STORE [FP−0x3c]`
does not occur before the first mix** in this function (first store is T-loop `0x20213FEA`).
Do not invent the addend as 0.

**Threshold loop pieces (still not a closed T[i] line):**

- Windowed `rsqrt` of Grade floats (`0xFFA0248C`) accumulated at `work+0x2C` (`0x20213B60` /
  `0x20213B74`).
- Window sizes use `range>>17` and **`ctx+0x2B`** (`0x20213B9E`).
- Scale **`1.2f` = `0x3F99999A`** (`0x202140C0`…`0x202140D0`), not `0x3F996666`.
- Compare vs **`0.25f`** (`0x3E800000` at `0x20213FE0`).
- Selected float `R3` stored to `+0x51E8[i]` at `0x202141D0`. The select is a chain of
  signed-float min/max, not “T = 1.2 × mean(rsqrt(G))” until every CC is named.

**Maps in pick:** L1 `page_FFA00000.bin` has **0** `0x4D5C` halfwords. Peak `0xFFA038E2` lives
there. `page_FFA10000.bin` has one unaligned `5c4d` at `0xFFA1368F` (not a `P-imm = 0x4D5C`
load). Scan IIR still has `0x5798` sites (`0xFFA047AE`, `0xFFA04EA0`). Pick helper still does
not load AFE / user map.

**Damping:** unpack `0x202B692A` copies `[rx+0x28]` → **`adv+0x1C`**. Later `0x202B69F4` copies
`adv+0x1C` → another object `+0x58`. That is a **move**, not metres IIR. Identity of `rx+0x28`
vs cmd-174 bytes 24–27 is not proven (rx is a large buffer, not the 34-byte payload alone).

**Adv Params:** landings + F15 consumer table.

## SIM HARNESS — how to run + HARD-WON QUIRKS (`evidence/traces/`)

- `teerun.sh <script.gdb> <trace.txt> [timeout]` — runs gdb script in the bfin sim,
  tees output. **Always use it** (PowerShell mangles pipes/quoting otherwise).
- `rungdb.sh` — underlying runner; `make_dummy_elf.py` built `/tmp/prog.elf` (required).
- Memory: mapfiles must precede their `--memory-region`. Required regions listed in
  the 08-06 session doc.

**Quirks (all cost hours — don't relearn):**
1. **First `stepi` after `set $pc` (post-`run`) faults** into `0xFFA00002`. Workaround:
   burn one `stepi`, then `set $pc` again.
2. **The fault handler clobbers registers.** Set R0-R7/P0-P5/SP/FP **after** the burn
   stepi, immediately before `continue`.
3. **CPU read-after-write to file-backed map regions is unreliable** (store→load a few
   instructions later can read stale zeros). Don't write formulas that depend on it;
   verify via registers at a breakpoint instead.
4. **Sim writes PERSIST into the `.bin` mapfiles on exit.** A run can silently modify the
   firmware image. Use only known-free scratch (`0x20280000`+ zero zones proven writable),
   and after any run that executed firmware code, diff against `page_202*.bin` dumps.
5. **Restore procedure (used 2026-08-06):** `restore_check.py` (diff report),
   `restore_contig.py` (restores from pristine `page_*.bin`, zeroes scratch).
   Polluted-image backup: `fullmap/sdram_20200000_contig.bin.polluted-20260806.bak`.
   Pristine rebuild source if ever needed: `assets/firmware/3DLevelScannerM_4_5_452.ldr`
   via the Ghidra BootMap452 project.
6. **"ILLEGAL" in disassembly can mean (a) you're reading a runtime table area
   (self-overwriting init code — see B above) or (b) your own pollution.** Check image
   integrity first (quirks 4/5) before believing weird disassembly.
7. Plain `--memory-region` RAM without a mapfile did NOT accept CPU stores at 0x21000000/
   0x20400000; the 0x20200000 mapfile region does (but persists — quirk 4).
8. DMA/event wait `0xFFA06008` spins on `0xFF806EE0` — stub with breakpoint +
   `set {int}0xFF806EE0 = 1; continue`.
9. RTOS tick never fires — boot-to-idle hangs in delay loops; the acquisition path itself
   only needs quirk 8's stub.

## OPEN ITEMS (parked — F18)

Support “why X” is **done** (`RESEARCH-CLOSED.md`). Do not hunt these unless a later request names them:

1. Live `range_fixed` / `586c` — not the tape axis.
2. Mix `a` — cannot replay mix; do not invent 0.
3. SNR/CRAF as Grade math — byte gates only.
4. Labeled `.bm4` set for heuristic scoring — collect as needed.
5. Install Guide / remake `buildBeamData` — **out of this tree**.

T rewrite, damping-as-metres, map-skip-this-peak, pick, Orange, Grade emit: **closed**.

### Product mapping

| Goal | Status |
|---|---|
| Why the unit reported X (file + tape) | **Done** — last `G>T` → metres; use file T |
| False-echo recommend as firmware pick | **No** — pick ignores maps; heuristic From/To only |
| Rebuild T from Grade alone | **No** — walk uses Grade `rsqrt` **and** AFE neighbors; use file T |
| ADC→Grade in the Install Guide | **Out of scope** |
| Full ADC-to-curve emulator | Spec in `DSP-GRADE.md` + `RESEARCH-CLOSED.md` §2; needs ADC |

## Working agreements

- Commit after every change, message style `Updated X` / `Fixed X` / `Added X` (short,
  no internals, no reverse-engineering vocabulary in messages) — repo rule.
- Never claim math that isn't traced to the image. Mark hypotheses as OPEN.
- Keep AI usage efficient: prefer targeted disasm + tiny in-sim function executions over
  long blind traces; write scripts to files, never inline shell quoting gymnastics.
- **Grade pipeline proven ≠ false-echo recommend.** Pick does not apply maps (F14). Heuristic From/To must stay labeled heuristic.

---

# AUTO-CALIBRATION EXPLORATION (standalone category — idea only, not firmware-faithful)

**Status: exploration.** Pick/axis closed (F14). Map **apply in pick** does not exist.
Do not ship a recommender as “the scanner would do this.”

## What the product already does (proven on PC + wire)

1. **Manual window** — operator draws From–To on the echo graph and a Y threshold;
   PC sends cmd **151 opcode 6** with those three floats + a beam mask. That *is*
   “tune out this range.” Firmware still has to *apply* it (OPEN 3).
2. **Auto map** — UI “Scan” → cmd **151 opcode 4** (Threshold zeroed on the wire).
   Separate enable bit **AutoFalseEchoes** (cmd 174 byte 18 bit3) and sensitivity
   **AutoFalseEchoesSensitivity** (cmd 187 bytes 19–22). The *algorithm* that fills
   AFE (`beam+0x4D5C`, 655 pts): Scan→aux→`8F4C`→emit pinned (F9). Mix at `0x20213350` and pick-apply still OPEN item 11.
3. **Resets** — opcodes 5/7/8 clear user and/or auto maps.
4. **UseFalseEchoes** (cmd 174 byte 18 bit4) is the master “apply maps” switch.

## What we can already see on a `.bm4` (heuristic, honest label)

On the **PC axis** (`h = offset + i·resolution`, fract32→m): Grade, Threshold, AFE,
False E. share ~80 m. A support tool can, without claiming FW math:

- Take customer **tape distance** (or Orange line at `GradeDataOff−4`) as “keep this”.
- Flag Grade peaks **nearer than tape** that sit above Threshold / AFE / False E.
- Propose **From/To** covering those nearer peaks, and a **Threshold** from their
  amplitude (same clamp idea as PC: 1000…500000) → a cmd-151 ManualScan payload
  the technician can send.

That is a **recommender**, not auto-calibration of the unit. It needs labeled captures
(OPEN 13) before it is even a good heuristic.

## What true “auto-calibrate from math” still requires

| Missing | Why it blocks auto-cal |
|---|---|
| Map apply in pick | **Does not exist** (F14). A window does not mean FW clips Grade. |
| Closed T without the file | Cannot rebuild Threshold; use the series in the recording. |
| Dampening IIR | Not in this image. A one-shot map’s live effect is unknown. |
| Mix addend `a` | AFE mix formula incomplete for exact `8F4C` replay. |

## Practical recommendation

1. For “why it reported X”: last `G>T` on the file, metres `last_i×(1000/65536)`.
2. Prefer **cmd-151 ManualScan** (opcode 6) as the technician action, labeled heuristic.
3. Keep AFE (Scan) and user False E. distinct.
4. Show any proposal on Grade vs tape/Orange before send.

---

# SIM PROBING PLAYBOOK (standalone category — zero-context startup + every probe technique)

Everything below is self-contained. If you know nothing, copy-paste the recipes.
Scripts live in `docs/firmware/evidence/traces/`. Mapfile `.bin` images were not copied here.

## 0. Startup checklist (from nothing)

1. Enter WSL Debian as root: everything runs through
   `wsl -d Debian -u root -- bash <script.sh>` from PowerShell.
2. Toolchain must exist: `/opt/bfin/bin/bfin-elf-gdb` (built 2026-08-05 by
   `evidence/traces/01_deps.sh` + `02_build_gdb.sh`; rebuild only if missing).
3. Dummy ELF must exist: `/tmp/prog.elf` (from `make_dummy_elf.py`). If missing:
   `python3 docs/firmware/evidence/traces/make_dummy_elf.py`
4. Memory snapshots: not in this tree. Reading proven math does not need them.
5. **Run every probe through `teerun.sh`** (never raw PowerShell pipes):
   `docs/firmware/evidence/traces/teerun.sh` `<script.gdb>` `<trace_out.txt>` `[timeout_s]`
   Output lands in `docs/firmware/evidence/traces/<trace_out.txt>` and on stdout.

## 1. The canonical script skeleton (copy this)

Every probe script starts the same way (memory map + load). Template = `t54_scale.gdb`:

```gdb
set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "<FM>/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "<FM>/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "<FM>/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "<FM>/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "<FM>/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
```

`<FM>` = `/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/evidence/dumps`
(write it out in full; the `target sim` line must stay ONE physical line — it is shown
wrapped above for readability only). After `run` stops at the reset stub you can
`set $pc` anywhere. Mapfile must come BEFORE the region it binds to.

## 2. Probe techniques (all of them, cheapest first)

### 2a. Pure disassembly read — SAFEST, no execution, no pollution
Skeleton + `disassemble 0xSTART,0xEND`. Handles Blackfin DSP/LSETUP loops that Ghidra
can't. Examples: `t45_sigill.gdb`, `t46_floatlib2.gdb`, `t47_findentry.gdb`.
Use for: identifying library functions, reading loop math, constants.

### 2b. Numeric constant decode — NO sim at all
IEEE-754 halves seen in code: `R0.H = 0x447a` → `0x447a0000` = 1000.0f;
`0x40C90FDB` = 2π; `0x43A5A666` = 331.2998 (c at 0 °C); `0x48855FC0` = 273118.6;
`0x49740000` = 999424.0; `0x55555556` = ÷3 magic; `0x147A` = 5242 (grade len);
`0x147` = 327 (false-echo series len). Keep this table handy — it's how you read math
straight out of disassembly.

### 2c. Mid-function entry + breakpoint execution — the workhorse
For running ONE function fragment to get numeric ground truth:
```gdb
tbreak *0x<RET_ADDR>        # breakpoint at the fragment's end (e.g. just after last store)
set $pc = 0x<ENTRY>
stepi                       # QUIRK 1: burn the faulting first step
set $p5 = 0x20288000        # QUIRK 2: set ALL inputs AFTER the burn stepi
set $sp = 0xFFE07F00
set $fp = 0xFFE07F00
set $r7 = 0x428c0000        # example float arg
set $pc = 0x<ENTRY>         # re-set PC (burn stepi may have advanced it)
continue
p/x $r0                     # read results from REGISTERS, not memory (QUIRK 3)
x/4xw 0x202884dc
```
Template: `t54_scale.gdb`. Verified the distance-scale formula (n=0 → `0x2A6809C0`).

### 2d. Single-step trace with register watch
Skeleton + `set $pc` + repeated `stepi` / `p/x $pc` / `p/x $r0`. Template: `t48c.gdb`.
Use for: seeing exactly which branch a fragment takes, confirming arg registers.

### 2e. Memory search
`find /w 0x20200000, 0x20300000, 0x11170` — locate where a value landed. Template: `t48b.gdb`.

### 2f. Writability test before using any scratch address
```gdb
set {int}0x<ADDR> = 0xdeadbeef
x/xw 0x<ADDR>
```
Template: `t53_wr.gdb`. Plain `--memory-region` RAM (0x21000000, 0x20400000) did NOT take
CPU stores; the 0x20200000 mapfile region does — but writes PERSIST to the file (QUIRK 4).

### 2g. Hardware-wait stubbing (required for any acquisition-path execution)
DMA/event wait `0xFFA06008` spins on `0xFF806EE0` forever:
```gdb
break *0xFFA06008
commands
  set {int}0xFF806EE0 = 1
  continue
end
```
Template: `t38_runcfg.gdb`. RTOS tick delays (boot path) have no fix — stay off boot path;
call acquisition functions directly instead.

### 2h. Full-function run (config init example)
`t38_runcfg.gdb`: set R0/R1 = scratch arena/ctx pointers, enter `FUN_20210be6`, stub the
DMA wait (2g), breakpoint at the config-complete RTS, dump config structs. Produced the
byte-exact FFT config values (log2N 10/10/11/12/12, twiddle `0xFF800100`, shift 12−log2N).
NOTE: its chirp-precompute callee SIGILLs at `0x202ec6e2` — that region is a runtime
TABLE area (self-overwriting init RAM), not bad code. Expected; do not chase it.

## 3. Image integrity — MANDATORY around execution runs

- **CPU stores to mapfile regions PERSIST into the `.bin` files on gdb exit.** A run that
  executes firmware can silently rewrite the image (this happened 2026-08-06; a crashed
  table-fill wrote 5.4 KB over code).
- Before believing weird disassembly ("ILLEGAL" clusters), check integrity:
  `python3 ../evidence/traces/restore_check.py` — diffs contig vs pristine `page_202*.bin`.
- Restore: `python3 ../evidence/traces/restore_contig.py` (restores polluted spans from page
  dumps, zeroes scratch zones; keeps a `.polluted-*.bak` backup).
- Only use scratch addresses proven zero+writable: `0x20280000`–`0x20290000` zone
  (still file-backed → restore/zero it after runs).

## 4. Quirk summary (details in "SIM HARNESS" section above)

1. First `stepi` after `set $pc` post-`run` faults → burn one, re-set PC.
2. Fault handler clobbers registers → set inputs AFTER the burn stepi.
3. CPU read-after-write unreliable → take results from registers at a breakpoint.
4. Stores persist to mapfiles → integrity-check + restore (see §3).
5. "ILLEGAL" = table area OR your pollution → check integrity first.
6. Non-file memory regions don't take CPU stores → use 0x2028xxxx zone.
7. `0xFFA06008` DMA wait → stub `0xFF806EE0=1`.
8. RTOS tick never fires → never run boot path; enter functions directly.
9. PowerShell eats quoting → all runs via `teerun.sh` / helper `.sh` files only.

## 5. Probe-to-question cheat sheet

| Question | Technique |
|---|---|
| "What does this function compute?" | 2a disasm + 2b constants |
| "What's the exact numeric output for input X?" | 2c fragment execution |
| "Which branch fires?" | 2d single-step |
| "Where did value V get stored?" | 2e find |
| "Is address A safe scratch?" | 2f write test |
| "Why does the run hang?" | 2g/2h stubs + breakpoints at candidate spins |
| "Is this weird disasm real?" | §3 integrity check |
