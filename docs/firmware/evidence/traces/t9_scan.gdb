set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
break *0xFFA00074
run
set $pc = 0xFFA00076
echo \n=== auto-force wait flag 0xFF806EE0 at FFA06008 ===\n
break *0xFFA06008
commands
silent
set {int}0xFF806EE0 = 1
continue
end
echo \n=== break at acquire + scan orchestrator + driver ===\n
break *0x20220636
break *0x202b5492
break *0x20224400
continue
echo \n=== STOPPED (scan hit or halt) ===\n
printf "PC = %08x\n", $pc
x/i $pc
printf "R0=%08x R1=%08x R2=%08x(=param_3 arena) R3=%08x\n", $r0, $r1, $r2, $r3
info registers r0 r1 r2 r3 r4 r5 r6 r7 p0 p1 p2 p3 p4 p5 sp fp
printf "root ptr: "
x/1xw 0xFF804840
echo \n=== done ===\n
