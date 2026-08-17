#!/usr/bin/env python3
"""Scan SDRAM contig for 16-bit immediates used as series offsets."""
import struct
from pathlib import Path

FM = Path(r"C:\Users\cody.krehnke\Documents\3D Emulator\docs\firmware\analysis\fullmap")
data = (FM / "sdram_20200000_contig.bin").read_bytes()
BASE = 0x20200000
want = {
    0x4D5C: "AFE",
    0x5798: "FalseE",
    0x5A26: "FalseE_twin",
    0x2938: "Thresh",
    0x3DB0: "aux",
}


def hits(imm):
    pat = struct.pack("<H", imm)
    out = []
    i = 0
    while True:
        j = data.find(pat, i)
        if j < 0:
            break
        va = BASE + j
        # Blackfin LDIMM: often 16-bit in instruction; keep word-aligned
        if j % 2 == 0:
            ctx = data[max(0, j - 8) : j + 10].hex()
            out.append((va, ctx))
        i = j + 2
    return out


for imm, name in want.items():
    hs = hits(imm)
    print(f"=== {name} {hex(imm)} count={len(hs)} ===")
    for va, ctx in hs:
        if 0x20200000 <= va < 0x20300000:
            print(f"  {va:#010x}  {ctx}")
