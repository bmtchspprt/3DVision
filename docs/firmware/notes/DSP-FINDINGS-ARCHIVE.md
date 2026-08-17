# DSP / Echo Curve — full findings archive

Source build: `3DLevelScannerM_4_5_452.ldr` (boot-stream VA map).  
Companion layout check: `assets/grades/example-format-only.bm4` (format only; not amplitude truth).  
**Rule:** cite VAs; do not invent formulas. InstallGuide FW-accurate sim stays **blocked** until Grade first-fill closes.

Companion docs:

| Doc | Role |
|-----|------|
| [`DSP-GRADE.md`](DSP-GRADE.md) | Condensed **proven-only** sheet for simulation gate |
| [`DSP-FINDINGS-SESSION-2026-08-05.md`](DSP-FINDINGS-SESSION-2026-08-05.md) | **Full** session dig catalog + every finding (Grade and non-Grade) |
| [`FULLMAP.md`](FULLMAP.md) | LDR → VA materialization |
| [`../evidence/dumps/INDEX.md`](../evidence/dumps/INDEX.md) | Dump file index (incl. all `grade/dig_*.txt`) |

This archive keeps **everything useful**: proven math, related DSP that is *not* Grade, ruled-out hypotheses, imm inventories, call graphs, scratch buffers, and dump pointers. Negatives are intentional knowledge. **Do not skip documenting a path because it is “not echo curve”** — other projects reuse DMA/IRQ/pulse/control findings.

---

## 0. Mandate & method

- Recover how FW builds Echo Curve series (Grade / Threshold / AFE / False E.) for InstallGuide simulation.
- PC MultiVision downloads HART beam blobs / parses `.bm4`; it does **not** compute amplitudes.
- Synthetic `buildBeamData` must stay labeled **not firmware-accurate** until Grade first producer is proven.
- Ghidra: 12.1.2 headless, project `BootMap452`, scripts under `C:\tmp\ghidra_scripts\` (UTF-8 no BOM).
- Motif for L1 calls from SDRAM: `LOAD P1.L/H` + `CALL (P1)`.
- **Documentation mandate:** archive/session must retain **all** static findings from digs — DMA SM, IRQ/completion flags, pulse/AFE MMR, control objects, correlator, soft-desc installers, ruled-out helpers — even when they do not produce Grade. Skipping non–echo-curve machinery loses reuse value for other projects. Exhaustive dig-by-dig narrative lives in [`DSP-FINDINGS-SESSION-2026-08-05.md`](DSP-FINDINGS-SESSION-2026-08-05.md).

---

## 1. Memory map (boot stream)

| Region | VA | Artifact |
|--------|-----|----------|
| App SDRAM | `0x20200000`… | `sdram_20200000_contig.bin` |
| L1 Data | `0xFF800000` | `l1_data_FF80.bin` |
| L1 Data B | `0xFF900000` | mostly fill; live pulse bufs use `0xFF90C0`, `0xFF9020C0` |
| L1 Inst bank0 | `0xFFA00000` | `page_FFA00000.bin` |
| L1 Inst bank1 | `0xFFA10000` | `page_FFA10000.bin` — **no** Grade length/stride imms |

Tag strings in L1 Data: Grade `0xFF802EC8`, Threshold `0xFF802ED0`, AFE `0xFF802EE8`, False E. `0xFF802EEC`.

Descriptor UI buffer `0x2020C844` filled by `0x2020CAA4` (formatter, **not** sample DSP).

---

## 2. Soft-float / convert library (L1) — proven

| VA | Role | Notes |
|----|------|-------|
| `0xFFA018F0` | fmul | |
| `0xFFA01814` | fdiv | |
| `0xFFA01716` | fadd | |
| `0xFFA01714` | fsub / ordered compare-add | |
| `0xFFA01688` | int→float | |
| `0xFFA02894` | fixed→float | abs + `signbits`, bias `0x77`; often after `<<3` |
| `0xFFA02948` | related fixed/float helper | used heavily in `FFA038E2` / `FFA043C4` |
| `0xFFA014DC` | float→int | exp bias `0x9E` |
| `0xFFA0290C` | float→int16 | exp bias `0x8F` (=127+16) |
| `0xFFA0248C` | sqrt | table `0xFF80349C` + Newton |
| `0xFFA016D4` | int→float variant / helper | acquire path |
| `0xFFA0165C` / `0xFFA01630` | float helpers | |
| `0xFFA01C74` | float helper | init scaling |
| `0xFFA00FB4` | DIVQ | correlator / False E. path |
| `0xFFA05EE4` | 64-bit div | |
| `0xFFA05F2E` | memset | |
| `0xFFA05F92` | memcpy | |
| `0xFFA06008` | helper | acquire / pulse |
| `0xFFA0586C` / `0xFFA05896` | helpers | emit wrap |
| `0xFFA05FB0` | helper | emit wrap |
| `0xFFA033F8` | sort/select | **RTS returns `0x2022A340`** scratch |
| `0xFFA03358` | related | giant path |
| `0xFFA028C8` | convert | correlator prefetch |

Sin table `0xFFA07194` / data `0xFF80100`:

```text
table[i] = round(32767 * sin(2π * i / 0x1000))  // i=0..0xC00, mirror via 0x1800-i
```

Returns `table[i] << 16`.

---

## 3. Beam buffer layout — proven (matches `.bm4`)

| Constant | Value | Meaning |
|----------|-------|---------|
| `beamStride` | `0x5CFC` = 23804 | per-beam stride |
| Grade max | `0x147A` = 5242 int16 | series[0] |
| Threshold | `0x51E` = 1310 int16 | series[1] |
| mid / AFE class | 655 | series[2]/[3] |
| False E. | `0x147` = 327 int16 | series[4] |

```text
beam_base = arena + 0x578 + beamIndex * 0x5CFC
```

| Series | Off from `beam_base` | dh vs Grade (PC) |
|--------|----------------------|------------------|
| Grade | `+0x44` | ×1 (`1000/65536` m) |
| Threshold | `+0x2938` | ×4 |
| mid | `+0x3374`, `+0x3892`, `+0x3DB0` | ×8-class; init clears `0x51E` **bytes** |
| AFE | `+0x4D5C` | ×8 |
| False E. | `+0x5A26` | ×16 |

Arena absolute Grade = `arena + 0x5BC` (`0x578+0x44`). Imm `0x5BC` appears **only** at bm4 packer `0x202B5202`.

### Beam meta fields (partial catalog)

| Off from beam / arena | Use |
|----------------------|-----|
| `beam+0x579c` | stores constant `0x44` at init — **never LOADed** as dest driver |
| `beam+0x578c` / `0x5790` / `0x5794` / `0x5798` / `0x57a0` | sibling series offset constants at init |
| `beam+0x5CD4` | Grade peak/scale (float) written by emit |
| `beam+0x5CE0`…`0x5CE4` | sibling scales (read in int16→float) |
| `beam+0x5CF0` / `0x5CF4` | used in `0x20212C5E` path |
| `beam+0x5CF8` | False E. path meta (`0x2022467E`) |
| `beam+0x5770` / `0x5772` / `0x5774` / `0x5776` | IQ tap / window counts (IQ MAC, `FFA05CA0`, pulse setup) |
| `beam+0x5780` / `0x5784` / `0x5788` | pulse/IQ float state |
| `beam+0x38` / `0x5CC4` | correlator angle inputs (`2π` / `16π` scales) |
| `beam+0x1` (byte) | flag checked in acquire / `FFA043C4` |
| control `P5+0x3c` | beam index word at init |
| control `P5+0x44` / `+0x48` | **not** Grade ptr — copies from `[P3+0x14]` / `[P3+0xc]` |
| control `P5+0x58` | length word for memset / soft-desc (often Grade len) |

Init memset Grade: `0x20211D5C` / `0x20211E4E` — `memset(beam+0x44, 0, min(n,5242)*2)` via `0x28F4` max bytes. Also clears mids at `+0x3374/+0x3892/+0x3DB0` with len `0x51E`.

---

## 4. Series producer status board

| Series | First fill | Quantize / reshape | Notes |
|--------|------------|--------------------|-------|
| **Grade** | **OPEN** | emit `FFA04B90` proven | Chicken-egg: emit reads int16→float then writes back |
| Threshold | depends on Grade | twin emit `0x20214350`; CFAR-ish `0x2021FFE4` | uses `0x4AD6`, `beam`-rel `0x5B8` |
| mid `+0x3374`… | cleared at init | emit siblings `>>18` | |
| AFE | twin of Threshold emit | `+0x4D5C` | |
| **False E.** | **CPU fill proven** `0x202246F0` | emit sibling | seed `0x7FFF`, loop `0x146` |

---

## 5. Grade int16 emit — proven (`0xFFA04B90` via parent `0xFFA0467E`)

```text
count = (range_field >> 15) + 1
for i in 0 .. count-1:
    v = float_to_i16( fdiv( grade_float[i], scale ) )
    store int16 at beam+0x44 + i*2
```

- Float work buf **`0x20215060`** — only **3** absolute materializations: emit parent, `0x20212C5E`, `0x2022D0FC`.
- `scale` = peak of float Grade (`FFA04970`); also `beam+0x5CD4`.
- Contiguous floats: Grade then Threshold (`+0x51E8` = 5242×4); span `+0x6660`.

### Emit parent order (`FFA0467E` via `0x2022E2DE`)

1. `CALL 0x2022D05E` — int16→float Grade → `@0x20215060` (twin body `0x2022D0FC`).
2. Peak/meta; sibling series converts (`+0x3374` etc.).
3. `FFA04B90` — float→int16 emit.

### All `FFA0290C` sites (11) — classified

| Site | Dest | Role |
|------|------|------|
| `FFA04BAA`…`FFA04ECC` | beam series | emit parent |
| `0x20214386` / `FA` | `+0x2938` / `+0x4D5C` | Threshold / AFE twin |
| `0x20231E1C` | `[0x20225EE4+0x24]` → `0x2022C6A8` | giant scratch |
| `0x202EC89C` / `CC` | `I0++` / `I1++` | unrelated pack |

### PC display (matches emit)

```text
amp = ArrayToFract(grade_i16) * gain
ArrayToFract(u): u>32768 ? (65536-u)/32768 : u/32768
```

With emit + `gain ≈ scale` → displayed amp ≈ pre-quant float envelope.

---

## 6. Acquire pipeline — proven call order (`0x20220636`)

Evidence: `acq_call_graph.txt`, `dump_pre_emit_fns.txt`, `emit_acquire_path.txt`.

| Order | Site | Callee | What it is |
|-------|------|--------|------------|
| | `0x20220A5C` | `0x20210BE6` | beam meta / `0x5774`/`0x5776` setup; calls `0x202ECC64`/`0x202ECCF2` |
| | `0x20220B2E` | `0x2020F330` | float scale helper |
| | `0x20220BA4` | `0x2021F97A` | pulse/IQ prep → `0x2020FD42`, `0x20210546`, `FFA05CA0` |
| | `0x20220CEE` | **`0xFFA043C4`** | beam float mix — **not** Grade sample fill |
| | `0x20220D58` | — | `LOAD R5 = [P5+0x44]` control field, not Grade buf |
| | `0x20220F9A` | `0x202122FA` | multi-buffer float blend / energy |
| | `0x20221050` | `0x2022E118` | emit wrap |
| inside wrap | `0x2022E2DE` | `FFA0467E` | emit parent |
| | `0x2022E2F8` | `0x2022D6DC` | modifier (scratch) |
| after | | `0x2021FFE4` | Threshold |
| | | `0x20212BAE`×2 | post-emit int16→float |
| | | `0x2022F986` | giant |
| late | `0x202303AC` | `FFA03C8A` | correlator **after** Grade emit |

Implication: correlator/`FFA03C8A` cannot be first Grade producer. Grade int16 must exist before first `0x2022D05E`.

Frequent acquire helper `0x202B5024`: small index/search on `arena+0x34A54`-class table — not sample fill.

---

## 7. L1 / SDRAM DSP units — roles (archive even if not Grade)

### `0xFFA03C8A` correlator — proven not 5242 Grade filler

Caller `0x202303AC` (giant, post-emit).

| Const | Float | Use |
|-------|-------|-----|
| `0x42490FDB` | ≈16π | `fdiv(beam+0x5CC4, 16π)` |
| `0x40C90FDB` | ≈2π | `fdiv(beam+0x38, 2π)` → loop count |

1. Prefetch `FP+0x20` via `FFA028C8` + `>>5`.
2. Multi-phase LO via `FFA07194` (phase offsets `0x55555554`≈120°, `0x2AAA5554`≈60° of 2³² circle).
3. Complex MAC; `|z|²`.
4. Optional **6-float** store (`<<3` + `FFA02894`) — not 5242 samples.

### `0xFFA038E2` peak / index over Grade length — proven consumer

- `LOAD P3 = 0x44`, `P2 = 0x578`, stride `0x5CFC`.
- Loop bound imm `0x147A` at `FFA03B00`.
- Stores Grade ptr at scratch `P5+0x8`; also handles Threshold `0x2938`.
- Callers: `0x20212F1C`, `0x2022DB02`.
- Optional single-word index stores to `[FP+0x24]` / `[SP+0x28]` — not series fill.

### `0xFFA043C4` beam float mix — acquire pre-emit

Uses `0x5CFC`/`0x578`, reads beam fields, soft-float + `FFA00AE4`; no Grade `STORE W` loop.

### `0xFFA05A56` / `0xFFA05B28` IQ MAC

Complex MAC over length `beam+0x5776`; dest `I0` from caller. **Not** Grade. Trace: `trace_5b28.txt`.

### `0xFFA05CA0`

IQ window / scale into caller float buffer; zeros then accumulates; uses `0x20215044` index table and `0x202D2850` beam ptr table. Callers inside `0x2021F97A`.

### `0xFFA06CFC` pulse reshape (L1)

- memcpy into `0xFF806F30`.
- `STORE W` into L1 working buffers `0xFF90C0` / `0xFF9020C0`.
- Calls `0xFFA00CC8` (near unused FIR `0xFFA00D00`).
- Caller `0x202ECE12` from pulse setup (`0x202ECCF2` family). **Not** Grade SDRAM.

### `0xFFA00D00` / `0xFFA00D18` FIR

Present in L1; **no CALL xrefs** found in image scan — dead or overlay-only.

### `0xFFA06688` FFT

In image; not wired to Grade store in cited path.

### Soft-desc / IRQ DMA

| VA | Role |
|----|------|
| `0xFFA0763C` | soft-desc walker — programs HW from descriptor fields |
| `0xFFA07BDE` | IRQ entry; may `CALL FFA0763C` |
| `0xFFA077EE` | `LOAD P3 = 0x44` in soft-desc context — **byte** pattern fill / desc size, not Grade samples |

`0xFFC0` MMR use: SIC/PPI (`0xa10`, `0x500`, …). **No** cited `START_ADDR = beam+0x44` / `arena+0x5BC`.

Near-beam `STORE +0x58` at `0x20221AA2` stores **div result**, not Grade dest.

### Modifier `0x2022D6DC`

Builds `beam+0x44` for addressing; `FFA033F8` returns `0x2022A340`; ADD/`STORE W [P2++]` biases **scratch**, not ADC→Grade.

### Giant path `0x2022F986` / `0x202316B0` / `0x20231E1C`

- `P3 = 0x20225EE4`; static `[P3+0x24] = 0x2022C6A8`.
- Stride-`0x18` floats from `arena+0x34C20` → fdiv into `0x2022C6A8` → float→i16 same buffer.
- **Not** Grade.

### `0x2021FC88` float→i16 scratch

`I1 = 0x2021F140`, LC ≈ 9 — tiny static scratch. Only one materialization of `0xf140`.

### `0x2022D2F0` I0 store loop

`I1 = P5+0x24` with `P5=0x20225CC4` → `0x20225CE8` scratch; writes float high-halves from `arena+0x6040`-indexed data. **Not** Grade.

### False E. CPU fill — proven (`0x202246F0`…`0x20224726`)

```text
P4 = beam_base + 0x5A26
STORE W [P4++] = 0x7FFF
for i in 0 .. 0x146:   // P2 = 0x146
    load W[P4]; int→float; fmul scale; float→int
    STORE W [P4 ++ P3] = v
```

Also `STORE W [P0 + 0x5A26]` on alternate branch. Scale source still partially open for InstallGuide use.

**Contrast:** Grade has **no** analogous imm-`0x44` fill loop — only memset / convert / emit.

### Threshold `0x2021FFE4`

Fills `beam+0x2938`; uses `0x4AD6` and `0x5B8` (beam+`0x40` stride-4 indexing). **Depends on Grade existing.**

### Index helper `0x2020F27C`

Uses `I0` + `M0` with `-0x147A` / `+0x147A` — Grade-length indexing helper, not fill.

---

## 8. Imm / pattern exhaustives (negatives = knowledge)

| Probe | Result |
|-------|--------|
| Exact imm `= 0x44` (18 sites) | memset / int16→float read / emit write for Grade; others = struct size, UI byte fills, soft-desc, False-E-adjacent |
| Imm `= 0x5BC` | **only** packer `0x202B5202` |
| Imm `= 0x28F4` | **only** Grade memset |
| Imm `= 0x147A` | init, packer, peak `FFA03B00`, emit-meta `FFA04FE0`, index helper — **no** Grade sample fill |
| `ASHIFT >>> 0xF` + `LSETUP` + `STORE W` | 6 sites only (Threshold meta, i16→f, modifier, emit) |
| `beam+0x579c` | STORE-only; never LOAD as dest |
| Series-offset table `0x44,0x2938,…` in L1D/SDRAM | **none** |
| L1 bank `0xFFA10000` | no `0x147A`/`0x578`/`0x5CFC` |
| `STORE W [I*]` with `0x578` in prior 60 | emit-path scratch only (`0xFF80485C`) |
| memcpy len Grade-sized with dest `beam+0x44` | not found |
| MDMA `START_ADDR == beam+0x44` | not cited |
| Boot map unmapped executable | none outside known SDRAM + L1 |
| `ADD`/`SUB` imm `0x44` | **0 hits** (2026-08-05) |
| Data table `0x44,0x2938` or lens `0x147A,0x051E` | **none** in init blocks (reconfirm) |
| Soft-desc `FFA0763C` as Grade DMA programmer | ruled out — matcher only |
| Pulse helpers / IQ MAC / `0x202256xx` as Grade fill | ruled out |

### Imm `0x44` site cheat-sheet

| VA | Verdict |
|----|---------|
| `0x20211D5C` / `E52` / `F22` | Grade memset |
| `0x20212C86` / `0x2022D128` | Grade int16→float **read** |
| `0xFFA04B90` | Grade emit **write** |
| `0xFFA0391C` | peak finder Grade base |
| `0x2022D78A` | modifier |
| `0x2020BB32` | UI/config **byte** pattern at struct+0x44 |
| `0x2020DF74` | string/UI offset |
| `0x2021112A` | stores `0x44` into `beam+0x579c` meta |
| early `0x2020108C` etc. | memcpy **size** 0x44 |
| `0xFFA077EE` | soft-desc |
| `0x2022DA52` | calls into `FFA038E2` family |

---

## 9. Static / scratch buffers catalog

| VA | Role |
|----|------|
| `0x20215060` | Grade (+Threshold) float work |
| `0x20215044` | index/table near float work (`FFA05CA0`) |
| `0x2022C6A8` | giant int16/float scratch |
| `0x20225EE4` | giant control; `+0x24` → `0x2022C6A8` |
| `0x20225CC4` | related scratch region (`0x2022D2F0`) |
| `0x2022A340` | `FFA033F8` return / modifier window |
| `0x2021F140` | 9-sample float→i16 scratch |
| `0x2021EA00` | companion static in `0x2021FC88` |
| `0x2021E9F4` | `0x2021F97A` state |
| `0xFF80485C` | L1 word cleared in int16→float |
| `0xFF806F30` / `0xFF806F20` | pulse memcpy targets |
| `0xFF90C0` / `0xFF9020C0` | L1 pulse working buffers |
| `0x202D2850` | beam object pointer table |

Raw arena offsets seen in acquire: `+0x6040`, `+0x5280`, `+0x2300`, `+0x34C20`, `+0x4C08`/`0x34C08` class.

---

## 10. bm4 packing — proven layout constants

Packer region `0x202B5202`:

- `LOAD R2 = 0x5BC` — arena Grade absolute.
- `LOAD R5 = 0x147A` — Grade length.
- `memcpy` Grade (and siblings) into outbound blob.
- Stride `0x5CFC` matches header.

Does **not** compute amplitudes.

---

## 11. Open item (only Grade first-fill)

**Need:** first non-zero int16 at `beam+0x44` before first `0x2022D05E`.

Remaining hypotheses (sharpened 2026-08-05):

1. Hardware DMA / peripheral deposits into `beam+0x44` (desc `START_ADDR` from runtime pointer; imm `0x44` never reappears). Soft-desc walker `FFA0763C` does **not** program START_ADDR — it matches descriptors and stores the match ptr at `[P0+0x54]`.
2. CPU `STORE W` via precomputed pointer that never materializes imm `0x44` at the store (indirect / mis-disassembled `||` store). **No** `ADD … 0x44` immediates exist (0 hits); all Grade addressing uses `LOAD = 0x44` then separate ADD — catalog of 18 `LOAD = 0x44` sites still exhaustive for that motif.
3. Outer measurement wrapper fills Grade **before** `0x20220636` via a path not yet cited (pulse helpers `0x2020FD42`/`0x20210546` ruled out as Grade writers — FFT/`FFA06688` + IQ MAC into small caller structs only).

Optional cross-check: older LDR (e.g. 340) for shifted writers; live MMR capture of DMA `START_ADDR` during a scan; patents = high-level only.

After Grade closes: finish Threshold CFAR / AFE / False E. scale identity → update proven sheet → InstallGuide.

---

## 12. Simulation gate

**Allowed as FW-accurate:**

- Layout, lengths, `dh`, stride.
- Quantize `int16 = float_to_i16(f/scale)` for Grade/Threshold/AFE/False E. with cited shifts.
- Display amp ↔ float via `ArrayToFract * gain`.
- False E. seed/`0x7FFF` loop **shape** (scale identity still soft).

**Blocked:** end-to-end Grade amplitude generator; InstallGuide `buildBeamData` must stay labeled not FW-accurate or parse real `.bm4`.

---

## 13. Dump hygiene

- Primary evidence: `../evidence/dumps/grade/` (710 files incl. 101 `dig_*.txt`) + `pulse/`, `hotl1/`, `sf/`, `writers/`, `trace/`, `range/`, `b4/`.
- Index: [`../evidence/dumps/INDEX.md`](../evidence/dumps/INDEX.md).
- Session narrative (do not Grade-filter): [`DSP-FINDINGS-SESSION-2026-08-05.md`](DSP-FINDINGS-SESSION-2026-08-05.md).
- Removed runaway `ireg_grade_fill.txt` (~1.7 GB infinite dump, 2026-08-04). Successor: `ireg_store_grade2.txt`.
- Empty / failed probes left as zero-byte markers are fine; treat as “hunt ran, no hits.”

### High-value dumps (start here)

| File | Why |
|------|-----|
| `acq_call_graph.txt` | acquire CALL order |
| `emit_callees.txt` / `emit_acquire_path.txt` | emit parent + `0x2022D05E` |
| `dump_ffa043c4.txt` | pre-emit mix |
| `dump_147a_l1.txt` | peak / `0x147A` |
| `prove_20224726.txt` | False E. fill |
| `prove_2021fd74.txt` | `0x2021F140` scratch (not Grade) |
| `hunt_5bc_iq_dest.txt` | imm `0x5BC` / `0x147A` inventory |
| `ash15_storew_loops.txt` | ash15 exhaust |
| `dma_desc_beam44.txt` / `mdma_start_hunt.txt` | DMA negatives |
| `irq_softdesc_buffers.txt` | soft-desc / IRQ |
| `giant_p3_grade_dest.txt` | giant ≠ Grade |
| `modifier_grade_ptr.txt` | modifier ≠ first fill |
| `precomputed_44_stores.txt` | all imm-`0x44` neighborhoods |
| `dump_ffa06cfc_irq.txt` | pulse L1 reshape |
| `trace_5b28.txt` | IQ MAC callers |

---

## 14. VA quick reference (alphabetical-ish by role)

```
Init / clear     20211D5C 20211E4E
Acquire          20220636 → … → 2022E118
Emit wrap        2022E118 → FFA0467E → FFA04B90 ; modifier 2022D6DC
i16→f Grade      2022D05E 2022D0FC 20212C5E 20212BAE
Threshold        2021FFE4 ; twin emit 20214350
False E. fill    202246F0…20224726
Peak 147A        FFA038E2
Correlator       FFA03C8A (late)
Beam mix         FFA043C4
IQ MAC           FFA05A56 / FFA05B28
IQ scale         FFA05CA0
Pulse L1         FFA06CFC ; setup 202ECC64/CF2
Soft-desc        FFA0763C ; IRQ FFA07BDE
Sort             FFA033F8 → 2022A340
Giant            2022F986 202316B0 20231E1C → 2022C6A8
bm4 pack         202B5202
Float Grade      20215060
```

---

---

## 15. Session 2026-08-05 — continued first-fill hunt (archived)

### Proven siblings (same emit motif as Grade / False E.)

| VA | Role |
|----|------|
| `0xFFA04DC8`…`0xFFA04E02` | **False E. float→i16 emit twin**: `dest = beam_base + 0x5A26 + i*2`; loads float `[P4++]`; `fdiv`/`float_to_i16`; LC from caller. Preceded by meta `STORE W` of length `0x147` (=327). |
| `0xFFA04E9A`…`0xFFA04ED2` | Same motif into **`beam+0x5798`** (not Grade). |
| `0xFFA04766`…`0xFFA047C4` (inside emit parent, **after** `0x2022D05E`) | int16→float of False E. (`+0x5A26`) and `+0x5798` into sibling float bufs at `0x20215060+0x8A30` / `+0x8514`. Confirms those int16 series already exist by emit time — same constraint as Grade. |

### Emit parent between convert and Grade emit

`FFA0467E`: after `CALL 0x2022D05E`, **no** path repopulates `@0x20215060` Grade floats from IQ/pulse. Only sibling i16→f, peak `FFA04970`, meta at `beam+0x5CD4`…, then `FFA04B90` Grade emit. Float-buf constant `0x5060`/`0x15060` still only **3** code materializations.

### Soft-desc / DMA

- `FFA0763C`: linked-list descriptor **matcher**; stores matching desc ptr to `[P0+0x54]`. Not a Grade sample writer.
- Table `@0xFF803690` (16-byte slots): word0 = DMA MMR base (`0xFFC00C00`, `0xFFC00C40`, …). This is a **DMA channel registry**, not buffer START_ADDR list. Slot+8 holds config/status constants in the image, not `beam+0x44`.
- `FFA0774A`: `LOAD R1 = [slot+0x8]` — reads registry field; `FFA07762` patches `[desc+0x2c]`.
- `0xFFC0` MMR windows surveyed: SIC/control style; **no** cited `START_ADDR = beam+0x44` yet (DMA MMR store hunt in progress: `hunt_dma_mmr_start_stores.txt`).
- Data scan for u16 table `0x0044,0x2938` / lens `0x147A,0x051E`: **no hits** in initialized blocks (reconfirm).
- Standalone u32 `0x5BC` / `0x44` in L1D/SDRAM image: **0 hits**.

### Meta fields `0x5798` / `0x579c`

- `0x579c`: **STORE-only** at init (`0x2021112A` family). **Not** a stable Grade-offset constant — beam0 gets `0x44`, later beams get `0xA0` / `0x110` etc. Do not treat as Grade dest driver.
- `0x5798`: LOADed at emit/convert sites; `0x2022456A` `memset(beam+0x5798, 0, 0x28E)` — `0x5798+0x28E = 0x5A26` (clears up to False E. start).

### Acquire call graph (outer)

`0x20220636` callers: `0x20224130`, `0x202245A8`/`EC`/`0E` (modes 4/5/7 after AFE/`0x5798` clears), `0x202382F2`/`382`, `0x202B5492`.

Outer order near False E. fill (`0x20224000`…):

`0x2020FD42` → `0x20210546` → memset AFE → memset `+0x5798` → **acquire ×N** → False E. CPU fill `0x202246F0`.

Emit wrap also from `0x20221624` (alt path) in addition to `0x20221050`.

### Ruled out this session (do not re-hunt without new angle)

| Probe | Result |
|-------|--------|
| `LSETUP`+`STORE W` with `0x578`, without imm `0x44` | only False E., `0x2021F140` scratch, `0x2022D2F0` scratch |
| `0x202256xx` I-reg+`0x578` | arena `+0x5280/+0x6040/+0x7444` acquire scratch — **not** Grade |
| IQ MAC callers `0x202106E0`/`87C`/`A10` | dest = caller `R5` small struct; length from `+0x5776` taps; FFT `FFA06688` then MAC — **not** Grade-sized |
| Pulse helpers `0x2020FD42` / `0x20210546` | no `0x578`/`0x147A` Grade store motif |
| `ADD`/`SUB` imm `0x44` | **0 hits** |
| `LOAD [P+0x58]` (Grade len field) → `LSETUP`+`STORE W` Grade fill | **none**; init uses `+0x58` for memset sizing only |
| `memcpy`/`memset` with `0x578` nearby | init clears / AFE clear / meta / packer-adjacent only |
| float→i16 + `0x578` without known series offset | False E. / `+0x5798` / modifier / giant — no mystery Grade writer |

### New dump artifacts

`hunt_desc_start_pulse.txt`, `hunt_preemit_grade_writers.txt`, `hunt_iqmac_dest_dmacount.txt`, `hunt_grade_ptr_materialize.txt`, `dump_202256xx_grade_candidate.txt`, `dump_emit_parent_between_convert_emit.txt`, `hunt_acquire_callers_12a64.txt`, `dump_pre_acquire_callers.txt`, `dump_pulse_helpers_grade_hunt.txt`, `hunt_add_imm44.txt`, `hunt_load_p58_loop.txt`.

### Next angles (priority)

1. Live or desc-table reconstruction: find **runtime** 32-bit pointers equal to `arena+0x5BC` / `beam+0x44` stored into DMA soft-desc fields (data, not code imm).
2. Trace `0x202B5492` / `0x202382xx` acquire wrappers further back for any bulk copy into beam before pulse helpers.
3. LDR 340 differential on Grade-offset writers if 452 obfuscates the producer.
4. Revisit mis-disassembly: `_STORE W` in multi-issue packets whose dest register was set outside a 80-insn window of `0x578`.
5. DMA MMR program path via registry `@0xFF803690` → channel base `0xFFC00C00+n*0x40`: find `STORE` of beam/SDRAM ptr into `START_ADDR` (+4). Current `0xFFC0` L1 hits are mostly **SIC** (`0xA10`/`0xA14`/…) not DMA0 — need channel-base-relative stores after `FFA0774A` lookup.

---

## 16. Session continued — vision lock + DMA START_ADDR path (archived)

### Vision (user, 2026-08-05+)

Recover **excruciatingly detailed** FW formulas (Grade / Threshold / AFE / False E. / advanced params) so InstallGuide can later use AI to (1) predict good settings and (2) judge echo-curve quality against physical measurement down to material. Do **not** invent math; archive every proven/partial/ruled-out finding. Grade first-fill remains the simulation gate.

### DMA soft-desc → START_ADDR programming (proven mechanism; buffer identity still open)

| VA | Finding |
|----|---------|
| `FFA077E0`…`FFA078CA` | Soft-desc **init**: loads DMA MMR base from registry `@0xFF803690`; stores MMR ptrs into soft-desc: `[desc+0x4]=MMR_base`, `[desc+0x8]=MMR_base+4` (**START_ADDR register address**), plus CONFIG/X_COUNT/… MMR ptrs at `+0xc/+0x10/+0x14/+0x18/…`. |
| `FFA07A84`…`FFA07AFC` | **Programs HW from args**: `STORE [*desc+0x8] = R1` (START_ADDR ← buffer ptr arg); `STORE W [*desc+0xc]=R5` (config-ish); `[*desc+0x10]=R3`, `[*desc+0x14]=R7`, `[*desc+0x18]=R6` (counts/modifies). |
| `FFA07C14`…`FFA07C38` | Alternate path: START_ADDR value rebuilt from **matched HW desc** at `[soft+0x58]`: `u32 = (u16[desc+0x4]<<16) \| u16[desc+0x2]`, then written through `[*soft+0x8]`. |
| `FFA10420`…`FFA10424` | Only resolved **CALL** into `FFA07A84`: `R1 = [P5+0x14]` (buffer ptr lives in caller struct `+0x14`); counts from `+0x18/+0x1c/+0x20`. |
| `0x2020EE0A` | `STORE [[P3+0x8]] = R7` with `R7` from L1 base `0xFF8022E0` (+offsets) — pulse/L1 DMA, **not** cited as `beam+0x44`. |

### Image data negatives (reconfirmed)

- SDRAM contig: u16 `0x147A` appears **only** as code immediates (5 sites); u16 `0x28F4` **only** at Grade init memset (`0x20211D62`). **No** baked DMA X_COUNT=`0x147A` table in initialized image/L1D.
- `memcpy`/`memset` with Grade-len imms: init clears + packer/`0x2022EDxx` scratch only — **no** Grade-sized CPU copy producer.

### Ruled out / clarified this dig

| Probe | Result |
|-------|--------|
| All `STORE [P+0x44]` (14 sites) | Single-word float/meta stores (incl. init floats wiped by Grade memset); **none** are Grade sample loops (`LSETUP`+`0x147A`). |
| `0x202122FA` | 3-wide float mix into `0x2020F0C2` scratch — **not** Grade. |
| Acquire sqrt `@0x20220D42` then `LOAD [P5+0x44]` | Reads beam `+0x44` as float word for soft-float path after `FFA043C4`; **not** a writer. |
| `0x202B5492` | Direct `CALL 0x20220636` acquire; no pre-acquire Grade bulk fill in wrap. |
| `FFA0586C` family | Fixed MAC / int16 reshape helpers — not Grade first-fill. |
| `STORE [P+0x14]` near beam imms (9 hits) | Packer lengths / meta / emit scratch — **no** cited `beam+0x44` buffer install into DMA struct `+0x14` yet. |

### New dump artifacts

`dig_grade_fill_next.txt`, `dig_sqrt_acq_02894.txt`, `dig_dma_043c4_fill.txt`, `dig_store_plus44_sites.txt`, `dig_memcpy_grade_len.txt`, `dig_softdesc_586c_e876.txt`, `dig_dma_start_via_desc8.txt`, `dig_startaddr_buffers.txt`, `dig_desc_buf_field_writers.txt`, `dig_callers_07a84.txt`, `dig_jump_07a84.txt`, `dig_store_p14_beam.txt`.

### Next angles (priority, sharpened)

1. Who **writes** soft-struct `[+0x14]` (and HW desc `+0x2/+0x4`) with a pointer derived from `arena+0x578+…+0x44`? Trace creators of the `P5` object passed into `FFA104xx`.
2. Follow `FFA07C24` matched-desc chain: who fills HW desc buffer address fields before IRQ/`FFA0763C` match.
3. L1→SDRAM second hop: after pulse DMA into `0xFF80xxxx`, find CPU/`memcpy`/DMA into `beam+0x44` (length may be runtime `range>>15`, not imm `0x147A`).
4. Optional: live MMR capture of DMA0 `START_ADDR` during a scan; LDR 340 differential.

---

## 17. Session continued — buffer-ptr chase (archived)

### `0x202076D8` soft-struct `+0x14` — identified, not Grade

Function `0x20207420` (caller `0x202381AC` measurement wrap, arg `R0=[FF804840]`):

1. `P4` ends as `0xFF803E84` (`MOVE P4=P5` after P5 init).
2. `R7 = P4 + 0x1c` → **`0xFF803EA0`** (L1).
3. `STORE [0xFF8046A0 + 0x14] = R7` — DMA buffer ptr for soft-desc `@FF8046A0` is L1, **not** `beam+0x44`.

Ruled out as Grade first-fill.

### Grade pointer materialize (reader, not producer)

`FFA038E2` peak helper:

```
beam = arena + 0x578 + beamIndex*0x5CFC
grade = beam + 0x44
thresh = beam + 0x2938
STORE grade → [0x20225D04 + 0x8]
STORE thresh → [0x20225D04 + 0xc]
```

Only code materialization of scratch `0x5D04`. Confirms addressing; does **not** write Grade samples.

### Grade-ptr compute catalog (LOAD `0x44` then `ADD P=P+`)

| Site | Role |
|------|------|
| `FFA0391C` | peak (above) |
| `FFA04B90` | Grade emit (known) |
| `FFA077EE` | soft-desc byte-slot stride `0x44` — not Grade |
| `0x2020BB32` | `STORE B` pattern init into small struct `+0x44` (LC=4) — **not** Grade samples |

Only emit remains as Grade `LSETUP`+`STORE W` after grade-ptr ADD.

### Float Grade `@0x20215060`

Still exactly **3** code materializations: `0x20212C5E`, `0x2022D0FC` (i16→float convert family), `FFA04688` (emit parent). No other float-buf filler found.

### Pulse L1→SDRAM memcpy (`0x202ECD4E`)

`memcpy` L1 `0xFF90C0xx` → SDRAM `0x202ED088`; also touches `beam+0x5770/+0x5788`. IQ/pulse path — **not** Grade `@+0x44`.

### Still open

Who deposits first non-zero int16 at `beam+0x44` before `0x2022D05E`. Soft-desc `START_ADDR` programming is understood; no cited path yet installs `arena+0x5BC` / `beam+0x44` as that buffer. Next: HW-desc field writers (`+0x2/+0x4` for `FFA07C24` rebuild); `0x20208xxx` `STORE [P+0x58]` match-ptr chain; live MMR capture.

### New dumps

`dig_bufptr_076d8.txt`, `dig_07420_entry_arena.txt`, `dig_load44_dma_store.txt`, `dig_grade_ptr_uses.txt`, `dig_2020bb32_grade_cand.txt`, `dig_15060_writers_07c24.txt`.

---

## 18. HW-desc `+0x2/+0x4` hunt + matched-desc origin (archived)

### Goal

Find who fills HW-desc START halfwords used by `FFA07C24` rebuild: `u32 = (u16[desc+0x4]<<16) | u16[desc+0x2]`.

### Ruled out / negative

| Probe | Result |
|-------|--------|
| Exhaustive `STORE W [P+0x2]` with beam/ptr context (`dig_hwdesc_buf_fields.txt`) | 36 hits — beam meta/counters, False E. neighborhood, acquire floats; **no** Grade START install |
| Paired `STORE W +0x2` and `+0x4` within 12 insns in L1 | **2** hits only: `FFA09E84`, `FFA0A9EA` |
| `FFA09E3A`…`FFA09EA4` | Writes **fixed** `P1=0xFF801D78` via `DEPOSIT` bitfields; sole caller `FFA0A510`. **Not** runtime beam/Grade desc |
| `FFA0A9EA` | Shadows `0xFFC00000/+4/+8` (system/PLL window) → `0xFF801D78` — **not** DMA0 `0xFFC00Cxx` START |
| Classic addr-split (`LSHIFT >> 0x10` near `STORE W +0x2/+0x4`) | **`addrSplitHits=0`** entire image |
| SDRAM paired `+0x2/+0x4` near beam imms | `0x20220A78` (soft-float `FFA05C38` returns into object meta); `0x202ECB16` (pulse helper) — not Grade DMA |
| `0x20207EB6` / `0x202FD54E` (feed soft `+0x58` in `0x20208xxx`) | Protocol/packet byte builders — **not** DMA START field writers |
| `0x20208A64` `STORE [P3+0x58]=P4` | `P4 = 28*n+0x18` offset vs `0xB54` bound — **index/offset**, not absolute Grade ptr |
| `FFA072E0` label in prior dig | Binary-search jump table helper — not desc START builder |
| Soft-desc init `FFA077EE` imm `0x44` | Channel soft-slot stride walk (`+0x70`) — coincidental imm, not Grade |

### Confirmed (mechanism notes)

- `FFA07C14`…`FFA07C56`: mode `==4` rebuilds START from desc `+0x2/+0x4`; else packs `+0x4/+0x6` into `[*soft+0x8]`.
- `FFA07A84` remains the only cited direct `STORE [*soft+0x8]=R1` START program; sole CALL `FFA10424` with `R1=[P5+0x14]`.
- Peak `FFA0393E` stores Grade **reader** ptr at `[0x20225D04+0x8]`; `[+0x14]` there is beam meta `+0x5CD8`, not DMA soft-desc buffer.

### Implication

CPU does **not** appear to split a 32-bit Grade/arena pointer into HW-desc START halfwords via normal store patterns. Remaining DMA angles: (1) `FFA10424` invoked with a **different** soft-desc whose `+0x14` is Grade; (2) hardware/desc-mode mirror not written by classic split; (3) Grade fill is not DMA. Next: START dispatcher callers / peak-ptr readers / `+0x14` after `0x578` / runtime-len copies (`dig_grade_dma_pivot.txt`).

### Pivot dig (`dig_grade_dma_pivot.txt`) — further negatives

| Probe | Result |
|-------|--------|
| External CALL into `FFA07A84` / START dispatcher | Still **only** `FFA10424 → FFA07A84`; `invokeHits` were internal `JUMP.S` within `FFA103xx` |
| Peak obj `0x20225D04` materialize | **1** site (`FFA03922`) — writer only; no other code loads `0x5d04` |
| `STORE [P+0x14]` with `0x578` in −50 | **3** hits — all false for DMA buf: `0x2020B6D6` stores imm `0x1FF`; `0x2022D2A8` inits scratch `0x20225CC4` to `0x7FFFFFFF`; `FFA03940` peak meta |
| `ASH >> 0xf/0x15` then store loop in acquire `0x20220000`–`0x20222000` | **`ash15Hits=0`** |
| `0xFFC0` + STORE | 30 hits — SIC/PLL/system windows; no cited `0xFFC00C04`-class Grade START with beam ptr |

### Still open (refined)

First non-zero Grade int16 at `beam+0x44` before `0x2022D05E`. DMA register-mode START only proven for soft `+0x14` = L1 (`FF803EA0`) on the known channel. Static RE has not shown HW-desc START halfword writers for Grade.

### Ops note — live MMR capture

**Out of scope** for current setup: production unit + PC software only (no JTAG/ICE). Cannot read `0xFFC0…` DMA START_ADDR at runtime from InstallGuide.

### New dumps

`dig_hwdesc_buf_fields.txt`, `dig_matched_desc_origin.txt`, `dig_grade_dma_pivot.txt`.

---

## 19. Runtime-length L1→SDRAM / Grade hop hunt (archived)

### Goal

Find a CPU `memcpy` / inline copy / `memset`-nonzero that moves samples into `beam+0x44` with length from `range>>15` (or other runtime), **not** requiring imm `0x147A`. This is the “second hop” after DMA into L1.

### Method

`dig_runtime_len_hop.txt`: all `CALL → FFA05F92` (memcpy, n=153); beam/grade `FFA05F2E` (memset); `ASH>>0xf/0x15` then LSETUP/`memcpy`; LSETUP with `ff80/ff90` + beam; acquire helper `FFA043C4` dump; memcpy with `0x44` in −30.

### Inspected candidates — none are Grade first-fill

| Site | Why not Grade first-fill |
|------|---------------------------|
| `0x202ECD4E` | Only **beam+L1** memcpy: pulse `0xFF90…` → `beam+0x5770` / SDRAM scratch — known IQ/pulse |
| `0x20204150` family | `memcpy` len **4** into `beam+0x5CF0` meta — not `+0x44` series |
| `0x20211D70`… / `0x20211F44` | Grade **zero** memset (`R1=0`, `0x28F4` / `+0x58` len) — clears, does not deposit samples |
| All other beam/grade memsets | **`r1zero=true` only** — no nonzero fill-to-Grade |
| `0x2020F960` ash15 | MAC/`A1>>>0xf` soft-float scale — not copy loop count into Grade |
| `0x2022D7DA` ash15 | MAC scale + pairwise `ADD` buffer walk; later reads `beam+0x578` for emit — not L1→Grade |
| `FFA04952` ash15 | Emit-parent float bit loop (`count=(range>>15)+1`) — stores FP temps, not Grade int16 |
| `0x2023148E` LSETUP | Compare/search loop; `0x578` appears **after** — not a fill |
| `0x2020847C` | Imm `0x44` is **protocol magic byte** compare; memcpy 10–11 B config from L1 |
| `0x202B522A` | Packer: writes outbound meta `off=0x5BC` `len=0x147A`, memcpy **6** header bytes — Grade is **source** already filled |
| `FFA043C4` | Acquire helper: builds `beam` base, soft-float on `+0x580` IQ — **no** STORE/memcpy into `+0x44` |

### What this closes (with reason)

Under the known bulk helpers (`FFA05F92` / `FFA05F2E`) and the ash15→LSETUP/`memcpy` patterns surveyed, there is **no** L1→`beam+0x44` second hop. Combined with prior result that the only `LSETUP`+`STORE W` after a Grade-ptr `ADD` is emit (`FFA04B90`), CPU-copy-from-L1 is not supported by current static evidence.

### What this does **not** close

- Custom/inlined copy that never calls `FFA05F92` and never materializes imm `0x44` in-window (pointer passed in).
- Direct DMA into Grade (START path still lacks a cited Grade buffer).
- Pre-acquire writer outside memcpy family.

### Next

LDR **340** differential (`FW_3DLevelScannerM_4_5_340_wrapped`); then broader pre-acquire / non-`FFA05F92` store hunt.

### New dumps

`dig_runtime_len_hop.txt`.

---

## 20. LDR 340 vs 452 differential (archived)

### Goal

See whether FW **4.5.340** still has a clearer Grade first-fill writer that 452 relocated/obscured.

### Method

Parse both LDRs (primary + L1 boot streams → VA maps). Compare Grade motif inventories and signature pairs VA-independently. Dump: `diff_340_452_grade.txt`.

### Proven sameness (not a clearer producer)

| Signature | 452 | 340 |
|-----------|-----|-----|
| `0x44` within 32B of `0x28F4` (Grade memset) | **1** @ `0x20211D5E` | **1** @ `0x20212538` |
| `0x44` within 32B of `0x147A` | **2** @ `0x20211E54`, `0x20211F24` | **2** @ `0x2021262C`, `0x202126FC` |
| `0x578`∩`0x147A` / `0x5BC`∩`0x147A` (32B) | **0** | **0** |
| L1 imm counts `0x44` / `0x578` / `0x147A` / `0x5BC` / `0x28F4` | 9 / 9 / 2 / 6 / 1 | **identical** |

Same motifs, **shifted VAs** (build relocation). Fixed-VA “ONLY340” hits from naive set-diff are relocation ghosts, not new writers.

L1 helpers at 452 VAs (`FFA04B90`, `FFA07A84`, …) are **not** byte-identical at those addresses in 340 — L1 also relocated — but imm inventory matches.

### What this closes (with reason)

340 does **not** expose an additional Grade first-fill path beyond 452’s known memset / packer / emit inventory. Differential alone cannot name the producer; it rules out “452 hid a writer that 340 still shows plainly” for these signatures.

### Still open

Same as after §19: first non-zero Grade int16 before convert. Next: pre-acquire / non-`FFA05F92` CPU store hunt (pointer-arg fills).

### New dumps

`diff_340_452_grade.txt`.

---

## 21. Path 3 — pre-acquire / non-memcpy Grade store hunt (archived)

### Goal

Find first non-zero Grade int16 writer before convert, via CPU stores that do **not** go through `FFA05F92`, including pointer-arg fills and pre-emit acquire body.

### Method / dumps

| Dump | Role |
|------|------|
| `dig_preacquire_grade_store.txt` | Initial STORE W / call-beam44 / wrapper scan |
| `classify_preconvert_stores.txt` | Classify 18 preconvert STORE W; call-arg44; SDRAM LSETUP+STORE W [I] |
| `dig_suspect_fill_helpers.txt` | Callees `0x20210BE6` / `0x2022F986`; bulk `P1++` / `I*` loops |
| `dig_preconvert_timeline.txt` | Acquire CALL timeline until convert-family |
| `dig_preemit_acquire_fill.txt` | Resolve `CALL (P1)` before emit; early LSETUP bodies |
| `dig_emit_prologue_wrapper.txt` | Emit / `FFA0467E` prologue before convert; wrapper; `0x5BC` memset family |
| `dig_outer_acquire_5bc.txt` | Imm `0x5BC`; outer acquire loop; `FFA0467E` reach |
| `dig_desc_5bc_consumers.txt` | bm4 `+0x10=0x5BC` / `+0x14=0x147A` writers & noisy `LOAD +0x10` |

### Refined timing constraint (proven)

Inside acquire `0x20220636`, **`CALL 0x2022E118` (emit entry) is at `0x20221050`**, before the later direct convert twin `CALL 0x20212BAE` at `0x20221338`.

`FFA0467E` (reached from emit via `LOAD P1.L=0x467E` at `0x2022E2D6`) calls convert **`0x2022D05E` at `FFA0475A`** after only beam-meta float loads (`+0x5CD4`…). **No Grade sample fill in emit prologue before convert.**

So Grade int16 must already exist before emit’s convert — i.e. before/during acquire prior to `0x20221050`, or via DMA/IRQ concurrent with that window.

### What path 3 inspected — none are Grade first-fill

| Candidate | Why not Grade first-fill |
|-----------|--------------------------|
| All **18** preconvert `STORE W` hits | Peak-index / meta / False E. (`0x202246FE`) / protocol builders; `FP-0x44` false positives dominate |
| `call-beam44` → `0x202B5024` | Index/search only (no sample STORE W) |
| `0x20210BE6` | Soft-desc / beam meta at `+0x5774`…`+0x579x`; touches `0x20215044` — not `beam+0x44` samples |
| `0x2022F986` | Post-path; zeros meta at arena+`0x4C0C`; no Grade bulk fill |
| SDRAM LSETUP+`STORE W [I*]` (only **4**) | `0x20224E66` protocol; `0x2022D2F0` convert scratch; `0x202EC866`/`0x202ECA78` → **L1** `0xFF90xxxx` |
| Early acquire LSETUP `0x2022083C` / `0x2022087E` | min/max stats over stride — **no** Grade stores |
| Pre-emit `CALL (P1)` targets (`FFA043C4`, soft-float family, `FFA06008`, …) | No `STORE W` bulk into Grade; `FFA06008` uses stack `FP-0x44` (cycles), not beam |
| Named pre-emit callees `0x2020F47C` / `0x2020F330` / `0x2021F97A` / `0x2021FFE4` / `0x202B5066` | No `0x44`+len Grade write pattern |
| Imm **`0x5BC`** | Still **only** bm4 packer `0x202B5202` (`STORE [P0+0x10]=0x5BC`, `[P0+0x14]=0x147A`) then `memcpy` **out** — packet field, not DMA START install |
| `STORE [P+0x10]` near `0x147A`/`0x5BC` | Only packer + init clamp at `0x20211E3A` (length clamp before Grade memset) |

`gradeLikePackHits=0` (no ADD/LOAD `0x44` → float_to_i16-ish → `STORE W` mystery packer).

### What this closes (with reason)

**CPU first-fill via obvious acquire/pre-emit stores, pointer-arg helpers with imm `0x44` in-window, LSETUP `[I*]` / `[P++]` Grade loops, and emit-prologue fill are ruled out** for the scanned inventory. Path 3’s “non-`FFA05F92` CPU store in the pre-convert acquire band” is closed for these signatures.

### Still open (narrowed)

1. **Hardware DMA / MDMA / PPI** depositing into `beam+0x44` / `arena+0x5BC` (no cited START=`Grade` path yet; live MMR capture out of scope without JTAG).
2. Custom/inlined copy with **no** imm `0x44`/`0x5BC`/`0x147A` in-window (deeper nested than scanned).
3. IRQ/handler fill concurrent with acquire (not visible on straight-line acquire disassembly).

### Next

Pivot: DMA/MDMA/PPI programming that uses **runtime** length (`P5+0x58` / `0x147A`) and a **computed** Grade address (`beam_base+0x44` or arena+loaded offset) without co-located imm `0x5BC`; deepen soft-desc `START` rebuild consumers past known L1-only channel.

### New dumps

Listed in Method table above.

---

## 22. Soft-desc START = computed Grade (session dig — partial)

### Goal

Find `STORE` soft-desc `+0x8`/`+0x14` or `CALL FFA07A84`/`FFA10424` where buffer was computed with imm `0x44` (not stack `FP±0x44`) plus beam context.

### Dump

`dig_softdesc_start_grade_compute.txt`

### Hits inspected — not Grade DMA START

| Site | Why not |
|------|---------|
| `0x2020BB32` | Byte pack into object `+0x44` — prior candidate, not beam Grade series |
| `0x20221568` | Imm `-0x44C` false positive |
| `0x202B6A0A` | Control `P5+0x44` / `+0x48` (known non-Grade) |
| `FFA0391C` | Peak path `LOAD P3=0x44` |
| `0x2022D2A8` `STORE [P4+0x14]` | Scratch at `0x20225CC4` gets `-1` — not soft-desc START |
| Only `CALL FFA07A84` co-scan hit `FFA10424` | flags `44/578/147a/5bc` all **false** in −40 |

### Status

Still **no cited** soft-desc START install whose buffer is `beam+0x44` / `arena+0x5BC`. DMA hyp remains open; this compute-window scan does not close it.

### Next

Widen to MDMA/PPI `X_COUNT`≈`0x147A` / `0x28F4` without requiring co-located `0x44`; IRQ handlers that `STORE W [P++]` into an arg pointer; re-read soft-desc init tables for any START absolute in SDRAM Grade range.

---

## 23. MDMA/PPI Grade-length co-scan (archived)

### Goal

See whether Grade sample/byte lengths (`0x147A` / `0x28F4`) are programmed into DMA MMR (`0xFFC0…`) or soft-desc START fields in the same window.

### Dump

`dig_mdma_ppi_grade_len.txt`

### Proven inventory

| Imm | Sites | DMA-ish in +60? |
|-----|-------|-----------------|
| `0x147A` / `-0x147A` / L1 uses | 10 total (SDRAM+L1) | only **memset** `0x20211D62` (`FFA05F2E`) and **bm4 packer** `0x202B5216` (`FFA05F92` out) |
| `0x28F4` | **1** — Grade memset max bytes @ `0x20211D62` | memset only |
| `FFC0` STORE windows with `147a`/`28f4`/`578`/`5bc`/`5cfc` | **0** interesting | 55 FFC0 store sites scanned; none co-locate Grade len/beam |

### What this closes (with reason)

No static path programs Grade length into Blackfin DMA MMR in the same instruction window as `0x147A`/`0x28F4`. That does **not** prove DMA is absent (runtime count from RAM still possible); it rules out the obvious “X_COUNT = 0x147A next to FFC0 poke” pattern.

### Still open

DMA/IRQ with **runtime** length; undocumented peripheral path; deeper nested CPU fill without markers.

### Next

Soft-desc **init tables** / absolute START constants in SDRAM Grade VA range; IRQ `STORE W [P++]` with large LC; trace who fills soft `+0x14` when `+0x58` length equals Grade count.

---

## 24. Soft-desc `+0x14` writers + IRQ/outer pre-acquire (archived)

### Goal

Close remaining soft-desc buffer-install and IRQ/outer CPU-fill angles for Grade first-fill.

### Dumps

`dig_soft14_writers_irq_fills.txt`, `dig_2022d7ce_grade_ptr_use.txt`, `dig_peakobj_grade_writers.txt`, `dig_outer_preacquire_calls.txt`

### Soft-desc table / `+0x14` init

| Finding | Detail |
|---------|--------|
| Static table `@0xFF803690` | Slot PTR words are config/MMR-ish — **no** `0x202xxxxx` Grade START in dump (`dump_softdesc_ff803690.txt`) |
| `FFA0788C` | Soft-desc **init**: `soft+0x14 = MMR_base+0x14` (DMA register address), **not** a sample buffer |
| `STORE [P+0x14]` inventory | **85** sites; beam-flagged ones = peak meta (`FFA03940`), bm4 packer length (`0x202B521A`), control `P5+0x14`, counts — **none** install `beam+0x44` as DMA START buffer |
| `0x2022D7CE` | Computes `grade_ptr` (`+0x44`) into `FP-0x1c`; `STORE [P3+0x14]` is a **count**, not the ptr. Runs in `0x2022D6DC` **after** emit/`FFA0467E` convert — **cannot** be first fill |

### IRQ / L1 bulk stores

| Probe | Result |
|-------|--------|
| `RTI` handlers with `STORE W` in body | **`rtiFillHits=0`** |
| L1 `LSETUP`+`STORE W [P++]` | **11** — `FFA05F68` family = **memset** (`FFA05F2E`); others reshape helpers; **no** `0x44`/`0x578`/`0x147A` |
| Soft-desc IRQ handlers `FFA07BDE`… | MMR program from HW desc (`FFA07C24` rebuild) — known; not Grade samples |

### Acquire / outer negatives (strong)

| Probe | Result |
|-------|--------|
| Peak obj `0x20225D04` materialize | Still **1** site (`FFA03922`) — writer only |
| `LSETUP`+`STORE++` in acquire `0x20220636`…`0x20221050` | **`allAcqLsetupStoreHits=0`** |
| Outer calls before first acquire `0x20224000`…`0x20224130` | Only `FFA05C38` / `FFA05EE4` / `FFA0586C` (soft-float/MAC) — **no** Grade fill |

### What this closes (with reason)

- Soft-desc **static** tables and init do not point START at Grade.
- No RTI/L1 IRQ loop found that bulk-writes Grade.
- Straight-line acquire before emit has **no** `LSETUP` store-fill at all.
- Outer prologue before first acquire is soft-float only.

### Still open (narrowed further)

1. DMA with **runtime** buffer ptr (soft `+0x14` overwritten after init to Grade) — still no cited writer.
2. Nested callee of acquire using **non-LSETUP** store pattern (unrolled / helper without imm markers).
3. Hardware path not visible in CPU disassembly.

### Next

Hunt writers that `STORE` into soft-desc objects’ buffer field after `FFA078xx` init (especially any `STORE [P+0x14]=` where value is `ADD` of loaded beam base); scan acquire callees one level deeper for unrolled `STORE W` Grade fills; consider whether Grade int16 is produced only via emit rewrite from a **different** float source than `@0x20215060` (re-verify convert source).

---

## 25. Pre-bm4 window + convert re-verify + pulse/`0x1770` (archived)

### Goal

Keep scraping **how the main echo-curve (Grade) series is first formed**. Tighten the fill deadline, re-prove convert reads Grade int16, classify remaining acquire callees / pulse overlap.

### Dumps

`dig_pre_bm4_fill_window.txt`, `dig_147b_memcpy_grade_dest.txt`, `dig_20211d_grade_memcpy.txt`, `dig_float_grade_writers_emit_order.txt`, `dig_20212c_float_convert_chain.txt`, `dig_pulse_memcpy_into_grade_span.txt`, `dig_beam_1770_writers.txt`, `dig_pulse_ec5de_dma_wait.txt`, `dig_falsee_pattern_twin_grade.txt`

### Timing — tightened

| Constraint | Evidence |
|------------|----------|
| Grade int16 before convert | `0x2022D05E` computes `beam+0x44` then `LOAD R0 = W [P1]` → float `@0x20215060` (`dig_147b…`) |
| Convert inside emit parent | `FFA04752` `P1=0x2022D05E`; call `@FFA0475A` |
| Acquire before emit | … → conditional `0x202B5066` `@0x20220EF0` → `0x202122FA` `@0x20220F9A` → emit `0x2022E118` `@0x20221050` |
| bm4 packer | **Reads** Grade (`0x5BC`/`0x147A` memcpy **out**); runs only under flag bytes — not a producer |

### Acquire CALL `(P1)` map `0x20220636`…`0x20221050` — fully resolved

All indirect targets are soft-float (`FFA01688`/`1814`/`1716`/`18F0`/`248C`/`16D4`), `FFA00FB4` (abs/div helper), `FFA05C38`, `FFA043C4`, `FFA06008`, plus direct `0x202B5024` / `0x2020F47C` / `0x20210BE6` / `0x2020F330` / `0x2021F97A` / `0x202B5066` / `0x202122FA` / `0x2022E118`. **None** is a Grade sample filler.

### Ruled out this dig

| Candidate | Why not first-fill |
|-----------|-------------------|
| `0x20210BE6` LSETUP `STORE W [P0++]` | LC=`5`; dest is pulse-meta scratch from `FP+0xc`; writes `+0x577x`/`+0x57cx` — not `+0x44` |
| `0x202ECC64` / `0x202ECCF2` | Pulse helpers; `FFA05F92` at `0x202ECD4E` is **L1`0xFF9000C0` → scratch `0x202ED088`** (memcpy `R0=dest,R1=src,R2=len`) |
| Geometric `beam+0x1770` inside Grade span | True as addresses (`0x1770∈[0x44,0x2938)`), but pulse writes via `0x202ECA00` land at **`beam+0x5788`** / L1 — **not** proven Grade sample deposit at `+0x44` |
| `0x202EC5DE` | Soft-float table build (`0x202EAxxx` / `FF806F28`) — not DMA START→Grade |
| `0x20211Dxx` `0x44`/`0x147A`/`0x28F4` | **memset** only (`FFA05F2E`) — already on proven sheet |
| `0x2020F47C` `0x147B` | Clamps a **control word** at `0x2020F03C+8`, not Grade samples |
| `0x20212BAE` float `@0x20215060` | Twin of convert; callers `@0x20221338`/`0x202213BA` are **after** emit in acquire |
| Float buf alt writers | Still exactly **3** `0x5060` materializations (emit parent + convert family) |
| False-E-like Grade fill | `gradePtr→LSETUP→STORE W` hits = **1** = emit `FFA04B90` only; False E. pattern at `0x5A26` detected; no Grade twin |

### What this closes (with reason)

- CPU first-fill via imm-marked loops / memcpy-to-`+0x44` / False-E-shaped store loops is **exhausted** under current static patterns.
- Convert **does** read pre-existing Grade int16; emit requantizes floats back — first non-zero int16 must precede `0x2022D05E`.
- Pulse path uses addresses that **overlap** the Grade byte range but, on cited stores, targets meta/`+0x5788`/L1/scratch — do not treat `+0x1770` as proven Grade producer without a cited `STORE`/`DMA START` to that ptr as sample dest.

### Still open (narrowed)

1. **Hardware DMA / IRQ** depositing into `beam+0x44` with **runtime** buffer/length (no imm `0x147A` co-located with MMR poke).
2. Soft-desc buffer field overwritten after init to Grade ptr (still no cited writer).
3. Producer hidden in a helper that builds Grade ptr without a local `0x44` imm (e.g. offset in register / table).

### Next

Trace correlator `FFA03C8A` **output** buffer identity vs Grade; hunt DMA START installs whose value is `beam_base + reg` without imm `0x44` in-window; inspect `FFA06008` wait sites for concurrent channel completion that could have filled Grade.

---

## 26. Peak-obj Grade ptr + wait helper + outer acquire (archived)

### Dumps

`dig_correlator_out_dma_start_reg.txt`, `dig_peakobj_grade_ptr_consumers.txt`, `dig_preacquire_and_peak_caller.txt`

### Peak object `0x20225D04` — Grade ptr holder, not producer

| Field | Value at `FFA0393E`… |
|-------|----------------------|
| `+0x0` | length-related |
| `+0x8` | **`grade_ptr = beam+0x44`** |
| `+0xc` | Threshold ptr `beam+0x2938` |
| `+0x10` / `+0x14` | scale/meta |

Only absolute materialize of `0x5D04` is this site. Function then **reads** `W[grade_ptr+…]` for peak math (`FFA02948`/`fmul`). Callers: `0x20212F1C`, `0x2022DB02`. **Consumer** of existing Grade int16.

### `FFA06008`

Cycle-stamp + poll `0xFF806EE0` flag bits; pokes `0xFFC00208`. Sync/wait helper (used near pulse/`ECA00` and acquire pre-bm4). Does **not** itself write Grade; may wait for HW that does.

### Correlator

Still only called from `0x202303AC` (post-emit giant path) — not first-fill.

### Outer → acquire

Acquire callers in `0x20224xxx` (e.g. `0x20224130`, `0x202245A8`). Immediately before first call: soft-float only. Nearby memset is `beam+0x5798` len `0x28E` — meta, not Grade.

### Still open

Same as §25: first non-zero Grade int16 before convert — static CPU patterns exhausted; HW/DMA/runtime-ptr remains.

---

## 27. Soft-desc DMA SM closed for Grade (archived)

### Dumps

`dig_irq_vectors_dma_sm.txt`, `dig_callers_ffa0bf14_start.txt`, `dig_ctrl_202060dc_plus14.txt`, `dig_ffa100d4_convention.txt`, `dig_softdesc_buf_installers.txt`, `dig_alloc_081a4_softinstall.txt`, `dig_all_ffa07a84_and_r5.txt`, `dig_callers_20207774.txt`, `dig_alt_dma_start_paths.txt`

### DMA state-machine API (proven)

| Piece | Addr | Role |
|-------|------|------|
| SM entry | `FFA100D4` | `R0`=channel obj, `R2`=desc/list, wrapper case via caller local → `FP+0x14` |
| Jump table | `@FF803BDC` | case 2 = `FFA1040A` |
| Case 2 | `FFA1040A` | `R1=[P5+0x14]` → **`CALL FFA07A84`** (programs HW START) |
| Wrapper case 1 | `FFA0BF00` | stores case `1`, calls SM |
| Wrapper case 2 | `FFA0BF14` | stores case `2` (= START), calls SM |
| `FFA07A84` | — | **sole** call site in image is `FFA10424` |

IRQ/EVT scan: jump table lives in `FF80xxxx`; `CALL (P1)` into `FFA0BFxx` from `0x202058xx` / `0x202077xx` / `0x2020AFBA` (not acquire Grade path).

### All `FFA0BF14` (START) callers — buffers ≠ Grade

| Site | `R2` (→ SM `P5`) | `[P5+0x14]` buffer |
|------|------------------|---------------------|
| `0x20205832` | `0x202060DC` | `[0x202060F0]=0x20205FB4` (meta; filled in same fn) |
| `0x202078F6` | soft-desc built by `0x20207774` | whatever caller passed as `R0` |

### Soft-desc installer `0x20207774`

- Builds desc at `FF804708 + f(index)`; **`STORE [desc+0x14]=R0`**; later `FFA0BF14`.
- **8 callers** (`0x202085E0`…`0x202091DC`): buffers are fixed/comm slabs (`0x20209280`, `0x2020A280`, `0x202096C8+0xBB8*n`, etc.), lengths like `0x191` — **no** `beam+0x44` / `0x5BC` / `0x147A`.
- Known L1 install still only `0x202076D8`: `FF8046A0+0x14 = FF803EA0`.

### Grade soft-install hunt

No `beam+0x44` / `0x5BC` materialize within ~40 insn of `STORE [P+0x14]` except known non-producers (peak obj `FFA0393E`, bm4 packer `0x202B5202`, window meta `0x2022D78A`).

### Implication (high confidence)

**The soft-descriptor DMA START pipeline never targets Grade** in static reachability. First non-zero Grade int16 is **not** explained by `FFA07A84` / `FFA0BF14` / `0x20207774`.

### Still open

1. CPU fill of `beam+0x44` without local imm `0x44` (reg-held offset / table).
2. Non-soft DMA (direct MMR / other helper than `FFA07A84`) — `FFA07C14` / `0xffc0` MMR paths still to classify.
3. Fill into a scratch that is later alias-mapped or bulk-moved onto Grade without a Grade-shaped memcpy signature.

### Next

Classify `FFA07C14` + all `0xffc0` MMR programmers for START_ADDR==Grade; hunt pre-convert `STORE W` loops whose dest base is loaded from a beam object field (not imm `0x44`); re-check acquire wait `FFA06008` for sibling channel completion that could imply a hidden producer.

### Follow-on digs (same §)

- `FFA07A84` body: `STORE [*ch+0x8]=R1` with `R1` from soft `+0x14` — confirms START_ADDR path; still only reached from `FFA1040A`.
- Outer acquire fill loops `0x20224700` / `0x20224BB2` / `0x20224C14`: **False E.** (`+0x5A26`) or fixed scratch (`0x2021F4B4` / `0x2021F194`) — not Grade.
- L1→Grade copy: no insn imm `0x3ea0`; no LSETUP drain onto `beam+0x44`. Soft `FF8046A0` real init only `0x20207688` (H=`ff80`). Scan hit `0x20203C4E` is **`0x202046A0`** — ignore.
- `FFA077EE` `P3=0x44`: soft-desc **node field stride**, not Grade.
- Acquire CALL targets through emit (`0x20220636..0x20221100`): **no** Grade sample filler; bm4 `0x202B5066` only writes packet meta (`STORE [obj+0x44]=0x5bc`).
- Grade-ptr install scan: still only peak `FFA0393E` (+0x8) plus convert/emit/memset — **no** HW-desc binding of `beam+0x44`.
- `FF806EE0` completion flag: set bit0 at `FFA02AB2`, bit1 at `FFA02C3C` (after `FFA0ADD0`); polled by `FFA06008`. Next: whether those IRQ paths imply a HW buffer already at Grade, or only L1/comm completion.

---

## 28. Pulse/AFE / alt-START / runtime-dest / acquire helpers (archived)

**Full narrative + 101-dig catalog:** [`DSP-FINDINGS-SESSION-2026-08-05.md`](DSP-FINDINGS-SESSION-2026-08-05.md) (sections A–O).  
This § keeps archive-local bullets; the session doc is the exhaustive record (DMA/IRQ/pulse/control included even when not Grade).

### Dump inventory (this wave — not Grade-filtered)

All `grade/dig_*.txt` (101 files) are listed in the session doc §A and in `INDEX.md` under `### dig_`. High-traffic dumps from this continuation:

`dig_pulse_afe_alt_start`, `dig_direct_mdma_start_pokes`, `dig_hwdesc_start_halfword_writers`, `dig_convert_2022d05e_full`, `dig_147a_dma_count_near_start`, `dig_bypass_start_channel_obj` (214KB), `dig_runtime_dest_storew`, `dig_579c_and_ffa043c4`, `dig_falsee_caller_grade_twin`, `dig_20224500_full`, `dig_float_grade_writers_all`, `dig_between_convert_and_emit`, `dig_20212a64_between_emit`, `dig_loaded_offset_grade_store`, `dig_word_store_grade_span`, `dig_acquire_call_p1_targets`, `dig_unknown_acquire_targets`, `dig_callers_2020f330`, `dig_20220b2e_walk`, `dig_acquire_entry_fp3c`, `dig_generic_storew_helpers`, `dig_correlator_dest_grade`, `dig_arena_soft14_grade`, `dig_completion_irq_ffa02a`, `dig_flag_806ee0_writers`, `dig_20211d26_before_memset`, plus §27 DMA SM set.

### DMA / MMR / IRQ (useful beyond Grade)

- Soft SM API unchanged (§27): `FFA0BF14` → `FFA1040A` → **sole** `FFA07A84`; buffers on known callers ≠ Grade.
- Registry `@FF803690`: `FFC00C00`/`C40`/`C80`/`CC0`; consumers only `FFA077xx`.
- Bypass `STORE [P+0x4/0x8]` sweep: IRQ `@FF803E34`, peak obj, soft builders, beam meta — **no** Grade→`FFC00Cxx` START.
- HW-desc halfword START writers: soft-chain / fixed L1 (`FF801D78`) — not `beam+0x44`.
- Direct `FFC0` pokes: SIC `A10`/`A1C`…; pulse helper `FFA070E0` programs `FFC0A00`/`A04`/`A08` then calls into `0x202D2864`; `0x202D2C78` touches `FFC03200`/`320C` (not MDMA START).
- `FFA07194` in that region is the **sin table** helper (also correlator) — not DMA.
- Wait flag `FF806EE0`: writers `FFA02AB2` / `FFA02C3C` (+ refs); body `FFA02A1E` is soft-desc bookkeeping + cycles — **no** Grade stores.

### Convert / emit / float workbuf

- `0x2022D05E`: Grade int16 **reader** → `@0x20215060`; sibling read `+0x3374`.
- Float Grade still **3** materializations only (`FFA04688`, `0x20212C5E`, `0x2022D0FC`).
- `FFA0467E` after convert: False E./`+0x5798` float siblings → `CALL 0x20212A64` (window meta) → wait/peak → `FFA04B90`. No IQ rewrite of float Grade.

### Acquire helpers (correct labels)

| VA | Role (proven this session) |
|----|----------------------------|
| `0x2020F330` / entry `0x2020F306` | Interleave `STORE W` copy (`R0` dest, `R1`/`R2` src, stack count) — **not** “float scale” |
| Call `@0x20214798` | Dest `0x2020F114`, count 0 → no-op |
| Call `@0x20220B2E` | Dest **`0x2021EA7C`** (`FP-0x3c=0x2021EA72` + `0xA`) control object |
| `0x2020F47C` | Control structure zero + cycles stamp |
| `0x20210BE6` | Meta / `FFA06008` / `>>4` fields |
| `0x2021F97A` | Bit/scale helper on `@0x2021E9E8` |
| `FFA05C38` / `FFA05B30` | Complex MAC → `STORE W` high-halves + soft-float |
| `FFA043C4` | Beam IQ mix at `+0x580`; no Grade `STORE W` |

Acquire entry stores `P1=0x2021EA72` into `FP-0x3c`.

### Outer wrapper / False E. / Threshold / AFE

- Wrapper calls acquire **before** False E. fill `0x202246F0`.
- Memset AFE `+0x4D5C` (`0x51E`) and `+0x5798` (`0x28E`) when bits set.
- Runtime `STORE W` without imm `0x44`: Threshold clear/emit, AFE emit, pulse meta — tabulated in session §J.

### Beam / control meta

- `beam+0x579c`: STORE-only; never LOAD as dest driver.
- `0x20211D26` `STORE [P5+0x44]` = control fields **before** Grade memset (not sample fill).
- Soft `+0x14` near `0x5BC`: bm4 packer packet meta only; `0x2022D2A8` writes meta `@0x20225CC4`.

### Correlator

- `FFA03C8A`: stack/scratch MAC + sin; caller `@0x202303AC` post-emit — keep for non-Grade DSP.

### Grade first-fill status

Still **OPEN**. Soft/alt DMA START, runtime CPU twin, float third-writer, convert↔emit overwrite, f330→Grade, correlator-first, soft+0x14 Grade bind all negative.

---

## 29. Dig catalog pointer + INDEX

- **§P/§Q/§R waves** → **113** dig files on disk (INDEX `### dig_` refreshed surgically).
- Exhaustive early catalog of **101** files: session doc **§A**; newer digs in **§P** / **§Q** / **§R**.
- `../evidence/dumps/INDEX.md` section `### dig_` lists every file.
- Scripts: session doc **§O**–**§R**.
- **Backups:** `../evidence/dumps/_backups/backup_dsp_docs.ps1` + `README.md` (triple copy; do not naive-regenerate INDEX).

---

## 30. I-reg / acquire LSETUP / pulse `+0x1770` / `FFA07C14` (archived)

Full narrative: session **§P**. Dumps: `dig_memset_to_convert_inventory`, `dig_ireg_parallel_grade_stores`, `dig_ffa07c14_mdma_start_abs`, `dig_acquire_lsetup_and_07c14_refs`, `dig_pulse_store_dest_grade`.

### Negatives (Grade first-fill)

- I0/I1 / `||` STORE W near Grade imms: only known emit/zero paths — **no** first-fill.
- Acquire LSETUP `@0x2022083C`/`87E`: **min/max** control reductions, not Grade fill.
- Absolute MDMA `FFC00Cxx` START programmers: **none** found; `FFA07C14` rebuilds channel fields from HW-desc (0 Ghidra refs by abs addr).

### Non-Grade but important (span overlap)

- Pulse memcpy/IQ uses `beam+0x1770` (**inside** Grade byte span). Writes mid-Grade buffer / pulse slot — **not** producer of Grade from `+0x44`.
- Sites: `0x202ECD26`, `0x20210DD0`, `0x202106C8` family → `FFA05F92` / `0x202ECA00` / `FFA05A56`.

### Still open

Same as §28: first non-zero int16 at `beam+0x44` before `0x2022D05E`.

---

## 31. FF90 / memcpy / fn-ptr / word-fill (archived)

Full narrative: session **§Q**. Dumps: `dig_ff90_memcpy_grade`, `dig_unresolved_fnptr_windows`, `dig_word_fill_add44_bulk`. Dig count → **109**.

### Negatives (Grade first-fill)

- All `CALL (P1)` in acquire/outer/pulse/beam-init/emit: **resolved**; targets = known L1 only; **0** unresolved.
- FF90 co-located with Grade: convert **reader** + pulse mid-span only.
- Grade-ish memcpy: small sizes only; **no** `0x28F4` / Grade-length hop onto `beam+0x44`.
- Word `STORE [P++]` Grade-ish: correlator only; `+0x44`+bulk: memset clear only.
- `0x6040` raw: modifier scratch, not Grade base.

### Still open

Unchanged. Next: pre-memset / out-of-window producers; PPI→arena rename; image template; deeper multi-issue decode.

---

## 32. Sensible pipeline closure (archived)

Full narrative: session **§R**. Dumps: `dig_meta_offset_grade_fill`, `dig_acquire_callee_grade_store_scan`, `dig_raw_fixedfloat_to_grade`, `dig_grade_ptr_consumer_stores`. Dig count → **113**.

### Proven tightenings

- Convert `0x2022D05E` sole caller: emit parent `FFA0475A`.
- Acquire SDRAM callees + `FFA043C4`: **no** Grade-shaped sample stores.
- Meta `+0x579c`: install-only, never loaded as dest.
- Peak `grade_ptr`: install/read for peak — **no** `STORE W` fill via that pointer.
- Pre-acquire raw cluster `0x20221936` ← `0x202383B6`: control `+0x44` fields, not Grade samples.

### Implication

CPU-visible measurement pipeline does not produce first Grade int16 before convert. Remaining: init-time HW buffer absolute, image-resident descriptors, or live capture.

---

*Archive updated as findings close. Prefer appending new bullets here and promoting only proven simulation-facing facts into `DSP-GRADE.md`. Non-Grade machinery belongs in the archive/session log anyway.*
