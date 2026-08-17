/* seed 2022e104 */

/* WARNING: Control flow encountered unimplemented instructions */

void FUN_2022e104(undefined4 param_1,short param_2,undefined4 param_3)

{
  short sVar1;
  short in_R3_L;
  int in_P0;
  short *in_P1;
  short *in_P2;
  short *psVar2;
  undefined4 *in_P3;
  
  do {
    sVar1 = in_R3_L + param_2;
    param_2 = *in_P1;
    psVar2 = in_P2 + 1;
    *in_P2 = sVar1;
    if (in_P0 == 0) break;
    in_P0 = in_P0 + -1;
    in_P1 = in_P1 + 1;
    in_P2 = psVar2;
  } while (in_P0 != 0);
  *psVar2 = in_R3_L + param_2;
  *in_P3 = param_3;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


