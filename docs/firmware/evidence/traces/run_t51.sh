#!/usr/bin/env bash
set -u
SIM="/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/sim"
sed -e 's/0x21008000/0x20408000/g' \
    -e 's/0x210084dc/0x204084dc/g' \
    -e 's|scratch_21000000.bin|scratch_20400000.bin|' \
    -e 's/--memory-region 0x21000000,0x10000/--memory-region 0x20400000,0x10000/' \
    "$SIM/t50_scale.gdb" > "$SIM/t51_scale.gdb"
python3 -c "open('$SIM/scratch_20400000.bin','wb').write(b'\x00'*65536)"
bash "$SIM/teerun.sh" t51_scale.gdb trace_t51_scale.txt 60
