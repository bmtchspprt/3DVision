set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000
load
tbreak *0xFFA00000
run
set $sp = 0xFF807FB0
set $fp = 0xFF807FB0
set $pc = 0xFFA00076
set $i = 0
set $lastpc = 0
set $same = 0
set $printed = 0
while $i < 6000
  if $pc != $lastpc
    x/i $pc
    set $printed = $printed + 1
  end
  stepi
  if $pc == $lastpc
    set $same = $same + 1
  else
    set $same = 0
  end
  set $lastpc = $pc
  if $same > 40
    printf "\n[SPIN at %08x after %d steps — dumping]\n", $pc, $i
    info registers r0 r1 r2 r5 p0 p1 p2 p3 pc
    set $i = 6001
  end
  set $i = $i + 1
end
printf "\n[END steps=%d pc=%08x]\n", $i, $pc
x/1xw 0xFF804840
info registers pc r0 r1 p0 p1 p5
printf "=== done ===\n"
