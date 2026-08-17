
/* WARNING: Control flow encountered unimplemented instructions */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined4 FUN_ffa06008(int param_1,int param_2)

{
  bool in_AZflag;
  uint local_5c;
  int local_58;
  
  _DAT_ffc00208 = 0;
  if (param_2 != 0) {
    DAT_ff806eec = param_2;
  }
  if (param_1 == 0) {
    while( true ) {
      if ((DAT_ff806ee0 & 1) != 0) {
        DAT_ff806ee0 = DAT_ff806ee0 & 0xfffffffe;
        _DAT_ffc00208 = 0;
        return 1;
      }
      if ((DAT_ff806ee0 & 2) != 0) break;
      if ((DAT_ff806ee0 & 0x20) != 0) {
        DAT_ff806ee0 = DAT_ff806ee0 & 0xffffffdf;
        return 0x20;
      }
    }
    DAT_ff806ee0 = DAT_ff806ee0 & 0xfffffffd;
    _DAT_ffc00208 = 0;
    return 2;
  }
  if (DAT_ff801a30 == 0xffffffff && in_AZflag) {
    local_5c = DAT_ff802e80;
    local_58 = DAT_ff802e84;
  }
  else {
    local_58 = (int)DAT_ff801a30 >> 0x1f;
    local_5c = DAT_ff801a30;
  }
  FUN_ffa01150(DAT_ff802e88,DAT_ff802e8c,local_58 << 0xd | local_5c >> 0x13,local_58 >> 0x13);
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
  halt_unimplemented();
}


