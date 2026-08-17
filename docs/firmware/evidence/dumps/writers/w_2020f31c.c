/* seed 2020f31c */

void FUN_2020f31c(void)

{
  undefined2 *in_P0;
  undefined2 *puVar1;
  undefined2 *in_P1;
  undefined2 *in_P2;
  int unaff_P5;
  
  do {
    puVar1 = in_P0 + 1;
    *in_P0 = *in_P2;
    in_P0 = in_P0 + 2;
    *puVar1 = *in_P1;
    if (unaff_P5 == 0) {
      return;
    }
    unaff_P5 = unaff_P5 + -1;
    in_P1 = in_P1 + 1;
    in_P2 = in_P2 + 1;
  } while (unaff_P5 != 0);
  return;
}


