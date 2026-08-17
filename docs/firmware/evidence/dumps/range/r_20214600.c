
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20214600(void)

{
  short sVar1;
  undefined4 uVar2;
  int in_P3;
  int unaff_P5;
  int unaff_FP;
  
  uVar2 = FUN_20212a64();
  uVar2 = FUN_ffa018f0(uVar2,*(undefined4 *)(in_P3 + 0x74));
  *(undefined4 *)(in_P3 + 0x74) = uVar2;
  sVar1 = *(short *)(unaff_P5 + 0xe);
  *(undefined4 *)(in_P3 + 0x78) = uVar2;
  *(int *)(unaff_FP + -0x20) = (int)sVar1;
  *(undefined4 *)(unaff_FP + -0x14) = *(undefined4 *)(in_P3 + 0x74);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


