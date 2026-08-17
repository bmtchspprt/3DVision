
/* WARNING: Control flow encountered unimplemented instructions */

undefined1 FUN_20212000(void)

{
  short sVar1;
  int iVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  undefined2 unaff_R4_L;
  int unaff_R7;
  int iVar5;
  short *psVar6;
  int in_P1;
  int in_P3;
  int unaff_P4;
  int unaff_P5;
  int unaff_FP;
  
  uVar3 = FUN_ffa02894(*(undefined4 *)(in_P1 + 0x34));
  uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(unaff_P5 + 0x50));
  uVar3 = FUN_ffa018f0(uVar3,0x40800000);
  *(undefined4 *)(unaff_P5 + 0x50) = uVar3;
  FUN_ffa01814(uVar3,0x40490fdb);
  uVar4 = FUN_ffa0248c();
  *(undefined4 *)(unaff_P5 + 0x50) = uVar4;
  uVar3 = FUN_ffa020d4(*(undefined4 *)(unaff_P4 + 0x62ac));
  FUN_ffa01814(uVar4,uVar3);
  iVar2 = FUN_ffa028c8();
  iVar2 = iVar2 * (uint)(unaff_R7 < iVar2) + unaff_R7 * (uint)(unaff_R7 >= iVar2);
  *(int *)(unaff_P4 + 0x528) = iVar2;
  *(int *)(unaff_P4 + 0x52c) = iVar2 * 2;
  uVar3 = FUN_ffa02894(iVar2 + unaff_R7);
  uVar3 = FUN_ffa018f0(uVar3,0x447a0000);
  uVar3 = FUN_ffa01c74(uVar3,0x40000000);
  *(undefined4 *)(unaff_P4 + 0x530) = uVar3;
  iVar2 = *(int *)(unaff_P4 + 0x52c);
  *(int *)(unaff_FP + -4) = unaff_P4 + 0x34a54;
  uVar3 = FUN_ffa02894(iVar2 + unaff_R7);
  uVar4 = FUN_ffa02894(*(int *)(unaff_P4 + 0x528) + unaff_R7);
  uVar3 = FUN_ffa01814(uVar3,uVar4);
  uVar3 = FUN_ffa01c74(uVar3,0x3fc00000);
  uVar3 = FUN_ffa018f0(uVar3,*(undefined4 *)(unaff_P4 + 0x530));
  psVar6 = *(short **)(unaff_FP + -4);
  *(undefined4 *)(unaff_P4 + 0x534) = uVar3;
  uVar3 = *(undefined4 *)(in_P3 + 0xc);
  sVar1 = *psVar6;
  *(undefined4 *)(unaff_P5 + 0x44) = *(undefined4 *)(in_P3 + 0x14);
  *(undefined4 *)(unaff_P5 + 0x48) = uVar3;
  *(undefined2 *)(unaff_P5 + 0x3c) = unaff_R4_L;
  if (0 < sVar1) {
    FUN_202b4a98((int)*(short *)(unaff_P5 + 0x3c),*(undefined4 *)(unaff_FP + -0xc));
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar5 = *(int *)(unaff_FP + 0x18);
  iVar2 = *(int *)(*(int *)(*(int *)(unaff_FP + 0x18) + 0x14) + 8) - *(int *)(in_P3 + 0x18);
  *(int *)(in_P3 + 8) = iVar2;
  *(int *)(in_P3 + 0x10) = *(int *)(*(int *)(iVar5 + 0x14) + 0xc) - *(int *)(in_P3 + 0x18);
  if (*(int *)(in_P3 + 0xc) < iVar2) {
    *(int *)(in_P3 + 8) = *(int *)(in_P3 + 0xc);
  }
  if (*(int *)(in_P3 + 8) < *(int *)(in_P3 + 0x10)) {
    *(int *)(in_P3 + 0x10) = *(int *)(in_P3 + 8);
  }
  else if (*(int *)(in_P3 + 0x10) < *(int *)(in_P3 + 0x14)) {
    *(int *)(in_P3 + 0x10) = *(int *)(in_P3 + 0x14);
  }
  return *(undefined1 *)(unaff_P4 + 0x522);
}


