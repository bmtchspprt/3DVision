
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20213000(void)

{
  bool bVar1;
  short sVar2;
  undefined4 uVar3;
  int iVar4;
  int iVar5;
  undefined4 uVar6;
  uint uVar7;
  uint uVar8;
  undefined2 in_R3_L;
  uint uVar9;
  uint uVar10;
  int unaff_R5;
  int iVar11;
  uint *puVar12;
  uint *puVar13;
  uint *puVar14;
  undefined4 *in_P3;
  int unaff_P4;
  short *psVar15;
  int iVar16;
  int unaff_FP;
  
  *(undefined2 *)(in_P3 + -1) = in_R3_L;
  uVar6 = *(undefined4 *)(unaff_FP + -0x44);
  uVar3 = *(undefined4 *)(unaff_FP + -0x54);
  *in_P3 = *(undefined4 *)(unaff_FP + -0x58);
  iVar4 = FUN_2020f27c(uVar3,uVar6);
  if ((iVar4 != 0) && (iVar4 = *(int *)(*(int *)(unaff_FP + -0x60) + 0x4fc20), 0x51eb86 < iVar4)) {
    iVar4 = iVar4 + -0x51eb86;
    bVar1 = iVar4 >> 0x12 < (int)*(short *)(in_P3 + -1);
    *in_P3 = 0x40c00000;
    *(ushort *)(in_P3 + -1) =
         *(short *)(in_P3 + -1) * (ushort)bVar1 + (short)(iVar4 >> 0x12) * (ushort)!bVar1;
  }
  uVar9 = *(uint *)(*(int *)(unaff_FP + 0x10) + 0x5c);
  if ((uVar9 != 0 && ((int)uVar9 < 0x7f800001 && (uVar9 & 0x80000000) == 0)) &&
     (unaff_R5 <= *(short *)(in_P3 + -1))) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar4 = FUN_2020f27c(*(undefined4 *)(unaff_FP + -0x54),*(undefined4 *)(unaff_FP + -0x44));
  if (iVar4 != 0) {
    sVar2 = *(short *)(in_P3 + -1);
    *(undefined1 *)(*(int *)(unaff_FP + 0x10) + 0x60) = 1;
    if (unaff_R5 <= sVar2) {
      *(undefined4 **)(unaff_FP + -0x28) = in_P3 + -1;
      iVar4 = *(int *)(unaff_FP + -0x60) + (0x34bc2 - *(int *)(unaff_FP + 0x10));
      *(int *)(unaff_FP + -0x1c) = iVar4;
      *(int *)(unaff_FP + -0x4c) = -iVar4;
      *(undefined4 *)(unaff_FP + -0x2c) = *(undefined4 *)(unaff_FP + -0x24);
      *(undefined4 *)(unaff_FP + 0xe) = 3;
      *(undefined4 *)(unaff_FP + 0xc) = 0x4a58;
      psVar15 = *(short **)(unaff_FP + -0x28);
      FUN_ffa05c38((int)sVar2 << 0x12,*(undefined4 *)(unaff_FP + -100),
                   *(undefined4 *)(unaff_FP + -0x54));
      psVar15[0x4a] = 0;
      psVar15[0x4b] = 0;
      *(int *)(unaff_FP + -0x30) = (int)*psVar15;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  if (((int)*(short *)(&DAT_ff801900 + **(short **)(unaff_FP + -0x24) * 2) & 0x8000U) != 1) {
    iVar4 = (int)(short)(*(short *)(&DAT_ff801900 + **(short **)(unaff_FP + -0x24) * 2) + -0x13);
    puVar12 = (uint *)(unaff_P4 + -4 + iVar4 * 4);
    iVar5 = (iVar4 + 1) - (int)*(short *)((int)in_P3 + 0x86);
    if (*(short *)((int)in_P3 + 0x86) <= iVar4) {
      uVar9 = puVar12[1];
      iVar16 = *(int *)(unaff_FP + -0x38);
      do {
        *(int *)(unaff_FP + -0x28) = iVar4 + -1;
        puVar13 = (uint *)(iVar16 + (iVar4 >> 3) * 4);
        uVar7 = *puVar13;
        uVar8 = (uint)((int)uVar9 < (int)uVar7);
        if (uVar7 != uVar9) {
          uVar8 = (uVar7 & uVar9) >> 0x1f ^ (uint)((int)uVar9 < (int)uVar7);
        }
        if ((uVar7 & 0x7fffffff) == 0 && (uVar9 & 0x7fffffff) == 0) {
          uVar8 = 0;
        }
        if (0x7f800000 < (uVar9 & 0x7fffffff) || 0x7f800000 < (uVar7 & 0x7fffffff)) {
          uVar8 = *(uint *)(unaff_FP + 8);
        }
        if ((uVar8 & 1) == 1) {
          uVar9 = uVar7;
        }
        *puVar13 = uVar9;
        uVar9 = *puVar12;
        uVar8 = puVar12[1];
        uVar7 = (uint)((int)uVar8 <= (int)uVar9);
        if (uVar9 != uVar8) {
          uVar7 = (uVar9 & uVar8) >> 0x1f ^ (uint)((int)uVar8 <= (int)uVar9);
        }
        if ((uVar9 & 0x7fffffff) == 0 && (uVar8 & 0x7fffffff) == 0) {
          uVar7 = 1;
        }
        if (0x7f800000 < (uVar8 & 0x7fffffff) || 0x7f800000 < (uVar9 & 0x7fffffff)) {
          uVar7 = 0;
        }
      } while (((uVar7 != 1) && (iVar4 = *(int *)(unaff_FP + -0x28), iVar5 != 0)) &&
              (iVar5 = iVar5 + -1, puVar12 = puVar12 + -1, iVar5 != 0));
    }
    iVar5 = *(short *)(&DAT_ff801900 + **(short **)(unaff_FP + -0x24) * 2) + -0x14;
    iVar4 = (int)(short)iVar5;
    puVar12 = (uint *)(unaff_P4 + iVar4 * 4);
    do {
      iVar16 = -1;
      puVar13 = puVar12;
      do {
        iVar11 = *(int *)(*(int *)(unaff_FP + 0x10) + 0xc);
        *(int *)(unaff_FP + -0x28) = iVar5 + 1;
        *(int *)(unaff_FP + -0x44) = iVar4 + 1;
        if (iVar11 >> 0xf < (int)(short)iVar5) {
LAB_20213512:
          psVar15 = *(short **)(unaff_FP + -0x24);
          *(short *)(in_P3 + -1) = (short)iVar5;
          *(undefined2 *)(&DAT_ff801900 + *psVar15 * 2) = 0xffff;
          goto LAB_20213522;
        }
        puVar12 = puVar13 + 1;
        uVar8 = *puVar13;
        puVar14 = (uint *)(*(int *)(unaff_FP + -0x38) + (iVar4 >> 3) * 4);
        uVar9 = *puVar14;
        psVar15 = *(short **)(unaff_FP + -0x24);
        *(uint *)(unaff_FP + 0xc) = uVar9 & 0x7fffffff | uVar8 & 0x7fffffff;
        uVar10 = (uVar9 & uVar8) >> 0x1f;
        *(uint *)(unaff_FP + -0x14) = uVar10;
        uVar10 = uVar10 ^ (int)uVar8 < (int)uVar9;
        uVar7 = (uint)((int)uVar8 < (int)uVar9);
        if (uVar9 != uVar8) {
          uVar7 = uVar10;
        }
        *(uint *)(unaff_FP + -0x14) = uVar10;
        if (*(int *)(unaff_FP + 0xc) == 0) {
          uVar7 = 0;
        }
        if (0x7f800000 < (uVar8 & 0x7fffffff) || 0x7f800000 < (uVar9 & 0x7fffffff)) {
          uVar7 = 0;
        }
        if (uVar7 == 1) {
          uVar8 = uVar9;
        }
        *puVar14 = uVar8;
        if (*(short *)(&DAT_ff801900 + *psVar15 * 2) < iVar4) {
          uVar7 = *puVar12;
          uVar8 = *puVar13;
          *(uint *)(unaff_FP + 0xc) = uVar7 & 0x7fffffff | uVar8 & 0x7fffffff;
          *(uint *)(unaff_FP + -0x14) = (uVar7 & uVar8) >> 0x1f;
          uVar9 = (uint)((int)uVar8 <= (int)uVar7);
          if (uVar7 != uVar8) {
            uVar9 = *(uint *)(unaff_FP + -0x14) ^ (uint)((int)uVar8 <= (int)uVar7);
          }
          if (*(int *)(unaff_FP + 0xc) == 0) {
            uVar9 = 1;
          }
          if (0x7f800000 < (uVar8 & 0x7fffffff) || 0x7f800000 < (uVar7 & 0x7fffffff)) {
            uVar9 = 0;
          }
          if ((uVar9 & 1) == 1) goto LAB_20213512;
        }
        iVar4 = *(int *)(unaff_FP + -0x44);
        iVar5 = *(int *)(unaff_FP + -0x28);
      } while ((iVar16 != 0) && (iVar16 = iVar16 + -1, puVar13 = puVar12, iVar16 != 0));
    } while( true );
  }
LAB_20213522:
  iVar5 = FUN_ffa0586c(*(undefined4 *)(*(int *)(unaff_FP + -0x60) + 0x544),
                       *(undefined4 *)(unaff_FP + -0x54));
  iVar4 = *(int *)(*(int *)(unaff_FP + 0x10) + 0x68);
  FUN_ffa016d4(*(undefined1 *)(*(int *)(unaff_FP + 0x10) + 0x38));
  in_P3[0x19] = ((int)(iVar5 * (uint)(iVar4 < iVar5) + iVar4 * (uint)(iVar4 >= iVar5)) >> 0x11) +
                0x10;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


