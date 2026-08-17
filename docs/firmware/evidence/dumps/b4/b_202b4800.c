
bool FUN_202b4800(int param_1,int param_2)

{
  bool bVar1;
  
  if (((2 < param_1) || (bVar1 = true, ((uint)*(byte *)(param_2 + 0x32) & 1 << param_1) == 0)) &&
     (bVar1 = false, 2 < param_1)) {
    bVar1 = ((uint)*(byte *)(param_2 + 0x2f) & 1 << param_1 + -3) != 0;
  }
  return bVar1;
}


