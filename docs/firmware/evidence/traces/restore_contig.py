#!/usr/bin/env python3
"""Restore sim-polluted bytes in sdram_20200000_contig.bin from pristine page dumps.

Polluted by sim runs on 2026-08-06:
 - 0x20215046..0x20215058  (t38 DMA state writes)         -> restore from page_20210000
 - 0x202376d0..0x20237739  (t38, likely)                  -> restore from page_20230000
 - 0x202bc8dc..0x202bc8e4  (t38 cfg0 writes)              -> restore from page_202B0000
 - 0x202d27fc..0x202d2803  (t38 cfg4 writes)              -> restore from page_202D0000
 - 0x202eada1..0x202eadad, 0x202eb1e0..0x202ec6e3,
   0x202efec4..0x202efffb  (t38 crashed table-fill)       -> restore from page_202E0000
 - 0x202f0000..0x202f0003  (t42 0x12345678 test)          -> restore from page_202F0000
 - 0x20280000, 0x202884ec..ef, 0x202904cc..d7, 0x20290500..03 (t38/t48 scratch) -> zero
NOT touched: 36 pre-existing diffs in page 0x20200000 span (not from sim).
"""
import os, shutil

FM = "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
cpath = os.path.join(FM, "sdram_20200000_contig.bin")
bak = cpath + ".polluted-20260806.bak"
if not os.path.exists(bak):
    shutil.copy2(cpath, bak)
    print("backup written:", bak)

contig = bytearray(open(cpath, "rb").read())
BASE = 0x20200000

def restore_from_page(page_name, lo, hi):
    page = open(os.path.join(FM, page_name), "rb").read()
    pbase = int(page_name[5:13], 16)
    n = hi - lo + 1
    contig[lo-BASE:lo-BASE+n] = page[lo-pbase:lo-pbase+n]
    print(f"restored {lo:#x}..{hi:#x} from {page_name}")

def zero(lo, hi):
    n = hi - lo + 1
    contig[lo-BASE:lo-BASE+n] = b"\x00" * n
    print(f"zeroed   {lo:#x}..{hi:#x}")

restore_from_page("page_20210000.bin", 0x20215046, 0x20215058)
restore_from_page("page_20230000.bin", 0x202376d0, 0x20237739)
restore_from_page("page_202B0000.bin", 0x202bc8dc, 0x202bc8e4)
restore_from_page("page_202D0000.bin", 0x202d27fc, 0x202d2803)
restore_from_page("page_202E0000.bin", 0x202eada1, 0x202eadad)
restore_from_page("page_202E0000.bin", 0x202eb1e0, 0x202ec6e3)
restore_from_page("page_202E0000.bin", 0x202efec4, 0x202efffb)
restore_from_page("page_202F0000.bin", 0x202f0000, 0x202f0003)
zero(0x20280000, 0x20280000)
zero(0x202884ec, 0x202884ef)
zero(0x202904cc, 0x202904d7)
zero(0x20290500, 0x20290503)

open(cpath, "wb").write(bytes(contig))
print("contig restored, size", len(contig))
