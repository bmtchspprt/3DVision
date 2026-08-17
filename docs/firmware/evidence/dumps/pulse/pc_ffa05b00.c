
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_ffa05b00(undefined4 param_1,int param_2)

{
  int iVar1;
  undefined4 uVar2;
  int unaff_R7;
  int unaff_FP;
  
  iVar1 = 0;
  if ((param_2 != 0) && (iVar1 = 1, param_2 != 0x7fffffff)) {
    iVar1 = FUN_ffa05ee4(1,param_2 + 1);
  }
  if (*(int *)(unaff_FP + 0x18) == 0) {
    if (0 < unaff_R7) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  else if (0 < unaff_R7) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  uVar2 = FUN_ffa01688(iVar1 * (uint)(1 < iVar1) + (uint)(1 >= iVar1));
  FUN_ffa01814(0x4f000000,uVar2);
  return;
}


