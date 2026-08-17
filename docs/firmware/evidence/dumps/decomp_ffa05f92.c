
void FUN_ffa05f92(undefined1 *param_1,undefined1 *param_2,int param_3)

{
  if (0 < param_3) {
    do {
      *param_1 = *param_2;
      if (param_3 == 0) {
        return;
      }
      param_3 = param_3 + -1;
      param_2 = param_2 + 1;
      param_1 = param_1 + 1;
    } while (param_3 != 0);
  }
  return;
}


