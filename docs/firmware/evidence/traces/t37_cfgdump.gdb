set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
echo \n=== ptr table 0x202d2850 (5 entries) ===\n
x/6wx 0x202d2850
echo \n=== cfg[0] head (0x4e0..0x500) ===\n
set $c0 = *(unsigned int*)0x202d2850
printf "cfg0 = 0x%x\n", $c0
x/12wx $c0+0x4e0
echo \n=== cfg[0] fft/chirp area (0x5770..0x57e0) ===\n
x/28wx $c0+0x5770
echo \n=== ctx+0x520..0x540 (detection thresholds) ===\n
echo NOTE: ctx base unknown here; dump 0x202d0000+0x520 as guess\n
x/16wx 0x202d0520
echo \n=== done ===\n
