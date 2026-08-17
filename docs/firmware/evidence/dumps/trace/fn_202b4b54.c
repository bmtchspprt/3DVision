
void FUN_202b4b54(char *param_1,char *param_2)

{
  char *pcVar1;
  char *pcVar2;
  int iVar3;
  
  if (*param_2 != '\0') {
    do {
      iVar3 = -1;
      pcVar1 = param_1;
      pcVar2 = param_2;
      do {
        param_2 = pcVar2 + 1;
        param_1 = pcVar1 + 1;
        *pcVar1 = *pcVar2;
        if (*param_2 == '\0') goto LAB_202b4b74;
      } while ((iVar3 != 0) && (iVar3 = iVar3 + -1, pcVar1 = param_1, pcVar2 = param_2, iVar3 != 0))
      ;
    } while( true );
  }
LAB_202b4b74:
  *param_1 = *param_2;
  return;
}


