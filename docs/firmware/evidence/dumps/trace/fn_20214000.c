
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20214000(void)

{
  uint uVar1;
  uint uVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  uint uVar5;
  uint uVar6;
  undefined4 uVar7;
  short sVar8;
  short sVar9;
  uint uVar10;
  int iVar11;
  int iVar12;
  ushort uVar13;
  ushort uVar14;
  uint unaff_R6;
  int unaff_R7;
  int iVar15;
  uint *puVar16;
  int in_P3;
  int unaff_P4;
  ushort *unaff_P5;
  int unaff_FP;
  undefined1 uVar17;
  
  uVar1 = FUN_ffa018f0();
  iVar11 = *(int *)(unaff_FP + -0x3c);
  iVar12 = *(int *)(unaff_FP + -0x3c);
  uVar10 = (uint)((int)uVar1 < (int)unaff_R6);
  if (unaff_R6 != uVar1) {
    uVar10 = (unaff_R6 & uVar1) >> 0x1f ^ (uint)((int)uVar1 < (int)unaff_R6);
  }
  *(undefined4 *)(unaff_FP + -0x3c) = *(undefined4 *)(*(int *)(unaff_FP + -0x30) + 0x24);
  if (iVar12 == 0 && (uVar1 & 0x7fffffff) == 0) {
    uVar10 = 0;
  }
  if (unaff_R7 < (int)(uVar1 & 0x7fffffff) || unaff_R7 < iVar11) {
    uVar10 = 0;
  }
  if (uVar10 == 1) {
    uVar1 = unaff_R6;
  }
  uVar2 = uVar1 & 0x7fffffff;
  *(uint *)(unaff_FP + -0x40) = uVar2;
  uVar10 = (uint)((int)*(uint *)(unaff_FP + -0x48) < (int)uVar1);
  if (uVar1 != *(uint *)(unaff_FP + -0x48)) {
    uVar10 = (uVar1 & *(uint *)(unaff_FP + -0x48)) >> 0x1f ^ uVar10;
  }
  if (uVar2 == 0 && *(int *)(unaff_FP + -0x1c) == 0) {
    uVar10 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x1c) || unaff_R7 < (int)uVar2) {
    uVar10 = 0;
  }
  uVar2 = uVar1;
  if (uVar10 == 1) {
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
  iVar11 = *(int *)(unaff_FP + -0x2c);
  iVar12 = *(int *)(unaff_FP + -0x2c);
  uVar6 = (*(uint *)(unaff_FP + -0x1c) & uVar5) >> 0x1f;
  iVar15 = *(int *)(unaff_FP + -0x20);
  uVar10 = (uint)((int)uVar5 < (int)*(uint *)(unaff_FP + -0x1c));
  *(uint *)(unaff_FP + -0x20) = uVar6;
  *(uint *)(unaff_FP + -0x20) = uVar6 ^ uVar10;
  uVar6 = *(uint *)(unaff_FP + -0x1c);
  *(uint *)(in_P3 + 0x18) = uVar1;
  if (uVar6 != uVar5) {
    uVar10 = *(uint *)(unaff_FP + -0x20);
  }
  if (iVar12 == 0 && (uVar5 & 0x7fffffff) == 0) {
    uVar10 = 0;
  }
  if (unaff_R7 < (int)(uVar5 & 0x7fffffff) || unaff_R7 < iVar11) {
    uVar10 = 0;
  }
  if ((uVar10 & 1) == 1) {
    uVar5 = *(uint *)(unaff_FP + -0x1c);
  }
  *(uint *)(unaff_FP + -0x20) = (uVar2 & uVar5) >> 0x1f;
  uVar6 = *(uint *)(unaff_FP + -0x20) ^ (uint)((int)uVar5 < (int)uVar2);
  uVar10 = (uint)((int)uVar5 < (int)uVar2);
  if (uVar2 != uVar5) {
    uVar10 = uVar6;
  }
  if (*(int *)(unaff_FP + -0x3c) == 0 && (uVar5 & 0x7fffffff) == 0) {
    uVar10 = 0;
  }
  *(uint *)(unaff_FP + -0x20) = uVar6;
  if (unaff_R7 < (int)(uVar5 & 0x7fffffff) || unaff_R7 < *(int *)(unaff_FP + -0x3c)) {
    uVar10 = 0;
  }
  if ((uVar10 & 1) == 1) {
    uVar5 = uVar2;
  }
  uVar10 = (uint)((int)uVar1 < (int)uVar5);
  if (uVar5 != uVar1) {
    uVar10 = (uVar5 & uVar1) >> 0x1f ^ (uint)((int)uVar1 < (int)uVar5);
  }
  if ((uVar5 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x40) == 0) {
    uVar10 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x40) || unaff_R7 < (int)(uVar5 & 0x7fffffff)) {
    uVar10 = *(uint *)(unaff_FP + 8);
  }
  if ((uVar10 & 1) == 1) {
    uVar1 = uVar5;
  }
  uVar2 = *(uint *)(unaff_FP + -0x14);
  iVar11 = *(int *)(unaff_FP + -0x50);
  uVar10 = (uint)((int)uVar2 < (int)uVar1);
  if (uVar1 != uVar2) {
    uVar10 = (uVar1 & uVar2) >> 0x1f ^ (uint)((int)uVar2 < (int)uVar1);
  }
  if ((uVar1 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x4c) == 0) {
    uVar10 = 0;
  }
  if (unaff_R7 < *(int *)(unaff_FP + -0x4c) || unaff_R7 < (int)(uVar1 & 0x7fffffff)) {
    uVar10 = 0;
  }
  uVar2 = *(uint *)(unaff_FP + -0x14);
  if (uVar10 == 1) {
    uVar2 = uVar1;
  }
  *(uint *)(in_P3 + 0x14) = uVar2;
  *(uint *)(iVar11 + iVar15 * 4) = uVar2;
  FUN_ffa06008(1,0,1);
  iVar11 = *(short *)(in_P3 + 10) + 1;
  iVar12 = *(int *)(*(int *)(unaff_FP + -0x30) + 0xc) >> 0x11;
  *(int *)(in_P3 + 10) = iVar11;
  iVar11 = (int)(short)iVar11;
  if ((int)(iVar12 * (uint)(iVar12 < 0x51d) + (uint)(iVar12 >= 0x51d) * 0x51d) < iVar11) {
    uVar3 = *(undefined4 *)(unaff_FP + -0x50);
    sVar9 = (short)((int)*(undefined4 *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11) + -1;
    *(short *)(in_P3 + -4) = sVar9;
    iVar11 = *(int *)(unaff_FP + -0x50);
    FUN_ffa05f2e(uVar3,0,(int)sVar9 << 1);
    sVar9 = (short)((int)*(undefined4 *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11) + 1;
    uVar3 = *(undefined4 *)(unaff_FP + 8);
    *(short *)(in_P3 + -4) = sVar9;
    FUN_ffa05f2e(iVar11 + sVar9 * 4,0,(int)(short)(0x51e - sVar9) << 1);
    puVar16 = *(uint **)(unaff_FP + -0x50);
    *(short *)(in_P3 + -4) = (short)uVar3;
    uVar10 = *(uint *)(unaff_FP + -0x6c);
    iVar11 = 0x51e;
    do {
      uVar1 = *puVar16;
      uVar2 = (uint)((int)uVar1 < (int)uVar10);
      if (uVar10 != uVar1) {
        uVar2 = (uVar10 & uVar1) >> 0x1f ^ (uint)((int)uVar1 < (int)uVar10);
      }
      if ((uVar10 & 0x7fffffff) == 0 && (uVar1 & 0x7fffffff) == 0) {
        uVar2 = 0;
      }
      if (unaff_R7 < (int)(uVar1 & 0x7fffffff) || unaff_R7 < (int)(uVar10 & 0x7fffffff)) {
        uVar2 = *(uint *)(unaff_FP + 8);
      }
      if ((uVar2 & 1) == 1) {
        uVar1 = uVar10;
      }
      uVar10 = uVar1;
    } while ((iVar11 != 0) && (iVar11 = iVar11 + -1, puVar16 = puVar16 + 1, iVar11 != 0));
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar15 = *(int *)(unaff_FP + 0x10);
  *(int *)(in_P3 + 0x10) = iVar11 << 0x11;
  iVar12 = (iVar11 - *(short *)(in_P3 + 0xc)) + -1;
  iVar11 = iVar11 - (*(byte *)(iVar15 + 0x2b) + 1) * (int)*(short *)(in_P3 + 0xc);
  *(int *)(in_P3 + 0x4c) = iVar12;
  *(int *)(in_P3 + 0x50) = iVar11;
  if (*(short *)(in_P3 + 0x7c) < iVar12) {
    sVar9 = (short)*(undefined4 *)(in_P3 + 0x7c);
    sVar8 = sVar9 * 4 + 1;
    *(short *)(in_P3 + -4) = sVar8;
    if ((int)sVar8 <= iVar12 * 4) {
      do {
        uVar10 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar1 = 0;
        if (uVar10 != 0 && ((int)uVar10 <= unaff_R7 && (uVar10 & 0x80000000) == 0)) {
          uVar1 = uVar10;
        }
        uVar3 = FUN_ffa0248c(uVar1);
        uVar13 = *unaff_P5;
        uVar3 = FUN_ffa01716(uVar3,*(undefined4 *)(unaff_P5 + 0x16));
        *unaff_P5 = uVar13 + 1;
        *(undefined4 *)(unaff_P5 + 0x16) = uVar3;
      } while ((int)(short)(uVar13 + 1) <= *(int *)(unaff_P5 + 0x28) << 2);
      sVar9 = (short)*(undefined4 *)(in_P3 + 0x7c);
    }
    *(short *)(in_P3 + 0x7c) = sVar9 + 1;
    *(int *)(in_P3 + 0x54) = *(int *)(in_P3 + 0x54) + 1;
    iVar11 = *(int *)(in_P3 + 0x50);
  }
  if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0x14) >> 0x11 < iVar11) &&
     (((int)*(short *)(in_P3 + 0x7c) - *(int *)(in_P3 + 0x54)) + 1 < iVar11)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar11 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c);
  *(uint *)(in_P3 + 0x50) =
       (int)*(short *)(in_P3 + 10) +
       (int)*(short *)(in_P3 + 0xc) * (*(byte *)(*(int *)(unaff_FP + 0x10) + 0x2b) + 1);
  *(int *)(in_P3 + 0x4c) = (int)*(short *)(in_P3 + 10) + (int)*(short *)(in_P3 + 0xc) + 1;
  while( true ) {
    iVar12 = *(int *)(unaff_FP + 0xc);
    iVar11 = *(short *)(iVar12 + 0x5e) + iVar11;
    if ((*(int *)(*(int *)(unaff_FP + 0x10) + 0xc) >> 0x11 < iVar11) ||
       (*(int *)(iVar12 + 0x30) <= iVar11)) break;
    sVar9 = (short)iVar11 * 4 + 1;
    *(short *)(iVar12 + -0x24) = sVar9;
    if ((int)sVar9 <= (iVar11 + 1) * 4) {
      do {
        uVar10 = *(uint *)(unaff_P4 + (uint)*unaff_P5 * 4);
        uVar1 = 0;
        if (uVar10 != 0 && ((int)uVar10 <= unaff_R7 && (uVar10 & 0x80000000) == 0)) {
          uVar1 = uVar10;
        }
        uVar3 = FUN_ffa0248c(uVar1);
        uVar13 = unaff_P5[0x41];
        iVar11 = *(int *)(unaff_P5 + 0x30);
        uVar3 = FUN_ffa01716(uVar3,*(undefined4 *)(unaff_P5 + 0x1c));
        uVar14 = *unaff_P5;
        *unaff_P5 = uVar14 + 1;
        *(undefined4 *)(unaff_P5 + 0x1c) = uVar3;
      } while ((int)(short)(uVar14 + 1) <= ((short)uVar13 + iVar11 + 1) * 4);
    }
    iVar11 = *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) + 1;
    *(int *)(*(int *)(unaff_FP + 0xc) + 0x3c) = iVar11;
  }
  if (*(int *)(unaff_P5 + 0x28) <= (int)(short)unaff_P5[0x41]) {
    if (*(byte *)(*(int *)(unaff_FP + 0x10) + 0x2a) < 0x65) {
      iVar11 = (int)*(short *)(in_P3 + 10);
      if (*(int *)(in_P3 + 0x60) < iVar11) {
        iVar12 = *(int *)(in_P3 + 100);
        uVar17 = iVar11 < iVar12;
        if ((bool)uVar17) {
          uVar3 = FUN_ffa01688(iVar11);
          uVar3 = FUN_ffa018f0(uVar3,*(uint *)(in_P3 + 0x70) ^ 0x80000000);
          uVar3 = FUN_ffa01c74(*(undefined4 *)(unaff_FP + -0x58),uVar3);
          uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(in_P3 + 0x6c));
          *(undefined4 *)(in_P3 + 0x74) = uVar3;
          uVar3 = FUN_20212a64(*(undefined4 *)(unaff_P5 + 10),*(undefined4 *)(unaff_FP + -100),
                               *(undefined4 *)(unaff_FP + -0x54));
          uVar7 = FUN_ffa018f0(uVar3,*(undefined4 *)(unaff_P5 + 0x3c));
          uVar3 = *(undefined4 *)(unaff_P5 + 0x3e);
          FUN_ffa0165c(uVar7,uVar3);
          uVar4 = uVar3;
          if ((bool)uVar17) {
            uVar4 = uVar7;
          }
          FUN_ffa01618(*(undefined4 *)(unaff_FP + -0x44),uVar3);
          uVar13 = unaff_P5[7];
          *(undefined4 *)(unaff_P5 + 0x3c) = uVar4;
          *(undefined4 *)(unaff_FP + -0x14) = uVar4;
          *(int *)(unaff_FP + -0x20) = (int)(short)uVar13;
          if ((bool)uVar17) {
            *(undefined4 *)(unaff_P5 + 0x3e) = uVar4;
          }
        }
        else {
          iVar15 = *(int *)(unaff_P5 + 0x36);
          if (iVar11 < iVar15) {
            uVar3 = FUN_ffa01688(iVar15 - iVar11);
            uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(unaff_P5 + 0x4e));
            *(undefined4 *)(unaff_FP + -0x14) = uVar3;
            uVar3 = FUN_ffa01688(iVar15 - iVar12);
            uVar3 = FUN_ffa01814(*(undefined4 *)(unaff_FP + -0x14),uVar3);
            *(undefined4 *)(unaff_P5 + 0x3c) = uVar3;
            uVar3 = FUN_20212a64(iVar12 << 0x11,*(undefined4 *)(unaff_FP + -100),
                                 *(undefined4 *)(unaff_FP + -0x54));
            uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(unaff_P5 + 0x3c));
            uVar13 = unaff_P5[7];
            *(undefined4 *)(unaff_P5 + 0x3c) = uVar3;
            *(undefined4 *)(unaff_FP + -0x14) = uVar3;
            *(int *)(unaff_FP + -0x20) = (int)(short)uVar13;
          }
          else {
            unaff_P5[0x3c] = 0;
            unaff_P5[0x3d] = 0;
            *(int *)(unaff_FP + -0x20) = iVar11;
            *(undefined4 *)(unaff_FP + -0x14) = 0;
          }
        }
      }
      else {
        uVar3 = FUN_ffa01688();
        uVar3 = FUN_ffa018f0(uVar3,*(uint *)(in_P3 + 0x70) ^ 0x80000000);
        uVar3 = FUN_ffa01c74(*(undefined4 *)(unaff_FP + -0x58),uVar3);
        uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(in_P3 + 0x6c));
        *(undefined4 *)(in_P3 + 0x74) = uVar3;
        uVar3 = FUN_20212a64(*(int *)(in_P3 + 0x60) << 0x11,*(undefined4 *)(unaff_FP + -100),
                             *(undefined4 *)(unaff_FP + -0x54));
        uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(in_P3 + 0x74));
        *(undefined4 *)(in_P3 + 0x74) = uVar3;
        uVar13 = unaff_P5[7];
        *(undefined4 *)(in_P3 + 0x78) = uVar3;
        *(int *)(unaff_FP + -0x20) = (int)(short)uVar13;
        *(undefined4 *)(unaff_FP + -0x14) = *(undefined4 *)(in_P3 + 0x74);
      }
    }
    else {
      uVar13 = unaff_P5[7];
      *(undefined4 *)(in_P3 + 0x74) = 0;
      *(int *)(unaff_FP + -0x20) = (int)(short)uVar13;
      *(undefined4 *)(unaff_FP + -0x14) = 0;
    }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


