#!/usr/bin/env python3
"""Check pollution in sdram_20200000_contig.bin vs pristine page dumps and report."""
import os

FM = "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
contig = open(os.path.join(FM, "sdram_20200000_contig.bin"), "rb").read()
BASE = 0x20200000

# pages present and their addresses
pages = {}
for name in os.listdir(FM):
    if name.startswith("page_202") and name.endswith(".bin"):
        addr = int(name[5:13], 16)
        pages[addr] = open(os.path.join(FM, name), "rb").read()

print("pages:", sorted(hex(a) for a in pages))

# 1) diff contig vs each page dump (page mtimes are 2026-08-04, pre-sim)
for addr in sorted(pages):
    data = pages[addr]
    off = addr - BASE
    if off < 0 or off + len(data) > len(contig):
        print(f"page {addr:#x}: out of contig range")
        continue
    seg = contig[off:off+len(data)]
    diffs = [i for i in range(len(data)) if seg[i] != data[i]]
    if diffs:
        first, last = diffs[0], diffs[-1]
        print(f"page {addr:#x}: {len(diffs)} bytes differ, span {addr+first:#x}..{addr+last:#x}")
    else:
        print(f"page {addr:#x}: identical")

# 2) check scratch zones that have no page dump: 0x20280000-0x20290000 etc
#    count non-zero bytes there now
for lo, hi in ((0x20240000, 0x202A0000), (0x202C0000, 0x202C1000)):
    seg = contig[lo-BASE:hi-BASE]
    nz = [i for i, b in enumerate(seg) if b != 0]
    if nz:
        # cluster into spans
        spans = []
        s = p = nz[0]
        for i in nz[1:]:
            if i - p > 16:
                spans.append((s, p))
                s = i
            p = i
        spans.append((s, p))
        print(f"zone {lo:#x}..{hi:#x}: {len(nz)} nonzero bytes in {len(spans)} spans:")
        for s, e in spans[:30]:
            print(f"   {lo+s:#x}..{lo+e:#x} ({e-s+1} bytes)")
    else:
        print(f"zone {lo:#x}..{hi:#x}: all zero")
print("done")
