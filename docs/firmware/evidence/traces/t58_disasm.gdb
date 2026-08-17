set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
echo \n===== T 13bb6-13d10 =====\n
x/90i 0x20213bb6
echo \n===== T 13d7c-140c0 =====\n
x/100i 0x20213d7c
echo \n===== range 20224000 =====\n
x/80i 0x20224000
echo \n===== range 2022e150 =====\n
x/50i 0x2022e150
echo \n===== orange 202205ec =====\n
x/30i 0x202205ec
echo \n===== damp 202b69c0 =====\n
x/80i 0x202b69c0
echo \n===== memcpy grade hunt 202b7xxx skip =====\n
x/40i 0x20213680
echo \n===== done =====\n
quit
