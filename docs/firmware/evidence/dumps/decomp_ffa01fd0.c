/* FUN_ffa01fd0 @ ffa01fd0 */

uint FUN_ffa01fd0(uint param_1,char param_2,uint param_3)

{
  uint uVar1;
  undefined4 unaff_R5;
  char unaff_R6_B;
  int in_stack_00000034;
  
  uVar1 = param_1 & param_3 |
          (uint)(byte)(unaff_R6_B + param_2 + (char)((uint)unaff_R5 >> 0x10) + 0x7f) << 0x17;
  if (in_stack_00000034 != 0) {
    uVar1 = uVar1 ^ 0x80000000;
  }
  return uVar1;
}


