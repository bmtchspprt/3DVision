/* seed 20224600 */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20224600(void)

{
  short sVar1;
  undefined2 unaff_R6_L;
  short *psVar2;
  int in_P3;
  int unaff_P4;
  short *unaff_P5;
  int unaff_FP;
  undefined4 uStack00000014;
  undefined4 uStack00000018;
  
  uStack00000018 = *(undefined4 *)(in_P3 + 0xe8);
  uStack00000014 = 7;
  FUN_20220636(0);
  psVar2 = *(short **)(unaff_FP + 8);
  *(undefined2 *)(unaff_P4 + -4) = unaff_R6_L;
  if (*unaff_P5 < *psVar2) {
    sVar1 = FUN_202b5024();
    *unaff_P5 = sVar1;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  FUN_20204044(*(undefined4 *)(unaff_FP + 0x18));
  return;
}


