
void FUN_202b5000(void)

{
  char *in_P1;
  char *pcVar1;
  int iVar2;
  
  if (*in_P1 == '\0') {
LAB_202b5018:
    FUN_202b4b54(in_P1);
    return;
  }
  pcVar1 = in_P1 + 1;
  do {
    iVar2 = -1;
    in_P1 = pcVar1;
    do {
      pcVar1 = in_P1 + 1;
      if (*in_P1 == '\0') goto LAB_202b5018;
    } while ((iVar2 != 0) && (iVar2 = iVar2 + -1, in_P1 = pcVar1, iVar2 != 0));
  } while( true );
}


