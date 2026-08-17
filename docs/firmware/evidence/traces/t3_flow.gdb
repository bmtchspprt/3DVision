set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000
load
tbreak *0xFFA00000
run
set $i = 0
set $lastpc = 0
set $same = 0
while $i < 3000
  set $here = $pc
  x/i $pc
  stepi
  if $pc == $lastpc
    set $same = $same + 1
  else
    set $same = 0
  end
  set $lastpc = $pc
  if $same > 200
    printf "\n[STUCK at %x — stopping trace]\n", $pc
    set $i = 3001
  end
  set $i = $i + 1
end
printf "\n=== final regs ===\n"
info registers pc sp fp r0 r1 r2 p0 p1 p5
printf "=== done ===\n"
