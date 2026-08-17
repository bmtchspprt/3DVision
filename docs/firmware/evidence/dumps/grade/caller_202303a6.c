
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_20230000(undefined4 param_1,undefined4 param_2,undefined4 param_3)

{
  byte bVar1;
  byte unaff_R4_B;
  int unaff_R5;
  undefined2 unaff_R6_L;
  int in_P3;
  int unaff_FP;
  
  *(undefined4 *)(in_P3 + 0x20) = param_3;
  *(undefined2 *)(in_P3 + -0xaa) = unaff_R6_L;
  if (unaff_R5 < *(int *)(unaff_FP + -0x5c)) {
    bVar1 = *(int *)(unaff_FP + -0x28) < 0x3f800000;
    if (*(int *)(unaff_FP + -8) < (int)(*(uint *)(unaff_FP + -0x28) & 0x7fffffff)) {
      bVar1 = unaff_R4_B;
    }
    if ((bVar1 & 1) == 1) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  if (*(int *)(in_P3 + 0x1c) < *(int *)(unaff_FP + -0x5c)) {
    bVar1 = (int)*(uint *)(in_P3 + 0x14) < 0x3f800000;
    if (*(int *)(unaff_FP + -8) < (int)(*(uint *)(in_P3 + 0x14) & 0x7fffffff)) {
      bVar1 = unaff_R4_B;
    }
    if ((bVar1 & 1) == 1) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


