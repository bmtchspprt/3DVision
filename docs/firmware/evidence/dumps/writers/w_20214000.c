/* seed 20214000 */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20214000(void)

{
  uint uVar1;
  uint uVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  uint uVar5;
  uint uVar6;
  short sVar7;
  short sVar8;
  uint uVar9;
  int iVar10;
  int iVar11;
  ushort uVar12;
  ushort uVar13;
  uint unaff_R6;
  int unaff_R7;
  int iVar14;
  uint *puVar15;
  int in_P3;
  int unaff_P4;
  ushort *unaff_P5;
  int unaff_FP;
  
  uVar1 = FUN_ffa018f0();
  iVar10 = *(int *)(unaff_FP + -0x3c);
  iVar11 = *(int *)(unaff_FP + -0x3c);
  uVar9 = (uint)((int)uVar1 < (int)unaff_R6);
  if (unaff_R6 != uVar1) {
    uVar9 = (unaff_R6 & uVar1) >> 0x1f ^ (uint)((int)uVar1 < (int)unaff_R6);
  }
  *(undefined4 *)(unaff_FP + -0x3c) = *(undefined4 *)(*(int *)(unaff_FP + -0x30) + 0x24);
  if (iVar11 == 0 && (uVar1 & 0x7fffffff) == 0) {
    uVar9 = 0;
  }
  if (unaff_R7 < (int)(uVar1 & 0x7fffffff) || unaff_R7 < iVar10) {
    uVar9 = 0;
  }
  if (uVar9 == 1) {
    uVar1 = unaff_R6;
  }
  uVar2 = uVar1 & 0x7fffffff;
  *(uint *)(unaff_FP + -0x40) = uVar2;
  uVar9 = (uint)((int)*(uint *)(unaff_FP + -0x48) < (int)uVar1);
  if (uVar1 != *(uint *)(unaff_FP + -0x48)) {
    uVar9 = (uVar1 & *(uint *)(unaff_FP + -0x48)) >> 0x1f ^ uVar9;
  }
  if (uVar2 == 0 && *(int *)(unaff_FP + -0x1c) == 0) {
    uVar9 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x1c) || unaff_R7 < (int)uVar2) {
    uVar9 = 0;
  }
  uVar2 = uVar1;
  if (uVar9 == 1) {
    uVar2 = *(uint *)(unaff_FP + -0x48);
  }
  uVar3 = FUN_ffa018f0(*(undefined4 *)(in_P3 + 0x3c),*(undefined4 *)(unaff_FP + -0x3c));
  *(undefined4 *)(unaff_FP + -0x1c) = uVar3;
  uVar4 = *(undefined4 *)(unaff_FP + -0x2c);
  *(uint *)(unaff_FP + -0x2c) = *(uint *)(unaff_FP + -0x1c) & 0x7fffffff;
  uVar3 = *(undefined4 *)(*(int *)(unaff_FP + -0x30) + 0x5c);
  *(uint *)(unaff_FP + -0x3c) = uVar2 & 0x7fffffff;
  uVar3 = FUN_ffa018f0(uVar4,uVar3);
  uVar5 = FUN_ffa018f0(uVar3,0x3f99999a);
  iVar10 = *(int *)(unaff_FP + -0x2c);
  iVar11 = *(int *)(unaff_FP + -0x2c);
  uVar6 = (*(uint *)(unaff_FP + -0x1c) & uVar5) >> 0x1f;
  iVar14 = *(int *)(unaff_FP + -0x20);
  uVar9 = (uint)((int)uVar5 < (int)*(uint *)(unaff_FP + -0x1c));
  *(uint *)(unaff_FP + -0x20) = uVar6;
  *(uint *)(unaff_FP + -0x20) = uVar6 ^ uVar9;
  uVar6 = *(uint *)(unaff_FP + -0x1c);
  *(uint *)(in_P3 + 0x18) = uVar1;
  if (uVar6 != uVar5) {
    uVar9 = *(uint *)(unaff_FP + -0x20);
  }
  if (iVar11 == 0 && (uVar5 & 0x7fffffff) == 0) {
    uVar9 = 0;
  }
  if (unaff_R7 < (int)(uVar5 & 0x7fffffff) || unaff_R7 < iVar10) {
    uVar9 = 0;
  }
  if ((uVar9 & 1) == 1) {
    uVar5 = *(uint *)(unaff_FP + -0x1c);
  }
  *(uint *)(unaff_FP + -0x20) = (uVar2 & uVar5) >> 0x1f;
  uVar6 = *(uint *)(unaff_FP + -0x20) ^ (uint)((int)uVar5 < (int)uVar2);
  uVar9 = (uint)((int)uVar5 < (int)uVar2);
  if (uVar2 != uVar5) {
    uVar9 = uVar6;
  }
  if (*(int *)(unaff_FP + -0x3c) == 0 && (uVar5 & 0x7fffffff) == 0) {
    uVar9 = 0;
  }
  *(uint *)(unaff_FP + -0x20) = uVar6;
  if (unaff_R7 < (int)(uVar5 & 0x7fffffff) || unaff_R7 < *(int *)(unaff_FP + -0x3c)) {
    uVar9 = 0;
  }
  if ((uVar9 & 1) == 1) {
    uVar5 = uVar2;
  }
  uVar9 = (uint)((int)uVar1 < (int)uVar5);
  if (uVar5 != uVar1) {
    uVar9 = (uVar5 & uVar1) >> 0x1f ^ (uint)((int)uVar1 < (int)uVar5);
  }
  if ((uVar5 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x40) == 0) {
    uVar9 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x40) || unaff_R7 < (int)(uVar5 & 0x7fffffff)) {
    uVar9 = *(uint *)(unaff_FP + 8);
  }
  if ((uVar9 & 1) == 1) {
    uVar1 = uVar5;
  }
  uVar2 = *(uint *)(unaff_FP + -0x14);
  iVar10 = *(int *)(unaff_FP + -0x50);
  uVar9 = (uint)((int)uVar2 < (int)uVar1);
  if (uVar1 != uVar2) {
    uVar9 = (uVar1 & uVar2) >> 0x1f ^ (uint)((int)uVar2 < (int)uVar1);
  }
  if ((uVar1 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x4c) == 0) {
    uVar9 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x4c) || unaff_R7 < (int)(uVar1 & 0x7fffffff)) {
    uVar9 = 0;
  }
  uVar2 = *(uint *)(unaff_FP + -0x14);
  if (uVar9 == 1) {
    uVar2 = uVar1;
  }
  *(uint *)(in_P3 + 0x14) = uVar2;
  *(uint *)(iVar10 + iVar14 * 4) = uVar2;
  FUN_ffa06008(1,0,1);
  iVar10 = *(short *)(in_P3 + 10) + 1;
  iVar11 = *(int *)(*(int *)(unaff_FP + -0x30) + 0xc) >> 0x11;
  *(int *)(in_P3 + 10) = iVar10;
  iVar10 = (int)(short)iVar10;
  if ((int)(iVar11 * (uint)(iVar11 < 0x51d) + (uint)(iVar11 >= 0x51d) * 0x51d) < iVar10) {
    uVar3 = *(undefined4 *)(unaff_FP + -0x50);
    sVar8 = (short)((int)*(undefined4 *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11) + -1;
    *(short *)(in_P3 + -4) = sVar8;
    iVar10 = *(int *)(unaff_FP + -0x50);
    FUN_ffa05f2e(uVar3,0,(int)sVar8 << 1);
    sVar8 = (short)((int)*(undefined4 *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11) + 1;
    uVar3 = *(undefined4 *)(unaff_FP + 8);
    *(short *)(in_P3 + -4) = sVar8;
    FUN_ffa05f2e(iVar10 + sVar8 * 4,0,(int)(short)(0x51e - sVar8) << 1);
    puVar15 = *(uint **)(unaff_FP + -0x50);
    *(short *)(in_P3 + -4) = (short)uVar3;
    uVar9 = *(uint *)(unaff_FP + -0x6c);
    iVar10 = 0x51e;
    do {
      uVar1 = *puVar15;
      uVar2 = (uint)((int)uVar1 < (int)uVar9);
      if (uVar9 != uVar1) {
        uVar2 = (uVar9 & uVar1) >> 0x1f ^ (uint)((int)uVar1 < (int)uVar9);
      }
      if ((uVar9 & 0x7fffffff) == 0 && (uVar1 & 0x7fffffff) == 0) {
        uVar2 = 0;
      }
      if (unaff_R7 < (int)(uVar1 & 0x7fffffff) || unaff_R7 < (int)(uVar9 & 0x7fffffff)) {
        uVar2 = *(uint *)(unaff_FP + 8);
      }
      if ((uVar2 & 1) == 1) {
        uVar1 = uVar9;
      }
      uVar9 = uVar1;
    } while ((iVar10 != 0) && (iVar10 = iVar10 + -1, puVar15 = puVar15 + 1, iVar10 != 0));
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar14 = *(int *)(unaff_FP + 0x10);
  *(int *)(in_P3 + 0x10) = iVar10 << 0x11;
  iVar11 = (iVar10 - *(short *)(in_P3 + 0xc)) + -1;
  iVar10 = iVar10 - (*(byte *)(iVar14 + 0x2b) + 1) * (int)*(short *)(in_P3 + 0xc);
  *(int *)(in_P3 + 0x4c) = iVar11;
  *(int *)(in_P3 + 0x50) = iVar10;
  if (*(short *)(in_P3 + 0x7c) < iVar11) {
    sVar8 = (short)*(undefined4 *)(in_P3 + 0x7c);
    sVar7 = sVar8 * 4 + 1;
    *(short *)(in_P3 + -4) = sVar7;
    if ((int)sVar7 <= iVar11 * 4) {
      do {
        uVar9 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar1 = 0;
        if (uVar9 != 0 && ((int)uVar9 <= unaff_R7 && (uVar9 & 0x80000000) == 0)) {
          uVar1 = uVar9;
        }
        uVar3 = FUN_ffa0248c(uVar1);
        uVar12 = *unaff_P5;
        uVar3 = FUN_ffa01716(uVar3,*(undefined4 *)(unaff_P5 + 0x16));
        *unaff_P5 = uVar12 + 1;
        *(undefined4 *)(unaff_P5 + 0x16) = uVar3;
      } while ((int)(short)(uVar12 + 1) <= *(int *)(unaff_P5 + 0x28) << 2);
      sVar8 = (short)*(undefined4 *)(in_P3 + 0x7c);
    }
    *(short *)(in_P3 + 0x7c) = sVar8 + 1;
    *(int *)(in_P3 + 0x54) = *(int *)(in_P3 + 0x54) + 1;
    iVar10 = *(int *)(in_P3 + 0x50);
  }
  if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11 < iVar10) &&
     (((int)*(short *)(in_P3 + 0x7c) - *(int *)(in_P3 + 0x54)) + 1 < iVar10)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar10 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c);
  *(uint *)(in_P3 + 0x50) =
       (int)*(short *)(in_P3 + 10) +
       (int)*(short *)(in_P3 + 0xc) * (*(byte *)(*(int *)(unaff_FP + 0x10) + 0x2b) + 1);
  *(int *)(in_P3 + 0x4c) = (int)*(short *)(in_P3 + 10) + (int)*(short *)(in_P3 + 0xc) + 1;
  while( true ) {
    iVar11 = *(int *)(unaff_FP + 0xc);
    iVar10 = *(short *)(iVar11 + 0x5e) + iVar10;
    if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11 < iVar10) ||
       (*(int *)(iVar11 + 0x30) <= iVar10)) break;
    sVar8 = (short)iVar10 * 4 + 1;
    *(short *)(iVar11 + -0x24) = sVar8;
    if ((int)sVar8 <= (iVar10 + 1) * 4) {
      do {
        uVar9 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar1 = 0;
        if (uVar9 != 0 && ((int)uVar9 <= unaff_R7 && (uVar9 & 0x80000000) == 0)) {
          uVar1 = uVar9;
        }
        uVar3 = FUN_ffa0248c(uVar1);
        uVar12 = unaff_P5[0x41];
        iVar10 = *(int *)(unaff_P5 + 0x30);
        uVar3 = FUN_ffa01716(uVar3,*(undefined4 *)(unaff_P5 + 0x1c));
        uVar13 = *unaff_P5;
        *unaff_P5 = uVar13 + 1;
        *(undefined4 *)(unaff_P5 + 0x1c) = uVar3;
      } while ((int)(short)(uVar13 + 1) <= ((short)uVar12 + iVar10 + 1) * 4);
    }
    iVar10 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) + 1;
    *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) = iVar10;
  }
  if (*(int *)(unaff_P5 + 0x28) <= (int)(short)unaff_P5[0x41]) {
    if (100 < *(byte *)(*(int *)(unaff_FP + 0x10) + 0x2a)) {
      uVar12 = unaff_P5[7];
      *(undefined4 *)(in_P3 + 0x74) = 0;
      *(int *)(unaff_FP + -0x20) = (int)(short)uVar12;
      *(undefined4 *)(unaff_FP + -0x14) = 0;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
    FUN_202144a4();
    return;
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


