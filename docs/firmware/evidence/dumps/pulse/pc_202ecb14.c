
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_202ecb14(void)

{
  short sVar1;
  short sVar2;
  undefined4 uVar3;
  undefined2 extraout_R0_H;
  undefined4 uVar4;
  int unaff_R5;
  int unaff_R6;
  int unaff_R7;
  code *in_P1;
  short *in_P3;
  int unaff_P4;
  int unaff_P5;
  int unaff_FP;
  
  uVar3 = (*in_P1)();
  *(undefined4 *)(in_P3 + 1) = uVar3;
  FUN_ffa06008(1,0,1);
  *(int *)(in_P3 + 2) = unaff_R5;
  *in_P3 = (short)unaff_R5;
  if (0 < unaff_R7) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  if (0 < unaff_R7) {
    FUN_ffa05ee4((int)*(short *)(unaff_P4 + unaff_R5 * 2),in_P3[2] + unaff_R6);
    sVar1 = *in_P3;
    sVar2 = in_P3[2];
    *(undefined2 *)(*(int *)(unaff_FP + 0x1c) + sVar1 * 4) = extraout_R0_H;
    FUN_ffa05ee4((int)*(short *)(unaff_P5 + sVar1 * 2),sVar2 + unaff_R6);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  FUN_ffa06008(1,0,1);
  uVar3 = FUN_ffa016d4(*(undefined4 *)(unaff_FP + 0x14));
  uVar4 = FUN_ffa01688(in_P3[2] + 1);
  FUN_ffa01814(uVar3,uVar4);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


