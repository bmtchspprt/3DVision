/* FUN_20220260 @ 20220260..20220635 */

/* WARNING: Control flow encountered unimplemented instructions */
/* WARNING: Removing unreachable block (ram,0x202205e8) */

void FUN_20220260(undefined4 param_1,short param_2)

{
  short sVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  undefined2 uVar4;
  uint uVar5;
  int iVar6;
  undefined4 uVar7;
  int iVar8;
  undefined4 uVar9;
  undefined4 unaff_R4;
  uint unaff_R5;
  short unaff_R6_L;
  int iVar10;
  short *psVar11;
  int in_P0;
  int iVar12;
  undefined1 *puVar13;
  undefined2 *puVar14;
  undefined4 *puVar15;
  short *psVar16;
  int in_P1;
  undefined2 *puVar17;
  undefined4 *in_P3;
  int unaff_P4;
  int unaff_P5;
  int unaff_FP;
  undefined1 uVar18;
  bool bVar19;
  int iVar20;
  code *UNRECOVERED_JUMPTABLE_00;
  int in_stack_00000030;
  undefined4 *in_stack_00000038;
  
  iVar10 = *(int *)(unaff_FP + -0x34);
  *(int *)(unaff_FP + -0x34) = in_P0 + 0x2938;
  iVar12 = *(int *)(unaff_FP + -0x20);
  *(undefined4 *)(unaff_FP + -0x2c) = *(undefined4 *)(unaff_P4 + 0x10);
  iVar6 = (in_stack_00000030 + 1) - (int)(short)(param_2 + 1);
  if (in_stack_00000030 <= (short)(param_2 + 1)) {
    iVar6 = 1;
  }
  uVar9 = *(undefined4 *)(unaff_P4 + 0x28);
  *(uint *)(unaff_FP + -0xc) = unaff_R5 * 2;
  *(undefined4 *)(unaff_FP + -0x60) = uVar9;
  *(int *)(unaff_FP + -0x30) = in_P1 + *(int *)(unaff_FP + -0x30) * 4;
  uVar9 = *(undefined4 *)(unaff_P4 + 0x24);
  *(uint *)(unaff_FP + -0x10) = *(int *)(unaff_FP + -0x54) + 0x4ad6 + iVar10 + unaff_R5 * 2;
  *(uint *)(unaff_FP + -0x14) = unaff_R5 << 1;
  *(int *)(unaff_FP + -0x20) = unaff_P5 + 0x4fc74;
  *(undefined4 *)(unaff_FP + 0x10) = uVar9;
  *(uint *)(unaff_FP + -8) = unaff_P5 + 0x5b8 + iVar12 + unaff_R5 * 4;
  uVar7 = *(undefined4 *)(unaff_P4 + 0x1c);
  uVar9 = *(undefined4 *)(unaff_P4 + 0x20);
  UNRECOVERED_JUMPTABLE_00 = (code *)0x202202e0;
  uVar18 = *(int *)(unaff_FP + -0xc) == (int)**(short **)(unaff_FP + -0x20);
  if ((bool)uVar18) {
    uVar9 = FUN_ffa01688((int)*(short *)(*(int *)(unaff_FP + -8) + 4));
    uVar9 = FUN_ffa018f0(uVar9,*(undefined4 *)(unaff_FP + -0x2c));
    *(undefined4 *)(unaff_FP + -4) = uVar9;
    *(int *)(unaff_FP + -0x1c) = (int)*(short *)((int)in_P3 + -0x12);
    uVar9 = FUN_ffa01688((int)**(short **)(unaff_FP + -0x10));
    uVar9 = FUN_ffa018f0(uVar9,*(undefined4 *)(unaff_FP + -0x28));
    puVar13 = (undefined1 *)(*(int *)(unaff_FP + -0x40) + *(int *)(unaff_FP + -0x1c));
    FUN_ffa0165c(uVar9,*(undefined4 *)(unaff_FP + -4));
    uVar7 = *(undefined4 *)(unaff_FP + -4);
    *puVar13 = uVar18;
    uVar2 = FUN_ffa01714(uVar7,uVar9);
    uVar7 = *(undefined4 *)(unaff_FP + -4);
    **(undefined4 **)(unaff_FP + -0x30) = uVar2;
  }
  uVar18 = unaff_R6_L == 0;
  uVar2 = *(undefined4 *)(unaff_FP + 0x10);
  if ((bool)uVar18) {
    uVar5 = unaff_R5 & 0xfffffffe;
    *(int *)(unaff_FP + -0x1c) = (int)*(short *)(*(int *)(unaff_FP + -8) + 4);
    uVar9 = FUN_ffa01688(*(undefined4 *)(unaff_FP + -0x1c));
    *(uint *)(unaff_FP + 0x10) = *(int *)(unaff_FP + -0x34) + uVar5;
    uVar9 = FUN_ffa018f0(uVar9,*(undefined4 *)(unaff_FP + -0x2c));
    *(undefined4 *)(unaff_FP + -4) = uVar9;
    uVar9 = FUN_ffa01688((int)**(short **)(unaff_FP + 0x10));
    uVar9 = FUN_ffa018f0(uVar9,*(undefined4 *)(unaff_FP + -0x38));
    *(undefined4 *)(unaff_FP + 0x10) = uVar9;
    uVar9 = FUN_ffa01688((int)**(short **)(unaff_FP + -0x10));
    uVar9 = FUN_ffa018f0(uVar9,*(undefined4 *)(unaff_FP + -0x28));
    uVar5 = FUN_ffa01714(*(undefined4 *)(unaff_FP + -4),uVar9);
    *(uint *)(unaff_FP + -0x24) = uVar5 & 0x7fffffff;
    uVar7 = FUN_ffa018f0(0x3fb33333,*(undefined4 *)(unaff_FP + 0x10));
    FUN_ffa0165c(uVar7,*(undefined4 *)(unaff_FP + -0x24));
    uVar7 = *(undefined4 *)(unaff_FP + -4);
    uVar2 = *(undefined4 *)(unaff_FP + 0x10);
    if ((bool)uVar18) {
      FUN_ffa0165c(0x44bb8000,*(undefined4 *)(unaff_FP + -0x24));
      uVar7 = *(undefined4 *)(unaff_FP + -4);
      uVar2 = *(undefined4 *)(unaff_FP + 0x10);
      if ((bool)uVar18) {
        FUN_ffa0165c(*(undefined4 *)(unaff_FP + -4),uVar9);
        uVar7 = uVar9;
        if ((bool)uVar18) {
          uVar7 = *(undefined4 *)(unaff_FP + -4);
        }
        FUN_ffa0165c(uVar7,0x461c4000);
        if (!(bool)uVar18) {
          unaff_R6_L = 0;
          FUN_ffa0165c(uVar7,*(undefined4 *)(unaff_FP + -0x24));
          uVar7 = *(undefined4 *)(unaff_FP + -4);
          uVar2 = *(undefined4 *)(unaff_FP + 0x10);
          if (!(bool)uVar18) goto LAB_2022035e;
        }
        unaff_R6_L = 0;
        uVar7 = *(undefined4 *)(unaff_FP + -4);
        uVar2 = *(undefined4 *)(unaff_FP + 0x10);
        if (((int)(*(short **)(unaff_FP + -8))[4] <= *(int *)(unaff_FP + -0x1c)) &&
           (bVar19 = (int)**(short **)(unaff_FP + -8) <= *(int *)(unaff_FP + -0x1c), bVar19)) {
          FUN_ffa0165c(*(undefined4 *)(unaff_FP + -0x60),*(undefined4 *)(unaff_FP + -4));
          uVar7 = *(undefined4 *)(unaff_FP + -4);
          uVar2 = *(undefined4 *)(unaff_FP + 0x10);
          if (bVar19) {
            sVar1 = *(short *)((int)in_P3 + -0x12);
            uVar3 = *(undefined4 *)(unaff_FP + -4);
            *(short *)(*(int *)(unaff_FP + -0x5c) + sVar1 * 2) =
                 (short)*(undefined4 *)(unaff_FP + -0x14);
            unaff_R6_L = 1;
            puVar15 = (undefined4 *)(unaff_P5 + 0x4fc28 + sVar1 * 8);
            *puVar15 = uVar3;
            puVar15[1] = uVar9;
          }
        }
      }
    }
  }
LAB_2022035e:
  puVar14 = *(undefined2 **)(unaff_FP + -0x10);
  *(undefined4 *)(unaff_FP + 0x10) = uVar2;
  puVar17 = (undefined2 *)(*(int *)(unaff_FP + -8) + 4);
  *(int *)(unaff_FP + -0xc) = *(int *)(unaff_FP + -0xc) + 2;
  iVar10 = *(int *)(unaff_FP + -0x14);
  *puVar14 = *puVar17;
  *(undefined2 **)(unaff_FP + -8) = puVar17;
  *(undefined2 **)(unaff_FP + -0x10) = puVar14 + 1;
  *(int *)(unaff_FP + -0x14) = iVar10 + 2;
                    /* WARNING: Could not recover jumptable at 0x2022037a. Too many branches */
                    /* WARNING: Treating indirect jump as call */
  if ((iVar6 != 0) && (iVar6 != 1)) {
    (*UNRECOVERED_JUMPTABLE_00)();
    return;
  }
  *(undefined4 *)(unaff_P4 + 0x20) = uVar9;
  *(undefined4 *)(unaff_P4 + 0x1c) = uVar7;
  *(undefined4 *)(unaff_P4 + 0x24) = uVar2;
  *(uint *)(unaff_P4 + 4) = CONCAT22(unaff_R6_L,(short)unaff_R5 + 1);
  **(undefined4 **)(unaff_FP + -0x4c) = *(undefined4 *)(*(int *)(unaff_FP + -0x3c) + 0x5cd4);
  while( true ) {
    *(int *)(unaff_P4 + 2) = *(short *)(unaff_P4 + 2) + 1;
    if ((int)**(short **)(unaff_FP + -0x48) <= (int)**(short **)(unaff_FP + -0x44)) break;
    iVar6 = FUN_202b5024((int)**(short **)(unaff_FP + -0x44),*(undefined4 *)(unaff_FP + -0x50),
                         *(undefined4 *)(unaff_FP + -0x54));
    psVar16 = *(short **)(unaff_FP + -0x44);
    psVar11 = *(short **)(unaff_FP + -0x48);
    *psVar16 = (short)iVar6;
    if (*psVar11 <= iVar6) break;
    iVar6 = (int)*psVar16;
    *(int *)(unaff_FP + -0x5c) = unaff_P5 + 0x4fbce;
    *(short *)(unaff_P5 + 0x4fbce + iVar6 * 2) = (short)unaff_R4;
    if (iVar6 != 2) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  psVar11 = *(short **)(unaff_FP + -0x48);
  iVar6 = (int)*psVar11;
  *(undefined4 *)(psVar11 + 0xd8de) = *(undefined4 *)(psVar11 + 0xd8e2);
  *(int *)(unaff_FP + -0x50) = unaff_P5 + 0x4fbce;
  uVar4 = *(undefined2 *)((int)in_P3 + -10);
  iVar10 = 0;
  if (0 < iVar6) {
    *(int *)(unaff_FP + -0x58) = iVar6;
    iVar12 = *(int *)(unaff_FP + -0x58);
    *(undefined4 *)(unaff_FP + -0x18) = 0;
    do {
      *(int *)(unaff_FP + -0x44) = iVar10;
      iVar10 = iVar10 + 1;
      uVar4 = 0;
      if (0 < iVar6) {
        iVar8 = 0;
        iVar20 = *(int *)(unaff_FP + -0x58);
        do {
          bVar19 = *(int *)(unaff_FP + -0x18) != iVar8;
          iVar8 = iVar8 + 1;
          if (bVar19) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
            halt_unimplemented();
          }
        } while ((iVar20 != 0) && (iVar20 = iVar20 + -1, iVar20 != 0));
      }
      *(int *)(unaff_FP + -0x18) = iVar10;
    } while ((iVar12 != 0) && (iVar12 = iVar12 + -1, iVar12 != 0));
  }
  psVar11 = *(short **)(unaff_FP + -0x48);
  *in_P3 = unaff_R4;
  *(undefined2 *)((int)in_P3 + -10) = uVar4;
  *(short *)((int)in_P3 + -0x12) = (short)iVar10;
  sVar1 = *psVar11;
  iVar6 = (int)sVar1;
  uVar18 = iVar6 < 1;
  *(short *)(in_P3 + -4) = (short)unaff_R4;
  if (!(bool)uVar18) {
    UNRECOVERED_JUMPTABLE_00 = (code *)0x20220574;
    iVar10 = iVar6;
    uVar9 = FUN_ffa01716(0,*(uint *)(unaff_P5 + 0x4fbec) & 0x7fffffff);
                    /* WARNING: Could not recover jumptable at 0x20220582. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    if ((iVar10 != 0) && (iVar10 != 1)) {
      (*UNRECOVERED_JUMPTABLE_00)();
      return;
    }
    *in_P3 = uVar9;
    *(short *)(in_P3 + -4) = sVar1;
  }
  uVar9 = FUN_ffa01688(iVar6);
  uVar9 = FUN_ffa01814(*in_P3,uVar9);
  FUN_ffa0165c(uVar9,0x43480000);
  if ((bool)uVar18) {
    *(char *)(unaff_P5 + 0x4fc14) = (char)unaff_R4;
  }
  FUN_2021f878(*(undefined4 *)(unaff_FP + -0x54),in_P3[-7],in_P3[-6]);
  uVar9 = in_P3[-9];
  in_stack_00000038[1] = in_P3[-8];
  *in_stack_00000038 = uVar9;
  return;
}


