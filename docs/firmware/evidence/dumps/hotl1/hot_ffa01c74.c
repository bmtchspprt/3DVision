
/* WARNING: Control flow encountered unimplemented instructions */

undefined4 FUN_ffa01c74(uint param_1,uint param_2)

{
  undefined4 uVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  uint uVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  undefined1 uVar9;
  undefined4 in_stack_00000004;
  undefined4 in_stack_00000008;
  uint local_18;
  
  if ((param_1 & 0x7fffffff) == 0) {
    uVar1 = 0x3f800000;
    if ((param_2 & 0x7fffffff) != 0) {
      uVar1 = 0;
      if (param_2 == 0 || (0x7f800000 < (int)param_2 || (param_2 & 0x80000000) != 0)) {
        uVar1 = 0x7f7fffff;
      }
    }
    return uVar1;
  }
  uVar5 = param_1 >> 0x1f;
  if (-0x800000 < (int)param_1) {
    uVar5 = 0;
  }
  if ((param_1 ^ 0x80000000) == 0) {
    uVar5 = 0;
  }
  uVar9 = uVar5 == 1;
  local_18 = 0;
  if ((bool)uVar9) {
    local_18 = FUN_ffa014dc(param_2);
    uVar1 = FUN_ffa01688();
    FUN_ffa01618(uVar1,param_2);
    if (!(bool)uVar9) {
      return 0;
    }
    local_18 = local_18 & 1;
    param_1 = param_1 ^ 0x80000000;
  }
  uVar5 = param_1 & 0x807fffff | 0x3f000000;
  iVar8 = 1;
  iVar7 = -0x7fca1c;
  FUN_ffa01630(DAT_ff8035c0,uVar5);
  if ((bool)uVar9) {
    iVar8 = 9;
  }
  FUN_ffa01630(*(undefined4 *)(s_____zyxwwvutssrqqpoonmmlkkjjiihg_ff8034de + (iVar8 + 4) * 4 + 0xbe)
               ,uVar5);
  if ((bool)uVar9) {
    iVar8 = iVar8 + 4;
  }
  FUN_ffa01630(*(undefined4 *)(s_____zyxwwvutssrqqpoonmmlkkjjiihg_ff8034de + (iVar8 + 2) * 4 + 0xbe)
               ,uVar5);
  if ((bool)uVar9) {
    iVar8 = iVar8 + 2;
  }
  uVar1 = *(undefined4 *)(s_____zyxwwvutssrqqpoonmmlkkjjiihg_ff8034de + (iVar8 + 1U) * 4 + 0xbe);
  uVar2 = FUN_ffa01714(uVar5,uVar1);
  uVar2 = FUN_ffa01714(uVar2,*(undefined4 *)(iVar7 + (iVar8 + 1U >> 1) * 4));
  uVar1 = FUN_ffa01716(uVar5,uVar1);
  uVar1 = FUN_ffa01814(uVar2,uVar1);
  uVar1 = FUN_ffa018f0(uVar1,0x40000000);
  uVar2 = FUN_ffa018f0(uVar1,uVar1);
  uVar3 = FUN_ffa018f0(uVar2,0x3c4ce800);
  uVar3 = FUN_ffa01716(uVar3,0x3daaaaaa);
  uVar2 = FUN_ffa018f0(uVar3,uVar2);
  uVar2 = FUN_ffa018f0(uVar2,uVar1);
  uVar3 = FUN_ffa018f0(uVar2,0x3ee2a8ed);
  uVar2 = FUN_ffa01716(uVar3,uVar2);
  uVar3 = FUN_ffa018f0(uVar1,0x3ee2a8ed);
  uVar2 = FUN_ffa01716(uVar3,uVar2);
  uVar1 = FUN_ffa01716(uVar2,uVar1);
  uVar2 = FUN_ffa01688((((int)param_1 >> 0x17) + -0x7e) * 0x10 - iVar8);
  uVar2 = FUN_ffa018f0(uVar2,0x3d800000);
  uVar3 = FUN_ffa018f0(0x41800000,param_2);
  FUN_ffa01bbc(uVar3,&stack0x00000008);
  uVar3 = FUN_ffa018f0(in_stack_00000008,0x3d800000);
  uVar4 = FUN_ffa01714(param_2,uVar3);
  uVar4 = FUN_ffa018f0(uVar4,uVar2);
  uVar1 = FUN_ffa018f0(param_2,uVar1);
  uVar1 = FUN_ffa01716(uVar1,uVar4);
  uVar4 = FUN_ffa018f0(uVar1,0x41800000);
  FUN_ffa01bbc(uVar4,&stack0x00000004);
  uVar4 = FUN_ffa018f0(0x3d800000,in_stack_00000004);
  uVar1 = FUN_ffa01714(uVar1,uVar4);
  uVar2 = FUN_ffa018f0(uVar2,uVar3);
  uVar2 = FUN_ffa01716(uVar2,uVar4);
  uVar3 = FUN_ffa018f0(uVar2,0x41800000);
  FUN_ffa01bbc(uVar3,&stack0x00000004);
  uVar3 = FUN_ffa018f0(uVar4,0x3d800000);
  uVar4 = FUN_ffa01714(uVar2,uVar3);
  uVar1 = FUN_ffa01716(uVar4,uVar1);
  uVar4 = FUN_ffa018f0(uVar1,0x41800000);
  FUN_ffa01bbc(uVar4,&stack0x00000000);
  uVar2 = FUN_ffa018f0(0x3d800000,uVar2);
  uVar3 = FUN_ffa01716(uVar2,uVar3);
  FUN_ffa018f0(uVar3,0x41800000);
  iVar8 = FUN_ffa014dc();
  uVar5 = FUN_ffa01714(uVar1,uVar2);
  if (iVar8 < 0x7ff) {
    if (uVar5 != 0 && ((int)uVar5 < 0x7f800001 && (uVar5 & 0x80000000) == 0)) {
      uVar5 = FUN_ffa01714(uVar5,0x3d800000);
      iVar8 = iVar8 + 1;
    }
    if (-0x7e0 < iVar8) {
      iVar6 = (int)(iVar8 + ((uint)(iVar8 >> 0x1f) >> 0x1c)) >> 4;
      iVar7 = iVar6 + 1;
      if (iVar8 < 0) {
        iVar7 = iVar6;
      }
      uVar1 = FUN_ffa018f0(0x3aab1518,uVar5);
      uVar1 = FUN_ffa01716(uVar1,0x3c1d8d4b);
      uVar1 = FUN_ffa018f0(uVar1,uVar5);
      uVar1 = FUN_ffa01716(uVar1,0x3d635837);
      uVar1 = FUN_ffa018f0(uVar1,uVar5);
      uVar1 = FUN_ffa01716(uVar1,0x3e75fdf0);
      uVar1 = FUN_ffa018f0(uVar1,uVar5);
      uVar1 = FUN_ffa01716(uVar1,0x3f317218);
      uVar2 = FUN_ffa018f0(uVar1,uVar5);
      uVar1 = *(undefined4 *)
               (s_____zyxwwvutssrqqpoonmmlkkjjiihg_ff8034de +
               ((iVar7 * 0x10 - iVar8) + 1) * 4 + 0xbe);
      uVar2 = FUN_ffa018f0(uVar2,uVar1);
      FUN_ffa01716(uVar2,uVar1);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
    uVar1 = FUN_ffa01cb2(0);
    return uVar1;
  }
  uVar1 = 0x7f7fffff;
  if (local_18 == 1) {
    uVar1 = 0xff7fffff;
  }
  uVar1 = FUN_ffa01cb2(uVar1);
  return uVar1;
}


