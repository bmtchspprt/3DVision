
/* WARNING: Control flow encountered unimplemented instructions */

uint FUN_ffa020d4(uint param_1)

{
  undefined4 uVar1;
  int iVar2;
  int iVar3;
  uint uVar4;
  int iVar5;
  uint uVar6;
  undefined8 uVar7;
  undefined8 uVar8;
  
  uVar6 = param_1 & 0x7fffffff;
  if (0x47c90e00 < uVar6) {
                    /* WARNING: Treating indirect jump as return */
    return 0;
  }
  if (0x39b504f3 < uVar6) {
    uVar1 = FUN_ffa018f0(0x3ea2f983,uVar6);
    FUN_ffa01716(uVar1,0x3f000000);
    iVar2 = FUN_ffa014dc();
    iVar5 = (uint)(0x46c90fda < uVar6) * 2;
    if (iVar2 < 1) {
      FUN_ffa01564(uVar6,0x1e);
    }
    else {
      iVar3 = (iVar5 >> 1) * 8;
      uVar7 = FUN_ffa01564(uVar6,(uint)(0x46c90fda < uVar6) * -2 + 0x30);
      uVar6 = (uint)((ulonglong)uVar7 >> 0x20);
      uVar8 = FUN_ffa01c38(iVar2,0,*(undefined4 *)(&DAT_ff803608 + iVar3),
                           *(undefined4 *)(&DAT_ff80360c + iVar3));
      uVar4 = (uint)((ulonglong)uVar8 >> 0x20);
      iVar2 = uVar6 - uVar4;
      iVar3 = ((int)uVar7 - (uint)(uVar6 < uVar4)) - (int)uVar8;
      FUN_ffa015b4(iVar2,iVar3);
      FUN_ffa004c0(iVar2,iVar3,iVar5 + -0x12);
    }
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
                    /* WARNING: Treating indirect jump as return */
  return param_1;
}


