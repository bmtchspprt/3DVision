#!/usr/bin/env bash
set -u
B=/opt/bfin/bin
D="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
export PATH="$B:$PATH"
echo "=== versions ==="
bfin-elf-objdump --version | head -1
bfin-elf-gdb --version | head -1
echo "=== run full help (model/memory) ==="
bfin-elf-run --help 2>&1 | grep -iE 'model|memory|env|board|--' | head -60
echo "=== disasm _start candidate 0xFFA00000 ==="
bfin-elf-objdump -D -b binary -m bfin --adjust-vma=0xFFA00000 "$D/page_FFA00000.bin" 2>/dev/null | sed -n '1,40p'
