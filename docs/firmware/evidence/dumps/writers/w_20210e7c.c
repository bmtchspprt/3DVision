/* seed 20210e7c */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20210e7c(void)

{
  int iVar1;
  short sVar2;
  short unaff_R6_L;
  short unaff_R7_L;
  undefined2 *puVar3;
  int iVar4;
  int *in_P1;
  int iVar5;
  int in_P2;
  int *piVar6;
  int *piVar7;
  int unaff_FP;
  int iVar8;
  
  while( true ) {
    puVar3 = *(undefined2 **)(unaff_FP + 0xc);
    iVar4 = *in_P1;
    *puVar3 = (short)*(undefined4 *)(unaff_FP + -8);
    *(short *)(iVar4 + 0x5784) = unaff_R7_L;
    iVar4 = *in_P1;
    *(undefined2 **)(unaff_FP + 0xc) = puVar3 + 1;
    *(undefined4 *)(iVar4 + 0x5780) = 0;
    *(undefined4 *)(*in_P1 + 0x57c0) = 0;
    *(uint *)(*in_P1 + 0x57c4) = (uint)*(ushort *)(*in_P1 + 0x5776);
    iVar4 = *in_P1;
    *(int **)(unaff_FP + 0x10) = in_P1 + 1;
    iVar5 = 0;
    if (0 < *(int *)(iVar4 + 0x57bc)) break;
LAB_20210f22:
    in_P1 = *(int **)(unaff_FP + 0x10);
    if ((in_P2 == 0) || (in_P2 = in_P2 + -1, in_P2 == 0)) {
      FUN_ffa05ee4((int)unaff_R6_L,(int)unaff_R7_L);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  sVar2 = 0;
  *(int *)(unaff_FP + 8) = *(int *)(unaff_FP + 0x10) + -4;
  do {
    iVar8 = -1;
    do {
      piVar6 = (int *)(iVar4 + 0x578c + iVar5);
      iVar1 = *piVar6;
      piVar7 = *(int **)(unaff_FP + 8);
      *(int *)(iVar4 + 0x57c0) =
           ((*(int *)(iVar1 + 0x14) - *(int *)(iVar1 + 0x1c)) + -1) * piVar6[2] +
           *(int *)(iVar4 + 0x57c0);
      iVar4 = *piVar7;
      sVar2 = sVar2 + 1;
      piVar6 = (int *)(iVar4 + 0x578c + iVar5);
      piVar7 = *(int **)(unaff_FP + 8);
      iVar5 = iVar5 + 0xc;
      *(int *)(iVar4 + 0x57c4) =
           piVar6[2] * (*(int *)(*piVar6 + 0x14) + -1) + 1 + *(int *)(iVar4 + 0x57c4);
      iVar4 = *piVar7;
      if (*(int *)(iVar4 + 0x57bc) <= (int)sVar2) goto LAB_20210f22;
    } while ((iVar8 != 0) && (iVar8 = iVar8 + -1, iVar8 != 0));
    iVar4 = **(int **)(unaff_FP + 8);
  } while( true );
}


