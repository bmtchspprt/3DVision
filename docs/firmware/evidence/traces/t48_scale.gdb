set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
# scratch cfg struct in SDRAM
set $p5 = 0x20288000
set {int}0x20288000 = 0
set {int}0x202884dc = 0
set {int}0x202884e0 = 0
set {int}0x202884ec = 0
# stack in FFE0 (L1-scratch style, proven writable)
set $sp = 0xFFE07F00
set $fp = 0xFFE07F00
# return address sentinel: breakpoint at 0x2020fb72
tbreak *0x2020fb72
# --- test 1: R7 = 70.0f (max range 70 m) ---
set $r7 = 0x428c0000
set $pc = 0x2020fadc
stepi
set $pc = 0x2020fadc
continue
echo \n=== n=70m: cfg+0x4e0 (mm int), cfg+0x4dc (max), cfg+0x4ec (scale) ===\n
x/4xw 0x202884dc
echo \n=== done1 ===\n
