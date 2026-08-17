
/* WARNING: Control flow encountered unimplemented instructions */

undefined1 FUN_2021204c(undefined4 param_1,undefined4 param_2,undefined4 param_3)

{
  short sVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  int iVar4;
  undefined2 unaff_R4_L;
  int unaff_R7;
  int iVar5;
  short *psVar6;
  int in_P2;
  int in_P3;
  int unaff_P4;
  int unaff_P5;
  int unaff_FP;
  
  *(undefined4 *)(in_P3 + 0x14) = param_3;
  if (*(char *)(*(int *)(in_P2 + 0xa4) + 1) == '\x01') {
    uVar2 = FUN_ffa02894();
  }
  else {
    uVar2 = FUN_ffa02894(*(undefined4 *)(*(int *)(unaff_FP + -4) + 0x30));
    iVar4 = *(int *)(unaff_FP + -4);
    *(undefined4 *)(unaff_P5 + 0x50) = uVar2;
    uVar2 = FUN_ffa02894(*(undefined4 *)(iVar4 + 0x34));
    uVar2 = FUN_ffa018f0(uVar2,*(undefined4 *)(unaff_P5 + 0x50));
    uVar2 = FUN_ffa018f0(uVar2,0x40800000);
    *(undefined4 *)(unaff_P5 + 0x50) = uVar2;
    FUN_ffa01814(uVar2,0x40490fdb);
    uVar2 = FUN_ffa0248c();
  }
  *(undefined4 *)(unaff_P5 + 0x50) = uVar2;
  uVar3 = FUN_ffa020d4(*(undefined4 *)(unaff_P4 + 0x62ac));
  FUN_ffa01814(uVar2,uVar3);
  iVar4 = FUN_ffa028c8();
  iVar4 = iVar4 * (uint)(unaff_R7 < iVar4) + unaff_R7 * (uint)(unaff_R7 >= iVar4);
  *(int *)(unaff_P4 + 0x528) = iVar4;
  *(int *)(unaff_P4 + 0x52c) = iVar4 * 2;
  uVar2 = FUN_ffa02894(iVar4 + unaff_R7);
  uVar2 = FUN_ffa018f0(uVar2,0x447a0000);
  uVar2 = FUN_ffa01c74(uVar2,0x40000000);
  *(undefined4 *)(unaff_P4 + 0x530) = uVar2;
  iVar4 = *(int *)(unaff_P4 + 0x52c);
  *(int *)(unaff_FP + -4) = unaff_P4 + 0x34a54;
  uVar2 = FUN_ffa02894(iVar4 + unaff_R7);
  uVar3 = FUN_ffa02894(*(int *)(unaff_P4 + 0x528) + unaff_R7);
  uVar2 = FUN_ffa01814(uVar2,uVar3);
  uVar2 = FUN_ffa01c74(uVar2,0x3fc00000);
  uVar2 = FUN_ffa018f0(uVar2,*(undefined4 *)(unaff_P4 + 0x530));
  psVar6 = *(short **)(unaff_FP + -4);
  *(undefined4 *)(unaff_P4 + 0x534) = uVar2;
  uVar2 = *(undefined4 *)(in_P3 + 0xc);
  sVar1 = *psVar6;
  *(undefined4 *)(unaff_P5 + 0x44) = *(undefined4 *)(in_P3 + 0x14);
  *(undefined4 *)(unaff_P5 + 0x48) = uVar2;
  *(undefined2 *)(unaff_P5 + 0x3c) = unaff_R4_L;
  if (0 < sVar1) {
    FUN_202b4a98((int)*(short *)(unaff_P5 + 0x3c),*(undefined4 *)(unaff_FP + -0xc));
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar5 = *(int *)(unaff_FP + 0x18);
  iVar4 = *(int *)(*(int *)(*(int *)(unaff_FP + 0x18) + 0x14) + 8) - *(int *)(in_P3 + 0x18);
  *(int *)(in_P3 + 8) = iVar4;
  *(int *)(in_P3 + 0x10) = *(int *)(*(int *)(iVar5 + 0x14) + 0xc) - *(int *)(in_P3 + 0x18);
  if (*(int *)(in_P3 + 0xc) < iVar4) {
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


