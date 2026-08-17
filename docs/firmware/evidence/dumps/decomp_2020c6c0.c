
/* WARNING: Control flow encountered unimplemented instructions */
/* WARNING: Removing unreachable block (ram,0x2020c7b6) */
/* WARNING: Removing unreachable block (ram,0x2020c7e4) */
/* WARNING: Removing unreachable block (ram,0x2020c76a) */
/* WARNING: Removing unreachable block (ram,0x2020c776) */
/* WARNING: Removing unreachable block (ram,0x2020c7d4) */
/* WARNING: Removing unreachable block (ram,0x2020c7d8) */
/* WARNING: Removing unreachable block (ram,0x2020c7da) */
/* WARNING: Removing unreachable block (ram,0x2020c78a) */
/* WARNING: Removing unreachable block (ram,0x2020c78e) */
/* WARNING: Removing unreachable block (ram,0x2020c7cc) */
/* WARNING: Removing unreachable block (ram,0x2020c7d0) */
/* WARNING: Removing unreachable block (ram,0x2020c7d2) */
/* WARNING: Removing unreachable block (ram,0x2020c79e) */
/* WARNING: Removing unreachable block (ram,0x2020c7a2) */
/* WARNING: Removing unreachable block (ram,0x2020c7b0) */
/* WARNING: Removing unreachable block (ram,0x2020c7b2) */
/* WARNING: Removing unreachable block (ram,0x2020c7b8) */
/* WARNING: Removing unreachable block (ram,0x2020c7bc) */

undefined4
FUN_2020c6c0(undefined4 *param_1,int param_2,int param_3,int param_4,undefined4 param_5,int param_6,
            undefined4 param_7,undefined4 param_8)

{
  uint uVar1;
  int iVar2;
  undefined4 *puVar3;
  undefined1 in_AZflag;
  
  uVar1 = FUN_202ffbe6(param_2,param_3,param_4,param_5,param_7,param_8);
  if ((param_6 == 0) || ((param_6 != 1 && (param_6 != 3)))) {
    if (param_3 < param_2) {
      FUN_ffa05ee4(param_4 - param_2,param_4 - param_3);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
      halt_unimplemented();
    }
  }
  else if (uVar1 < 100000) {
    FUN_ffa05ee4();
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
  iVar2 = 0x14;
  puVar3 = param_1;
  if (((uint)param_1 & 1) == 0) {
    iVar2 = 10;
    if ((bool)in_AZflag) {
      iVar2 = 5;
      do {
        *puVar3 = 0x1010101;
        if (iVar2 == 0) break;
        iVar2 = iVar2 + -1;
        puVar3 = puVar3 + 1;
      } while (iVar2 != 0);
    }
    else {
      do {
        *(undefined2 *)puVar3 = 0x101;
        if (iVar2 == 0) break;
        iVar2 = iVar2 + -1;
        puVar3 = (undefined4 *)((int)puVar3 + 2);
      } while (iVar2 != 0);
    }
  }
  else {
    do {
      *(undefined1 *)puVar3 = 1;
      if (iVar2 == 0) break;
      iVar2 = iVar2 + -1;
      puVar3 = (undefined4 *)((int)puVar3 + 1);
    } while (iVar2 != 0);
  }
  *(undefined1 *)(param_1 + 5) = 0;
  return 0x14;
}


