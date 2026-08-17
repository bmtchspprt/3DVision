
void thunk_FUN_2022efac(void)

{
  int iVar1;
  int iVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  uint uVar5;
  int iVar6;
  uint uVar7;
  uint unaff_R5;
  undefined4 *puVar8;
  int in_P3;
  undefined4 *unaff_P5;
  int unaff_FP;
  
  unaff_P5[8] = unaff_R5;
  unaff_P5[7] = *(undefined4 *)(in_P3 + 0x90);
  iVar1 = unaff_P5[10];
  iVar6 = *(int *)(in_P3 + 0x14);
  if (iVar6 < iVar1) {
    unaff_P5[10] = iVar6;
  }
  iVar2 = *(int *)(in_P3 + 0xc);
  unaff_P5[8] = unaff_P5[8] - *(int *)(in_P3 + 0x10);
  *(bool *)((int)unaff_P5 + 0x72) = iVar6 < iVar1;
  unaff_P5[7] = unaff_P5[7] - iVar2;
  uVar3 = FUN_ffa02894();
  *unaff_P5 = uVar3;
  uVar3 = FUN_ffa02894(unaff_P5[8]);
  unaff_P5[1] = uVar3;
  uVar3 = FUN_ffa02894(unaff_P5[10]);
  iVar1 = *(int *)(unaff_FP + 0x14);
  unaff_P5[2] = uVar3;
  FUN_ffa02894(*(undefined4 *)(iVar1 + 0x34));
  FUN_ffa02894(*(undefined4 *)(in_P3 + 0x18));
  FUN_2022e612();
  uVar3 = FUN_ffa018f0(*unaff_P5,*unaff_P5);
  uVar4 = FUN_ffa018f0(unaff_P5[1],unaff_P5[1]);
  FUN_ffa01716(uVar4,uVar3);
  uVar3 = FUN_ffa0248c();
  unaff_P5[3] = uVar3;
  if (*(char *)((int)unaff_P5 + 0x72) != '\0') {
    uVar3 = FUN_ffa018f0(uVar3,uVar3);
    uVar4 = FUN_ffa018f0(unaff_P5[2]);
    FUN_ffa01716(uVar4,uVar3);
    uVar3 = FUN_ffa0248c();
    unaff_P5[4] = uVar3;
  }
  FUN_ffa01814(unaff_P5[3],unaff_P5[4]);
  uVar3 = FUN_ffa004f0();
  puVar8 = *(undefined4 **)(unaff_FP + 0xc);
  *(undefined4 *)(*(int *)(unaff_FP + 0xc) + 4) = uVar3;
  uVar3 = FUN_ffa028c8(unaff_P5[4]);
  uVar7 = unaff_P5[3];
  *puVar8 = uVar3;
  if ((uVar7 & 0x7fffffff) == 0) {
    puVar8[2] = unaff_R5;
  }
  else {
    FUN_ffa01814(*unaff_P5,uVar7);
    uVar3 = FUN_ffa004f0();
    uVar3 = FUN_ffa01714(0x3fc90fdb,uVar3);
    *(undefined4 *)(*(int *)(unaff_FP + 0xc) + 8) = uVar3;
    uVar5 = unaff_P5[1];
    uVar7 = uVar5 >> 0x1f;
    if (-0x800000 < (int)uVar5) {
      uVar7 = unaff_R5;
    }
    if (uVar5 == 0x80000000) {
      uVar7 = 0;
    }
    if ((uVar7 & 1) == 1) {
      uVar3 = FUN_ffa01714(0x40c90fdb,uVar3);
      *(undefined4 *)(*(int *)(unaff_FP + 0xc) + 8) = uVar3;
    }
    uVar5 = *(uint *)(*(int *)(unaff_FP + 0xc) + 8);
    uVar7 = uVar5 >> 0x1f;
    if (-0x800000 < (int)uVar5) {
      uVar7 = unaff_R5;
    }
    if (uVar5 == 0x80000000) {
      uVar7 = 0;
    }
    if ((uVar7 & 1) == 1) {
      uVar3 = FUN_ffa01716(uVar5,0x40c90fdb);
      *(undefined4 *)(*(int *)(unaff_FP + 0xc) + 8) = uVar3;
    }
  }
  uVar3 = FUN_ffa018f0(0x3fc00000,unaff_P5[0x15]);
  FUN_ffa01714(uVar3,0x3f000000);
  return;
}


