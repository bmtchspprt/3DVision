/* FUN_ffa02894 @ ffa02894 */

/* WARNING: Control flow encountered unimplemented instructions */

uint FUN_ffa02894(uint param_1)

{
  bool in_AZflag;
  
  if (!in_AZflag) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  if ((param_1 & 0x80000000) == 1) {
    param_1 = CONCAT22(0xbf80,(short)(param_1 << 1));
  }
  return param_1;
}


