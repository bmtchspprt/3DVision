set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000
load
tbreak *0xFFA00000
run
echo \n=== at entry, stepping ===\n
set $i = 0
while $i < 160
  x/i $pc
  stepi
  set $i = $i + 1
end
echo \n=== regs after ===\n
info registers r0 r1 r2 r3 r4 r5 r6 r7 p0 p1 p2 p3 p4 p5 sp fp i0 i1 i2 i3 pc
echo \n=== done ===\n
