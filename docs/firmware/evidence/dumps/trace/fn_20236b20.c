
undefined4 FUN_20236b20(int param_1)

{
  undefined4 uVar1;
  
  uVar1 = 0x40130001;
  if (param_1 != 0) {
    uVar1 = 0x40130002;
    DAT_20236514 = *(byte **)(param_1 + 0x14);
    if (*DAT_20236514 < 0x36) {
      FUN_202369ee(DAT_20236514);
      uVar1 = 0;
      DAT_20236510 = 0;
    }
  }
  return uVar1;
}


