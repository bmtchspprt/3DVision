
/* WARNING: Control flow encountered unimplemented instructions */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_20210be6(undefined4 param_1,int param_2)

{
  undefined *puVar1;
  undefined *puVar2;
  undefined *puVar3;
  
  DAT_20215048 = 0x30002;
  DAT_20215058 = 4;
  DAT_2021504c = 0x40004;
  DAT_20215050 = 0x40004;
  DAT_20215054 = 0x40004;
  _DAT_20215044 = 0x10000;
  *(undefined ***)(param_2 + 0x4cc) = &PTR_DAT_202d2850;
  puVar1 = PTR_DAT_202d2850;
  *(undefined2 **)(param_2 + 0x4d0) = &DAT_20215044;
  puVar2 = PTR_DAT_202d2854;
  *(undefined **)(param_2 + 0x500) = &DAT_202d2d7c;
  *(undefined4 **)(param_2 + 0x4d4) = &DAT_20215030;
  puVar3 = PTR_DAT_202d2858;
  *(undefined2 *)(puVar1 + 0x5774) = 10;
  puVar1 = PTR_DAT_202d285c;
  *(undefined2 *)(puVar2 + 0x5774) = 10;
  puVar2 = PTR_DAT_202d2860;
  *(undefined2 *)(puVar3 + 0x5774) = 0xb;
  *(undefined2 *)(puVar1 + 0x5774) = 0xc;
  *(undefined2 *)(puVar2 + 0x5774) = 0xc;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


