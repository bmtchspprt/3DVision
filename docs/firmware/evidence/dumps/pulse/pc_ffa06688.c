
/* WARNING: Control flow encountered unimplemented instructions */

undefined8
FUN_ffa06688(undefined2 *param_1,int param_2,undefined4 param_3,undefined4 param_4,int param_5)

{
  undefined2 uVar1;
  int iVar2;
  int iVar3;
  uint uVar4;
  int iVar5;
  undefined2 *puVar6;
  undefined2 *puVar7;
  undefined2 *puVar8;
  int iVar9;
  int iVar10;
  
  param_5 = 1 << param_5;
  uVar4 = 0;
  iVar3 = param_5 + -1;
  if (iVar3 < 1) {
LAB_ffa06710:
    if (1 < param_5) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
                    /* WARNING: Treating indirect jump as return */
    return 0;
  }
  iVar5 = 1;
  iVar10 = iVar3;
  puVar8 = param_1;
LAB_ffa066cc:
  puVar8 = puVar8 + 1;
  iVar2 = param_5;
  do {
    iVar9 = -1;
    do {
      iVar2 = iVar2 >> 1;
      if ((int)(uVar4 + iVar2) <= iVar3) {
        uVar4 = iVar2 + (uVar4 & iVar2 - 1U);
        if (iVar5 < (int)uVar4) {
          uVar1 = *puVar8;
          puVar7 = (undefined2 *)((int)puVar8 + (param_2 - (int)param_1));
          *puVar8 = param_1[uVar4];
          param_1[uVar4] = uVar1;
          puVar6 = (undefined2 *)(param_2 + uVar4 * 2);
          uVar1 = *puVar7;
          puVar8 = (undefined2 *)((int)puVar7 + ((int)param_1 - param_2));
          *puVar7 = *puVar6;
          *puVar6 = uVar1;
        }
        iVar5 = iVar5 + 1;
        if ((iVar10 == 0) || (iVar10 = iVar10 + -1, iVar10 == 0)) goto LAB_ffa06710;
        goto LAB_ffa066cc;
      }
    } while ((iVar9 != 0) && (iVar9 = iVar9 + -1, iVar9 != 0));
  } while( true );
}


