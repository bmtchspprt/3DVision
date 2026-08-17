/* FUN_ffa03b00 @ ffa03b00..ffa03c6b */

void FUN_ffa03b00(int param_1,int param_2)

{
  undefined4 uVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  int in_R3;
  uint uVar6;
  int unaff_P4;
  int unaff_P5;
  int unaff_FP;
  undefined2 *in_stack_00000028;
  uint in_stack_00000038;
  
  while( true ) {
    *(int *)(unaff_FP + 0x28) = in_R3 >> 2;
    if (0x1479 < param_2) break;
    uVar1 = FUN_ffa02948((int)*(short *)(*(int *)(unaff_P5 + 8) + unaff_P4));
    uVar2 = FUN_ffa018f0(uVar1,*(undefined4 *)(unaff_P5 + 0x10));
    uVar1 = FUN_ffa02948((int)*(short *)(*(int *)(unaff_P5 + 0xc) + (in_R3 >> 2) * 2));
    uVar3 = FUN_ffa018f0(uVar1,*(undefined4 *)(unaff_P5 + 0x14));
    uVar4 = FUN_ffa01714(uVar2,uVar3);
    uVar5 = FUN_ffa018f0(in_stack_00000038,*(undefined4 *)(unaff_FP + 0x14));
    uVar6 = (uint)((int)uVar4 <= (int)uVar5);
    if (uVar5 != uVar4) {
      uVar6 = (uVar5 & uVar4) >> 0x1f ^ (uint)((int)uVar4 <= (int)uVar5);
    }
    if ((uVar5 & 0x7fffffff) == 0 && (uVar4 & 0x7fffffff) == 0) {
      uVar6 = 1;
    }
    if (0x7f800000 < (uVar4 & 0x7fffffff) || 0x7f800000 < (uVar5 & 0x7fffffff)) {
      uVar6 = 0;
    }
    if (uVar6 == 1) break;
    uVar5 = uVar2 & 0x7fffffff;
    uVar6 = (uint)((int)uVar2 <= (int)uVar3);
    if (uVar3 != uVar2) {
      uVar6 = (uVar3 & uVar2) >> 0x1f ^ (uint)((int)uVar2 <= (int)uVar3);
    }
    if ((uVar3 & 0x7fffffff) == 0 && uVar5 == 0) {
      uVar6 = 1;
    }
    if (0x7f800000 < uVar5 || 0x7f800000 < (uVar3 & 0x7fffffff)) {
      uVar6 = 0;
    }
    if (uVar6 == 1) break;
    uVar6 = (uint)((int)in_stack_00000038 < (int)uVar2);
    if (uVar2 != in_stack_00000038) {
      uVar6 = (uVar2 & in_stack_00000038) >> 0x1f ^ (uint)((int)in_stack_00000038 < (int)uVar2);
    }
    if (uVar5 == 0 && (in_stack_00000038 & 0x7fffffff) == 0) {
      uVar6 = 0;
    }
    if (0x7f800000 < (in_stack_00000038 & 0x7fffffff) || 0x7f800000 < uVar5) {
      uVar6 = 0;
    }
    if (uVar6 == 1) break;
    *(int *)(unaff_FP + 0x24) = param_1 + 1;
    uVar1 = FUN_ffa018f0(uVar4,uVar4);
    uVar1 = FUN_ffa01716(uVar1,*(undefined4 *)(unaff_FP + 0x10));
    *(undefined4 *)(unaff_FP + 0x10) = uVar1;
    in_R3 = *(int *)(unaff_FP + 0x28);
    param_1 = *(int *)(unaff_FP + 0x24);
    param_2 = (int)(short)*(undefined4 *)(unaff_FP + 0x24);
    unaff_P4 = unaff_P4 + 2;
  }
  if (in_stack_00000028 != (undefined2 *)0x0) {
    *in_stack_00000028 = (short)*(undefined4 *)(unaff_FP + 0x24);
  }
  uVar1 = FUN_ffa016d4(*(undefined2 *)
                        (*(int *)(*(int *)(*(int *)(unaff_FP + 0x20) + 0x4cc) +
                                 (uint)*(ushort *)
                                        (*(int *)(*(int *)(unaff_FP + 0x20) + 0x4d0) +
                                        *(int *)(unaff_FP + 0x18) * 2) * 4) + 0x5770));
  FUN_ffa01814(*(undefined4 *)(unaff_FP + 0x10),uVar1);
  FUN_ffa0248c();
  return;
}


