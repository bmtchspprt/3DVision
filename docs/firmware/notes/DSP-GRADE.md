# DSP / Echo Curve — proven from firmware image

Source build: `3DLevelScannerM_4_5_452.ldr` (boot-stream map).  
Companion capture: `assets/grades/example-format-only.bm4` (same layout constants).

**Full archive** (every VA, negative, call graph, scratch buffer, dump index): [`DSP-FINDINGS-ARCHIVE.md`](DSP-FINDINGS-ARCHIVE.md) · dump index [`../evidence/dumps/INDEX.md`](../evidence/dumps/INDEX.md).

This file stays **simulation-facing proven-only**. Details and ruled-outs live in the archive.

## Soft-float / convert library (L1)

| VA | Role | Evidence |
|----|------|----------|
| `0xFFA018F0` | `fmul` | mantissa MAC |
| `0xFFA01814` | `fdiv` | sign xor; `x/1→x`; `x/x→1` |
| `0xFFA01716` | `fadd` (`__addsf3`) | t46 |
| `0xFFA01714` | **same function as `0xFFA01716`** (entry) | HANDOFF §C |
| `0xFFA01688` | `int→float` (standard) | |
| `0xFFA02894` | **fixed→float** (abs + `signbits`, bias `0x77`) | used after `<< 3` on raw samples |
| `0xFFA014DC` | `float→int` | exp bias `0x9E` |
| `0xFFA0290C` | **`float→int16`** | exp bias `0x8F` (=127+16) |
| `0xFFA0248C` | **`rsqrt`** (table `0xFF80349C` + 3 Newton vs `0x30000000` = 1.5 Q29) | t46; **not** sqrt. `sqrt(x)` would be `x * rsqrt(x)` |
| `0xFFA05F2E` | `memset` | |
| `0xFFA05F92` | `memcpy` | |

## Beam buffer layout (exact match to `.bm4`)

| Constant | Value | bm4 field |
|----------|-------|-----------|
| `beamStride` | **`0x5CFC` = 23804** | header `beamStride` |
| Grade max/len | **`0x147A` = 5242** int16 | series[0].length |
| Threshold len | **`0x51E` = 1310** int16 | series[1].length |
| Grades E / AFE | **655** | series[2]/[3] |
| False E. | **`0x147` = 327** | series[4].length |

Per-beam (`beam_base = arena + 0x578 + beamIndex * 0x5CFC`):

| Series | Offset from `beam_base` | dh vs Grade |
|--------|-------------------------|-------------|
| Grade | `+0x44` | ×1 (`1000/65536` m) |
| Threshold | `+0x2938` | ×4 |
| (mid series) | `+0x3374`, `+0x3892`, `+0x3DB0` | ×8-class clears `0x51E` bytes |
| AFE | `+0x4D5C` | ×8 |
| False E. | `+0x5A26` | ×16 |

Init clears Grade with `memset(beam+0x44, 0, min(n,5242)*2)` (`0x20211E4E` / `0x20211D5C`).

## Grade int16 emit — **proven** (`0xFFA04B90`)

```text
count = (range_field >> 15) + 1          // ASHIFT >>> 0xF
for i in 0 .. count-1:
    v = float_to_i16( fdiv( grade_float[i], scale ) )   // FFA01814 then FFA0290C
    store int16 v at beam_base + 0x44 + i*2
```

- `grade_float` base: **`0x20215060`** (set at `0xFFA0469A`: `P1.L=0x5060; P1.H=0x2021`)
- Contiguous float layout: Grade floats then Threshold floats (`+0x51E8` = 5242×4); combined span `+0x6660`
- Next 655×3 floats (`+0x6660` / `+0x709C` / `+0x7AD8`) are mid-series twins (`+0x3374/+0x3892/+0x3DB0`); Scan IIR reuses them. **AFE export floats are `+0x8F4C`**. See F8.
- `scale` = peak/max of the float Grade (running float-max loop `@0xFFA04970`), also written to beam meta `+0x5CD4`
- Length written back for the series

Sibling emits in the same function (`0xFFA04B9A` region):

| Series | offset | length shift |
|--------|--------|--------------|
| Grade | `0x44` | `>> 15` |
| mid | `0x3374` | `>> 18` |
| mid | `0x3892` / `0x3DB0` | `>> 18` |
| False E. | `0x5A26` | special + `0x147` |
| (SDRAM twin) Threshold `0x2938` `>> 17`; AFE `0x4D5C` `>> 18` (`0x20214350`) |

## PC display reconstruction (matches emit)

From `BeamDataParser` / bm4:

```text
amp = ArrayToFract(grade_i16) * gain
ArrayToFract(u): u>32768 ? (65536-u)/32768 : u/32768
```

With `grade_i16 = float_to_i16(grade_f / scale)` and `gain ≈ scale`, displayed **amp ≈ grade_f** (pre-quantization envelope).

## Call graph (Grade path)

| From | To | Role |
|------|----|------|
| `0x202303AC` | **`0xFFA03C8A`** | Invoke L1 DSP / envelope body |
| `0x2022E2DE` | **`0xFFA0467E`** | Invoke quantize/emit parent (Grade `0xFFA04B90` …) |
| `0xFFA0467E` | float `@0x20215060` | Work buffer base |

## Sin table — **proven** (`0xFFA07194` / `0xFF80100`)

```text
table[i] = round(32767 * sin(2π * i / 0x1000))  // i=0..0xC00, then mirrored via 0x1800-i
```

`FFA07194` returns `table[i] << 16`.

## L1 kernel `0xFFA03C8A` — **proven (not the 5242 Grade filler)**

Called from `0x202303AC`. Beam stride `0x5CFC`; `beam_base = arena+0x578+beam*stride`.

| Constant | Float | Role |
|----------|-------|------|
| `0x42490FDB` | ≈ **16π** | `fdiv(beam+0x5CC4, 16π)` |
| `0x40C90FDB` | ≈ **2π** | `fdiv(beam+0x38, 2π)` → loop count |

1. Six inputs from `FP+0x20` via `FFA028C8` + `>>5` (`0xFFA03D1E`).
2. Multi-phase LO via **`FFA07194`** (offsets `0x55555554` ≈120°, `0x2AAA5554` ≈60° of a 2³² circle).
3. Complex MAC LO×inputs (`0xFFA03EEE`…`0xFFA03FE4`).
4. Power `|z|²` (`0xFFA03FF0`…`0xFFA0402C`).
5. Optional **6-float** store: `<<3` + `FFA02894` (`0xFFA0425A`) — not 5242 Grade samples.

Helpers: `FFA00FB4` (DIVQ), `FFA05EE4` (64-bit div).

## Grade float `@0x20215060` — consumers proven; first producer open

| VA | Direction | Role |
|----|-----------|------|
| `0x20212C7C` / `0x2022D118` | READ int16→float | scale into `@0x20215060` |
| `0xFFA04B90` (via `0xFFA0467E`) | WRITE float→int16 | Grade emit |
| `0x20214350` | WRITE | Threshold/AFE twin emit |

All `FFA0290C` sites (complete image scan, 11 calls):

| Site | Dest | Role |
|------|------|------|
| `FFA04BAA`…`FFA04ECC` | `beam+0x44` / siblings | emit parent (proven Grade/mids/False E.) |
| `0x20214386` / `0x202143FA` | `beam+0x2938` / `+0x4D5C` | Threshold / AFE twin emit |
| `0x20231E1C` | **`[0x20225EE4+0x24]` → static `0x2022C6A8`** | giant scratch int16 (not Grade) |
| `0x202EC89C` / `0x202EC8CC` | `I0++` / `I1++` from local `P4` | unrelated pack path |

Also in image (not wired to Grade store): FIR `0xFFA00D00` (no CALL xrefs), IQ MAC `0xFFA05B28`, FFT `0xFFA06688`.

### Emit parent order — **proven** (`0xFFA0467E` via `0x2022E2DE`)

1. `CALL 0x2022D05E` — **int16→float** Grade: `beam+0x44` → floats `@0x20215060` (same body as twin `0x2022D0FC`).
2. Peak/meta over float Grade; sibling series converted similarly (`+0x3374` etc.).
3. `FFA04B90` — float→int16 emit back to `beam+0x44`.

Acquire (`0x20220636`) — **proven call order before emit** (`acq_call_graph.txt`):

| Step | VA | Callee | Role |
|------|-----|--------|------|
| | `0x20220A5C` | `0x20210BE6` | beam meta / tap-count setup |
| | `0x20220B2E` | `0x2020F330` | interleave halfword copy into ctrl `0x2021EA7C` (not Grade; was mislabeled “float scale”) |
| | `0x20220BA4` | `0x2021F97A` | unsigned bit/scale helper (`@0x2021E9E8`) |
| | `0x20220CEE` | **`0xFFA043C4`** | beam float mix (reads beam; **not** Grade sample fill) |
| | `0x20220F9A` | `0x202122FA` | multi-buffer float blend |
| | `0x20221050` | `0x2022E118` | emit wrap → `FFA0467E` + modifier |
| after emit | | `0x2021FFE4` | Threshold |
| | | `0x20212BAE`×2 | post-emit int16→float |
| | | `0x2022F986` | giant |
| late giant | `0x202303AC` | `FFA03C8A` | correlator (**after** Grade emit) |

So emit’s own `0x2022D05E` is the Grade→float step for quantize; correlator cannot be the first Grade producer.

Only **3** code materializations of `@0x20215060`: emit parent, `0x20212C5E`, `0x2022D0FC`. No other absolute writer.

### Related L1 / SDRAM helpers — **proven roles (not Grade first-fill)**

| VA | Role |
|----|------|
| `0xFFA038E2` | Grade/Threshold **peak search** over len `0x147A`; stores `beam+0x44` ptr at scratch `P5+0x8`; callers `0x20212F1C`, `0x2022DB02` |
| `0xFFA043C4` | Soft-float mix on beam fields; acquire pre-emit |
| `0xFFA05CA0` | IQ window / scale into caller float buf; uses `beam+0x5770/0x5776` |
| `0xFFA05A56`/`0xFFA05B28` | IQ MAC; dest from caller `I0` — not Grade |
| `0xFFA06CFC` | Pulse reshape: memcpy + `STORE W` into **L1** (`0xFF90C0` / `0xFF9020C0`); caller `0x202ECE12` |
| `0x2021FC88` | float→int16 into static **`0x2021F140`** (9 samples) — scratch, not Grade |
| `0x2022D2F0` | `STORE W [I0++]` into scratch `0x20225CE8` (not Grade) |
| `0x202B5024` | small index/search helper on acquire path |

### False E. CPU fill — **proven** (`0x202246F0`…`0x20224726`)

Unlike Grade, False E. has an explicit imm-offset writer:

```text
P4 = beam_base + 0x5A26
STORE W [P4++] = 0x7FFF          // seed
for i in 0 .. 0x146:             // P2 = 0x146
    v = float_to_int( fmul( int_to_float(W[P4]), scale ) )
    STORE W [P4 ++ P3] = v
// also STORE W [P0 + 0x5A26] meta path nearby
```

Contrast: Grade has **no** analogous `LOAD imm = 0x44` + fill loop (only memset / convert / emit).

### Modifier / sort — **proven not first-fill**

- `0x2022D6DC`: builds `beam+0x44`, calls `FFA033F8`; **RTS returns `0x2022A340`** (scratch). ADD/`STORE W [P2++]` bias that scratch window — not ADC→Grade.
- Giant `0x202316B0`/`0x20231E1C`: stride-`0x18` floats from `arena+0x34C20` → fdiv into **`0x2022C6A8`**, then float→i16 into same buffer (`[P3+0x24]` with `P3=0x20225EE4`; static init `+0x24 = 0x2022C6A8`). Then `FFA033F8` on that scratch — **not** `beam+0x44`.

### Imm / pointer exhaustives — **proven**

| Probe | Result |
|-------|--------|
| Exact imm `= 0x44` Grade sample stores | memset / int16→float **read** / emit **write** only (18 imm-`0x44` sites total; others are struct size / UI / soft-desc byte fills) |
| Imm `= 0x5BC` (= arena Grade absolute) | **only** bm4 packer `0x202B5202` |
| Imm `= 0x28F4` (5242×2) | **only** Grade memset at init |
| Imm `= 0x147A` | init clamp, packer, peak `FFA03B00`, emit-meta `FFA04FE0`, index helper `0x2020F27C` — **no** Grade sample fill |
| `ASHIFT >>> 0xF` + `LSETUP` + `STORE W` | 6 sites only (Threshold meta, i16→f twin, modifier, emit) |
| `beam+0x579c` (= stored `0x44` constant) | **STORE-only** at init; never `LOAD`’d as dest driver |
| Series-offset table (`0x44,0x2938,…`) in L1D/SDRAM | **none** |
| L1 bank `0xFFA10000` | no `0x147A`/`0x578`/`0x5CFC`; not Grade filler |
| `STORE W [I*]` with `0x578` in prior 60 | only emit-path scratch (`0x2022D0F8` → `0xFF80485C`) |
| `0xFFC0` MMR | SIC/PPI-class; no cited MDMA `START_ADDR = beam+0x44` |
| Soft-desc `FFA0763C` / IRQ `FFA07BDE` | programs HW from desc; does not write Grade samples |
| Init `STORE/LOAD [P5+0x44]` | control-struct fields (`[P3+0x14]` etc.), **not** Grade buffer pointer |

**Still open:** first non-zero Grade int16 at `beam+0x44` (before first `0x2022D05E`).

Ruled out this pass: emit float path alone, modifier, `FFA03C8A`, giant `0x2022C6A8`, imm-`0x44` CPU fill, ash15 Grade fill, L1 bank1, `0x2021F140` scratch, `0x2022D2F0` scratch, False-E-style imm fill for Grade, series-offset table indirection via `0x579c`.

Remaining hypotheses:

1. **DMA/HW** deposits into `beam+0x44` (desc `START_ADDR` programmed from a runtime pointer that never reloads imm `0x44` in-window).
2. **CPU `STORE W`** via a precomputed pointer (saved earlier) that never materializes imm `0x44` at the store site — not yet cited.

## Simulation gate

**Allowed as firmware-accurate now:**

- Layout, lengths, `dh` ratios, stride.
- Grade/Threshold/AFE/False E. **quantize**: `int16 = float_to_i16(f / scale)` with cited shifts.
- Display amp ↔ float envelope via `ArrayToFract * gain`.
- False E. seed/`0x7FFF` reshape loop shape (above) — pending full scale-source identity before InstallGuide use.

**Blocked as end-to-end Grade amplitude generator** until first Grade producer is closed with cited VAs.

Until then InstallGuide must either parse real `.bm4` or label synthetic amplitudes **not firmware-accurate**.

## Float arena `@0x20215060` — convert map (do not call 655-planes “AFE” without F8)

| Offset | Count | Int16 twin / role |
|--------|-------|-------------------|
| `0` | 5242 | Grade `+0x44` |
| `+0x51E8` | 1310 | Threshold `+0x2938` |
| `+0x6660` | 655 | mid `+0x3374` (Scan IIR also writes here) |
| `+0x709C` | 655 | mid `+0x3892` |
| `+0x7AD8` | 655 | mid `+0x3DB0` (Scan `aux`) |
| `+0x8514` | 327 | False E. `+0x5798` |
| `+0x8F4C` | 655 | **AFE export** `+0x4D5C` (`FUN_20212BAE` convert/emit) |

Scan handler / IIR: `HANDOFF.md` §F6–F9. Emit of AFE int16 reads **`+0x8F4C`**, not `+0x6660`.

## AFE Scan IIR (reuses mid floats)

Inside `0xFFA0467E` opcodes 3/4/5 (`0xFFA04F6E`): index **`>> 3`**; `0xFFA0165C` running max. Bin-change IIR on `+0x7AD8`: `α=8·w`, `aux = (α·aux + rsqrt(|scratch|)) / (α+1)` (`w` from `uint16[obj+0x46]`, ÷3 if `ctx+0x521==0`). Then mid-plane1/0 update as F7. Same function then float→i16: `3374` / `3892` / `3DB0`.

`FUN_20212BAE` seeds `+0x8F4C` from existing `+0x4D5C`, mixes **`+0x3DB0`**, then **max** of Grade floats into `8F4C[i>>3]`, then emits AFE. Mix ops (F12): `f=floatsisf(aux+1)×scale`; store `(f+addend)×8F4C+work+0x94` `/ f`. Addend `[FP−0x3c]` is not written before first mix. Peak `0xFFA038E2` runs **before** that rewrite. Peak helper still does not load maps (`FFA00000` has no `0x4D5C` immediate). After the other peak call (`0x2022DB02`), aux `+0x3DB0[i>>3]` is read (F11) — not AFE apply.

T rewrite **after** this peak interpolates **AFE** floats via `[FP−0x38]` (`+0x8F4C`), not Grade neighbors (`RESEARCH-CLOSED.md` §5–6). That can change later Threshold. This pick still uses T already in RAM.

Packer writes Grade resolution **`0x8000` fract32 = 1000/65536 m** (`0x202B5252`). Orange word is **`last_i<<15`** (`0x2022062C`) → **`Orange_m = last_i × (1000/65536)`**. Tape vs **file** Grade/Orange uses that. Live `586c` is `5ee4(hw+0x57c0,41000)+acc` (F13), not the tape axis.

## Artifacts

- Full archive: `docs/firmware/DSP-FINDINGS-ARCHIVE.md`
- Session dig catalog (everything, Grade + non-Grade): `docs/firmware/DSP-FINDINGS-SESSION-2026-08-05.md`
- Dump index: `../evidence/dumps/INDEX.md` (`### dig_` = 101 files)
- Finished support math: `docs/firmware/RESEARCH-CLOSED.md`
- Full map: `docs/firmware/FULLMAP.md`
- Ghidra: `../evidence/dumps/ghidra_boot_project`
- Grade dumps: `../evidence/dumps/grade/` (710 files incl. digs; scripts in `C:\tmp\ghidra_scripts\`)
- Pulse / other: `…/pulse/`, `hotl1/`, `sf/`, `writers/`, `trace/`, `range/`
