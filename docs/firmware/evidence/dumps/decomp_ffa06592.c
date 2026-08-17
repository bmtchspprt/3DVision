/* FUN_ffa06592 @ ffa06592 */

void FUN_ffa06592(void)

{
  bool bVar1;
  bool bVar2;
  undefined4 unaff_R5;
  int unaff_R7;
  undefined4 *puVar3;
  undefined2 unaff_P4_L;
  char *pcVar4;
  int unaff_FP;
  int in_stack_00000030;
  
  puVar3 = (undefined4 *)0x202376c0;
  pcVar4 = (char *)0x2023651c;
  bVar2 = true;
  do {
    bVar1 = bVar2;
    if (*pcVar4 != '\0') {
      *(int *)(pcVar4 + 4) = *(int *)(pcVar4 + 4) + 1;
      func_0xffa086ca(*puVar3,unaff_FP + 8);
      if (in_stack_00000030 == 0) {
        *(int *)(pcVar4 + 8) = *(int *)(pcVar4 + 8) + 1;
      }
      bVar1 = false;
      if (5 < *(int *)(pcVar4 + 4)) {
        if ((*(int *)(pcVar4 + 8) < 4) || (in_stack_00000030 != 0)) {
          *pcVar4 = (char)unaff_R5;
          func_0xffa08888(*puVar3,6);
        }
        else {
          *(undefined4 *)CONCAT22(0x2020,unaff_P4_L) = *puVar3;
          cRam2020c82c = (char)unaff_R5;
          func_0xffa02ed4(0x40130008);
          func_0xffa08888(*puVar3,2);
        }
        func_0xffa08874(*puVar3,0x4200012);
        *(undefined4 *)(pcVar4 + 8) = unaff_R5;
        *(undefined4 *)(pcVar4 + 4) = unaff_R5;
        bVar1 = bVar2;
      }
    }
    unaff_R7 = unaff_R7 + -1;
    puVar3 = puVar3 + 1;
    pcVar4 = pcVar4 + 0xc;
    bVar2 = bVar1;
  } while (unaff_R7 != 0);
  if (bVar1) {
    func_0xffa0b610(0x18000008,0x70018,0);
  }
  return;
}


