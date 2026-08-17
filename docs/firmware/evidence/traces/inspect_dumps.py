#!/usr/bin/env python3
import struct, os

BASEDIR = "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"

def load(name):
    p = os.path.join(BASEDIR, name)
    with open(p, "rb") as f:
        return f.read()

def u32(buf, off):
    if off < 0 or off + 4 > len(buf):
        return None
    return struct.unpack_from("<I", buf, off)[0]

def u16(buf, off):
    if off < 0 or off + 2 > len(buf):
        return None
    return struct.unpack_from("<H", buf, off)[0]

# ---- L1 Data A (0xFF800000) ----
try:
    l1 = load("page_FF800000.bin")
    print(f"[L1 FF800000] size=0x{len(l1):X}")
    root = u32(l1, 0x4840)  # DAT_ff804840
    print(f"  *0xFF804840 (root ptr) = {root:#010x}" if root is not None else "  0xFF804840 out of range")
    # neighbors used by acquire off the root
    for off in (0x4840,):
        pass
except Exception as e:
    print("L1 err", e)

# ---- SDRAM/PSRAM app region ----
# figure out which container files exist and their spans
for name in ("sdram_20200000_contig.bin","seg_20200000.bin","seg_20000000.bin",
             "page_20200000.bin","page_20210000.bin","page_20220000.bin","page_20230000.bin"):
    p = os.path.join(BASEDIR, name)
    if os.path.exists(p):
        print(f"[file] {name}: size=0x{os.path.getsize(p):X}")

# float work buffer 0x20215060 lives in 0x2020xxxx region
try:
    contig = load("sdram_20200000_contig.bin")
    base = 0x20200000
    off = 0x20215060 - base
    v = u32(contig, off)
    print(f"[SDRAM] contig size=0x{len(contig):X}; *0x20215060 = {v:#010x}" if v is not None else "0x20215060 OOR")
    # sample the region where a static arena might be: look for large zeroed spans (memset targets)
    # report first 0x40 bytes at a few candidate arena bases
    for cand in (0x20200000, 0x20201000, 0x20204000, 0x20210000):
        o = cand - base
        if 0 <= o+16 <= len(contig):
            words = [u32(contig, o+4*i) for i in range(4)]
            print(f"  @{cand:#010x}: " + " ".join(f"{w:08x}" for w in words))
except Exception as e:
    print("SDRAM err", e)

print("=== done ===")
