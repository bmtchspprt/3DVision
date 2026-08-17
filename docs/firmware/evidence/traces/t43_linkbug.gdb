set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0x20380000,0x80000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
set $sp = 0x20381000
set $fp = 0x20381000
echo \n=== test PUSH (not LINK) at 0x20210bea ===\n
set $pc = 0x20210bea
x/i $pc
stepi
info registers pc
echo \n=== test acquire entry LINK at 0x20220636 ===\n
set $pc = 0x20220636
x/i $pc
stepi
info registers pc
echo \n=== test L1 func LINK at 0xffa0586c ===\n
set $pc = 0xffa0586e
x/i $pc
stepi
info registers pc
echo \n=== done ===\n
