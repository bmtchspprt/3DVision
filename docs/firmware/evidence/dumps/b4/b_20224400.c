
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20224400(void)

{
  int unaff_R5;
  int in_P1;
  int iVar1;
  short *psVar2;
  int iVar3;
  int unaff_FP;
  int in_stack_0000003c;
  
  if (*(char *)(*(int *)(in_P1 + 0xe8) + 3) != '\0') {
    iVar1 = *(int *)(unaff_FP + 0x18);
    *(undefined4 *)(*(int *)(*(int *)(unaff_FP + 0x18) + 0x74) + 0x4c) = 0;
    *(undefined1 *)(iVar1 + 0x6c) = 1;
    DAT_2021ebf8 = 0;
    psVar2 = (short *)(in_stack_0000003c + 0x34a54);
    if (0 < *psVar2) {
      iVar1 = FUN_202b5024(0);
      DAT_2021ebf8 = (short)iVar1;
      if (iVar1 < *psVar2) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
    }
  }
  iVar1 = *(int *)(*(int *)(unaff_FP + 0x18) + 0xe8);
  if (*(char *)(iVar1 + 2) != '\0') {
    iVar3 = *(int *)(unaff_FP + 0x18);
    *(undefined4 *)(iVar1 + 8) = 0xa3570a3;
    *(undefined4 *)(*(int *)(iVar3 + 0xe8) + 0xc) = *(undefined4 *)(unaff_R5 + 0x18);
    *(undefined1 *)(*(int *)(iVar3 + 0xe8) + 4) = 1;
  }
  *(undefined4 *)(unaff_FP + 0xc) = 0;
  DAT_2021ebf8 = 0;
  *(int *)(unaff_FP + 8) = in_stack_0000003c + 0x34a54;
  if (0 < **(short **)(unaff_FP + 8)) {
    iVar1 = FUN_202b5024((int)DAT_2021ebf8);
    DAT_2021ebf8 = (short)iVar1;
    if (iVar1 < **(short **)(unaff_FP + 8)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  iVar1 = *(int *)(*(int *)(unaff_FP + 0x18) + 0xe8);
  if (*(short *)(iVar1 + 0x14) != 0) {
    if (*(char *)(iVar1 + 4) == '\0') {
      DAT_2021ebf8 = 0;
      do {
        FUN_20220636(0);
        DAT_2021ebf8 = DAT_2021ebf8 + 1;
      } while (DAT_2021ebf8 < 3);
    }
    FUN_20220636(0);
    FUN_20220636(0);
    DAT_2021ebf8 = 0;
    if (0 < **(short **)(unaff_FP + 8)) {
      DAT_2021ebf8 = FUN_202b5024();
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
    FUN_20204044(*(undefined4 *)(unaff_FP + 0x18));
  }
  return;
}


