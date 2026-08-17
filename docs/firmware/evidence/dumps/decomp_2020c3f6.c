
uint FUN_2020c3f6(int param_1,undefined1 *param_2,uint param_3,int param_4,undefined4 param_5,
                 undefined4 param_6,int param_7)

{
  int iVar1;
  int iVar2;
  char *pcVar3;
  int iVar4;
  char extraout_R1_B;
  char extraout_R1_B_00;
  uint uVar5;
  undefined1 *puVar6;
  undefined1 *puVar7;
  int *piVar8;
  int iVar9;
  code *UNRECOVERED_JUMPTABLE_00;
  longlong lVar10;
  
  if (param_1 < 0) {
    param_1 = -param_1;
    *param_2 = 0x2d;
    puVar6 = param_2 + 1;
  }
  else {
    puVar6 = param_2;
    if (param_7 != 0) {
      puVar6 = param_2 + 1;
      *param_2 = 0x2b;
    }
  }
  lVar10 = FUN_ffa010a0(param_1,1000);
  iVar4 = (int)((ulonglong)lVar10 >> 0x20);
  piVar8 = &DAT_ff806efc;
  uVar5 = 0;
  iVar1 = iVar4;
  DAT_ff806efc = iVar4;
  if (0xffffffff < lVar10) {
    while( true ) {
      UNRECOVERED_JUMPTABLE_00 = (code *)0x2020c43c;
      iVar9 = -1;
      uVar5 = uVar5 + 1;
      iVar1 = FUN_ffa01038(iVar1,10);
                    /* WARNING: Could not recover jumptable at 0x2020c44c. Too many branches */
                    /* WARNING: Treating indirect jump as call */
      if (iVar1 < 1) break;
      if ((iVar9 != 0) && (iVar9 != 1)) {
        uVar5 = (*UNRECOVERED_JUMPTABLE_00)();
        return uVar5;
      }
    }
  }
  if (((int)param_3 <= (int)(char)uVar5) && (param_3 = 1, (char)uVar5 != 0)) {
    param_3 = uVar5;
  }
  iVar1 = (int)(char)((char)param_3 + -1);
  if (-1 < iVar1) {
    iVar9 = (int)(char)((char)param_3 + -2);
    iVar2 = iVar9 + 2;
    if (iVar9 < 0) {
      iVar2 = 1;
    }
    pcVar3 = puVar6 + iVar1;
    UNRECOVERED_JUMPTABLE_00 = (code *)0x2020c480;
    iVar1 = FUN_ffa010a0(iVar4,10);
                    /* WARNING: Could not recover jumptable at 0x2020c48e. Too many branches */
                    /* WARNING: Treating indirect jump as call */
    *pcVar3 = extraout_R1_B + '0';
    if ((iVar2 != 0) && (iVar2 != 1)) {
      uVar5 = (*UNRECOVERED_JUMPTABLE_00)();
      return uVar5;
    }
    *piVar8 = iVar1;
  }
  puVar7 = puVar6 + (param_3 & 0xff);
  if ((param_4 < 1) && (*piVar8 < 1)) {
    *puVar7 = 0;
  }
  else {
    iVar1 = (int)(char)param_4;
    *piVar8 = (int)lVar10;
    *puVar7 = 0x2e;
    if (iVar1 < 3) {
      iVar9 = 4 - (char)((char)param_4 + '\x01');
      UNRECOVERED_JUMPTABLE_00 = (code *)0x2020c4be;
      iVar4 = FUN_ffa00fb4((int)lVar10,10);
                    /* WARNING: Could not recover jumptable at 0x2020c4ca. Too many branches */
                    /* WARNING: Treating indirect jump as call */
      if ((iVar9 != 0) && (iVar9 != 1)) {
        uVar5 = (*UNRECOVERED_JUMPTABLE_00)();
        return uVar5;
      }
      *piVar8 = iVar4;
    }
    if (0 < iVar1) {
      iVar4 = (param_4 - 1U & 0xff) + 1;
      pcVar3 = puVar6 + (param_3 & 0xff) + iVar1;
      UNRECOVERED_JUMPTABLE_00 = (code *)0x2020c4ea;
      iVar1 = FUN_ffa010a0(*piVar8,10);
                    /* WARNING: Could not recover jumptable at 0x2020c4f8. Too many branches */
                    /* WARNING: Treating indirect jump as call */
      *pcVar3 = extraout_R1_B_00 + '0';
      if ((iVar4 != 0) && (iVar4 != 1)) {
        uVar5 = (*UNRECOVERED_JUMPTABLE_00)();
        return uVar5;
      }
      *piVar8 = iVar1;
    }
    param_3 = param_3 + param_4 + 1;
    puVar7[param_4 + 1] = 0;
  }
  FUN_202b4ffa(param_2,param_6);
  return param_3 & 0xff;
}


