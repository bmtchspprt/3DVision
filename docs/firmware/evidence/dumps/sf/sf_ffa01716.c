
/* WARNING: Control flow encountered unimplemented instructions */

uint FUN_ffa01716(uint param_1,uint param_2)

{
  bool bVar1;
  
  if ((param_2 & 0x7fffffff) == 0) {
    bVar1 = param_1 == 0x80000000;
  }
  else {
    bVar1 = (param_1 & 0x7fffffff) == 0;
    if (!bVar1) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  if (bVar1) {
    param_1 = param_2;
  }
  return param_1;
}


