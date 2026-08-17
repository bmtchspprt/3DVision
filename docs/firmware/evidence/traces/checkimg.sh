#!/usr/bin/env bash
set -u
FM="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
ls -la --time-style=full-iso "$FM"/seg_20200000.bin "$FM"/page_20200000.bin "$FM"/sdram_20200000_contig.bin
echo "--- git? ---"
cd "/mnt/c/Users/cody.krehnke/Documents/3D Emulator" && git rev-parse --is-inside-work-tree 2>&1 | head -1
echo "--- sizes ---"
wc -c "$FM"/seg_20200000.bin "$FM"/page_20200000.bin "$FM"/sdram_20200000_contig.bin
echo "--- how contig was built: check for build script ---"
ls "$FM"/.. | head -40
grep -rl "contig" "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis" --include=*.sh --include=*.py --include=*.md 2>/dev/null | head
