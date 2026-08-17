
void FUN_ffa06ccc(int param_1,int param_2,int param_3)

{
  int iVar1;
  
  param_1 = param_1 + param_2;
  if (param_1 < param_3) {
LAB_ffa06ce4:
    if (-1 < param_1) {
      return;
    }
    do {
      iVar1 = -1;
      do {
        param_1 = param_3 + param_1;
        if (-1 < param_1) {
          return;
        }
      } while ((iVar1 != 0) && (iVar1 = iVar1 + -1, iVar1 != 0));
    } while( true );
  }
  do {
    iVar1 = -1;
    do {
      param_1 = param_1 - param_3;
      if (param_1 < param_3) goto LAB_ffa06ce4;
    } while ((iVar1 != 0) && (iVar1 = iVar1 + -1, iVar1 != 0));
  } while( true );
}


