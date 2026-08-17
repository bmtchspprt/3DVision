#!/usr/bin/env bash
# Usage: rungdb.sh <gdbscript> [timeout_seconds]
set -u
HERE="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim"
GDB=/opt/bfin/bin/bfin-elf-gdb
SRC="$HERE/$1"
TO="${2:-90}"
python3 "$HERE/make_dummy_elf.py" /tmp/prog.elf >/dev/null
sed 's/\r$//' "$SRC" > /tmp/run.gdb
timeout "$TO" "$GDB" -q -batch -x /tmp/run.gdb 2>&1 | grep -vE '^warning: Can not parse XML'
echo "GDB-EXIT:$?"
