#!/usr/bin/env bash
D="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
for f in page_FFA00000.bin page_FFA10000.bin page_FF800000.bin seg_FF900000.bin sdram_20200000_contig.bin; do
  printf '%s: ' "$f"
  stat -c %s "$D/$f" 2>/dev/null || echo MISSING
done
