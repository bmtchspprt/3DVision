# Scanner firmware LDR reverse engineering

## Goal

Recover how firmware **generates** Grade / Threshold / AFE / False E. (and related) sample arrays that become `.bm4` blobs — analogous to how `decompiled/locator` recovered MultiVision PC behavior.

## Breakthrough: ISA = Analog Devices Blackfin

The LDR payload is **not** an unknown packer blob. It is **Blackfin machine code + RODATA**.

### Smoking gun

The dominant 6-byte motif `49 E1 A0 FF 61 00` decodes as:

```text
P1.H = 0xFFA0;     /* LDIMMhalf, opcode 0xE1xx */
CALL (P1);         /* ProgCtrl, encoding 0x0061 */
```

`0xFFA0xxxx` is the classic Blackfin **L1 Instruction SRAM** window. The image contains thousands of calls into that region (on-chip helpers / overlays), plus many `*.H = 0x2020` immediates into **SDRAM-style** `0x2020xxxx` addresses.

Supporting counts (FW 4.5.452, `file[16:0x20000]`):

| Pattern | Count |
|---------|------:|
| LDIMMhalf | ~7000 |
| `CALL (P1)` with known P1 | ~2000 |
| MNOP | 26 |
| `P1.H = 0xFFA0` | ~2012 |
| `*.H = 0x2020` | ~148 |

`wrapper.exe` (BinMaster `binClient\bin`) only MD5-validates the file (`Tools\md5\gui\wrapper.pdb`); it does **not** unpack. Cross-build byte identity at the same offsets is low because code is relocated/rebuilt — shared Blackfin sequences still exist at different file offsets.

## LDR header

```text
40 00 80 FF  04 00 00 00  12 00 XX XX  03 00 00 00
20 20 02 01  00 00 02 00  00 E8 00 00  E5 05 39 30
```

| Field | Meaning (current best) |
|-------|------------------------|
| `40 00 80 FF` | Magic `0xFF800040` |
| `04 00 00 00` | Constant |
| `12 00 XX XX` | `0x0012` + 16-bit checksum/id (varies per build) |
| `03 00 00 00` | `nseg`-like constant (3) |
| `20 20 02 01` | Constant product/layout id `0x01022020` |
| `00 00 02 00` | Size `0x20000` |
| `00 E8 00 00` | Size `0xE800` |
| `E5 05 39 30` | Constant `0x303905E5` (same on 200/340/452) |

## Memory map (working)

RODATA / string segment (file `0x20000` …) is addressed as:

```text
VA = 0x20200000 + (file_offset - 0x20000)
```

Verified by an exact code reference:

```text
file 0xA7D4:  P5.L = 0xC844
file 0xA7D8:  P5.H = 0x2020
             → P5 = 0x2020C844
```

File `0x2C844` is the 16-byte descriptor immediately before the `Grade` tag string at `0x2C854`. Nearby pointers load `0x2020C830`, `0x2020C994`, `0x2020C978`, etc. (same table cluster).

Code segment (file `16:0x20000`) contains those loaders; L1 `0xFFA0xxxx` targets may be on-chip ROM/helpers not fully present as a flat 1:1 image at file offset 16.

## Grade / series tag table (RODATA)

File `0x2C844` cluster (stable across 4.5.200 / 340 / 452 when aligned on the strings):

```text
… 7FFFFFFF …
500000000 (i32, repeated) …
0x004C4B40 / related …
15000000 (0x00E4E1C0) …
Grade / Threshold / Grades E / AFE / False E. / Theta / Phi
500000000 ×5
9                    ← beam count
1,2,4,8,16,32,64,128 ← bit masks
```

Same tag set the PC `BeamDataParser` expects in `.bm4` series headers.

## What PC already proved

- Download: Hart **202 → 111 → 112…** on `HART_PORT_BEAMS` (170)
- File write: strip Hart framing → `.bm4`
- Decode: `BeamDataParser` (`docs/grades/BM4-FORMAT.md`)

LDR RE targets the **writer/DSP on Blackfin**, not the PC parse path.

## RE plan (updated)

1. ~~Identify ISA / packing~~ → **Blackfin**; motif explained; not zlib.
2. **Finish load map** — exact SDRAM base for code; whether `0xFFA0` bodies are in-file overlays.
3. **Xrefs** — expand from `0xA7D4` Grade-descriptor site; find bm4 emit loops (32-byte headers + int16 samples + IEEE754 gains).
4. **DSP formulas** — pulse compression / CFAR / fuzzy confidence (also described in APM patents US8391336, US9518860) vs what the binary actually does.
5. **Assets** — only after formulas are solid, expose a JS simulation module (never claim bit-identical to a capture unless verified).

## Tools / artifacts

| Path | Role |
|------|------|
| `assets/firmware/3DLevelScannerM_4_5_452.ldr` | Image under study |
| `tools/ghidra_12.1.2_PUBLIC/` | Ghidra + Blackfin SLEIGH installed |
| `tools/jdk-21/` | JDK 21 for Ghidra 12 |
| `docs/firmware/analysis/ghidra/` | Project, flat image, scripts — see `README.md` |
| `docs/firmware/analysis/ghidra/grade-xref-ghidra.asm` | Ghidra dump of Grade-desc writer |
| `scripts/analyze-bfin-ldr.py` | Blackfin LDIMM/CALL analysis |
| `docs/firmware/analysis/binutils-2.36/opcodes/bfin-dis.c` | Reference disassembler |

## Status

| Item | State |
|------|-------|
| BM4 format (PC) | Documented |
| LDR ISA | **Blackfin confirmed** |
| Load map | **CODE `0x20000000`, RODATA `0x20200000`** |
| Ghidra | **Installed; project analyzes as `blackfin:LE:32:default`** |
| Grade xrefs | **`FUN_2000a7b6` copies struct fields into `0x2020C844` via `P5++`** |
| Writer/DSP decompile | In progress (follow callers of `FUN_2000a7b6`) |
| Portable DSP → JS | Blocked on writer recovery |

## Honesty bar

Until Grade/Threshold/AFE producers are recovered from the Blackfin image, InstallGuide Echo Curve demo amplitudes remain **invented fillers** in the BeamData *shape*. Do not market them as firmware-accurate sensor readings.
