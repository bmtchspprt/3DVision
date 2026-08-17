/* seed 20210c00 */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20210c00(undefined4 param_1,int param_2)

{
  undefined *puVar1;
  undefined *puVar2;
  undefined *puVar3;
  undefined4 in_R3;
  int in_P1;
  undefined4 *puVar4;
  int iVar5;
  int unaff_FP;
  
  *(int *)(unaff_FP + -4) = in_P1;
  *(undefined4 *)(in_P1 + 4) = in_R3;
  *(undefined4 *)(in_P1 + 0x14) = 4;
  puVar4 = *(undefined4 **)(unaff_FP + -4);
  *(undefined4 *)(unaff_FP + -0xc) = 0xc;
  iVar5 = *(int *)(unaff_FP + -4);
  puVar4[2] = 0x40004;
  puVar4[3] = 0x40004;
  *(undefined4 *)(iVar5 + 0x10) = 0x40004;
  *puVar4 = 0x10000;
  *(undefined ***)(param_2 + 0x4cc) = &PTR_DAT_202d2850;
  puVar1 = PTR_DAT_202d2850;
  *(undefined4 *)(param_2 + 0x4d0) = *(undefined4 *)(unaff_FP + -4);
  *(undefined4 *)(unaff_FP + -0x10) = param_1;
  puVar2 = PTR_DAT_202d2854;
  *(undefined **)(param_2 + 0x500) = &DAT_202d2d7c;
  *(undefined4 **)(param_2 + 0x4d4) = &DAT_20215030;
  *(int *)(unaff_FP + -0x18) = param_2;
  *(int *)(unaff_FP + -0x14) = param_2 + 0x578;
  puVar3 = PTR_DAT_202d2858;
  *(undefined2 *)(puVar1 + 0x5774) = 10;
  puVar1 = PTR_DAT_202d285c;
  *(undefined2 *)(puVar2 + 0x5774) = 10;
  puVar2 = PTR_DAT_202d2860;
  *(undefined2 *)(puVar3 + 0x5774) = 0xb;
  *(undefined2 *)(puVar1 + 0x5774) = 0xc;
  *(undefined2 *)(puVar2 + 0x5774) = 0xc;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


