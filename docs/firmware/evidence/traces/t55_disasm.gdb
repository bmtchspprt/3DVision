set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
echo \n===== 12BAE start stores =====\n
x/80i 0x20212bae
echo \n===== 132f0 mix =====\n
x/60i 0x202132f0
echo \n===== T loop 13a60 =====\n
x/120i 0x20213a60
echo \n===== T store 140b0 =====\n
x/80i 0x202140b0
echo \n===== unpack 174 =====\n
x/80i 0x202b67e0
echo \n===== packer 202b5200 =====\n
x/80i 0x202b5200
echo \n===== peak after last_i =====\n
x/40i 0xffa03c2a
echo \n===== 2d000 snr =====\n
x/40i 0x2022cfc8
echo \n===== done =====\n
quit
