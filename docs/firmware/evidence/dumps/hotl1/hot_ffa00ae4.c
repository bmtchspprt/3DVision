
/* WARNING: Control flow encountered unimplemented instructions */

uint FUN_ffa00ae4(uint param_1,uint param_2)

{
  uint uVar1;
  
  uVar1 = param_1 & 0x7fffffff;
  if (((param_2 & 0x7fffffff) != 0) && (uVar1 = param_2 & 0x7fffffff, (param_1 & 0x7fffffff) != 0))
  {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  return uVar1;
}


