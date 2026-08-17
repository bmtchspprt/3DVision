/* seed 20213000 */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20213000(void)

{
  bool bVar1;
  uint uVar2;
  undefined4 uVar3;
  int iVar4;
  undefined4 uVar5;
  undefined2 in_R3_L;
  int unaff_R5;
  undefined4 *in_P3;
  int unaff_FP;
  
  *(undefined2 *)(in_P3 + -1) = in_R3_L;
  uVar5 = *(undefined4 *)(unaff_FP + -0x44);
  uVar3 = *(undefined4 *)(unaff_FP + -0x54);
  *in_P3 = *(undefined4 *)(unaff_FP + -0x58);
  iVar4 = FUN_2020f27c(uVar3,uVar5);
  if ((iVar4 != 0) && (iVar4 = *(int *)(*(int *)(unaff_FP + -0x60) + 0x4fc20), 0x51eb86 < iVar4)) {
    iVar4 = iVar4 + -0x51eb86;
    bVar1 = iVar4 >> 0x12 < (int)*(short *)(in_P3 + -1);
    *in_P3 = 0x40c00000;
    *(ushort *)(in_P3 + -1) =
         *(short *)(in_P3 + -1) * (ushort)bVar1 + (short)(iVar4 >> 0x12) * (ushort)!bVar1;
  }
  uVar2 = *(uint *)(*(int *)(unaff_FP + 0x10) + 0x5c);
  if (uVar2 == 0 || (0x7f800000 < (int)uVar2 || (uVar2 & 0x80000000) != 0)) {
    FUN_202146d8();
    return;
  }
  if (*(short *)(in_P3 + -1) < unaff_R5) {
    FUN_202146d8();
    return;
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


