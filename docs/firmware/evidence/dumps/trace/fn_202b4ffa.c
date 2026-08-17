
void FUN_202b4ffa(char *param_1)

{
  char *pcVar1;
  int iVar2;
  
  if (*param_1 == '\0') {
LAB_202b5018:
    FUN_202b4b54(param_1);
    return;
  }
  pcVar1 = param_1 + 1;
  do {
    iVar2 = -1;
    param_1 = pcVar1;
    do {
      pcVar1 = param_1 + 1;
      if (*param_1 == '\0') goto LAB_202b5018;
    } while ((iVar2 != 0) && (iVar2 = iVar2 + -1, param_1 = pcVar1, iVar2 != 0));
  } while( true );
}


