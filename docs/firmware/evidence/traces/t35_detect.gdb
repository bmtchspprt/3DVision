set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
echo \n=== ffa01688 ===\n
disassemble 0xffa01688,0xffa016d4
echo \n=== ffa016d4 ===\n
disassemble 0xffa016d4,0xffa01760
echo \n=== ffa01814 ===\n
disassemble 0xffa01814,0xffa018f0
echo \n=== ffa018f0 ===\n
disassemble 0xffa018f0,0xffa01a00
echo \n=== ffa014dc ===\n
disassemble 0xffa014dc,0xffa015a0
echo \n=== ffa01c74 ===\n
disassemble 0xffa01c74,0xffa01d60
echo \n=== done ===\n
