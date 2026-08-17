
/* WARNING: Control flow encountered unimplemented instructions */

void FUN_2022d800(short *param_1,undefined4 param_2,uint param_3)

{
  short *psVar1;
  uint uVar2;
  short sVar3;
  short sVar4;
  int iVar5;
  undefined4 uVar6;
  short sVar7;
  undefined2 unaff_R7_L;
  short *psVar8;
  uint *in_P3;
  bool in_CCflag;
  bool in_AZflag;
  
  *(undefined2 *)in_P3 = unaff_R7_L;
  if (in_CCflag) {
    halt_unimplemented();
  }
  sVar7 = (short)in_P3[5];
  if (in_AZflag) {
    if (param_3 != 1) {
      iVar5 = (int)param_3 >> 1;
      uVar6 = *(undefined4 *)param_1;
      psVar1 = param_1;
      do {
        iVar5 = iVar5 + -1;
        psVar8 = psVar1;
        if (iVar5 == 0) break;
        param_1 = param_1 + 2;
        sVar3 = (short)uVar6;
        uVar2 = (uint)uVar6 >> 0x10;
        uVar6 = *(undefined4 *)param_1;
        psVar8 = psVar1 + 2;
        *(uint *)psVar1 = CONCAT22(sVar7 + (short)uVar2,sVar7 + sVar3);
        psVar1 = psVar8;
      } while (iVar5 != 0);
      param_1 = psVar8 + 2;
      *(uint *)psVar8 = CONCAT22(sVar7 + (short)((uint)uVar6 >> 0x10),sVar7 + (short)uVar6);
      if ((param_3 & 1) != 1) goto LAB_2022d84c;
    }
    *param_1 = sVar7 + *param_1;
  }
  else {
    sVar3 = *param_1;
    psVar1 = param_1;
    uVar2 = param_3;
    do {
      uVar2 = uVar2 - 1;
      psVar8 = psVar1;
      if (uVar2 == 0) break;
      param_1 = param_1 + 1;
      sVar4 = sVar7 + sVar3;
      sVar3 = *param_1;
      psVar8 = psVar1 + 1;
      *psVar1 = sVar4;
      psVar1 = psVar8;
    } while (uVar2 != 0);
    *psVar8 = sVar7 + sVar3;
  }
LAB_2022d84c:
  *in_P3 = param_3;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


