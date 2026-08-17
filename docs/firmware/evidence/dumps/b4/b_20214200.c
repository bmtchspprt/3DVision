
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20214200(int param_1)

{
  uint uVar1;
  undefined4 uVar2;
  uint uVar3;
  short sVar4;
  short sVar5;
  int iVar6;
  ushort uVar7;
  ushort uVar8;
  int unaff_R7;
  int iVar9;
  int in_P3;
  int unaff_P4;
  ushort *unaff_P5;
  int unaff_FP;
  
  iVar9 = *(int *)(unaff_FP + 0x10);
  *(int *)(in_P3 + 0x10) = param_1 << 0x11;
  iVar6 = (param_1 - *(short *)(in_P3 + 0xc)) + -1;
  param_1 = param_1 - (*(byte *)(iVar9 + 0x2b) + 1) * (int)*(short *)(in_P3 + 0xc);
  *(int *)(in_P3 + 0x4c) = iVar6;
  *(int *)(in_P3 + 0x50) = param_1;
  if (*(short *)(in_P3 + 0x7c) < iVar6) {
    sVar5 = (short)*(undefined4 *)(in_P3 + 0x7c);
    sVar4 = sVar5 * 4 + 1;
    *(short *)(in_P3 + -4) = sVar4;
    if ((int)sVar4 <= iVar6 * 4) {
      do {
        uVar1 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar3 = 0;
        if (uVar1 != 0 && ((int)uVar1 <= unaff_R7 && (uVar1 & 0x80000000) == 0)) {
          uVar3 = uVar1;
        }
        uVar2 = FUN_ffa0248c(uVar3);
        uVar7 = *unaff_P5;
        uVar2 = FUN_ffa01716(uVar2,*(undefined4 *)(unaff_P5 + 0x16));
        *unaff_P5 = uVar7 + 1;
        *(undefined4 *)(unaff_P5 + 0x16) = uVar2;
      } while ((int)(short)(uVar7 + 1) <= *(int *)(unaff_P5 + 0x28) << 2);
      sVar5 = (short)*(undefined4 *)(in_P3 + 0x7c);
    }
    *(short *)(in_P3 + 0x7c) = sVar5 + 1;
    *(int *)(in_P3 + 0x54) = *(int *)(in_P3 + 0x54) + 1;
    param_1 = *(int *)(in_P3 + 0x50);
  }
  if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11 < param_1) &&
     (((int)*(short *)(in_P3 + 0x7c) - *(int *)(in_P3 + 0x54)) + 1 < param_1)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar6 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c);
  *(uint *)(in_P3 + 0x50) =
       (int)*(short *)(in_P3 + 10) +
       (int)*(short *)(in_P3 + 0xc) * (*(byte *)(*(int *)(unaff_FP + 0x10) + 0x2b) + 1);
  *(int *)(in_P3 + 0x4c) = (int)*(short *)(in_P3 + 10) + (int)*(short *)(in_P3 + 0xc) + 1;
  while( true ) {
    iVar9 = *(int *)(unaff_FP + 0xc);
    iVar6 = *(short *)(iVar9 + 0x5e) + iVar6;
    if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11 < iVar6) ||
       (*(int *)(iVar9 + 0x30) <= iVar6)) break;
    sVar5 = (short)iVar6 * 4 + 1;
    *(short *)(iVar9 + -0x24) = sVar5;
    if ((int)sVar5 <= (iVar6 + 1) * 4) {
      do {
        uVar1 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar3 = 0;
        if (uVar1 != 0 && ((int)uVar1 <= unaff_R7 && (uVar1 & 0x80000000) == 0)) {
          uVar3 = uVar1;
        }
        uVar2 = FUN_ffa0248c(uVar3);
        uVar7 = unaff_P5[0x41];
        iVar6 = *(int *)(unaff_P5 + 0x30);
        uVar2 = FUN_ffa01716(uVar2,*(undefined4 *)(unaff_P5 + 0x1c));
        uVar8 = *unaff_P5;
        *unaff_P5 = uVar8 + 1;
        *(undefined4 *)(unaff_P5 + 0x1c) = uVar2;
      } while ((int)(short)(uVar8 + 1) <= ((short)uVar7 + iVar6 + 1) * 4);
    }
    iVar6 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) + 1;
    *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) = iVar6;
  }
  if ((int)(short)unaff_P5[0x41] < *(int *)(unaff_P5 + 0x28)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  if (*(byte *)(*(int *)(unaff_FP + 0x10) + 0x2a) < 0x65) {
    FUN_202144a4();
    return;
  }
  uVar7 = unaff_P5[7];
  *(undefined4 *)(in_P3 + 0x74) = 0;
  *(int *)(unaff_FP + -0x20) = (int)(short)uVar7;
  *(undefined4 *)(unaff_FP + -0x14) = 0;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


