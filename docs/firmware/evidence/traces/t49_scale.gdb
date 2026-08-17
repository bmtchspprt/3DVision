set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000 --memory-region 0x21000000,0x100000
load
tbreak *0xFFA00000
run
tbreak *0x2020fb72
set $pc = 0x2020fadc
stepi
# registers set AFTER the burn stepi (fault handler clobbers them)
set $p5 = 0x21008000
set $sp = 0xFFE07F00
set $fp = 0xFFE07F00
set $r7 = 0x428c0000
set {int}0x210084dc = 0
set $pc = 0x2020fadc
continue
echo \n=== n=70m result ===\n
x/4xw 0x210084dc
p/d $r0
p/x $r0
echo \n=== done ===\n
