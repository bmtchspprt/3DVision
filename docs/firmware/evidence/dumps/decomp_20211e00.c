
undefined1 FUN_20211e00(void)

{
  int iVar1;
  int iVar2;
  int in_P1;
  int in_P3;
  int unaff_P4;
  int unaff_FP;
  
  iVar2 = *(int *)(unaff_FP + 0x18);
  iVar1 = *(int *)(*(int *)(in_P1 + 0x14) + 8) - *(int *)(in_P3 + 0x18);
  *(int *)(in_P3 + 8) = iVar1;
  *(int *)(in_P3 + 0x10) = *(int *)(*(int *)(iVar2 + 0x14) + 0xc) - *(int *)(in_P3 + 0x18);
  if (*(int *)(in_P3 + 0xc) < iVar1) {
    *(int *)(in_P3 + 8) = *(int *)(in_P3 + 0xc);
  }
  if (*(int *)(in_P3 + 8) < *(int *)(in_P3 + 0x10)) {
    *(int *)(in_P3 + 0x10) = *(int *)(in_P3 + 8);
  }
  else if (*(int *)(in_P3 + 0x10) < *(int *)(in_P3 + 0x14)) {
    *(int *)(in_P3 + 0x10) = *(int *)(in_P3 + 0x14);
  }
  return *(undefined1 *)(unaff_P4 + 0x522);
}


