set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
break *0xFFA00074
run
set $pc = 0xFFA00076
watch *(int*)0xFF804840
continue
delete
set $root = *(int*)0xFF804840
printf "\n=== root object @ %08x ===\n", $root
x/64xw $root
printf "\n=== follow root+0xbc, +0xe8, +0xd8, +8 ===\n"
set $p_bc = *(int*)($root + 0xbc)
set $p_e8 = *(int*)($root + 0xe8)
set $p_d8 = *(int*)($root + 0xd8)
set $p_08 = *(int*)($root + 0x8)
printf "root+0xbc -> %08x   root+0xe8 -> %08x   root+0xd8 -> %08x   root+0x08 -> %08x\n", $p_bc, $p_e8, $p_d8, $p_08
printf "\n=== search SDRAM for Grade len 0x147A halfwords ===\n"
find /2 0x20200000, 0x20300000, 0x147A
printf "\n=== search for beam stride count region: value 9 near 0x5cfc pattern (search 0x5CFC word) ===\n"
find /1 0x20200000, 0x20300000, 0x5CFC
printf "\n=== done ===\n"
