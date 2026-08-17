# Firmware math — research closed

Firmware `3DLevelScannerM_4_5_452`. This file is the finished answer. Detail lives in `notes/` (`HANDOFF.md`, `CERTAINTY.md`, `DSP-GRADE.md`). Instruction listings: `evidence/dumps/`. Traces: `evidence/traces/`.

These are notes. Do **not** put them into Install Guide `js/` unless asked.

---

## 1. Why the unit reported distance X (file + tape)

Use the **Grade** and **Threshold** series already in the `.bm4`.

```
dh = 1000 / 65536          // metres per Grade index
G[i] = GradeAmp[i] × 1.01
T[i] = ThresholdAmp[i >> 2]
last_i = last index with G[i] > T[i]
X_m  = last_i × dh         // when Orange is written (last_i << 15 fract32)
```

Orange store is gated (`|Δ|<20`, both >20, count vs 5). If Orange is in the file, that word is this encoding.

Tape vs file: compare tape metres to `X_m` (or to `last_i × dh` if you recompute pick).

Live `ffa0586c` is DMA/window integer math. It is **not** the tape axis.

---

## 2. Grade curve (ADC → 5242 int16)

Finished pipeline (do not invent a gaussian as firmware Grade):

```
ADC DMA → L1 re/im 0xFF9000C0 / 0xFF9020C0
→ FFT fwd 0xFFA06688
→ matched filter 0xFFA05A56: X[k]·conj(Ref[k]) >> 16
→ FFT inv
→ magnitude 0xFFA05CA0: sqrt(re²+im²) → float
→ emit 0xFFA04B90: int16 = float_to_i16(grade_f[i] / scale)
   count = (range >> 15) + 1
   store beam+0x44
```

Display: `amp ≈ ArrayToFract(i16) × gain` with `gain ≈ scale` → amp ≈ grade_f.

Without ADC samples you cannot paint a real Grade. You **can** pick on a Grade that already exists (file or live RAM).

---

## 3. Mix addend `a` — closed

AFE mix (accept path in `FUN_20212BAE`):

```
k = 0
k = max(k, 8F4C[window])           // work+0x94
f = float(aux_int16 + 1) × [work+0x4]
8F4C[i] = ((f + a) × 8F4C[i] + k) / f
```

`a = [FP−0x3C]`. Every `STORE [FP+…]` from `LINK` through peak `0x20212F1C` was catalogued. **None** write `FP−0x3C`. First store of that slot is later, in the T loop.

**Finished:** `a` is not a firmware constant. Do not replay mix. Do not use `a = 0`.

**AFE for support / synthesis:** only the proven **max** path:

```
AFE[i >> 3] = max(AFE[i >> 3], Grade[i])    // 655 bins
```

Then emit int16 at `beam+0x4D5C`.

---

## 4. Damping — closed

Cmd-174 damping float is copied: `[rx+0x28] → adv+0x1C → obj+0x58`.

The consume site `0x2022F752` is `MAC` of that word as **Q15 × spatial delta**, then `ffa05ee4`. Same family as `2022E876` (sin/cos, 3D mapping). Acquire also writes an `ffa0586c` **bin** to a different `+0x58`.

**Finished:** there is no `orange = old + d·(new−old)`. Do not slew reported metres with Dampening.

---

## 5. Maps vs “skip this peak” — closed

**This shot’s pick** (`0xFFA038E2`): Grade vs Threshold only. No AFE, no False E.

**Order in `FUN_20212BAE`:** convert existing T → **peak** → AFE mix/max → **then** rewrite T → emit T and AFE.

So this measurement’s `last_i` uses Threshold **already in RAM** (the series you see in a `.bm4` is that snapshot). Maps do not clip Grade inside the peak helper.

**Next T rewrite** (after this peak) walks Grade with `rsqrt` windows, then interpolates neighbors from `[FP−0x38]`. Last store of that slot is `0x20212DBC`: `P1 = 0x20215060+0x8F4C`. `fn_20213000.asm` has **no** later `STORE [FP−0x38]`. The T loop **does** load that pointer (`0x20213DAA` / `13DF8` / `13E52`) even though it never loads the immediate `0x8F4C`. Earlier “T rewrite never loads AFE” meant no immediate; the **pointer is AFE**. AFE can change **later** Threshold, not this pick.

User False E (`+0x5798`, opcode 6 ManualScan) is a stored 327-pt series. Peak does not load it.

**Finished:** “this map bin would make the unit skip that peak” is **false for the pick that produced Orange**. AFE can feed the **next** Threshold rewrite. For a recording, use Threshold **in the file**.

---

## 6. Threshold rewrite — closed as the firmware procedure

There is no `T[i] = c·Grade[i]`. Sites: `evidence/dumps/grade/g_20213a00.asm`, `evidence/dumps/trace/fn_20213000.asm`, `evidence/traces/trace_t58_disasm.txt`.

1. Zero T int16 at `beam+0x2938` (`0x20213A26`). Cap `min(range>>17, 0x51D)` (`0x51D` = 1309). T float base `[FP−0x50] = +0x51E8` (`0x20212CD4`).
2. Grade windows: `P4 = 0x20215060`. If the float is finite (not Inf/NaN vs `0x7F800000`), `acc += rsqrt(G)` (`0xFFA0248C`) into `work+0x2C` / `+0x38`. Width uses `ctx+0x2B` and `work+0x10` (`(work+0x10)×byte / 2` at `0x20213C56`…`13C6A`).
3. Scale the acc: `÷ 4.0f` (`0x40800000` at `0x20213D8A`).
4. Neighbor mix on **AFE floats**, not Grade:
   - `idx = W[work+0xe]` saved to `[FP−0x20]` (`0x20213D0C`)
   - `j = idx >> 1`; load `8F4C[j]`
   - if `2j < idx`: mix toward `8F4C[j+1]`; else toward `8F4C[j−1]`
   - weights are `floatsisf` of the odd/even remainder (`0x20213DC8`…`13E7C`)
   - `÷ 2.0f` (`BITSET` bit 30 → `0x40000000` at `0x20213E80`)
5. `× 1.2f` (`0x3F99999A` at `0x202140C4`). Finite-float compare vs `0.25f` (`0x3E800000` at `0x20213FE0`). Store selected float at `+0x51E8[i]` (`0x202141D0`). Loop while `i ≤ min(range>>17, 0x51D)` (`0x202141E2`…`14200`).
6. Emit T int16 from `+0x51E8` (same convert-twin family as F8).

**For support:** do not rebuild T from Grade. Use T in the file.

---

## 7. Synthesis spec (not Install Guide)

| Piece | Use |
|---|---|
| Axis | `h(i) = i × (1000/65536)` m |
| Pick | last `G>T` as §1 |
| Orange | `last_i << 15` |
| AFE | max at `i>>3` only (§3) |
| False E | opcode 6 fills 327 pts; pick ignores |
| Damping | ignore for metres |
| Grade from ADC | §2 if you have ADC; else file Grade |
| Mix | do not implement |

---

## Done

Support “why X”: §1.  
Full ADC emulator: §2 when ADC exists; not this website.  
The five leftovers are closed above — not invented, not left OPEN for the mission.
