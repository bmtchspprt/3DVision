
/* WARNING: Control flow encountered unimplemented instructions */

undefined4 FUN_ffa00da4(uint param_1)

{
  undefined4 uVar1;
  int iVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  int iVar6;
  int iVar7;
  byte in_AC0flag;
  undefined8 uVar8;
  undefined8 uVar9;
  
  param_1 = param_1 & 0x7fffffff;
  if (param_1 < 0x47c90e01) {
    uVar1 = FUN_ffa018f0(0x3ea2f983,param_1);
    FUN_ffa01716(uVar1,0x3f800000);
    iVar2 = FUN_ffa014dc();
    uVar5 = (uint)(0x46c90fda < param_1);
    iVar7 = uVar5 * 0x10;
    uVar8 = FUN_ffa01564(param_1,uVar5 * -2 + 0x30);
    uVar3 = (uint)((ulonglong)uVar8 >> 0x20);
    uVar9 = FUN_ffa01c38(iVar2,iVar2 >> 0x1f,*(undefined4 *)(&DAT_ff803488 + iVar7),
                         *(undefined4 *)(&DAT_ff80348c + iVar7));
    uVar4 = (uint)((ulonglong)uVar9 >> 0x20);
    iVar6 = (uVar3 - uVar4) + *(int *)(&DAT_ff803490 + iVar7);
    iVar2 = (((int)uVar8 - (uint)(uVar3 < uVar4)) - (int)uVar9) + (uint)in_AC0flag +
            *(int *)(&DAT_ff803494 + iVar7);
    FUN_ffa015b4(iVar6,iVar2);
    FUN_ffa004c0(iVar6,iVar2,uVar5 * 2 + -0x12);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
    halt_unimplemented();
  }
                    /* WARNING: Treating indirect jump as return */
  return 0;
}


