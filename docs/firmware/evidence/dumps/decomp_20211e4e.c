
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20211e4e(int param_1,undefined4 param_2,int param_3)

{
  int iVar1;
  int unaff_P5;
  
  iVar1 = param_3 * (uint)(param_3 < 0x147a) + (uint)(param_3 >= 0x147a) * 0x147a;
  *(short *)(unaff_P5 + 0x58) = (short)iVar1;
  FUN_ffa05f2e(param_1 + 0x44,0,iVar1 * 2);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


