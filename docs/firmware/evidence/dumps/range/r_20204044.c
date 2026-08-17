
void FUN_20204044(int param_1)

{
  int iVar1;
  uint uVar2;
  bool bVar3;
  int iVar4;
  
  FUN_ffa06008(100000,0,0);
  FUN_ffa06bd2(0x12);
  FUN_ffa06008(500000,0,1);
  FUN_ffa05f92(&DAT_202046a8,*(int *)(param_1 + 0xd8) + 0x10,4);
  FUN_ffa06008(100000,0,0);
  FUN_ffa06a94(0xf0000,4,&DAT_202046a8);
  uVar2 = 0xf0004;
  iVar4 = 0;
  iVar1 = 0;
  while( true ) {
    FUN_ffa06008(100000,0,1);
    if ((*(short *)(*(int *)(param_1 + 0xf8) + 0x34a54) <= iVar1) || (0xfffff < uVar2 + 0x522))
    break;
    FUN_ffa05f92(&DAT_202046a8,*(int *)(param_1 + 0xf8) + iVar4 + 0x6268,4);
    FUN_ffa05f92(&DAT_202046ac,*(int *)(param_1 + 0xf8) + iVar4 + 0x52d4,0x51e);
    FUN_ffa06008(100000,0,0);
    FUN_ffa06a94(uVar2,0x522,&DAT_202046a8);
    uVar2 = uVar2 + 0x522;
    iVar4 = iVar4 + 0x5cfc;
    iVar1 = iVar1 + 1;
  }
  iVar1 = 0;
  iVar4 = 0;
  while( true ) {
    bVar3 = *(short *)(*(int *)(param_1 + 0xf8) + 0x34a54) <= iVar1;
    iVar1 = iVar1 + 1;
    if ((bVar3) || (0xfffff < uVar2 + 0x292)) break;
    FUN_ffa05f92(&DAT_202046a8,*(int *)(param_1 + 0xf8) + iVar4 + 0x6270,4);
    FUN_ffa05f92(&DAT_202046ac,*(int *)(param_1 + 0xf8) + iVar4 + 0x5f9e,0x28e);
    FUN_ffa06008(100000,0,0);
    FUN_ffa06a94(uVar2,0x292,&DAT_202046a8);
    FUN_ffa06008(100000,0,1);
    uVar2 = uVar2 + 0x292;
    iVar4 = iVar4 + 0x5cfc;
  }
  return;
}


