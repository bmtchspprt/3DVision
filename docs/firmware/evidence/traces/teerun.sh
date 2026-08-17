#!/usr/bin/env bash
# Usage: teerun.sh <gdbscript> <trace_name> [timeout]
set -u
HERE="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim"
"$HERE/rungdb.sh" "$1" "${3:-40}" 2>&1 | tee "$HERE/$2"
