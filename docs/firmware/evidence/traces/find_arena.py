#!/usr/bin/env python3
import struct, os

D = "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
contig = open(os.path.join(D, "sdram_20200000_contig.bin"), "rb").read()
BASE = 0x20200000
print(f"contig size 0x{len(contig):X}  VA {BASE:#x}..{BASE+len(contig):#x}")

def u16(o): return struct.unpack_from("<H", contig, o)[0]
def u32(o): return struct.unpack_from("<I", contig, o)[0]

# Look at the tail region (last 0x20000) non-zero extents
tail_start = len(contig) - 0x40000
print("\n=== non-zero words in tail 0x202C0000..0x20300000 ===")
run = None
for o in range(tail_start, len(contig), 4):
    v = u32(o)
    if v != 0:
        if run is None:
            run = [o, o, 0]
        run[1] = o
        run[2] += 1
    else:
        if run and run[2] >= 2:
            va = BASE + run[0]
            print(f"  {va:#010x}..{BASE+run[1]:#010x} ({run[2]} words)")
        run = None
if run and run[2] >= 2:
    print(f"  {BASE+run[0]:#010x}..{BASE+run[1]:#010x} ({run[2]} words)")

# Search whole image for Grade len 0x147A
print("\n=== offsets where 0x147A appears (u16) ===")
hits = []
for o in range(0, len(contig) - 2, 2):
    if u16(o) == 0x147A:
        hits.append(o)
for o in hits[:60]:
    print(f"  off {o:#x}  VA {BASE+o:#010x}")
print(f"total {len(hits)} hits")

# Search for stride 0x5CFC as u32 (could be a length/stride field)
print("\n=== offsets where 0x5CFC appears (u16) ===")
c = 0
for o in range(0, len(contig) - 2, 2):
    if u16(o) == 0x5CFC:
        print(f"  off {o:#x}  VA {BASE+o:#010x}")
        c += 1
        if c > 40: break
print("done")
