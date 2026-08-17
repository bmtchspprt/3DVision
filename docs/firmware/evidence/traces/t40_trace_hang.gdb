set pagination off
set confirm off
file /tmp/prog.elf
target sim --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA00000.bin" --memory-region 0xFFA00000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FFA10000.bin" --memory-region 0xFFA10000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/page_FF800000.bin" --memory-region 0xFF800000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/seg_FF900000.bin" --memory-region 0xFF900000,0x10000 --memory-mapfile "/mnt/c/Users/cody.krehnke/Documents/3D Emulator/docs/firmware/analysis/fullmap/sdram_20200000_contig.bin" --memory-region 0x20200000,0x100000 --memory-region 0xFFE00000,0x100000 --memory-region 0xFFC00000,0x100000
load
tbreak *0xFFA00000
run
set $sp = 0x202F0000
set $fp = 0x202F0000
set {short}0x202834690 = 0
set {char}0x20280000 = 1
set $r0 = 0x20280000
set $r1 = 0x20290000
break *0x20210dfc
commands
  printf "HIT call ecc64\n"
  continue
end
break *0x202ecc64
commands
  printf "HIT ecc64 entry\n"
  continue
end
break *0x202ec5de
commands
  printf "HIT ec5de\n"
  continue
end
break *0x202eca00
commands
  printf "HIT eca00\n"
  continue
end
break *0x202ec1dc
commands
  printf "HIT ec1dc\n"
  continue
end
break *0x202ec914
commands
  printf "HIT ec914\n"
  continue
end
break *0x202eccf2
commands
  printf "HIT eccf2 entry\n"
  continue
end
break *0x202eceb4
commands
  printf "HIT spin call site\n"
  continue
end
break *0xffa06008
commands
  printf "HIT ffa06008 - stubbing\n"
  set {int}0xff806ee0 = 1
  continue
end
break *0x20211024
commands
  printf "HIT config done\n"
  continue
end
break *0x20210be6
commands
  printf "HIT entry\n"
  continue
end
break *0x20210c8e
commands
  printf "HIT lsetup5\n"
  continue
end
break *0x20210cdc
commands
  printf "HIT mode dispatch\n"
  continue
end
break *0x20210db2
commands
  printf "HIT post-mode\n"
  continue
end
set $pc = 0x20210be6
info registers pc
continue
echo \n=== fell out ===\n
info registers pc
