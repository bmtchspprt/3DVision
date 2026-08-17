set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
set $p5 = 0x20288000
set $sp = 0xFFE07F00
set $fp = 0xFFE07F00
set $r7 = 0x428c0000
set $pc = 0x2020fadc
stepi
set $pc = 0x2020fadc
echo \n=== stepping 14 insns ===\n
stepi
p/x $pc
p/x $r0
p/x $r1
stepi
p/x $pc
stepi
p/x $pc
stepi
p/x $pc
stepi
p/x $pc
p/x $r0
stepi
p/x $pc
stepi
p/x $pc
stepi
p/x $pc
p/x $r0
stepi
p/x $pc
stepi
p/x $pc
stepi
p/x $pc
p/x $r0
stepi
p/x $pc
stepi
p/x $pc
stepi
p/x $pc
p/x $r0
echo \n=== scratch after ===\n
x/8xw 0x202884dc
echo \n=== done ===\n
