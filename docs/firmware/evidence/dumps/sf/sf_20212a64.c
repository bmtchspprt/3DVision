
void FUN_20212a64(int param_1,int param_2,int param_3)

{
  undefined4 uVar1;
  undefined4 uVar2;
  
  if (*(char *)(param_2 + 0x30) == '\0') {
    if (*(int *)(param_3 + 0x528) < param_1) {
      if (*(int *)(param_3 + 0x52c) < param_1) {
        uVar1 = FUN_ffa02894(param_1 + 0x20c49b);
        uVar2 = FUN_ffa02894(*(int *)(param_3 + 0x52c) + 0x20c49b);
        uVar1 = FUN_ffa01814(uVar1,uVar2);
        uVar1 = FUN_ffa01c74(uVar1,0x3f800000);
        FUN_ffa018f0(uVar1,*(undefined4 *)(param_3 + 0x534));
      }
      else {
        uVar1 = FUN_ffa02894();
        uVar2 = FUN_ffa02894(*(int *)(param_3 + 0x528) + 0x20c49b);
        uVar1 = FUN_ffa01814(uVar1,uVar2);
        uVar1 = FUN_ffa01c74(uVar1,0x3fc00000);
        FUN_ffa018f0(uVar1,*(undefined4 *)(param_3 + 0x530));
      }
    }
    else {
      uVar1 = FUN_ffa02894(param_1 + 0x20c49b);
      uVar1 = FUN_ffa018f0(uVar1,0x447a0000);
      FUN_ffa01c74(uVar1,0x40000000);
    }
  }
  else {
    uVar1 = FUN_ffa02894(param_1 + 0x20c49b);
    uVar1 = FUN_ffa018f0(uVar1,0x447a0000);
    uVar2 = FUN_ffa016d4(*(undefined1 *)(param_2 + 0x30));
    uVar2 = FUN_ffa01814(uVar2,0x40000000);
    FUN_ffa01c74(uVar1,uVar2);
  }
  return;
}


