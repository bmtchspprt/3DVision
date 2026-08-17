
undefined4 FUN_ffa03358(undefined4 param_1,undefined4 param_2,undefined4 param_3)

{
  undefined4 uVar1;
  undefined4 uVar2;
  undefined1 in_CCflag;
  
  FUN_ffa0165c(param_2,param_3);
  if ((bool)in_CCflag) {
    FUN_ffa01630(param_2,param_1);
    uVar1 = 0;
    if (!(bool)in_CCflag) {
      FUN_ffa01630(param_1,param_3);
      uVar1 = 0x3f800000;
      if (!(bool)in_CCflag) {
        uVar1 = FUN_ffa01714(param_1,param_2);
        uVar2 = FUN_ffa01714(param_3,param_2);
        uVar1 = FUN_ffa01814(uVar1,uVar2);
      }
    }
  }
  else {
    FUN_ffa0165c(param_3,param_2);
    uVar1 = 0x3f800000;
    if ((bool)in_CCflag) {
      FUN_ffa01630(param_1,param_2);
      uVar1 = 0;
      if ((!(bool)in_CCflag) &&
         (FUN_ffa01630(param_3,param_1), uVar1 = 0x3f800000, !(bool)in_CCflag)) {
        uVar1 = FUN_ffa01714(param_2,param_1);
        uVar2 = FUN_ffa01714(param_2,param_3);
        uVar1 = FUN_ffa01814(uVar1,uVar2);
      }
    }
  }
  return uVar1;
}


