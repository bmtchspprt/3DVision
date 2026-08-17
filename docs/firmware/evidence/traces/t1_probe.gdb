set pagination off
set confirm off
echo \n=== file ===\n
file /tmp/prog.elf
echo \n=== target sim ===\n
target sim --memory-region 0xFF800000,0x10000 --memory-region 0xFF900000,0x10000 --memory-region 0xFFA00000,0x20000 --memory-region 0x20200000,0x100000
echo \n=== load dummy ===\n
load
echo \n=== restore L1 inst ===\n
restore "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" binary 0xFFA00000
echo \n=== restore L1 inst hi ===\n
restore "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" binary 0xFFA10000
echo \n=== disasm 0xFFA00000 ===\n
set $pc = 0xFFA00000
x/48i 0xFFA00000
echo \n=== regs ===\n
info registers r0 r1 r2 sp fp pc
echo \n=== done ===\n
