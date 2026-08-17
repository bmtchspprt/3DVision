# Session 2026-08-06 — Blackfin simulator (binutils-gdb `sim/bfin`) — Grade fill

Goal: definitive ground truth for what writes the Grade amplitude at `beam+0x44`
(arena-abs `+0x5BC`). Previous static work (Ghidra) could not decompile the Blackfin
DSP/LSETUP loops, leaving "unimplemented instruction" holes exactly where the fill
lives. This session stands up a `bfin-elf` instruction-set simulator and, crucially,
uses its **disassembler** (which DOES handle the DSP loops) to read those holes.

## Toolchain / harness (scripts in `docs/firmware/evidence/traces/`)

- Built `binutils-gdb` 15.2 `--target=bfin-elf --enable-sim`, installed to `/opt/bfin`
  on WSL2 Debian (`01_deps.sh`, `02_build_gdb.sh`). Provides `bfin-elf-gdb` + `bfin-elf-run`.
- `make_dummy_elf.py` — minimal bfin ELF (entry `0xFFA00000`, one `.text` section) so
  gdb's sim target creates an inferior. `gdbsim` needs real section headers (not just
  program headers), and `restore`/`x/i`/register access need a live process.
- `rungdb.sh <script> [timeout]` — runner (WSL quoting is painful; keep logic in files).
- Memory is mapped with `--memory-mapfile FILE --memory-region VA,len` — **mapfile must
  come BEFORE the region it binds to** ("next region"). Snapshots in `../evidence/dumps/`.
- Required regions: `FFA00000/FFA10000` (L1 inst), `FF800000/FF900000` (L1 data),
  `20200000` (SDRAM app, 1MB), plus **`FFE00000,0x100000`** (core MMR — boot stores to
  `0xFFE01300`) and **`FFC00000,0x100000`** (EBIU/peripheral MMR — init reads `0xFFC00Axx`
  and faults without it).
- Blackfin opcode quick reference (learned from bytes↔disasm):
  `P1.L = imm16` = `09 e1 lo hi`; `P1.H = imm16` = `49 e1 lo hi`; `CALL (P1)` follows.

## Boot control flow (PROVEN by stepping)

- `0xFFA00000` = reset vector stub: clears loop/regs, fills IVT stubs, sets
  `SP=0xFF807FB0`, `SYSCFG`, `RAISE 0xf`, `RETI=0xFFA00074`, `RTI` → parks in a self-RTI
  idle loop at **`0xFFA00074`**. The raised IVG15 is the app main.
- App main = **`0xFFA00076`** (IVG15 handler). On real HW the RTI vectors there; in the
  sim we set PC manually: break at `0xFFA00074`, `run`, then `set $pc=0xFFA00076`.
- App init allocates the **root object at `0x20237d8c`** (watchpoint on `0xFF804840`).

## Hardware-dependency blockers (why full boot-to-scan is hard)

- **`FUN_ffa06008(p1,p2)`** = DMA/event wait. With `p1==0` it busy-polls `0xFF806EE0`
  for bits 0x1/0x2/0x20 (set by a DMA/ISR completion that never fires in sim).
  Stub: breakpoint at `0xFFA06008` doing `set {int}0xFF806EE0 = 1` (+`continue`).
- **RTOS tick delays**: startup power-up delays sleep on a tick countdown
  (`[0x2020ef84]`) that a timer ISR decrements. Sim fires no tick → busy-wait at
  `0x2020b080` (chunked delay in fn `0x2020afc6`, kernel struct `0x202376d0`).
  This is the wall for full boot-to-idle; needs tick emulation or per-site stubbing.
  The **acquisition path itself uses `FFA06008` (DMA flag), not RTOS sleeps.**

# ===== THE GRADE PIPELINE (this session's core result) =====

Beam layout (PROVEN in acquire + convert-twin): beam struct = `ctx + 0x578 + idx*0x5CFC`.
- `beam+0x44`   = Grade int16 series (one int16 per bin, **not** I/Q pairs)
- `beam+0x2938` = Threshold int16 series (`0x2938 = 0x44 + 2*5242`)
- `beam+0x5CD4/0x5CD8/0x5CF0/0x5CF4` = float scale factors
- length fields: grade len = `([ctx+0x584] >>> 15)+1`, thresh len = `([ctx+0x584] >>> 17)+1`,
  max 5242.

Call chain: `acquire` (`0x20220636`) per-beam loop → `FUN_20210be6` (setup+process)
→ `0x2021f97a` (kick; calls magnitude ×2) → `0x2020fd42` → arming `0x20210546`.

### 1. Setup (`FUN_20210be6`, `r_20210be6.c`)
Per-beam hw struct table `PTR_DAT_202d2850` (5 entries); writes FFT log2N into
`struct+0x5774` = **10, 10, 11, 12, 12** (N = 1024/1024/2048/4096/4096).

### 2. Arming (`0x20210546`, sim disasm t22)
- Branch A (ref precompute): `CALL 0x202ecec8`, `memcpy(0xFF9000C0 ← 0x202ED088, cnt*2)`
  via `0xffa05f92`, `memset(0xFF9020C0,0,0x2000)` via `0xffa05f2e`.
- Branch B: `memset(0xFF9020C0, 0, cnt*2)`.
- `FFA06008` DMA-wait (ADC DMA fills L1 re=`0xFF9000C0`, im=`0xFF9020C0`).
- **FFT forward**: `FUN_ffa06688(re=0xFF9000C0, im=0xFF9020C0, twiddle=[hw+0x5778],
  idxshift=[hw+0x577C], log2N=[hw+0x5774], inverse=…)`.
- If mode flag: **matched-filter peak detect** `FUN_ffa05a56(re, im, ref=hw+0x1770)`
  (complex MAC + MAX, returns peak) → float diag into `0x2020F058` state struct.
- **FFT inverse** (second `FUN_ffa06688`, twiddle sign flipped).
- **Interleave out**: `FUN_2020f306(dest=param3, re, im, count=[hw+0x5776])` —
  per bin: `dest[2i]=re[i]; dest[2i+1]=im[i]` (int16).
- Float scale out: `100.0f / f(1<<total_BFP_shift)`-style → `*param1`.

### 3. FFT = `FUN_ffa06688` — FULL MATH PROVEN (sim t21/t25 + `pulse/pc_ffa06688.c`)
Args: `R0`=re int16 array, `R1`=im int16 array, `R2`=twiddle table base,
stack p4=twiddle-index shift, p5=`log2N`, p6=inverse flag.
- **Phase 1**: in-place **bit-reverse permutation** of BOTH arrays in parallel
  (classic bit-reversed index increment `j = k + (j & k-1)`), N = `1<<log2N`.
- **Phase 2**: radix-2 **DIT** stages, per stage:
  - **Block-floating-point pre-scan**: peak = max(|re_i|,|im_i|) over all N;
    stage shift `s = 2` if peak > `0x6A09` (27145), else `1` if > `0x3504` (13572), else `0`.
  - Twiddles: `wr = table[k]`, `wi = ±table[k + N/4]` (single shared table;
    negated when inverse; quarter-period offset for cos↔sin).
    Twiddle index `k = stage_iter << (stage_shift + p4)`; stage_shift decrements per stage.
  - Q15 complex multiply with **round-to-nearest**: with `v = (mul32 >>> 14)`,
    `rnd(v) = (v & 1) + (v >>> 1)` (arithmetic shifts) ≈ round(product / 2^15).
    `t_re = rnd(wr*a) - rnd(wi*b)`; `t_im = rnd(wr*b) + rnd(wi*a)`.
  - Leg-1 pre-scaled by stage shift: `a' = a >> s`, `b' = b >> s` (arithmetic).
  - `re1' = a' + t_re; re2' = a' - t_re; im1' = b' + t_im; im2' = b' - t_im` (in-place,
    int16 stores; P2 stride = span*4 bytes).
- Returns **total BFP shift sum** in R0 (callers accumulate it as the scale exponent).
  NOTE: earlier sessions mislabeled this function as a "DMA programmer" — it is the FFT.

### 4. Normalize+interleave writer (`0x202ecb14` body, sim t27)
Used by the ref precompute (`0x202ecec8` entry ~`0x202ecaf4`, which itself calls
`FUN_ffa06688` with log2N = 11 or 10, forward).
- peak = max over bins of max(|re|,|im|) → state `W[P3+0x4]`.
- Per bin i: `dest[4i]   = FUN_ffa05ee4(re[i], peak+adj).H`  (normalized int16 re)
             `dest[4i+2] = FUN_ffa05ee4(im[i], peak+adj).H`  (normalized int16 im)
  (`FUN_ffa05ee4(v,shift)` = fixed-point normalize, result in `R0.H`; decompile
  `writers/w_ffa05ee4.c`).
- Float scale out (`f(count, peak, shift)`) → `*[FP+0x20]`.

### 4b. Matched filter `FUN_ffa05a56` — PULSE COMPRESSION PROVEN (sim t21/t31)
Second half (`0xffa05b16+`, Ghidra stub `pc_ffa05b28.c`) is the **frequency-domain
matched-filter multiply, in-place** on the two L1 arrays, per bin i:
- `out_re = (a*cr + b*ci) * scale >> 16` ; `out_im = (b*cr - a*ci) * scale >> 16`
  = **X[k] · conj(Ref[k])** (conjugate variant; a non-conjugate variant exists behind
  flag `[FP+0x18]`).
- `cr/ci` = reference spectrum int16 at `hw+0x1770` (precomputed by `0x202ecec8`: FFT of
  the transmit chirp, normalized-interleaved).
- `scale` (R0) computed in loop A from the peak product magnitude via `FUN_ffa05ee4`
  (block normalization to prevent overflow); products are 32-bit, `.H` taken (>>16).
- Loop A also returns the overall peak for diagnostics.

### 4c. Twiddle table = `0xFF800100` (PROVEN — dumped from L1 snapshot)
`[hw+0x5778] = 0xFF800100` for every beam; `[hw+0x577C] = 12 - log2N` (twiddle-index
shift); `[hw+0x5776] = 1 << log2N` (FUN_20210be6 init loop at `0x20210C8E`).
Table contents = **`round(sin(2πk/4096) · 32767)`**, k=0..1024+ (verified byte-exact:
50, 101, 151, …, max 32767 at k=1024). Quarter-sine; cos = index + N/4.

### 5. Magnitude `FUN_ffa05ca0` (sim t21 + call sites t28)
Per bin: `f = sqrt(float(re)^2 + float(im)^2)` (calls sqrt `0xffa02894`, int→float
`0xffa01688`, float mul/div `0xffa018f0/0xffa01716/0xffa01814`), writes **float**
per bin. Also processes 4 sub-blocks at `+0x4000` offsets.
Call sites (found by opcode-pattern search `09 e1 a0 5c 49 e1 a0 ff`):
`0x2021fb26` and `0x2021fc50` in `0x2021f97a`:
- site 1: src pairs `ctx+0x4E958 + …`, dest floats `ctx+0x4EB08 + …`
- site 2: src pairs `ctx+0x4E814 + …`, dest floats `ctx+0x4E9C4 + …` (multiplier 0x24=36)
(ctx = big root object; these are past the 12-beam arena = separate float buffers.)

### 6. convert-twin `FUN_20212bae` (sim t22 — read path, PROVEN)
- `float_grade[i] = (float)(int16)grade[i] * scale` (scale = float at `beam+0x5CD4`),
  out array `0x20215060`; grade len = `([ctx+0x584]>>>15)+1`.
- `float_thresh[i] = (float)(int16)thresh[i] * scale2` (`beam+0x5CD8`),
  out `0x20215060+0x51E8`; thresh len = `([ctx+0x584]>>>17)+1`.

## Still NOT pinned (next session)
1. **The final float→int16 quantization write into `beam+0x44`** (source = the float
   magnitude buffer `ctx+0x4EB08`; writer TBD — candidates checked & eliminated:
   `FUN_2021ffe4` (HART/export prep), `FUN_20210be6` stride sites (config/timing math).
   Next: head of `0x2021f97a` (`0x2021f97a-0x2021fac0`) and site `0x20211d34`;
   or opcode-pattern search for a `W[Px+0x44]` store near a `0x5cfc` multiply).
   For simulation this is only a rounding/storage detail — the float magnitude
   (step 5) plus the `beam+0x5CD4` scale fully define the curve.
2. ADC DMA MMR programming (which DMA channel, descriptor vs autobuffer).
3. `FUN_ffa05ee4` exact shift semantics (decompile `writers/w_ffa05ee4.c`; verify vs sim).
4. Mode dispatch at `0xff802e30` (modes 0/1→`0x2020f550`, 2→`0x2020f870`, 3→`0x2020f878`)
   = diagnostic/calibration paths (12-bit ADC temp read at `0x2020f120`), not echo path.

## Old session notes (kept from 2026-08-05)

**PROVEN:**
- `acquire` contains **NO CPU store to `beam+0x44`**. It only **READS** `[P5+0x44]`
  (at `0x20220d58`) feeding the float-convert chain. The Grade first-fill is therefore
  **NOT a CPU loop inside acquire** — consistent with the fill happening in
  `FUN_20210be6`'s per-beam processing (above).
- Beam layout confirmed in-loop: stride **`0x5CFC`**, beam base **`+0x578`**, arena from
  `[FP-0x44]`. Grade at `arena + i*0x5CFC + 0x578 + 0x44` = `arena + i*0x5CFC + 0x5BC`.
