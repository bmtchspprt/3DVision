#!/usr/bin/env bash
set -u
D="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap"
RUN=/opt/bfin/bin/bfin-elf-run
OUT="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim/trace_boot.txt"
python3 "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim/make_dummy_elf.py" /tmp/prog.elf

"$RUN" \
  --memory-mapfile "$D/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 \
  --memory-mapfile "$D/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 \
  --memory-mapfile "$D/page_FF800000.bin" --memory-region 0xFF800000,0x10000 \
  --memory-mapfile "$D/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 \
  --memory-mapfile "$D/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 \
  --trace-insn --trace-disasm --trace-file "$OUT" \
  /tmp/prog.elf &
PID=$!
sleep 6
kill -INT $PID 2>/dev/null || true
sleep 1
kill -9 $PID 2>/dev/null || true
wait $PID 2>/dev/null || true
echo "=== trace head ==="
head -80 "$OUT" 2>/dev/null || echo "no trace file"
echo "=== trace tail ==="
tail -20 "$OUT" 2>/dev/null
