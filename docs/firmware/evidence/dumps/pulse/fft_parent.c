
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_202106a6(void)

{
  short sVar1;
  undefined4 uVar2;
  code *in_P1;
  short *in_P3;
  int unaff_FP;
  
  sVar1 = (*in_P1)();
  *in_P3 = sVar1;
  FUN_ffa06008(1,0,1);
  if (*(int *)(unaff_FP + 0x1c) == 0) {
    uVar2 = FUN_ffa05a56();
    uVar2 = FUN_ffa018f0(uVar2,*(undefined4 *)(in_P3 + 2));
    *(undefined4 *)(in_P3 + 2) = uVar2;
    FUN_ffa06008(1,0,1);
    sVar1 = FUN_ffa06688();
    *in_P3 = sVar1 + *in_P3;
    FUN_ffa06008(1,0,1);
  }
  FUN_2020f306(*(undefined4 *)(unaff_FP + 0x20));
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


