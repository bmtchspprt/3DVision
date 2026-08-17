
void FUN_2020e000(int param_1,int param_2)

{
  undefined1 unaff_R7_B;
  int unaff_P4;
  int unaff_FP;
  
  if ((param_1 == param_2) || (param_1 == 0x20)) {
    *(undefined1 *)(unaff_P4 + -0x91) = unaff_R7_B;
    *(undefined1 *)(unaff_P4 + -0x92) = unaff_R7_B;
    FUN_2020caa4(0);
  }
  else if (*(char *)(*(int *)(unaff_FP + 0x10) + 1) == '\x01') {
    FUN_2020caa4(2);
  }
  else {
    FUN_2020caa4(3);
  }
  return;
}


