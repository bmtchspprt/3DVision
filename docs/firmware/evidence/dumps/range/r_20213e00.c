
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20213e00(void)

{
  undefined4 uVar1;
  undefined4 uVar2;
  uint uVar3;
  uint uVar4;
  short sVar5;
  short sVar6;
  int iVar7;
  uint uVar8;
  int iVar9;
  ushort uVar10;
  uint uVar11;
  uint uVar12;
  ushort uVar13;
  uint uVar14;
  int unaff_R7;
  undefined4 *in_P1;
  int iVar15;
  uint *puVar16;
  int in_P3;
  int unaff_P4;
  ushort *unaff_P5;
  int unaff_FP;
  
  uVar2 = *in_P1;
  uVar1 = FUN_ffa01688();
  FUN_ffa018f0(uVar1,uVar2);
  uVar2 = FUN_ffa01716();
  uVar2 = FUN_ffa01814(uVar2,0x40000000);
  iVar7 = *(int *)(in_P3 + 0x54);
  *(undefined4 *)(in_P3 + 0x40) = uVar2;
  *(int *)(unaff_FP + -0x2c) = iVar7;
  uVar2 = FUN_ffa01688();
  uVar3 = FUN_ffa01814(*(undefined4 *)(in_P3 + 0x28),uVar2);
  uVar4 = uVar3;
  if (iVar7 < *(int *)(in_P3 + 0x58)) {
    uVar1 = *(undefined4 *)(in_P3 + 0x2c);
    uVar2 = FUN_ffa01688(*(int *)(in_P3 + 0x58));
    uVar4 = FUN_ffa01814(uVar1,uVar2);
    *(uint *)(unaff_FP + -0x4c) = (uVar4 & uVar3) >> 0x1f;
    uVar11 = (uint)((int)uVar3 < (int)uVar4);
    if (uVar4 != uVar3) {
      uVar11 = *(uint *)(unaff_FP + -0x4c) ^ (uint)((int)uVar3 < (int)uVar4);
    }
    if ((uVar4 & 0x7fffffff) == 0 && (uVar3 & 0x7fffffff) == 0) {
      uVar11 = 0;
    }
    if (unaff_R7 < (int)(uVar3 & 0x7fffffff) || unaff_R7 < (int)(uVar4 & 0x7fffffff)) {
      uVar11 = 0;
    }
    if ((uVar11 & 1) == 1) {
      uVar4 = uVar3;
    }
  }
  uVar11 = FUN_ffa01814(uVar4,0x40800000);
  *(undefined4 *)(unaff_FP + -0x1c) = *(undefined4 *)(in_P3 + 0x34);
  iVar7 = *(int *)(in_P3 + 0x5c);
  *(uint *)(unaff_FP + -0x4c) = *(uint *)(unaff_FP + -0x14) & 0x7fffffff;
  uVar2 = FUN_ffa01688(iVar7 << 2);
  uVar4 = FUN_ffa01814(*(undefined4 *)(unaff_FP + -0x1c),uVar2);
  *(uint *)(in_P3 + 0x30) = uVar11;
  uVar12 = *(uint *)(in_P3 + 0x1c);
  uVar8 = (uint)(unaff_R7 < (int)(uVar4 & 0x7fffffff));
  uVar3 = 1;
  if ((int)(uVar11 & 0x7fffffff) <= unaff_R7) {
    uVar3 = uVar8;
  }
  uVar14 = (uVar4 & uVar11) >> 0x1f;
  *(uint *)(unaff_FP + -0x1c) = uVar8;
  *(uint *)(unaff_FP + -0x1c) = uVar14;
  uVar14 = uVar14 ^ (int)uVar11 < (int)uVar4;
  uVar8 = (uint)((int)uVar11 < (int)uVar4);
  if (uVar4 != uVar11) {
    uVar8 = uVar14;
  }
  *(uint *)(unaff_FP + -0x1c) = uVar14;
  if ((uVar4 & 0x7fffffff) == 0 && (uVar11 & 0x7fffffff) == 0) {
    uVar8 = 0;
  }
  if (uVar3 == 1) {
    uVar8 = 0;
  }
  if (uVar8 == 1) {
    uVar4 = uVar11;
  }
  *(uint *)(unaff_FP + -0x40) = uVar12;
  uVar2 = FUN_ffa018f0(uVar4);
  *(undefined4 *)(unaff_FP + -0x48) = uVar2;
  *(uint *)(in_P3 + 0x20) = uVar12;
  uVar4 = FUN_ffa018f0(uVar2,uVar12);
  *(uint *)(unaff_FP + -0x3c) = uVar4 & 0x7fffffff;
  uVar2 = 0x3e800000;
  if ((int)(uVar12 & 0x7fffffff) <= unaff_R7 && *(int *)(unaff_FP + -0x40) < 0x3e800000) {
    uVar2 = *(undefined4 *)(unaff_FP + -0x40);
  }
  uVar1 = *(undefined4 *)(in_P3 + 0x24);
  *(uint *)(unaff_FP + -0x1c) = *(uint *)(unaff_FP + -0x48) & 0x7fffffff;
  uVar11 = FUN_ffa018f0(uVar2,uVar1);
  iVar7 = *(int *)(unaff_FP + -0x3c);
  iVar9 = *(int *)(unaff_FP + -0x3c);
  uVar3 = (uint)((int)uVar11 < (int)uVar4);
  if (uVar4 != uVar11) {
    uVar3 = (uVar4 & uVar11) >> 0x1f ^ (uint)((int)uVar11 < (int)uVar4);
  }
  *(undefined4 *)(unaff_FP + -0x3c) = *(undefined4 *)(*(int *)(unaff_FP + -0x30) + 0x24);
  if (iVar9 == 0 && (uVar11 & 0x7fffffff) == 0) {
    uVar3 = 0;
  }
  if (unaff_R7 < (int)(uVar11 & 0x7fffffff) || unaff_R7 < iVar7) {
    uVar3 = 0;
  }
  if (uVar3 == 1) {
    uVar11 = uVar4;
  }
  uVar3 = uVar11 & 0x7fffffff;
  *(uint *)(unaff_FP + -0x40) = uVar3;
  uVar4 = (uint)((int)*(uint *)(unaff_FP + -0x48) < (int)uVar11);
  if (uVar11 != *(uint *)(unaff_FP + -0x48)) {
    uVar4 = (uVar11 & *(uint *)(unaff_FP + -0x48)) >> 0x1f ^ uVar4;
  }
  if (uVar3 == 0 && *(int *)(unaff_FP + -0x1c) == 0) {
    uVar4 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x1c) || unaff_R7 < (int)uVar3) {
    uVar4 = 0;
  }
  uVar3 = uVar11;
  if (uVar4 == 1) {
    uVar3 = *(uint *)(unaff_FP + -0x48);
  }
  uVar2 = FUN_ffa018f0(*(undefined4 *)(in_P3 + 0x3c),*(undefined4 *)(unaff_FP + -0x3c));
  *(undefined4 *)(unaff_FP + -0x1c) = uVar2;
  uVar1 = *(undefined4 *)(unaff_FP + -0x2c);
  *(uint *)(unaff_FP + -0x2c) = *(uint *)(unaff_FP + -0x1c) & 0x7fffffff;
  uVar2 = *(undefined4 *)(*(int *)(unaff_FP + -0x30) + 0x5c);
  *(uint *)(unaff_FP + -0x3c) = uVar3 & 0x7fffffff;
  uVar2 = FUN_ffa018f0(uVar1,uVar2);
  uVar8 = FUN_ffa018f0(uVar2,0x3f99999a);
  iVar7 = *(int *)(unaff_FP + -0x2c);
  iVar9 = *(int *)(unaff_FP + -0x2c);
  uVar12 = (*(uint *)(unaff_FP + -0x1c) & uVar8) >> 0x1f;
  iVar15 = *(int *)(unaff_FP + -0x20);
  uVar4 = (uint)((int)uVar8 < (int)*(uint *)(unaff_FP + -0x1c));
  *(uint *)(unaff_FP + -0x20) = uVar12;
  *(uint *)(unaff_FP + -0x20) = uVar12 ^ uVar4;
  uVar12 = *(uint *)(unaff_FP + -0x1c);
  *(uint *)(in_P3 + 0x18) = uVar11;
  if (uVar12 != uVar8) {
    uVar4 = *(uint *)(unaff_FP + -0x20);
  }
  if (iVar9 == 0 && (uVar8 & 0x7fffffff) == 0) {
    uVar4 = 0;
  }
  if (unaff_R7 < (int)(uVar8 & 0x7fffffff) || unaff_R7 < iVar7) {
    uVar4 = 0;
  }
  if ((uVar4 & 1) == 1) {
    uVar8 = *(uint *)(unaff_FP + -0x1c);
  }
  *(uint *)(unaff_FP + -0x20) = (uVar3 & uVar8) >> 0x1f;
  uVar12 = *(uint *)(unaff_FP + -0x20) ^ (uint)((int)uVar8 < (int)uVar3);
  uVar4 = (uint)((int)uVar8 < (int)uVar3);
  if (uVar3 != uVar8) {
    uVar4 = uVar12;
  }
  if (*(int *)(unaff_FP + -0x3c) == 0 && (uVar8 & 0x7fffffff) == 0) {
    uVar4 = 0;
  }
  *(uint *)(unaff_FP + -0x20) = uVar12;
  if (unaff_R7 < (int)(uVar8 & 0x7fffffff) || unaff_R7 < *(int *)(unaff_FP + -0x3c)) {
    uVar4 = 0;
  }
  if ((uVar4 & 1) == 1) {
    uVar8 = uVar3;
  }
  uVar4 = (uint)((int)uVar11 < (int)uVar8);
  if (uVar8 != uVar11) {
    uVar4 = (uVar8 & uVar11) >> 0x1f ^ (uint)((int)uVar11 < (int)uVar8);
  }
  if ((uVar8 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x40) == 0) {
    uVar4 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x40) || unaff_R7 < (int)(uVar8 & 0x7fffffff)) {
    uVar4 = *(uint *)(unaff_FP + 8);
  }
  if ((uVar4 & 1) == 1) {
    uVar11 = uVar8;
  }
  uVar3 = *(uint *)(unaff_FP + -0x14);
  iVar7 = *(int *)(unaff_FP + -0x50);
  uVar4 = (uint)((int)uVar3 < (int)uVar11);
  if (uVar11 != uVar3) {
    uVar4 = (uVar11 & uVar3) >> 0x1f ^ (uint)((int)uVar3 < (int)uVar11);
  }
  if ((uVar11 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x4c) == 0) {
    uVar4 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x4c) || unaff_R7 < (int)(uVar11 & 0x7fffffff)) {
    uVar4 = 0;
  }
  uVar3 = *(uint *)(unaff_FP + -0x14);
  if (uVar4 == 1) {
    uVar3 = uVar11;
  }
  *(uint *)(in_P3 + 0x14) = uVar3;
  *(uint *)(iVar7 + iVar15 * 4) = uVar3;
  FUN_ffa06008(1,0,1);
  iVar7 = *(short *)(in_P3 + 10) + 1;
  iVar9 = *(int *)(*(int *)(unaff_FP + -0x30) + 0xc) >> 0x11;
  *(int *)(in_P3 + 10) = iVar7;
  iVar7 = (int)(short)iVar7;
  if ((int)(iVar9 * (uint)(iVar9 < 0x51d) + (uint)(iVar9 >= 0x51d) * 0x51d) < iVar7) {
    uVar2 = *(undefined4 *)(unaff_FP + -0x50);
    sVar6 = (short)((int)*(undefined4 *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11) + -1;
    *(short *)(in_P3 + -4) = sVar6;
    iVar7 = *(int *)(unaff_FP + -0x50);
    FUN_ffa05f2e(uVar2,0,(int)sVar6 << 1);
    sVar6 = (short)((int)*(undefined4 *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11) + 1;
    uVar2 = *(undefined4 *)(unaff_FP + 8);
    *(short *)(in_P3 + -4) = sVar6;
    FUN_ffa05f2e(iVar7 + sVar6 * 4,0,(int)(short)(0x51e - sVar6) << 1);
    puVar16 = *(uint **)(unaff_FP + -0x50);
    *(short *)(in_P3 + -4) = (short)uVar2;
    uVar4 = *(uint *)(unaff_FP + -0x6c);
    iVar7 = 0x51e;
    do {
      uVar3 = *puVar16;
      uVar11 = (uint)((int)uVar3 < (int)uVar4);
      if (uVar4 != uVar3) {
        uVar11 = (uVar4 & uVar3) >> 0x1f ^ (uint)((int)uVar3 < (int)uVar4);
      }
      if ((uVar4 & 0x7fffffff) == 0 && (uVar3 & 0x7fffffff) == 0) {
        uVar11 = 0;
      }
      if (unaff_R7 < (int)(uVar3 & 0x7fffffff) || unaff_R7 < (int)(uVar4 & 0x7fffffff)) {
        uVar11 = *(uint *)(unaff_FP + 8);
      }
      if ((uVar11 & 1) == 1) {
        uVar3 = uVar4;
      }
      uVar4 = uVar3;
    } while ((iVar7 != 0) && (iVar7 = iVar7 + -1, puVar16 = puVar16 + 1, iVar7 != 0));
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar15 = *(int *)(unaff_FP + 0x10);
  *(int *)(in_P3 + 0x10) = iVar7 << 0x11;
  iVar9 = (iVar7 - *(short *)(in_P3 + 0xc)) + -1;
  iVar7 = iVar7 - (*(byte *)(iVar15 + 0x2b) + 1) * (int)*(short *)(in_P3 + 0xc);
  *(int *)(in_P3 + 0x4c) = iVar9;
  *(int *)(in_P3 + 0x50) = iVar7;
  if (*(short *)(in_P3 + 0x7c) < iVar9) {
    sVar6 = (short)*(undefined4 *)(in_P3 + 0x7c);
    sVar5 = sVar6 * 4 + 1;
    *(short *)(in_P3 + -4) = sVar5;
    if ((int)sVar5 <= iVar9 * 4) {
      do {
        uVar4 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar3 = 0;
        if (uVar4 != 0 && ((int)uVar4 <= unaff_R7 && (uVar4 & 0x80000000) == 0)) {
          uVar3 = uVar4;
        }
        uVar2 = FUN_ffa0248c(uVar3);
        uVar10 = *unaff_P5;
        uVar2 = FUN_ffa01716(uVar2,*(undefined4 *)(unaff_P5 + 0x16));
        *unaff_P5 = uVar10 + 1;
        *(undefined4 *)(unaff_P5 + 0x16) = uVar2;
      } while ((int)(short)(uVar10 + 1) <= *(int *)(unaff_P5 + 0x28) << 2);
      sVar6 = (short)*(undefined4 *)(in_P3 + 0x7c);
    }
    *(short *)(in_P3 + 0x7c) = sVar6 + 1;
    *(int *)(in_P3 + 0x54) = *(int *)(in_P3 + 0x54) + 1;
    iVar7 = *(int *)(in_P3 + 0x50);
  }
  if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11 < iVar7) &&
     (((int)*(short *)(in_P3 + 0x7c) - *(int *)(in_P3 + 0x54)) + 1 < iVar7)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar7 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c);
  *(uint *)(in_P3 + 0x50) =
       (int)*(short *)(in_P3 + 10) +
       (int)*(short *)(in_P3 + 0xc) * (*(byte *)(*(int *)(unaff_FP + 0x10) + 0x2b) + 1);
  *(int *)(in_P3 + 0x4c) = (int)*(short *)(in_P3 + 10) + (int)*(short *)(in_P3 + 0xc) + 1;
  while( true ) {
    iVar9 = *(int *)(unaff_FP + 0xc);
    iVar7 = *(short *)(iVar9 + 0x5e) + iVar7;
    if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11 < iVar7) ||
       (*(int *)(iVar9 + 0x30) <= iVar7)) break;
    sVar6 = (short)iVar7 * 4 + 1;
    *(short *)(iVar9 + -0x24) = sVar6;
    if ((int)sVar6 <= (iVar7 + 1) * 4) {
      do {
        uVar4 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar3 = 0;
        if (uVar4 != 0 && ((int)uVar4 <= unaff_R7 && (uVar4 & 0x80000000) == 0)) {
          uVar3 = uVar4;
        }
        uVar2 = FUN_ffa0248c(uVar3);
        uVar10 = unaff_P5[0x41];
        iVar7 = *(int *)(unaff_P5 + 0x30);
        uVar2 = FUN_ffa01716(uVar2,*(undefined4 *)(unaff_P5 + 0x1c));
        uVar13 = *unaff_P5;
        *unaff_P5 = uVar13 + 1;
        *(undefined4 *)(unaff_P5 + 0x1c) = uVar2;
      } while ((int)(short)(uVar13 + 1) <= ((short)uVar10 + iVar7 + 1) * 4);
    }
    iVar7 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) + 1;
    *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) = iVar7;
  }
  if (*(int *)(unaff_P5 + 0x28) <= (int)(short)unaff_P5[0x41]) {
    if (100 < *(byte *)(*(int *)(unaff_FP + 0x10) + 0x2a)) {
      uVar10 = unaff_P5[7];
      *(undefined4 *)(in_P3 + 0x74) = 0;
      *(int *)(unaff_FP + -0x20) = (int)(short)uVar10;
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


