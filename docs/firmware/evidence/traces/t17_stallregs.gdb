set pagination off
set confirm off
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
break *0x2020b06e
commands
silent
printf "stall-loop: P3=%08x [P3]=%08x [P3+4]=%08x R4=%08x P1=%08x P5=%08x\n", $p3, *(int*)$p3, *(int*)($p3+4), $r4, $p1, $p5
continue
end
set $hits = 0
break *0xFFA0BF28
commands
silent
set $hits = $hits + 1
if $hits < 3
  printf "suspend fn: R0=%08x R1=%08x\n", $r0, $r1
end
continue
end
continue
echo \n=== stopped ===\n
printf "PC=%08x\n", $pc
echo \n=== disasm suspend fn 0xFFA0BF28 ===\n
disassemble 0xFFA0BF28,0xFFA0C020
echo \n=== disasm 0xFFA10684 and 0xFFA08700 ===\n
disassemble 0xFFA10684,0xFFA10700
disassemble 0xFFA08700,0xFFA08760
echo \n=== done ===\n
