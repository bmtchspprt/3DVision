
/* WARNING: Control flow encountered unimplemented instructions */

int FUN_ffa01688(uint param_1)

{
  int iVar1;
  bool in_AZflag;
  
  if (!in_AZflag) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar1 = CONCAT22(0xcf00,(short)param_1);
  if ((param_1 & 0x80000000) != 1) {
    iVar1 = param_1 << 1;
  }
  return iVar1;
}


