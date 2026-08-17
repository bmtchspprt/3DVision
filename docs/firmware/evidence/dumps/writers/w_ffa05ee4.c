/* seed ffa05ee4 */

/* WARNING: Control flow encountered unimplemented instructions */

undefined4 FUN_ffa05ee4(int param_1,int param_2)

{
  undefined4 uVar1;
  int extraout_R1;
  int iVar2;
  int iVar3;
  
  iVar2 = -param_1;
  iVar3 = -param_2;
  if ((int)(iVar3 * (uint)(param_2 < iVar3) + param_2 * (uint)(param_2 >= iVar3)) <=
      (int)(iVar2 * (uint)(param_1 < iVar2) + param_1 * (uint)(param_1 >= iVar2))) {
    FUN_ffa01c38(param_1,param_1 >> 0x1f,param_2,param_2 >> 0x1f);
    uVar1 = 0x7fffffff;
    if (extraout_R1 < 0) {
      uVar1 = 0x80000000;
    }
    return uVar1;
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


