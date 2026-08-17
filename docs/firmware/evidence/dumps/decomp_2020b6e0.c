/* FUN_2020b6e0 @ 2020b6e0 */

void FUN_2020b6e0(void)

{
  int unaff_R6;
  int unaff_R7;
  int unaff_P4;
  int unaff_P5;
  int unaff_FP;
  
  do {
    (*(code *)0xffa05f2e)(*(int *)(unaff_P4 + 0xf8) + unaff_R6 + unaff_P5 + 0x4d5c,0,0x51e);
    unaff_R7 = unaff_R7 + -1;
    *(undefined4 *)(*(int *)(unaff_P4 + 0xf8) + unaff_P5 + 0x6268) = *(undefined4 *)(unaff_FP + 8);
    unaff_P5 = unaff_P5 + 0x5cfc;
  } while (unaff_R7 != 0);
  func_0x2022477c(*(undefined4 *)(unaff_P4 + 0xf4),*(undefined4 *)(unaff_P4 + 0xf8),
                  *(undefined4 *)(unaff_P4 + 0xfc));
  return;
}


