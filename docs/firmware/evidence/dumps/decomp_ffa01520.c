
/* WARNING: Control flow encountered unimplemented instructions */

undefined4 FUN_ffa01520(uint param_1)

{
  uint uVar1;
  
  uVar1 = param_1 << 1;
  if (uVar1 != 0) {
    if (uVar1 < 0xff000000) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
    if ((uVar1 < 0xff000001) && ((param_1 & 0x80000000) != 1)) {
      return 0xffffffff;
    }
  }
  return 0;
}


