# Certainty log — Echo Curve / LDR RE

Rule: no guessed DSP. Simulation OK only with full math proven from the image.

## Whole-picture status

See **`FULLMAP.md`**. Boot-stream map rebuilt; L1 + SDRAM in Ghidra (`fullmap/ghidra_boot_project` was not copied).

## Proven highlights

| Fact | Evidence |
|------|----------|
| Entire `.ldr` is addr/count/flags boot stream from offset 0 | `fullmap/boot_blocks_full.json` |
| App code/data VA base **`0x20200000`** (not `0x20000000`) | LDIMM sites + materialized contig |
| Grade strings in L1 Data `@0xFF802EC8` | load block + byte search |
| `0xFFA05F2E` = **memset** | `ghidra_boot_dump/asm_ffa05f2e.txt` |
| Max series length **5242** int16; clear via `memset(dst,0,n<<1)` | `asm` at `0x20211E4E` |
| `FUN_2020caa4` = config/UI switch, not sample DSP | decompile |
| Grade fill is **NOT a CPU loop in `acquire`** — no CPU store to `beam+0x44`, only a READ at `0x20220d58` | sim disasm `DSP-FINDINGS-SESSION-2026-08-06` |
| Beam layout: stride **`0x5CFC`**, Grade at **`beam+0x44`** (one int16/bin), Threshold at **`beam+0x2938`**, float scales at **`beam+0x5CD4/0x5CD8`** | sim disasm of `acquire` + convert-twin |
| `0xFFA06688` = **FFT** (bit-reverse + radix-2 DIT, Q15, block-floating-point stages, shift 0/1/2 by peak vs `0x3504/0x6A09`, returns total shift) — **full butterfly math recovered** | sim disasm t21/t25 |
| Per-beam FFT size log2N = **10/10/11/12/12** (field `hw+0x5774`) | `r_20210be6.c` |
| Chain: ADC DMA → L1 re/im `0xFF9000C0/0xFF9020C0` → FFT fwd → **matched filter `0xFFA05A56` = X[k]·conj(Ref[k]) in-place, scale>>16** → FFT inv → interleave `0x2020F306` / normalize-interleave `0x202ECB14` | sim disasm t22/t27/t31 |
| **Pulse compression**: Grade ∝ \|IFFT(FFT(echo)·conj(FFT(chirp)))\| per bin; ref spectrum at `hw+0x1770` (precomputed by `0x202ECEC8`) | sim disasm t31 |
| Twiddle table = `round(sin(2πk/4096)·32767)` at **`0xFF800100`** (byte-verified); `[hw+0x577C] = 12−log2N` | L1 snapshot dump + `0x20210C8E` init loop |
| Magnitude `0xFFA05CA0` = per-bin **sqrt(re²+im²) → float**, called from `0x2021F97A` (src `ctx+0x4E958/0x4E814`, dst `ctx+0x4EB08/0x4E9C4`) | sim disasm t21/t28 |
| convert-twin: `float = int16(beam+0x44) * scale(beam+0x5CD4)`; lens from `ctx+0x584` bits 15/17 | sim disasm t22 |
| Float lib CORRECTED: `0xffa018f0`=**mulsf3** (adds exps), `0xffa01814`=**divsf3** (subs exps), `0xffa01716`=addsf3, `0xffa014dc`=fixsfsi(int32), `0xffa028c8`=float→fract32 Q31 sat, `0xffa0248c`=**rsqrt** (table `0xff80349c`+3 Newton), `0xffa020d4/0xffa00da4`=sin/cos | sim disasm t35/t46/t50 |
| Band distance scale: `n_mm=int(param·1000)` → `[cfg+0x4E0]`; `scale=fract32(331.2998f/1000·rsqrt(n_mm·273118.6f+1))` → `[cfg+0x4EC]`; `bin=(range_fixed·scale)>>32` | sim disasm + in-sim exec t54 (n=0 → `0x2A6809C0` exact) |
| Chirp sin/cos table gen `0x202ec5de`: `θ=k·2π·step`, tables `~0x202eb1e0..0x202ec6e3` (self-overwriting init RAM) | sim disasm t45b (clean image) |
| `0xffa01c74` = **powf** | t35 disasm + `hot_ffa01c74.c` |
| Beam series: Grade `+0x44`/5242, Threshold `+0x2938`/1310, **AFE `+0x4D5C`/655**, False E. `+0x5798`/327 + twin `+0x5A26`/327 | emit/memset + L1 tags `@0xFF802EC8` + BM4 lengths |
| Cmd 151 payload: To, opcode 4/5/6/7/8, start flag, From, Threshold, beam mask | `HartPacker.PackCommand151` |

**Start here:** `../RESEARCH-CLOSED.md` (finished support math), then `HANDOFF.md`.

## Not proven

The final **float→int16 quantization write into `beam+0x44`** (writer fn TBD —
candidates `FUN_2021ffe4`, tail of `0x2021F97A`).
**Later cite (do not drop the line above):** `DSP-GRADE.md` names **`0xFFA04B90`** as that write loop:
`v = float_to_i16(grade_f[i] / scale)`, `scale = max(grade_f)` → `beam+0x5CD4`. Keep both until a session re-traces `0xFFA04B90` against the old candidates.

ADC DMA MMR programming. Threshold / False E. transforms (Threshold reads like Grade at
`beam+0x2938` but its fill not individually proven). AFE fill math (655 pts) and
false-echo *apply* (clip/AND) not proven. Cmd 151 firmware unpack not found (no LDIMM
151/172/174 in image — likely jump table).
Distance scale inputs: which config param feeds `param_float` (struct `0x20214ff4`),
`range_fixed` format into `FUN_ffa0586c`, bins→5242 mapping, temperature compensation site.
Any formula that used `0xffa018f0` as **divide** (e.g. old "value/41000" normalize note) —
it is **multiply**; re-derive those sites.

## Simulation gate

Implement FW-derived `buildBeamData` only after `DSP-GRADE.md` cites the write-loop math.

---

## Addendum — logic vs bit-identical (2026-08-17, **appended**, does not replace the tables above)

**If we have the math, we can follow the logic** (why a peak was kept, why a map
window exists, how Grade is an envelope of pulse compression). That does **not**
require replaying ADC DMA bit-for-bit.

**“Not byte-to-byte”** only meant: guide Grade samples are a demo envelope. Pick is
Grade vs Threshold only (maps/damping/SNR clip were removed; they were never in the helper).

Formulas (with registers) also live in `HANDOFF.md` §F2.

### Extra proven rows (additive; same facts as highlights where they overlap)

| Fact | Math | Register / evidence |
|------|------|---------------------|
| Grade float→int16 write (cite) | `count=(range>>15)+1`; `v=float_to_i16(grade_f[i] / scale)`; store `beam+0x44+2i` | `0xFFA04B90` (`DSP-GRADE.md`) |
| Display round-trip | `amp = ArrayToFract(i16) × gain`; `gain≈scale` → amp ≈ grade_f | `BeamDataParser` |
| Peak helper | `G=g×scale×1.01`; if `G>T`: `acc+=G²`, `last_i=i`; return `rsqrt(acc/count)` | `0xFFA038E2` |
| Distance-power | piecewise `pow` on `(r+0x20C49B)` vs T0/T1 | `FUN_20212a64` |
| PC Grade axis | `h(i)=offset + i×(1000/65536)` m (~80 m span) | BM4 fract32 |

### Progress on open items (2026-08-17, appended from existing dumps — not a rewrite)

Worked from session notes + `twin_20214300.asm` + `dig_20224500_full.txt` + HANDOFF §D +
`trace_t47`. Open table below is unchanged; this is extra math we can now write down.

**ADC → `0xFF9000C0` (destination + wait proven; MMR poke still open)**

- Live path (`0x20210546`): `FUN_ffa06008` spins until event `0xFF806EE0` is set, then
  FFT reads **re = `0xFF9000C0`**, **im = `0xFF9020C0`** (session 2026-08-06 §2).
- Soft-desc field `+0x8` is the **START_ADDR MMR pointer** (buffer is programmed
  *through* that), not the sample buffer itself (`dig_softdesc_bufptrs_image.txt`).
- Ref/chirp path **memcpy** `0x202ED088 → 0xFF9000C0` (`cnt×2`) then `memset` im
  `0xFF9020C0` (`0x202ecec8` / `0xffa05f92`). That is precompute, not ADC.
- Still missing: which DMA channel / PPI `START_ADDR` word is written for ADC.

**Threshold / AFE int16 emit (quantize math proven; float *generator* still open)**

Same `range_field` at `ctx+0xC` / `ctx+0x584` family:

```
n_grade = (range >> 15) + 1     // 5242
n_thresh = (range >> 17) + 1    // 1310  (= Grade ÷ 4)
n_afe    = (range >> 18) + 1    // 655   (= Grade ÷ 8)
```

Threshold loop `0x20214350..0x20214398`:

```
T_i16[i] = float_to_i16( fdiv( T_float[i], scale ) )   // 0xffa01814 then 0xffa0290c
store W[ beam + 0x2938 + 2i ]
scale → beam+0x5CD8 (stored just above the loop)
T_float from I0 (convert-twin dest `0x20215060 + 0x51E8`)
```

AFE loop `0x202143c6..0x2021440c` is the same formula into **`beam+0x4D5C`**, floats
from `[P2++]`, count `>>18`. Zero-fill fallback stores `R3.H` into AFE slots
(`0x20214436`).

Scan/clear AFE (`0x20224492`): `memset(beam+0x4D5C, 0, 0x51E)` when a per-beam bit
in `W[obj+0x14]` is clear — **clear**, not the Scan envelope builder. Envelope
builder still OPEN.

**False-echo apply vs persist**

`FUN_20204044` / `0x20204400` / `0x20204630` **memcpy maps to/from a 1 MB window**
(record sizes `0x522` = 4+`0x51E` AFE, `0x292` = 4+`0x28E` user map). Arena-relative
`+0x52D4` = beam `+0x4D5C`, `+0x5F9E` = beam `+0x5A26`. Scale gate vs floats
**1611.0** (`0x44898000`) and **900.0** (`0x44610000`). That is **storage / load**,
not Grade clipping. Apply-to-pick still OPEN.

**`range_fixed` / `0x20214ff4` (shape already in highlights; inputs narrowed)**

- `FUN_ffa0586c`: `bin = (range_fixed × [cfg+0x4EC]) >> 32`. Callers include acquire
  windows `0x202240e4/0x20224104` and emit `0xffa04844`.
- `n_mm` anchors **`{0.25, 1.0, 200.0}` metres** → 250 / 1000 / 200000 mm — these are
  **range bands**, not °C. Band scale `331.2998/1000 × rsqrt(n_mm×273118.6+1)` is
  therefore a **range-dependent bin scale** using c(0 °C).
- Struct `0x20214ff4`: loads `[0],[4],[8],[0xC],[0x14]`. Ratio (t47):
  `R4 = [8]*[4]` (mul); `R0 = ([0x14] − R7) * [0]` (sub then mul); `ratio = R4/R0`
  (div); compare vs `999424.0` (`0x49740000`) and a 10.0 path. That ratio **selects**
  the 0.25/1/200 anchor (loop at `0x2020fa0e`). Exact mapping ratio→anchor still OPEN.
- Window constants **0.64 / 0.638 m** at `0x2021ea84/0x2021ea88` (Q28 candidate).
- Consumer `>>>17` after `0xffa0586c` (`0x202136ec`) ties into the same shift as
  Threshold length.

**Temperature (formula on the ADC path; not yet multiplied into 331.3)**

At `0x2020f8c6`: 10 × 12-bit reads (`W[I0++] & 0xFFF`), average (`0xffa01038`, N=10),
compare cal word `0xff802d34` → flag `0xff900000`. Then

```
norm = f(4096, adc)           // 12-bit full scale
ratio = (3·norm · [P3+4]) / (([P3+0x14] + 3·norm) · [P3])
```

NTC / divider shape. **Not proven** that this ratio replaces 331.3 or `n_mm`.
`FixedTemperatureForMeasurements` (cmd 174 byte 15) is the manual override candidate.

**Dampening / cmd 151 unpack:** no new consumer found this pass (still open).

### Still open (need math *and* the consumer site)

| Topic | What we do **not** have yet | Where to look |
|-------|-----------------------------|---------------|
| ADC DMA MMRs | How samples get into `0xFF9000C0` | PPI/DMA descriptors — **not required to read a `.bm4`** |
| Threshold **fill** (how T is computed from Grade) | Emit of Threshold is proven (`>>17` twin); **generator** of those floats is not | `0x20214350`, `0x2021F97A` tail |
| AFE **build** (Scan opcode 4) | Envelope vs empty Grade vs other | `0x20224492`, memset `+0x4D5C` |
| False-echo **apply** | Clip Grade vs raise T vs AND flags vs pick-skip | readers `0x2020421e` / `0x20204634` / `0xFFA038E2` |
| Cmd 151 **firmware unpack** | Jump table, not `R=n=151` immediates | comm `0x20208xxx` |
| `range_fixed` format + which param → `0x20214ff4` | Band-scale **shape** proven; input semantics not | callers of `0xffa0586c` |
| Dampening consumer | UI unit = **meters**; IIR/slew/gate in FW not traced | cmd 174 bytes 24–27 RAM dest |
| Temperature → `c` in band scale | NTC-style formula nearby; site into `331.3` not pinned | `0x2020f8c6` |

### Guide implementation vs this log

Do **not** edit the Install Guide for firmware math. Formulas stay in this log.

### Addendum 2026-08-17 (F4) — do not delete rows above

| Fact | Evidence |
|------|----------|
| T floats `@0x20215060+0x51E8` = convert-twin from T int16, not magnitude `0x2021F97A` | `0x20212CD4` loop; `0x2021F97A` dst `ctx+0x4EB08` |
| Peak `last_i` written to caller int16 (`P3+0x8a`); acc **+= G²**; rsqrt(acc/`[hw+0x5770]`) | `l1_ffa038e2_147a.asm` `ffa03ad8` / `ffa03c34` / `ffa03c4e` |
| After pick, AFE-bin `last_i>>3` then `<<18` ≡ `last_i<<15` (same shape as PC Orange fract32) | `sdram_20212800.asm` `0x20212F38`…`0x20213130` |
| `0x2020421e` / `0x20204634` persist copy/clear of `+0x5A26`, not apply | `r_20204044.asm`; `0xFFA05F92` memcpy, `0xFFA05F2E` memset |
| Peak helper does not load user/AFE maps | `l1_ffa038e2_147a.asm` (only `+0x44` / `+0x2938`) |
| `0x2020F27C` is accept predicate, not metres | `dump_147a_l1.txt` |
| `range_fixed` path uses `ffa05ee4(…, 41000)` then `ffa0586c` | `dump_emit_parent_between_convert_emit.txt` `ffa04838`/`ffa04844` |

### Addendum 2026-08-17 (F5) — do not delete rows above

| Fact | Evidence |
|------|----------|
| `0x0A3D70A3` ≈ 80 m in BM4 fract32 (`m = x/2^31×1000`), same encoding as Orange `last_i<<15` | acquire `DAT_2021ea84/88`; `r_20220636.c` |
| Cmd 151 opcode **4 or 5** From/To = packet floats − `param_2+0x18`, clamp `0x0A3570A3` | `r_20220636.c` |
| `FUN_ffa05c38(window)` returns ladder slot **0..11**, not Grade index | `hot_ffa05c38.c` |
| `FUN_ffa05ee4(a,41000)` is signed integer ratio, not float÷41000 | `trace_t32_dist.txt` |
| L1 post-Grade emit writes `+0x3374` / `+0x3DB0` at `>>18`, not Threshold `+0x2938` | `emit_parent_full.asm` `ffa04c32` / `ffa04c74` |
| `0x202246f0` rescales user map `+0x5A26`, first `0x7FFF` | `dig_20224500_full.txt` |
| Cmd 174 unpack: `dest+0x2C/2D/2E` SNR/CRAF bytes; `dest+0x58` bit4 UseFalseEchoes | `store_off24_near44.txt` `0x202B683E` |

Still open: T-from-Grade **first fill**; map **apply** in pick; AFE float-plane → `+0x4D5C` emit on Scan; damping metres IIR; SNR/CRAF **compare** (bytes landed, math not); `ffa05c38` slot → Grade `last_i`.

### Addendum 2026-08-17 (F6) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Acquire opcode 4/5 “ILLEGAL” body = beam mask skip `(1<<i) & [packet+0x14]` | `acquire_20220636.asm` `0x202209EA` / `0x202217FC` |
| Scan handler: memset AFE, memset False E, 3× opcode 4, opcode 5, opcode 7, rescale `+0x5A26`, persist | `b_20224400.asm` / `dig_20224500_full.txt` |
| `0x2022E118` opcodes 4/5/7 share window then `0x2022D6DC` + `0xFFA0467E` | `caller_2022e118.asm` `0x2022E1F6`…`0x2022E320` |
| Scan envelope index is Grade-related **`>>3`**; 655-float twin at **`+0xA3C`**; max via `0xFFA0165C` | `ffa0467e_full.asm` `0xFFA05018`…`0xFFA0519E` |
| Opcode 4/5 bin-change mix uses 8.0f and `rsqrt` | same file `0xFFA050E6` / `0xFFA05118` |
| AFE float planes = `@0x20215060+0x6660` / `+0x709C` (655+655 after Grade+T floats) | `ffa0467e` `P2=0x6660` / `P0=0x709C`; `DSP-GRADE.md` layout |
| AFE int16 emit = `fdiv` then `float_to_i16` → `beam+0x4D5C`, count `(range>>18)+1` | `twin_20214300_full.asm` `0x202143BA`…`0x2021440C` |

### Addendum 2026-08-17 (F7) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Third 655-float plane `@0x20215060+0x7AD8` (`FP−0x50`) | `ffa0467e_emit.asm` `P1=0x7ad8` |
| Scan weight `w=uint16_to_float(obj+0x46)`; if `ctx+0x521==0` then `w/=3` | `0xFFA047D4`…`0xFFA047F2` |
| Bin-change: `aux=(8w·aux+rsqrt(|scratch|))/(8w+1)`; `plane1=plane0`; `plane0=scratch` | `ffa0467e_full.asm` `0xFFA050E0`…`0xFFA051BC` |

### Addendum 2026-08-17 (F8) — do not delete rows above

| Fact | Evidence |
|------|----------|
| `+0x6660/+0x709C/+0x7AD8` ← int16 `+0x3374/+0x3892/+0x3DB0` (not AFE export) | `int16_to_float_2d05e.asm` `0x2022D16C`… |
| AFE convert/emit uses `@0x20215060+0x8F4C` ↔ `beam+0x4D5C`; `FP−0x38` held through emit | `dig_20212c_float_convert_chain.txt` `0x20212DBC` / `0x20212DE0`; `twin_20214300_full.asm` `0x202143B8` |
| `FUN_20212BAE` RTS `0x2021441C` (convert+emit one function) | `ADD SP += 0x24` / `UNLINK` at `0x20214414` |
| T zero `beam+0x2938`; T emit from `+0x51E8`; Grade walker `rsqrt`/`fadd` + `ctx+0x2B` | `g_20213a00.asm` `0x20213A26`; `p324_20213800.asm` `0x2021380E` / `0x2021385E` |
| False E. floats `+0x8514` ← `+0x5798` | `dig_20212c_float_convert_chain.txt` `0x20212E40` |

### Addendum 2026-08-17 (F9) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Scan emit: `+0x7AD8` → `beam+0x3DB0` (aux plane) | `ffa0467e_full.asm` `0xFFA04CE8`…`0xFFA04D20` |
| `FUN_20212BAE` reads `beam+0x3DB0` then `STORE`s `8F4C[i]` | `fn_20213000.asm` `0x2021320C` / `0x20213350` |
| Grade vs AFE `i>>3` max into `+0x8F4C` | same file `0x202133A6` / `0x202133E8` / `0x202134B8` |
| Persist copies AFE at `parent+0x52D4` len `0x51E`, not a builder | `r_20204044.c` |

### Addendum 2026-08-17 (F10) — do not delete rows above

| Fact | Evidence |
|------|----------|
| `FUN_20212BAE` peak `0x20212F1C` is before AFE mix and T rewrite | `dig_20212c_float_convert_chain.txt` `0x20212F1C`; `fn_20213000.asm` `0x20213350` / `0x20213A02` / `0x202141D0` |
| `0xFFA02948` = signed int→float via `signbits`, exp `0x87−shift` | `ffa02948.asm` |
| `0xFFA01714` = `__addsf3` (same as `0xFFA01716`) | HANDOFF §C t46 |
| T floats zeroed at `+0x51E8` then `STORE` at `0x202141D0`; tail `memset`; emit `0x20214350` | `fn_20213000.asm` `0x20213A02` / `0x202141D0` / `0x20214220` |

### Addendum 2026-08-17 (F11) — do not delete rows above

| Fact | Evidence |
|------|----------|
| After `0x2022DB02`, load `beam+0x3DB0[i>>3]`, `2948`, `×+0x5CE4`, store `obj+0x58` | `site_2022da20.asm` `0x2022DB88`…`0x2022DBD6` |
| `dest+0x2c` (MinimalSnr byte) `>0` → predicate return 1 | `int16_to_float_2d05e.asm` `0x2022D01C` |
| `dest+0x2d` and `+0x2e` compared to 13 | `dig_outer_acquire_fill_loops.txt` `0x20224A66` |
| Peak `last_i` `STORE W` to caller out-pointers | `l1_ffa038e2_147a.asm` `0xFFA03AE8` / `0xFFA03C34` |

### Addendum 2026-08-17 (F12) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Packer Grade data offset `0x5BC`, length 5242, stride `0x5CFC`, 7 series, 9 beams | `bm4_pack_full.asm` `0x202B51E0`…`0x202B542A`; `trace_t56_disasm.txt` |
| Packer writes Grade Δh fract32 **`0x8000`** (`1000/65536` m) at `file+0x28` | same `0x202B5252` |
| AFE mix: `(f+[FP−0x3c])×8F4C[i]+work+0x94` then `÷f`; `f=floatsisf(aux+1)×[work+0x4]` | `fn_20213000.asm` `0x202132F4`…`0x20213350` |
| No `STORE [FP−0x3c]` before first mix in `FUN_20212BAE` | `fn_20213000.asm` first store `0x20213FEA`; `trace_t55_disasm.txt` |
| T loop `mulsf3` by **`1.2f` (`0x3F99999A`)** | `trace_t55_disasm.txt` `0x202140C0` |
| L1 `FFA00000` has 0× `0x4D5C`; peak lives there | `page_FFA00000.bin` search; `0xFFA038E2` |
| Unpack copies `[rx+0x28]` → `adv+0x1C`, later `adv+0x1C` → `obj+0x58` | `0x202B692C` / `0x202B69F4` |

### Addendum 2026-08-17 (F13) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Orange word = `(int16 last_i)<<15` stored at `[ptr−4]` | `g_20220260.asm` `0x20220628`…`0x2022062C`; `trace_t58_disasm.txt` |
| That fract32 is `last_i×(1000/65536)` m (same Δh as packer `0x8000`) | F5 fract32; F12 `0x202B5252` |
| `FUN_2021FFE4` (Orange store) is called from acquire `0x20221262` | `acquire_20220636.asm` |
| `586c` arg = `5ee4([hw+0x57c0],41000)+acc`; result `[P4+0x10]` | `trace_t58_disasm.txt` `0x2022405E`…`0x20224094`; `l1_05c40.asm` |
| `hw+0x57c0` += `(desc+0x14 − desc+0x1c − 1)×[desc+0x8]` | `dig_runtime_dest_storew.txt` `0x20210ED2`…`0x20210EE6` |
| T loop also `÷4.0f` and `÷2.0f` around neighbor Grade interp | `trace_t58_disasm.txt` `0x20213D8A` / `0x20213E80` |

### Addendum 2026-08-17 (F14) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Peak `G` uses `1.01f` (`0x3F8147AE`); acc `+= G×G` (not `(G−T)²`) | `l1_ffa038e2_147a.asm` `0xFFA0395C` / `0xFFA03ACE` |
| Peak callers only `0x20212F1C` and `0x2022DB02` | existing xref dumps |
| Post-peak reject: `[obj+0x5C]` Inf/0; `last_i < R5`; `FUN_2020F27C` | `fn_20213000.asm`; `dump_147a_l1.txt` `0x2020F27C`; `w_20213000.c` |
| Scan `0xFFA049D4` maxes mid planes `+0x6660/+0x709C/+0x7AD8`, not False E vs Grade | `ffa0467e_full.asm` |
| UseFalseEchoes copies `[rx+0x4]` or 0 to `dest+0x24`; peak does not load it | `trace_t55_disasm.txt` `0x202B680E`…`0x202B6824` |
| Pick does not load AFE / user False E | F4 + F14 (image-negative) |

### Addendum 2026-08-17 (F15) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Grade emit `float_to_i16(grade_f/scale)` at `beam+0x44` | `f2i_ffa04baa.asm` `0xFFA04B90`…`0xFFA04BCA` |
| `+0x5A26` first `0x7FFF` then `fixsfsi(float(W)×R7)` | `dig_20224500_full.txt` `0x202246F0`…`0x20224726` |
| T rewrite loop `0x20213A66`… store `0x202141D0`; cap `0x51D` | `fn_20213000.asm` |
| Mix `a` is `[FP−0x3C]` with no store before first mix | F12; `LINK 0x6C` |
| `0x202B69DA` `>>>1` is not unpack `dest+0x24` | `trace_t58_disasm.txt` (fields `+0x20/+0x24`) |

### Addendum 2026-08-17 (F16) — do not delete rows above

| Fact | Evidence |
|------|----------|
| Mix `a` unstored before `0x2021330C` | `fn_20212a64_full.asm` / `fn_20213000.asm` |
| `[P3+0x58]` Q15 MAC then `5ee4` (not Orange IIR) | `giant_2022f600.asm` `0x2022F752` |
| T rewrite does not load AFE/False E | `fn_20213000.asm` T loop |
| Do not implement pick/AFE in the Install Guide | this fence |

### Addendum 2026-08-17 (F17) — do not delete rows above

| Fact | Evidence |
|------|----------|
| No `STORE [FP−0x3C]` from `12BAE` LINK through peak `0x20212F1C` | `dig_20212c_float_convert_chain.txt` |
| Mix `k`: zero then max of `8F4C` window into `work+0x94` | `fn_20213000.asm` `0x20213148` / `0x202131E4` |
| Mix `a` is `[FP−0x3C]` at `0x2021330C` (GDB) | `trace_t55_disasm.txt` |

### Addendum 2026-08-17 (F18) — do not delete rows above

| Fact | Evidence |
|------|----------|
| T neighbor mix base is `[FP−0x38]` = AFE `+0x8F4C` (`0x20212DBC`); T loop loads it | `dig_20212c_float_convert_chain.txt`; `trace_t58` `0x20213DAA` / `13DF8` / `13E52` |
| `idx = W[work+0xe]`; `j = idx>>1`; mix `8F4C[j]` with `j±1`; `÷2` | `g_20213a00.asm` `0x20213D0C`…; `fn_20213000.asm` |
| T store `+0x51E8[i]` at `0x202141D0`; `×1.2f` / vs `0.25f` | `fn_20213000.asm` `0x202140C4` / `13FE0` / `141D0` |
| Pick still does not load maps; AFE can feed **next** T only | F14 + F18 |
| Support mission closed; ADC→Grade not Install Guide | `RESEARCH-CLOSED.md` |


