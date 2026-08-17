/* seed 20224700 */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20224700(void)

{
  short sVar1;
  short unaff_R6_L;
  short *psVar2;
  int in_P2;
  short *unaff_P4;
  short *unaff_P5;
  int unaff_FP;
  code *UNRECOVERED_JUMPTABLE;
  
  UNRECOVERED_JUMPTABLE = FUN_20224700;
  FUN_ffa01688((int)*unaff_P4);
  FUN_ffa018f0();
  sVar1 = FUN_ffa014dc();
                    /* WARNING: Could not recover jumptable at 0x20224726. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  *unaff_P4 = sVar1;
  if ((in_P2 != 0) && (in_P2 != 1)) {
    (*UNRECOVERED_JUMPTABLE)();
    return;
  }
  psVar2 = *(short **)(unaff_FP + 8);
  unaff_P5[1] = 0x147;
  unaff_P5[2] = 0;
  sVar1 = *psVar2;
  *unaff_P5 = unaff_R6_L + 1;
  if (*unaff_P5 < sVar1) {
    sVar1 = FUN_202b5024();
    *unaff_P5 = sVar1;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  FUN_20204044(*(undefined4 *)(unaff_FP + 0x18));
  return;
}


