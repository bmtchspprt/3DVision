set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0x20380000,0x80000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
echo \n=== write test file-backed 0x202F0000 ===\n
set {int}0x202F0000 = 0x12345678
x/wx 0x202F0000
echo \n=== write test fresh region 0x20380000 ===\n
set {int}0x20380000 = 0xabcdef01
x/wx 0x20380000
echo \n=== try LINK with SP in fresh region ===\n
set $sp = 0x20381000
set $fp = 0x20381000
set $r0 = 0x20382000
set $r1 = 0x20384000
set $pc = 0x20210be6
x/i $pc
stepi
x/i $pc
info registers pc sp
echo \n=== done ===\n
