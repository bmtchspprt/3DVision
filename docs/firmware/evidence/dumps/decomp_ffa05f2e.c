/* FUN_ffa05f2e @ ffa05f2e */

uint * FUN_ffa05f2e(uint *param_1,uint param_2,uint param_3)

{
  uint *puVar1;
  uint uVar2;
  undefined2 uVar3;
  uint uVar4;
  uint *puVar5;
  bool in_AZflag;
  uint *puVar6;
  
  if ((int)param_3 < 1) {
    return param_1;
  }
  puVar1 = param_1;
  if (!in_AZflag) {
    do {
      *(char *)puVar1 = (char)param_2;
      if (param_3 == 0) {
        return param_1;
      }
      param_3 = param_3 - 1;
      puVar1 = (uint *)((int)puVar1 + 1);
    } while (param_3 != 0);
    return param_1;
  }
  if (param_3 == 1) goto LAB_ffa05f78;
  uVar4 = param_2 | param_2 << 8;
  uVar2 = (int)param_3 >> 1;
  puVar1 = (uint *)((int)param_1 << 0x1e);
  uVar3 = (undefined2)uVar4;
  puVar5 = param_1;
  if (in_AZflag) {
    if (uVar2 != 1) {
      puVar1 = (uint *)((int)param_3 >> 2);
      uVar4 = CONCAT22(uVar3,uVar3);
      puVar6 = puVar1;
      do {
        param_1 = puVar5 + 1;
        *puVar5 = uVar4;
        if (puVar6 == (uint *)0x0) break;
        puVar6 = (uint *)((int)puVar6 + -1);
        puVar5 = param_1;
      } while (puVar6 != (uint *)0x0);
      puVar5 = param_1;
      if ((uVar2 & 1) != 1) goto LAB_ffa05f74;
    }
    param_1 = (uint *)((int)puVar5 + 2);
    *(short *)puVar5 = (short)uVar4;
  }
  else {
    do {
      param_1 = (uint *)((int)puVar5 + 2);
      *(undefined2 *)puVar5 = uVar3;
      if (uVar2 == 0) break;
      uVar2 = uVar2 - 1;
      puVar5 = param_1;
    } while (uVar2 != 0);
  }
LAB_ffa05f74:
  if ((param_3 & 1) != 1) {
    return puVar1;
  }
LAB_ffa05f78:
  *(char *)param_1 = (char)param_2;
  return puVar1;
}


