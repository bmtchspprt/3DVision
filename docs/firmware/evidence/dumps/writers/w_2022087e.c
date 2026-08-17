/* seed 2022087e */

/* WARNING: Control flow encountered unimplemented instructions */

undefined4 FUN_2022087e(undefined2 param_1,int param_2,int param_3)

{
  char *pcVar1;
  char cVar2;
  undefined1 uVar3;
  short sVar4;
  int iVar5;
  undefined4 uVar6;
  uint uVar7;
  uint uVar8;
  int iVar9;
  int iVar10;
  undefined4 uVar11;
  int in_R3;
  short sVar12;
  int unaff_R6;
  undefined4 uVar13;
  int *in_P0;
  int *piVar14;
  int *piVar15;
  undefined2 *puVar16;
  int in_P1;
  undefined4 *puVar17;
  int iVar18;
  short *psVar19;
  short *psVar20;
  undefined4 *puVar21;
  int *in_P2;
  int unaff_P4;
  short *psVar22;
  int *unaff_P5;
  int iVar23;
  int unaff_FP;
  bool bVar24;
  
  do {
    param_2 = param_2 * (uint)(in_R3 < param_2) + in_R3 * (uint)(in_R3 >= param_2);
    in_R3 = *unaff_P5;
    param_3 = param_3 * (uint)(param_3 < in_R3) + in_R3 * (uint)(param_3 >= in_R3);
    if (in_P1 == 0) break;
    in_P1 = in_P1 + -1;
    unaff_P5 = (int *)((int)unaff_P5 + unaff_P4);
  } while (in_P1 != 0);
  *in_P0 = param_2 * (uint)(in_R3 < param_2) + in_R3 * (uint)(in_R3 >= param_2);
  *(undefined2 *)(in_P0 + -8) = param_1;
  in_P0[-1] = param_3;
  iVar5 = in_P2[1] + 0x20c49b;
  iVar9 = *in_P2 + -0x20c49b;
  iVar10 = *(int *)(*(int *)(unaff_FP + -0x68) + 0x68);
  iVar10 = iVar9 * (uint)(iVar10 < iVar9) + iVar10 * (uint)(iVar10 >= iVar9);
  in_P2[1] = iVar5 * (uint)(iVar5 < 0xa3570a3) + (uint)(iVar5 >= 0xa3570a3) * 0xa3570a3;
  in_P2[-8] = unaff_R6 + 1;
  iVar5 = *(int *)(unaff_FP + -0x3c);
  uVar6 = 0;
  *(int *)(iVar5 + 0x12) = iVar10;
  if (iVar10 < *(int *)(iVar5 + 0x16)) {
    iVar10 = *(int *)(unaff_FP + 0x1c);
    puVar17 = (undefined4 *)(*(int *)(unaff_FP + -0x3c) + 0x26);
    *puVar17 = 1;
    *(undefined4 **)(unaff_FP + -0x4c) = puVar17;
    if (iVar10 == 7) {
      *puVar17 = 0;
    }
    else if (*(int *)(unaff_FP + 0x1c) == 5) {
      **(uint **)(unaff_FP + -0x4c) =
           (uint)(*(char *)(*(int *)(**(int **)(unaff_FP + 0x10) + 0xe8) + 4) == '\0');
    }
    *(undefined4 **)(unaff_FP + -0x48) = &DAT_ff8000ec;
    iVar10 = **(int **)(unaff_FP + -0x4c);
    *(undefined4 **)(unaff_FP + -0x50) = &DAT_ff806ed8;
    if (iVar10 != 0) {
      piVar14 = *(int **)(unaff_FP + -0x48);
      iVar18 = *(int *)(unaff_FP + -0x50);
      iVar9 = *piVar14 * 2;
      iVar5 = *piVar14 * 8 * piVar14[1];
      piVar15 = piVar14 + -2;
      piVar14[-1] = iVar5;
      *(int *)(iVar18 + -4) = iVar9;
      *piVar14 = 0;
      iVar5 = FUN_ffa00fb4(iVar5,iVar9);
      *piVar15 = iVar9 + iVar5 * iVar9;
      piVar15[3] = 0;
    }
    sVar4 = *(short *)(*(int *)(unaff_FP + -0x3c) + 0x22);
    *(undefined4 *)(*(int *)(unaff_FP + -0x50) + 4) = 1;
    if ((sVar4 != 0) && (iVar10 != 0)) {
      iVar10 = *(int *)(unaff_FP + -0x44);
      *(undefined4 *)(iVar10 + 0x4ec24) = 0;
      *(undefined4 *)(iVar10 + 0x4ec28) = 0;
    }
    iVar10 = *(int *)(unaff_FP + -0x3c);
    iVar9 = *(int *)(unaff_FP + -0x3c);
    *(int *)(unaff_FP + -0x14) = *(int *)(unaff_FP + -0x3c) + 0x36;
    iVar5 = *(int *)(unaff_FP + -0x3c);
    iVar23 = *(int *)(unaff_FP + -0x3c);
    iVar18 = *(int *)(unaff_FP + -0x3c);
    *(undefined2 *)(iVar10 + -2) = 0;
    *(int *)(unaff_FP + -0x38) = iVar9 + -2;
    *(int *)(unaff_FP + -0x20) = iVar5 + 10;
    *(int *)(unaff_FP + -0x18) = iVar10 + 0x2e;
    psVar22 = (short *)(iVar18 + -8);
    while( true ) {
      psVar19 = (short *)(*(int *)(unaff_FP + -0x44) + 0x34a54);
      sVar4 = *psVar19;
      sVar12 = **(short **)(unaff_FP + -0x38);
      *(short **)(unaff_FP + -8) = psVar19;
      if ((int)sVar4 <= (int)sVar12) break;
      uVar13 = *(undefined4 *)(unaff_FP + 8);
      uVar6 = *(undefined4 *)(unaff_FP + 0xc);
      **(undefined4 **)(unaff_FP + -0x50) = 1;
      iVar10 = FUN_202b5024((int)sVar12,uVar6,uVar13);
      puVar16 = *(undefined2 **)(unaff_FP + -0x38);
      sVar4 = **(short **)(unaff_FP + -8);
      *puVar16 = (short)iVar10;
      if (sVar4 <= iVar10) break;
      if (*(int *)(puVar16 + 0x14) != 0) {
        **(int **)(unaff_FP + -0x48) = **(int **)(unaff_FP + -0x48) + 1;
      }
      if ((*(int *)(unaff_FP + 0x1c) == 5) ||
         (sVar4 = **(short **)(unaff_FP + -0x38), *(int *)(unaff_FP + 0x1c) == 4)) {
        if (**(short **)(unaff_FP + -0x38) < **(short **)(unaff_FP + -8)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
          halt_unimplemented();
        }
        sVar4 = **(short **)(unaff_FP + -0x38);
        if (**(short **)(unaff_FP + -8) <= sVar4) break;
      }
      psVar19 = (short *)(*(int *)(unaff_FP + -0x44) + 0x34c0a);
      sVar12 = *psVar19;
      *(short **)(unaff_FP + -0x60) = psVar19;
      if (sVar12 < sVar4) {
        **(short **)(unaff_FP + -0x38) = *psVar19;
      }
      uVar13 = *(undefined4 *)(unaff_FP + 8);
      *(int *)(unaff_FP + -0xc) = *(int *)(unaff_FP + -0x44) + 0x34c08;
      uVar6 = *(undefined4 *)(unaff_FP + 0xc);
      **(undefined2 **)(unaff_FP + -0xc) = **(undefined2 **)(unaff_FP + -0x38);
      FUN_20210be6(uVar6,uVar13);
      uVar6 = FUN_ffa05c38(*(undefined4 *)(*(int *)(unaff_FP + -0x38) + 0x14),
                           *(undefined4 *)(unaff_FP + 0xc),*(undefined4 *)(unaff_FP + 8));
      iVar10 = *(int *)(unaff_FP + -0x38);
      uVar11 = *(undefined4 *)(unaff_FP + 8);
      uVar13 = *(undefined4 *)(unaff_FP + 0xc);
      *(undefined4 *)(iVar10 + 2) = uVar6;
      uVar6 = FUN_ffa05c38(*(undefined4 *)(iVar10 + 0x18),uVar13,uVar11);
      iVar10 = *(int *)(unaff_FP + -0x38);
      *(undefined4 *)(unaff_FP + -100) = uVar6;
      iVar5 = *(int *)(unaff_FP + -0x38);
      *(undefined4 *)(iVar10 + 4) = *(undefined4 *)(unaff_FP + -100);
      if (*(int *)(iVar10 + 0x28) != 0) {
        iVar9 = *(int *)(*(int *)(unaff_FP + -0x48) + 4);
        iVar10 = ((int)*(short *)(iVar10 + 4) - (int)*(short *)(iVar5 + 2)) + 1;
        *(uint *)(*(int *)(unaff_FP + -0x48) + 4) =
             iVar9 * (uint)(iVar10 < iVar9) + iVar10 * (uint)(iVar10 >= iVar9);
      }
      iVar5 = *(int *)(unaff_FP + -0x38);
      iVar10 = *(int *)(unaff_FP + -0x44);
      *(short *)(iVar5 + -8) = *(short *)(iVar5 + 2);
      if (*(short *)(iVar5 + 2) <= *(short *)(iVar5 + 4)) {
        iVar5 = (iVar10 + 0x4db) - *(int *)(unaff_FP + -0x68);
        *(int *)(unaff_FP + -0x54) = iVar5;
        *(int *)(unaff_FP + -0x34) = iVar10 + 0x3ec2c;
        *(int *)(unaff_FP + -0x5c) = 0x8d - iVar5;
        *(undefined4 *)(unaff_FP + -0x58) = 0xfffc1868;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      if ((*(short **)(unaff_FP + -0xc))[1] <= **(short **)(unaff_FP + -0xc)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      **(short **)(unaff_FP + -0x38) = **(short **)(unaff_FP + -0x38) + 1;
    }
    iVar10 = *(int *)(**(int **)(unaff_FP + 0x10) + 0xf0);
    cVar2 = *(char *)(iVar10 + 2);
    if ((cVar2 == '\x01') || (cVar2 == '\x02')) {
      *(undefined1 *)(iVar10 + 1) = 0xfa;
      while ((pcVar1 = *(char **)(**(int **)(unaff_FP + 0x10) + 0xf0), *pcVar1 == '\0' &&
             (pcVar1[2] != '\0'))) {
        FUN_ffa06008(10000,0,1);
      }
      piVar14 = *(int **)(unaff_FP + 0x10);
      **(undefined1 **)(**(int **)(unaff_FP + 0x10) + 0xf0) = 0;
      *(undefined1 *)(*(int *)(*piVar14 + 0xf0) + 1) = 0xff;
    }
    if (*(int *)(unaff_FP + 0x1c) == 3) {
      if (*(int *)(*(int *)(**(int **)(unaff_FP + 0x10) + 0xf0) + 0xc) < 3) {
        *(undefined1 *)(*(int *)(unaff_FP + -0x44) + 0x4fc72) = 0;
      }
      iVar10 = **(int **)(unaff_FP + 0x10);
      iVar9 = *(int *)(unaff_FP + -0x44);
      iVar5 = *(int *)(**(int **)(unaff_FP + 0x10) + 0xf0);
      *(int *)(unaff_FP + -0x48) = iVar9 + 0x6210;
      *(int *)(iVar5 + 0xc) = *(int *)(iVar5 + 0xc) + 1;
      uVar6 = *(undefined4 *)(iVar9 + 0x624c);
      *(undefined4 *)(unaff_FP + -0x50) = *(undefined4 *)(iVar10 + 0xd8);
      uVar6 = FUN_ffa01716(0x459c4000,uVar6);
      FUN_ffa01814(uVar6,0x461c4000);
      iVar9 = *(int *)(unaff_FP + -0x50);
      uVar3 = FUN_ffa014dc();
      iVar5 = *(int *)(unaff_FP + -0x44);
      *(undefined1 *)(iVar9 + 0x32) = uVar3;
      uVar6 = FUN_ffa01716(*(undefined4 *)(iVar5 + 0x17940),0x459c4000);
      uVar6 = FUN_ffa01716(uVar6,*(undefined4 *)(*(int *)(unaff_FP + -0x44) + 0x1d63c));
      *(undefined4 *)(unaff_FP + -0x50) = *(undefined4 *)(iVar10 + 0xd8);
      uVar6 = FUN_ffa01716(uVar6,*(undefined4 *)(*(int *)(unaff_FP + -0x48) + 0x1d128));
      FUN_ffa01814(uVar6,0x46ea6000);
      uVar3 = FUN_ffa014dc();
      *(undefined1 *)(*(int *)(unaff_FP + -0x50) + 0x33) = uVar3;
      cVar2 = *(char *)(*(int *)(iVar10 + 0xf0) + 2);
      if (((((cVar2 == '\x01') || (cVar2 == '\x02')) &&
           (3 < *(int *)(*(int *)(iVar10 + 0xf0) + 0xc))) &&
          (*(char *)(*(int *)(unaff_FP + -0x48) + 0x49a62) == '\0')) || (cVar2 == '\0')) {
        FUN_2021ffe4(*(undefined4 *)(unaff_FP + 0xc),*(undefined4 *)(unaff_FP + 8));
      }
    }
    iVar10 = *(int *)(unaff_FP + -0x44);
    *(undefined2 *)(*(int *)(unaff_FP + -0x3c) + -2) = 0;
    *(undefined4 *)(unaff_FP + -0x48) = 0xfffcb918;
    psVar19 = (short *)(iVar10 + 0x34c08);
    while( true ) {
      if ((int)psVar19[-0xda] <= (int)**(short **)(unaff_FP + -0x38)) break;
      iVar5 = FUN_202b5024((int)**(short **)(unaff_FP + -0x38),*(undefined4 *)(unaff_FP + 0xc),
                           *(undefined4 *)(unaff_FP + 8));
      psVar20 = *(short **)(unaff_FP + -0x38);
      iVar10 = (int)psVar19[-0xda];
      *psVar20 = (short)iVar5;
      if (iVar10 <= iVar5) break;
      if ((*(int *)(unaff_FP + 0x1c) == 5) || (*(int *)(unaff_FP + 0x1c) == 4)) {
        if (**(short **)(unaff_FP + -0x38) < iVar10) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
          halt_unimplemented();
        }
        iVar5 = (int)**(short **)(unaff_FP + -0x38);
        if (iVar10 <= iVar5) break;
      }
      else {
        iVar5 = (int)*psVar20;
      }
      sVar4 = psVar19[1];
      if (sVar4 < iVar5) {
        **(short **)(unaff_FP + -0x38) = sVar4;
      }
      psVar20 = *(short **)(unaff_FP + -0x38);
      sVar12 = *psVar20;
      *psVar19 = sVar12;
      if ((int)sVar4 <= (int)sVar12) {
        sVar12 = *(short *)(*(int *)(unaff_FP + -0x44) + 0x34c0a);
        *(int *)(unaff_FP + -0x48) = *(int *)(unaff_FP + -0x44) + 0x578;
        sVar4 = **(short **)(unaff_FP + -8);
        *psVar22 = sVar12;
        if ((int)*psVar22 < (int)sVar4) {
          iVar10 = FUN_202b5024((int)*psVar22,*(undefined4 *)(unaff_FP + 0xc),
                                *(undefined4 *)(unaff_FP + 8));
          psVar19 = *(short **)(unaff_FP + -8);
          *psVar22 = (short)iVar10;
          if (iVar10 < *psVar19) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
            halt_unimplemented();
          }
        }
        break;
      }
      if (((psVar20[0x12] != 0) || (*(char *)((int)psVar19 + *(int *)(unaff_FP + -0x48)) != '\0'))
         && (*(int *)(*(int *)(unaff_FP + -0x38) + 0x28) != 0)) {
        uVar7 = FUN_20212bae(*(undefined4 *)(unaff_FP + 0xc),*(undefined4 *)(unaff_FP + 8),
                             *(undefined4 *)(unaff_FP + 0x14));
        psVar20 = *(short **)(unaff_FP + -0x38);
        *(uint *)(psVar20 + 4) = uVar7 | *(uint *)(psVar20 + 4);
        sVar12 = *psVar20;
      }
      **(short **)(unaff_FP + -0x38) = sVar12 + 1;
    }
    iVar10 = *(int *)(unaff_FP + 0x1c);
    if (iVar10 == 6) {
      iVar5 = 9;
      puVar17 = *(undefined4 **)(unaff_FP + -0x6c);
      puVar21 = (undefined4 *)(*(int *)(unaff_FP + 0x18) + 0x2c5e8);
      do {
        *puVar17 = *puVar21;
        if (iVar5 == 0) break;
        iVar5 = iVar5 + -1;
        puVar17 = puVar17 + 1;
        puVar21 = puVar21 + 1;
      } while (iVar5 != 0);
      *(undefined2 *)(*(int *)(unaff_FP + -0x3c) + -8) = 9;
    }
    if (iVar10 == 3) {
      iVar10 = *(int *)(unaff_FP + -0x44);
      FUN_2022f986(*(undefined4 *)(unaff_FP + 0xc),*(undefined4 *)(unaff_FP + 8),
                   *(undefined4 *)(unaff_FP + 0x14));
      bVar24 = *(short *)(iVar10 + 0x34c0c) < 1;
      *(undefined4 *)(iVar23 + 0x1a) = 0;
      *(undefined4 *)(iVar23 + 0x1e) = 0;
      *(undefined2 *)(iVar23 + -10) = 0;
      if (!bVar24) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      iVar10 = *(int *)(unaff_FP + -0x68);
      puVar17 = (undefined4 *)(*(int *)(unaff_FP + -0x3c) + 0x1a);
      uVar13 = *(undefined4 *)(*(int *)(unaff_FP + -0x3c) + 0x1e);
      FUN_ffa0165c(0x3f800000,uVar13);
      uVar6 = 0x3f800000;
      if (bVar24) {
        uVar6 = uVar13;
      }
      uVar6 = FUN_ffa01814(*puVar17,uVar6);
      *puVar17 = uVar6;
      uVar13 = FUN_ffa01688(*(ushort *)(iVar10 + 6) - 1);
      uVar13 = FUN_ffa018f0(uVar13,*(undefined4 *)(*(int *)(unaff_FP + -0x44) + 0x4f0));
      uVar6 = FUN_ffa018f0(0x40000000,uVar6);
      uVar6 = FUN_ffa01716(uVar6,uVar13);
      iVar10 = *(int *)(unaff_FP + -0x68);
      *(undefined4 *)(*(int *)(unaff_FP + -0x44) + 0x4f0) = uVar6;
      uVar13 = FUN_ffa01688(*(ushort *)(iVar10 + 6) + 1);
      uVar8 = FUN_ffa01814(uVar6,uVar13);
      uVar7 = uVar8 >> 0x1f;
      if (-0x800000 < (int)uVar8) {
        uVar7 = 0;
      }
      if (uVar8 == 0x80000000) {
        uVar7 = 0;
      }
      if (uVar7 == 1) {
        uVar8 = 0;
      }
      *(uint *)(*(int *)(unaff_FP + -0x44) + 0x4f0) = uVar8;
    }
    iVar10 = **(int **)(unaff_FP + 0x10);
    uVar6 = FUN_ffa01716(0x459c4000,*(undefined4 *)(*(int *)(unaff_FP + -0x44) + 0x4fbb4));
    iVar5 = *(int *)(iVar10 + 0xd8);
    FUN_ffa01814(uVar6,0x461c4000);
    uVar3 = FUN_ffa014dc();
    iVar9 = *(int *)(unaff_FP + -0x3c);
    *(undefined1 *)(iVar5 + 0x3d) = uVar3;
    *(char *)(*(int *)(iVar10 + 0xd8) + 0x3e) = (char)*(undefined4 *)(iVar9 + -0xe);
    uVar6 = *(undefined4 *)(iVar9 + 0x1a);
  }
  return uVar6;
}


