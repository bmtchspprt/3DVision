set pagination off
set confirm off
set target-async on
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
break *0xFFA00074
run
set $pc = 0xFFA00076
break *0xFFA06008
commands
silent
set {int}0xFF806EE0 = 1
continue
end
continue &
shell sleep 30
interrupt
echo \n=== STOPPED in idle ===\n
printf "PC = %08x\n", $pc
x/3i $pc
echo \n=== backtrace ===\n
bt
echo \n=== root ===\n
set $root = *(int*)0xFF804840
printf "root = %08x\n", $root
x/48xw $root
echo \n=== done ===\n
