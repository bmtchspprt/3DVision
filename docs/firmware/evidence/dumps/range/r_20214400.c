
/* WARNING: Control flow encountered unimplemented instructions */

undefined4 FUN_20214400(undefined2 param_1,int param_2)

{
  undefined4 uVar1;
  undefined2 unaff_R6_L;
  undefined2 *in_P0;
  int in_P1;
  int in_P3;
  int in_LC1;
  code *UNRECOVERED_JUMPTABLE;
  
  *in_P0 = param_1;
                    /* WARNING: Could not recover jumptable at 0x2021440c. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  if ((*(int *)(in_P1 + 0xc) >> 0x12) + 1 <= param_2) {
    *(undefined2 *)(in_P3 + -4) = unaff_R6_L;
    return 0;
  }
  if ((in_LC1 != 0) && (in_LC1 != 1)) {
    uVar1 = (*UNRECOVERED_JUMPTABLE)();
    return uVar1;
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


