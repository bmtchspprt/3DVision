/* FUN_ffa04fe0 @ ffa04fe0..ffa0549d */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_ffa04fe0(uint param_1)

{
  uint uVar1;
  int iVar2;
  uint uVar3;
  uint uVar4;
  undefined4 uVar5;
  undefined4 uVar6;
  int iVar7;
  uint uVar8;
  uint uVar9;
  int unaff_R6;
  short sVar10;
  int iVar11;
  int unaff_R7;
  undefined4 uVar12;
  uint *puVar13;
  int *piVar14;
  undefined4 *puVar15;
  undefined *puVar16;
  undefined4 *puVar17;
  int unaff_P4;
  short *unaff_P5;
  int unaff_FP;
  uint *puVar18;
  bool bVar19;
  
  do {
    if (unaff_R6 < 0x147a) {
      iVar2 = (int)*unaff_P5;
      if ((*(int *)(&DAT_ff8048ac + iVar2 * 4) < unaff_R6) &&
         ((*(int *)(&DAT_ff804888 + iVar2 * 4) < unaff_R6 ||
          (unaff_R6 + 10 < *(int *)(&DAT_ff804888 + iVar2 * 4))))) {
        bVar19 = *(int *)(unaff_FP + 0x28) == 5;
        if ((!bVar19) && (bVar19 = *(int *)(unaff_FP + 0x28) == 4, !bVar19)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
          halt_unimplemented();
        }
        uVar6 = *(undefined4 *)(&DAT_ff8048d0 + iVar2 * 4);
        puVar15 = (undefined4 *)
                  (*(int *)(unaff_FP + -0x4c) + (*(int *)(&DAT_ff8048ac + iVar2 * 4) >> 3) * 4);
        uVar5 = *puVar15;
        uVar12 = puVar15[0x28f];
        FUN_ffa0165c(uVar5,uVar12);
        if (bVar19) {
          uVar12 = uVar5;
        }
        FUN_ffa0165c(uVar6,uVar12);
        if (bVar19) {
          uVar12 = uVar6;
        }
        *(undefined4 *)(*(int *)(unaff_FP + -0x1c) + 0x18) = uVar12;
        iVar2 = (int)*unaff_P5;
        bVar19 = *(int *)(&DAT_ff8048ac + iVar2 * 4) >> 3 == unaff_R6 >> 3;
        if (bVar19) {
          puVar15 = (undefined4 *)(&DAT_ff804918 + iVar2 * 4);
          uVar6 = *puVar15;
          uVar5 = *(undefined4 *)(&DAT_ff8048d0 + iVar2 * 4);
          FUN_ffa0165c(uVar5,uVar6);
          if (bVar19) {
            uVar5 = uVar6;
          }
          *puVar15 = uVar5;
        }
        else {
          *(int *)(unaff_FP + 0x20) = *(int *)(&DAT_ff8048ac + iVar2 * 4) >> 3;
          uVar6 = FUN_ffa018f0(0x41000000,*(undefined4 *)(*(int *)(unaff_FP + -0x1c) + 0x1c));
          puVar15 = (undefined4 *)(*(int *)(unaff_FP + -0x50) + *(int *)(unaff_FP + 0x20) * 4);
          *(undefined4 **)(unaff_FP + 0x20) = puVar15;
          puVar17 = *(undefined4 **)(unaff_FP + 0x20);
          uVar6 = FUN_ffa018f0(uVar6,*puVar15);
          *puVar17 = uVar6;
          iVar11 = *(int *)(unaff_FP + -0x50);
          uVar5 = FUN_ffa0248c(*(uint *)(&DAT_ff804918 + *unaff_P5 * 4) & 0x7fffffff);
          puVar15 = (undefined4 *)(iVar11 + (*(int *)(&DAT_ff8048ac + *unaff_P5 * 4) >> 3) * 4);
          uVar6 = *puVar15;
          *(undefined4 **)(unaff_FP + 0x20) = puVar15;
          uVar6 = FUN_ffa01716(uVar5,uVar6);
          iVar2 = *(int *)(unaff_FP + -0x1c);
          **(undefined4 **)(unaff_FP + 0x20) = uVar6;
          uVar6 = *(undefined4 *)(iVar2 + 0x1c);
          *(int *)(unaff_FP + 0x20) = (int)*unaff_P5;
          uVar6 = FUN_ffa018f0(uVar6,0x41000000);
          uVar6 = FUN_ffa01716(uVar6,0x3f800000);
          puVar16 = &DAT_ff8048ac;
          puVar15 = (undefined4 *)
                    (iVar11 + (*(int *)(&DAT_ff8048ac + *(int *)(unaff_FP + 0x20) * 4) >> 3) * 4);
          uVar6 = FUN_ffa01814(*puVar15,uVar6);
          *puVar15 = uVar6;
          iVar2 = *(int *)(unaff_FP + -0x4c);
          puVar15 = (undefined4 *)(iVar2 + (*(int *)(puVar16 + *unaff_P5 * 4) >> 3) * 4);
          puVar15[0x28f] = *puVar15;
          *(undefined4 *)(iVar2 + (*(int *)(&DAT_ff8048ac + *unaff_P5 * 4) >> 3) * 4) =
               *(undefined4 *)(&DAT_ff804918 + *unaff_P5 * 4);
          *(undefined4 *)(&DAT_ff804918 + *unaff_P5 * 4) =
               *(undefined4 *)(&DAT_ff8048d0 + *unaff_P5 * 4);
        }
        iVar2 = (int)*unaff_P5;
        iVar11 = *(int *)(unaff_FP + -0x1c);
        unaff_R7 = (int)*(short *)(*(int *)(unaff_FP + -0x5c) + -6);
        *(undefined4 *)(&DAT_ff8048d0 + iVar2 * 4) = *(undefined4 *)(iVar11 + 0xc);
        uVar5 = *(undefined4 *)(iVar11 + -4);
        uVar6 = *(undefined4 *)(&DAT_ff8048ac + iVar2 * 4);
        *(undefined4 *)(&DAT_ff8048f4 + iVar2 * 4) = *(undefined4 *)(iVar11 + 0x14);
        *(undefined4 *)(&DAT_ff8048ac + iVar2 * 4) = uVar5;
        *(undefined4 *)(&DAT_ff804888 + iVar2 * 4) = uVar6;
      }
      else {
        *(undefined4 *)(unaff_FP + 0x20) = 0x7f800000;
        uVar1 = *(uint *)(&DAT_ff8048f4 + iVar2 * 4);
        uVar8 = *(uint *)(&DAT_ff8048d0 + iVar2 * 4);
        *(uint *)(unaff_FP + -0x38) = uVar8;
        *(uint *)(unaff_FP + -0x3c) = (uVar1 & param_1) >> 0x1f;
        *(uint *)(unaff_FP + -0x20) = uVar1 & 0x7fffffff | param_1 & 0x7fffffff;
        uVar3 = *(uint *)(*(int *)(unaff_FP + -0x1c) + 0xc);
        *(uint *)(unaff_FP + -0x30) = uVar8 & 0x7fffffff | uVar3 & 0x7fffffff;
        *(uint *)(unaff_FP + -0x34) = (uVar8 & uVar3) >> 0x1f;
        *(uint *)(unaff_FP + -0x1c) = (uint)(*(int *)(unaff_FP + 0x20) < (int)(uVar8 & 0x7fffffff));
        *(undefined4 *)(unaff_FP + -0x58) = 1;
        uVar6 = 1;
        if ((int)(uVar3 & 0x7fffffff) <= *(int *)(unaff_FP + 0x20)) {
          uVar6 = *(undefined4 *)(unaff_FP + -0x1c);
        }
        *(undefined4 *)(unaff_FP + -0x58) = uVar6;
        uVar4 = *(uint *)(unaff_FP + -0x34) ^ (uint)((int)uVar3 < (int)uVar8);
        uVar9 = (uint)((int)uVar3 < (int)uVar8);
        if (uVar8 != uVar3) {
          uVar9 = uVar4;
        }
        *(uint *)(unaff_FP + -0x1c) = uVar4;
        if (*(int *)(unaff_FP + -0x30) == 0) {
          uVar9 = 0;
        }
        if ((*(uint *)(unaff_FP + -0x58) & 1) == 1) {
          uVar9 = 0;
        }
        if ((uVar9 & 1) == 1) {
          uVar3 = uVar8;
        }
        iVar11 = *(int *)(unaff_FP + 0x20);
        *(uint *)(&DAT_ff8048d0 + iVar2 * 4) = uVar3;
        uVar8 = (uint)((int)param_1 < (int)uVar1);
        if (uVar1 != param_1) {
          uVar8 = *(uint *)(unaff_FP + -0x3c) ^ (uint)((int)param_1 < (int)uVar1);
        }
        if (*(int *)(unaff_FP + -0x20) == 0) {
          uVar8 = 0;
        }
        if (iVar11 < *(int *)(unaff_FP + -0x38) || iVar11 < (int)(uVar1 & 0x7fffffff)) {
          uVar8 = 0;
        }
        if ((uVar8 & 1) == 1) {
          param_1 = uVar1;
        }
        *(uint *)(&DAT_ff8048f4 + iVar2 * 4) = param_1;
      }
    }
    do {
      if (*(int *)(unaff_FP + 0x28) == 5) {
        iVar11 = *(int *)(unaff_FP + 0x2c);
        piVar14 = *(int **)(unaff_FP + -0x5c);
        iVar2 = *(int *)(*(int *)(unaff_FP + 0x18) + 0x18);
        if ((*(int *)(iVar11 + 0xc) - iVar2 <= *piVar14) &&
           (iVar7 = *piVar14 >> 0x13, iVar7 < *(int *)(iVar11 + 8) - iVar2 >> 0x13)) {
          bVar19 = *(char *)(iVar11 + 4) == '\0';
          piVar14[1] = iVar7;
          if (bVar19) {
            iVar2 = piVar14[6];
            piVar14 = (int *)(unaff_P4 + piVar14[1] * 4);
            FUN_ffa0165c(*piVar14,iVar2);
            if (bVar19) {
              *piVar14 = iVar2;
            }
          }
          else {
            uVar1 = piVar14[5];
            if (uVar1 == 0 || (0x7f800000 < (int)uVar1 || (uVar1 & 0x80000000) != 0)) {
              *(undefined4 *)(unaff_P4 + piVar14[1] * 4) = 0;
            }
            else {
              if (*(char *)(iVar11 + 2) != '\0') {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
                halt_unimplemented();
              }
              iVar2 = piVar14[1];
              uVar6 = FUN_ffa01814(*(undefined4 *)(*(int *)(unaff_FP + 0x2c) + 0x10),uVar1);
              *(undefined4 *)(unaff_P4 + iVar2 * 4) = uVar6;
            }
          }
        }
      }
      else if (*(int *)(unaff_FP + 0x28) == 7) {
        uVar5 = *(undefined4 *)(*(int *)(unaff_FP + -0x5c) + 0xc);
        uVar6 = *(undefined4 *)(*(int *)(unaff_FP + -0x5c) + 0x14);
        *(undefined4 *)(unaff_FP + 0x20) = *(undefined4 *)(*(int *)(unaff_FP + -0x5c) + 4);
        uVar3 = FUN_ffa018f0(uVar6,uVar5);
        puVar13 = (uint *)(*(int *)(unaff_FP + -0x48) + *(int *)(unaff_FP + 0x20) * 4);
        uVar1 = *puVar13;
        *(uint *)(unaff_FP + 0x20) = (uVar3 & uVar1) >> 0x1f;
        uVar8 = (uint)((int)uVar1 < (int)uVar3);
        if (uVar3 != uVar1) {
          uVar8 = *(uint *)(unaff_FP + 0x20) ^ (uint)((int)uVar1 < (int)uVar3);
        }
        if ((uVar3 & 0x7fffffff) == 0 && (uVar1 & 0x7fffffff) == 0) {
          uVar8 = 0;
        }
        if (0x7f800000 < (uVar1 & 0x7fffffff) || 0x7f800000 < (uVar3 & 0x7fffffff)) {
          uVar8 = 0;
        }
        if ((uVar8 & 1) == 1) {
          *puVar13 = uVar3;
        }
      }
      sVar10 = (short)unaff_R7 + 1;
      iVar2 = *(int *)(unaff_FP + 8);
      *(short *)(*(int *)(unaff_FP + -0x5c) + -6) = sVar10;
      if (iVar2 < sVar10) {
        FUN_ffa06008(1,0,1);
        iVar2 = *(int *)(*(int *)(unaff_FP + 0x18) + 0xc);
        *(int *)(unaff_FP + 8) = iVar2;
        iVar2 = (iVar2 >> 0xf) + 1;
        *(undefined2 *)(*(int *)(unaff_FP + -0x5c) + -6) = 0;
        if (0 < iVar2) {
          uVar1 = *(uint *)(unaff_FP + -0x2c);
          puVar13 = *(uint **)(unaff_FP + -0x44);
          do {
            uVar8 = *puVar13;
            *(uint *)(unaff_FP + 0x10) = (uVar1 & uVar8) >> 0x1f;
            uVar3 = (uint)((int)uVar8 < (int)uVar1);
            if (uVar1 != uVar8) {
              uVar3 = *(uint *)(unaff_FP + 0x10) ^ (uint)((int)uVar8 < (int)uVar1);
            }
            if ((uVar1 & 0x7fffffff) == 0 && (uVar8 & 0x7fffffff) == 0) {
              uVar3 = 0;
            }
            if (0x7f800000 < (uVar8 & 0x7fffffff) || 0x7f800000 < (uVar1 & 0x7fffffff)) {
              uVar3 = 0;
            }
            if ((uVar3 & 1) == 1) {
              uVar8 = uVar1;
            }
          } while ((iVar2 != 0) &&
                  (iVar2 = iVar2 + -1, uVar1 = uVar8, puVar13 = puVar13 + 1, iVar2 != 0));
          *(uint *)(unaff_FP + -0x18) = uVar8;
        }
        iVar2 = (*(int *)(unaff_FP + 8) >> 0x12) + 1;
        *(int *)(unaff_FP + 8) = iVar2;
        if (0 < iVar2) {
          iVar2 = *(int *)(unaff_FP + 8);
          uVar1 = *(uint *)(unaff_FP + -0x10);
          uVar8 = *(uint *)(unaff_FP + -0x14);
          uVar3 = *(uint *)(unaff_FP + -0xc);
          puVar13 = *(uint **)(unaff_FP + -0x4c);
          puVar15 = *(undefined4 **)(unaff_FP + -0x50);
          puVar18 = *(uint **)(unaff_FP + -0x54);
          do {
            uVar9 = *puVar13;
            uVar4 = *puVar18;
            *(uint *)(unaff_FP + -0x58) = uVar9;
            *(uint *)(unaff_FP + -0x28) = uVar8;
            *(uint *)(unaff_FP + -0x24) = uVar4;
            *(uint *)(unaff_FP + 0x10) = uVar1 & 0x7fffffff;
            *(uint *)(unaff_FP + 0x20) =
                 (*(uint *)(unaff_FP + -0x28) & *(uint *)(unaff_FP + -0x58)) >> 0x1f;
            uVar9 = uVar9 & 0x7fffffff;
            *(uint *)(unaff_FP + -0x38) = (*(uint *)(unaff_FP + -0x24) & uVar4) >> 0x1f;
            *(uint *)(unaff_FP + -0x1c) = uVar8 & 0x7fffffff | uVar9;
            *(uint *)(unaff_FP + -0x34) = *(uint *)(unaff_FP + 0x10) | uVar4 & 0x7fffffff;
            *(undefined4 *)(unaff_FP + -0x20) = *puVar15;
            *(uint *)(unaff_FP + -0x30) = *(uint *)(unaff_FP + -0x20) & 0x7fffffff;
            uVar1 = (uint)(*(int *)(unaff_FP + -0x58) < *(int *)(unaff_FP + -0x28));
            *(uint *)(unaff_FP + 0x20) = *(uint *)(unaff_FP + 0x20) ^ uVar1;
            if (*(int *)(unaff_FP + -0x28) != *(int *)(unaff_FP + -0x58)) {
              uVar1 = *(uint *)(unaff_FP + 0x20);
            }
            if (*(int *)(unaff_FP + -0x1c) == 0) {
              uVar1 = 0;
            }
            if (0x7f800000 < uVar9 || 0x7f800000 < (uVar8 & 0x7fffffff)) {
              uVar1 = 0;
            }
            uVar8 = *(uint *)(unaff_FP + -0x58);
            if ((uVar1 & 1) == 1) {
              uVar8 = *(uint *)(unaff_FP + -0x28);
            }
            uVar9 = (uint)((int)uVar4 < *(int *)(unaff_FP + -0x24));
            *(uint *)(unaff_FP + -0x58) = *(uint *)(unaff_FP + -0x38) ^ uVar9;
            *(uint *)(unaff_FP + -0x2c) = uVar3;
            if (*(uint *)(unaff_FP + -0x24) != uVar4) {
              uVar9 = *(uint *)(unaff_FP + -0x58);
            }
            if (*(int *)(unaff_FP + -0x34) == 0) {
              uVar9 = 0;
            }
            if (0x7f800000 < (uVar4 & 0x7fffffff) || 0x7f800000 < *(int *)(unaff_FP + 0x10)) {
              uVar9 = 0;
            }
            uVar1 = uVar4;
            if ((uVar9 & 1) == 1) {
              uVar1 = *(uint *)(unaff_FP + -0x24);
            }
            *(uint *)(unaff_FP + -0x58) =
                 (*(uint *)(unaff_FP + -0x2c) & *(uint *)(unaff_FP + -0x20)) >> 0x1f;
            uVar9 = (uint)(*(int *)(unaff_FP + -0x20) < *(int *)(unaff_FP + -0x2c));
            if (*(uint *)(unaff_FP + -0x2c) != *(uint *)(unaff_FP + -0x20)) {
              uVar9 = *(uint *)(unaff_FP + -0x58) ^ uVar9;
            }
            if ((uVar3 & 0x7fffffff) == 0 && *(int *)(unaff_FP + -0x30) == 0) {
              uVar9 = 0;
            }
            if (0x7f800000 < *(int *)(unaff_FP + -0x30) || 0x7f800000 < (uVar3 & 0x7fffffff)) {
              uVar9 = 0;
            }
            uVar3 = *(uint *)(unaff_FP + -0x20);
            if ((uVar9 & 1) == 1) {
              uVar3 = *(uint *)(unaff_FP + -0x2c);
            }
          } while ((iVar2 != 0) &&
                  (iVar2 = iVar2 + -1, puVar13 = puVar13 + 1, puVar15 = puVar15 + 1,
                  puVar18 = puVar18 + 1, iVar2 != 0));
          *(uint *)(unaff_FP + -0x14) = uVar8;
          *(uint *)(unaff_FP + -0x10) = uVar1;
          *(short *)(*(int *)(unaff_FP + -0x5c) + -6) = (short)*(undefined4 *)(unaff_FP + 8);
          *(uint *)(unaff_FP + -0xc) = uVar3;
        }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      iVar11 = *(int *)(unaff_FP + 0x10);
      iVar2 = FUN_ffa05ee4((int)*(short *)(*(int *)(unaff_FP + -0x5c) + -6),41000);
      iVar2 = FUN_ffa0586c(iVar11 + iVar2,*(undefined4 *)(unaff_FP + -0x40));
      iVar11 = *(int *)(unaff_FP + 0x28);
      **(int **)(unaff_FP + -0x5c) = iVar2;
      if (iVar11 != 7) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      iVar11 = *(int *)(unaff_FP + -0x5c);
      *(int *)(iVar11 + 4) = iVar2 >> 0x13;
      *(undefined4 *)(iVar11 + 0xc) = *(undefined4 *)(unaff_P4 + (iVar2 >> 0x13) * 4);
      param_1 = FUN_20212a64(**(undefined4 **)(unaff_FP + -0x5c),*(undefined4 *)(unaff_FP + -0x28),
                             *(undefined4 *)(unaff_FP + -0x40));
      iVar11 = *(int *)(unaff_FP + -0x5c);
      iVar2 = *(int *)(unaff_FP + 0x28);
      *(uint *)(iVar11 + 0x14) = param_1;
    } while (((iVar2 != 3) && (iVar2 != 5)) && (unaff_R7 = (int)*(short *)(iVar11 + -6), iVar2 != 4)
            );
    piVar14 = *(int **)(unaff_FP + -0x5c);
    iVar2 = *(int *)(unaff_FP + -0x24);
    unaff_R6 = *piVar14 >> 0xf;
    piVar14[-1] = unaff_R6;
    unaff_R7 = (int)*(short *)((int)piVar14 + -6);
    *(int **)(unaff_FP + -0x1c) = piVar14;
    if (iVar2 == unaff_R7) {
      iVar2 = (int)*unaff_P5;
      if ((unaff_R6 + 2 < *(int *)(&DAT_ff804888 + iVar2 * 4)) ||
         (*(int *)(&DAT_ff804888 + iVar2 * 4) < unaff_R6 + -2)) {
        *(uint *)(&DAT_ff8048f4 + iVar2 * 4) = param_1;
        *(undefined **)(unaff_FP + -0x58) = &DAT_ff8048ac + iVar2 * 4;
        piVar14 = *(int **)(unaff_FP + -0x58);
        uVar6 = *(undefined4 *)(*(int *)(unaff_FP + -0x1c) + 0xc);
        *(undefined4 *)(&DAT_ff8048d0 + iVar2 * 4) = uVar6;
        *(undefined4 *)(&DAT_ff804918 + iVar2 * 4) = uVar6;
        *piVar14 = unaff_R6;
      }
    }
  } while( true );
}


