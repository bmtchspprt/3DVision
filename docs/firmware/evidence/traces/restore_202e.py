#!/usr/bin/env python3
"""Compare contig vs pristine page in 0x202e0000 region and restore."""
import os

FM = "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
cpath = os.path.join(FM, "sdram_20200000_contig.bin")
ppath = os.path.join(FM, "page_202E0000.bin")
contig = bytearray(open(cpath, "rb").read())
page = open(ppath, "rb").read()
BASE = 0x20200000
PBASE = 0x202E0000

off = PBASE - BASE
seg = bytes(contig[off:off+len(page)])
diffs = [i for i in range(len(page)) if seg[i] != page[i]]
print(f"{len(diffs)} bytes differ")

# show sample diffs around the code region 0x202ec6c0-0x202ec700
for a in range(0x202ec6c0, 0x202ec700, 16):
    i = a - PBASE
    c = seg[i:i+16].hex()
    p = page[i:i+16].hex()
    mark = "  <-- DIFF" if c != p else ""
    print(f"{a:#x}: contig={c}\n           page ={p}{mark}")

# where are the diff clusters?
clusters = []
if diffs:
    s = pp = diffs[0]
    for i in diffs[1:]:
        if i - pp > 64:
            clusters.append((s, pp))
            s = i
        pp = i
    clusters.append((s, pp))
print("clusters:")
for s, e in clusters:
    print(f"  {PBASE+s:#x}..{PBASE+e:#x} ({e-s+1} span)")
