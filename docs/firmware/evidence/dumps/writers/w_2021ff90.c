/* seed 2021ff90 */

void FUN_2021ff90(undefined4 param_1,int param_2,int param_3)

{
  undefined4 uVar1;
  undefined4 uVar2;
  int in_R3;
  int iVar3;
  undefined4 unaff_R7;
  int in_P0;
  short *in_P1;
  short *in_P2;
  undefined2 *unaff_P4;
  
  do {
    param_2 = param_2 + in_R3;
    param_3 = param_3 + *in_P2;
    in_R3 = (int)*in_P1;
    if (in_P0 == 0) break;
    in_P0 = in_P0 + -1;
    in_P1 = in_P1 + 1;
    in_P2 = in_P2 + 1;
  } while (in_P0 != 0);
  *(int *)(unaff_P4 + 8) = param_3;
  *(int *)(unaff_P4 + 6) = param_2 + in_R3;
  *unaff_P4 = (short)((uint)unaff_R7 >> 0x10);
  iVar3 = *(int *)(unaff_P4 + 8);
  if (0 < iVar3) {
    uVar1 = FUN_ffa01688(*(undefined4 *)(unaff_P4 + 6));
    uVar2 = FUN_ffa01688(iVar3);
    FUN_ffa01814(uVar1,uVar2);
  }
  return;
}


