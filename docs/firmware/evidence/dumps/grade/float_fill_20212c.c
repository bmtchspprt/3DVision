
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20212c00(void)

{
  undefined4 uVar1;
  undefined4 in_R3;
  int iVar2;
  int in_P0;
  int in_P2;
  int unaff_FP;
  
  *(undefined4 *)(unaff_FP + 0x10) = in_R3;
  uVar1 = FUN_ffa01814();
  *(undefined4 *)(unaff_FP + -0x50) = uVar1;
  uVar1 = FUN_ffa01814(*(undefined4 *)(in_P2 + 0x5cd8));
  *(undefined4 *)(unaff_FP + -0x6c) = uVar1;
  uVar1 = *(undefined4 *)(in_P2 + 0x5cf0);
  *(undefined4 *)(unaff_FP + -0x44) = *(undefined4 *)(unaff_FP + 0x14);
  uVar1 = FUN_ffa01814(uVar1);
  iVar2 = *(int *)(in_P0 + 0xc);
  *(undefined4 *)(unaff_FP + -0x5c) = uVar1;
  FUN_ffa01814(*(undefined4 *)(in_P2 + 0x5cf4));
  if (0 < (iVar2 >> 0xf) + 1) {
    *(undefined4 *)(unaff_FP + -0x38) = *(undefined4 *)(unaff_FP + -0x58);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  *(undefined4 **)(unaff_FP + -0x50) = &DAT_2021a248;
  if (0 < (*(int *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11) + 1) {
    *(undefined4 *)(unaff_FP + -0x38) = *(undefined4 *)(unaff_FP + -0x58);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


