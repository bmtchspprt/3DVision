#!/usr/bin/env bash
set -u
SIM="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim"
python3 -c "open('$SIM/scratch_21000000.bin','wb').write(b'\x00'*65536)"
bash "$SIM/teerun.sh" t50_scale.gdb trace_t50_scale.txt 60
