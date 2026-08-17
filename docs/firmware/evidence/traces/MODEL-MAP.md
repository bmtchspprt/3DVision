# Sim model + memory map (for GNU Blackfin sim)

Working notes for running FW 4.5.452 under `bfin-elf` GNU sim to observe the Grade fill.

## Part identification (evidence)

MMR pokes cited in `DSP-FINDINGS-ARCHIVE.md`, mapped to the standard Blackfin EBIU/DMA layout:

| MMR | Standard Blackfin meaning | Note |
|-----|---------------------------|------|
| `0xFFC00A00/A04/A08` | EBIU_AMGCTL / AMBCTL0 / AMBCTL1 (async bank ctrl) | flash/async timing (was called "pulse helper") |
| `0xFFC00A10/A14/A1C` | EBIU_SDGCTL / SDBCTL / SDSTAT (SDRAM ctrl) | archive mislabeled these "SIC" |
| `0xFFC00C00 + n*0x40` | DMA channel n CONFIG base | registry `@0xFF803690` lists C00/C40/C80/CC0 = DMA0..3 |
| `0xFFC00000/+4/+8` | PLL / system reset (DPMC) | clock init |
| `0xFFC03000+` | EMAC region | Ethernet-capable product |

Conclusion: **BF537-class** (BF534/6/7 share EBIU + DMA map; product has Ethernet -> BF537).
Single core (dumps have L1 Data A `0xFF800000` + B `0xFF900000` + L1 Inst `0xFFA00000/10000`; no Core-B `0xFF4/FF5` banks -> not BF561).

TODO confirm post-build: `bfin-elf-objdump` the init/boot code, look for a store to `0xFFC03000`-class EMAC MMR (confirms BF537 vs BF533).

## Sim model

- `--model bf537` (fallback `bf533` if EMAC absent).

## Memory regions (from `boot_blocks_full.json`, 220 blocks)

Real load targets (ignore the old linear `seg_20000000.bin` @ 0x20000000 -- no boot block loads there):

| VA span | Role | Snapshot file |
|---------|------|---------------|
| `0x20200000`..`0x202FFFFF` | App RW (async bank 2 / external RW RAM) | `sdram_20200000_contig.bin` (0x100000) |
| `0xFF800000`..`0xFF80FFFF` | L1 Data A (globals; root ptr @0xFF804840) | `page_FF800000.bin` (0x10000) |
| `0xFF900000`..           | L1 Data B (mostly fill/zero) | `seg_FF900000.bin` |
| `0xFFA00000`..`0xFFA0FFFF` | L1 Instruction (code, _start) | `page_FFA00000.bin` (0x10000) |
| `0xFFA10000`..           | L1 Instruction (FINAL block) | `page_FFA10000.bin` |

Snapshot is the **load-time image** (post boot-ROM copy, pre-run):
- `*0xFF804840` (root object ptr) = 0  -> set at runtime by app init
- `*0x20215060` (convert float buffer) = 0  -> filled at runtime

=> Cannot jump straight into acquire `0x20220636`; must run app init first so the
root object + beam arena get allocated. Entry = firmware `_start`.

## Entry point

Final boot block = `0xFFA10000` flags `0x8002` (FINAL); main code block = `0xFFA00000` (49076 bytes).
Candidate reset/_start = **`0xFFA00000`** (L1 inst base). Confirm by disassembly.

## Grade target offsets (to watch)

- beam stride `0x5CFC`; beam base `+0x578`; Grade within beam `+0x44` => Grade[beam i] @ `arena + i*0x5CFC + 0x5BC`
- beam0 Grade first int16 = `arena + 0x5BC`
- Grade length `0x147A` (5242) int16 = `0x28F4` bytes
- `arena` (== acquire `param_3`) address is a runtime value; recover by walking root `0xFF804840` or reading caller's R2 at the acquire CALL.

## Key code addresses

| VA | Role |
|----|------|
| `0x20220636` | acquire (per-beam loop; calls convert-twin) |
| `FUN_20212bae` | convert-twin (reads beam+0x44 -> floats) |
| `0x2022D05E` | convert |
| `0xFFA0467E` | emit (packs .bm4) |
| `0xFFA05F2E` | memset |
| `0xFFA06008` | wait/poll on `0xFF806EE0` |
| `0x20224400` | acquisition driver (loops acquire 3x + 2x) |
| `0x20238120` | pre-acquire outer wrapper |
