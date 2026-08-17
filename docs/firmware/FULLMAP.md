# Full firmware memory picture (4.5.452)

Source: `assets/firmware/3DLevelScannerM_4_5_452.ldr`  
Rule: cite bytes/VAs; no invented DSP.

## Loader format (whole file)

The `.ldr` is an **ADI-style boot stream from offset 0**, not a flat CODE+RODATA blob.

Each block:

| Field | Size | Meaning |
|-------|------|---------|
| `addr` | u32 LE | load destination VA |
| `count` | u32 LE | byte count |
| `flags` | u16 LE | bit0 = fill (no payload; zero `count` bytes at `addr`) |
| payload | `count` | omitted if fill |

- Stream ends ~`0x3CFE4`; tail is wrapper name `3DLevelScannerM_4_5_452_wrapped`.
- Block list: `analysis/fullmap/boot_blocks_full.json` (~220 blocks).

### Corrected VA map (materialized)

| Region | VA | Artifact |
|--------|-----|----------|
| App SDRAM (sparse → contig) | `0x20200000` … ~`0x202FFDA4` | `sdram_20200000_contig.bin` |
| L1 Data A | `0xFF800000` | `l1_data_FF80.bin` / `page_FF800000.bin` |
| L1 Data B | `0xFF900000` | mostly fill |
| L1 Instruction | `0xFFA00000`, `0xFFA10000` | `page_FFA00000.bin`, `page_FFA10000.bin` |

Ghidra project: `analysis/fullmap/ghidra_boot_project/BootMap452`  
Dumps: `analysis/fullmap/ghidra_boot_dump/`  
Dump index: `analysis/fullmap/ghidra_boot_dump/INDEX.md`  
DSP archive (all findings): `docs/firmware/DSP-FINDINGS-ARCHIVE.md`  
Session dig catalog (101 `dig_*.txt` + full narrative): `docs/firmware/DSP-FINDINGS-SESSION-2026-08-05.md`  
Proven Grade gate: `docs/firmware/DSP-GRADE.md`

### What was wrong before

Treating `file[16:0x20000] @ 0x20000000` as linear CODE **misplaced VAs**.  
Same bytes appear under the boot map at **`0x2020xxxx`** (e.g. Grade writer at **`0x2020CAA4`**, not `0x2000A7B6`).

## Tag strings

ASCII `Grade` / `Threshold` / `AFE` / `False E.` / … live in **L1 Data**:

| String | VA |
|--------|-----|
| Grade | `0xFF802EC8` |
| Threshold | `0xFF802ED0` |
| AFE | `0xFF802EE8` |
| False E. | `0xFF802EEC` |

Runtime descriptor buffer at SDRAM **`0x2020C844`** starts zero in the image; `FUN_2020caa4` fills it from a live struct.

## Proven library helpers (L1)

| VA | Role | Evidence |
|----|------|----------|
| `0xFFA05F2E` | **memset** | byte/half/word fill loops; `asm_ffa05f2e.txt` |
| `0xFFA05F92` | **memcpy** (likely) | immediately after memset |
| `0xFFA018F0` / `0xFFA01716` / … | soft-float (SLEIGH incomplete) | IEEE const uses; `32768.0` at L1 `+0x18ED` |

## Proven: sample-buffer length **5242**

At `0x20211E4E` (and siblings):

```text
R3 = 5242
R3 = min(R2, 5242)      ; clamp
R0 = R0 + 0x44          ; buffer base adjust
[P5+0x58] = R3          ; store length
R2 = R3 << 1            ; byte count = samples * sizeof(int16)
R1 = 0
CALL memset @ 0xFFA05F2E
```

**Certainty:** firmware caps echo-style series at **5242 int16 samples** and zero-fills `length*2` bytes. Matches example `.bm4` Grade `length` for that capture’s cap/size class — not yet the amplitude formula.

## `FUN_2020caa4` (was “Grade writer”)

Large `switch(param_1)` UI/config formatter (display strings, unit scaling via soft-float).  
Calls into L1 float helpers with constants such as `1000.0`, `0.7`, `32000.0`.  
**Not** the ADC→Grade sample DSP loop.

## DSP recovery status

See **`DSP-FINDINGS-ARCHIVE.md`** (full VA archive) and **`DSP-GRADE.md`** (proven-only simulation gate).  
Dump index: `analysis/fullmap/ghidra_boot_dump/INDEX.md`.

### Still open (before InstallGuide “FW-accurate” Grade sim)

1. First non-zero Grade int16 writer at `beam+0x44` (before emit’s `0x2022D05E`).
2. Finish Threshold CFAR / AFE formulas; False E. scale identity (fill loop shape already archived).
3. bm4/HART packing gains (layout constants proven at `0x202B5202`).
4. Then replace InstallGuide `buildBeamData` from proven math only.

## 4.5.340

Same boot-stream shape; L1 present; call targets shifted. Use as cross-check, not a missing piece.
