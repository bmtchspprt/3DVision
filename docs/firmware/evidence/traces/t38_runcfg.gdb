set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
set $sp = 0x202F0000
set $fp = 0x202F0000
# scratch arena 0x20280000, ctx 0x20290000
set {short}0x202834690 = 0
set {char}0x20280000 = 1
set $r0 = 0x20280000
set $r1 = 0x20290000
# stub DMA-wait spin FUN_ffa06008: force done-flag 0xFF806EE0=1
break *0xffa06008
commands
  set {int}0xff806ee0 = 1
  continue
end
# return sentinel: break at 0x20211024 (the RTS after config loop) instead
tbreak *0x20211024
set $pc = 0x20210be6
# gdb-sim quirk: first stepi after run faults; burn it, then re-set PC
stepi
set $pc = 0x20210be6
continue
echo \n=== reached config-complete breakpoint ===\n
info registers pc
echo \n=== cfg0 (0x202b7168) 0x5770..0x57c8 ===\n
x/23wx 0x202b7168+0x5770
echo \n=== cfg1 (0x202bc930) 0x5770..0x57c8 ===\n
x/23wx 0x202bc930+0x5770
echo \n=== cfg2 (0x202c20f8) 0x5770..0x57c8 ===\n
x/23wx 0x202c20f8+0x5770
echo \n=== cfg3 (0x202c78c0) 0x5770..0x57c8 ===\n
x/23wx 0x202c78c0+0x5770
echo \n=== cfg4 (0x202cd088) 0x5770..0x57c8 ===\n
x/23wx 0x202cd088+0x5770
echo \n=== cfg0 0x4e0..0x500 (FUN_ffa0586c scale at +0x4ec) ===\n
x/8wx 0x202b7168+0x4e0
echo \n=== state 0x20215030..0x20215060 ===\n
x/12wx 0x20215030
echo \n=== arena+0x60..0x70 ===\n
x/4wx 0x20280060
echo \n=== done ===\n
