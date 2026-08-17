
int FUN_ffa05c38(int param_1,undefined4 param_2,int param_3)

{
  short sVar1;
  int iVar2;
  short sVar3;
  int *piVar4;
  int *piVar5;
  ushort *puVar6;
  
  piVar4 = (int *)(param_3 + 0x548);
  puVar6 = &DAT_20215046;
  sVar1 = 0;
  do {
    sVar3 = sVar1;
    iVar2 = FUN_ffa05ee4(*(undefined4 *)((&PTR_DAT_202d2850)[*puVar6] + 0x57c0),41000);
    piVar5 = piVar4 + 1;
    iVar2 = FUN_ffa0586c(iVar2 + *piVar4,param_3);
    if (param_1 <= iVar2) break;
    piVar4 = piVar5;
    puVar6 = puVar6 + 1;
    sVar1 = sVar3 + 1;
  } while (sVar3 < 0xb);
  return (int)sVar3;
}


