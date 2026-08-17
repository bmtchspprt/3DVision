/* FUN_ffa01814 @ ffa01814 */

/* WARNING: Control flow encountered unimplemented instructions */

uint FUN_ffa01814(uint param_1,uint param_2)

{
  uint uVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  bool in_AZflag;
  
  uVar1 = param_1 & 0x7fffffff;
  uVar3 = param_2 & 0x7fffffff;
  uVar4 = uVar3 >> 0x17;
  if (uVar1 >> 0x17 == 0xff) {
    if (0xfe < uVar4 || !in_AZflag) {
      return 0xffffffff;
    }
  }
  else {
    if (uVar4 == 0xff) {
      if (uVar1 != 0 || !in_AZflag) {
        return 0xffffffff;
      }
      uVar2 = 0;
      goto LAB_ffa018e2;
    }
    if (uVar3 == 0) {
      if (uVar1 == 0) {
        return 0xffffffff;
      }
    }
    else {
      uVar2 = uVar1;
      if (((uVar1 == 0) || (uVar3 == 0x3f800000)) || (uVar2 = 0x3f800000, uVar1 == uVar3))
      goto LAB_ffa018e2;
      if ((int)(((uVar1 >> 0x17) - uVar4) + 0x7f) < 0x100) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
    }
  }
  uVar2 = 0x7f800000;
LAB_ffa018e2:
  return uVar2 | (param_1 ^ param_2) & 0x80000000;
}


