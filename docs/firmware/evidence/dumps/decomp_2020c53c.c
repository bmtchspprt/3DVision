
void FUN_2020c53c(undefined4 param_1,undefined4 param_2,int param_3,undefined4 param_4,uint param_5,
                 int param_6)

{
  undefined4 uVar1;
  uint uVar2;
  char cVar3;
  undefined2 local_c;
  undefined1 local_a;
  
  local_a = DAT_ff80302e;
  local_c = DAT_ff80302c;
  switch(param_6 + -2) {
  case 0:
    FUN_202b4b54(&local_c,&DAT_ff803014);
    uVar1 = FUN_202ffa74(param_1,100000000);
    break;
  case 1:
    FUN_202b4b54(&local_c,&DAT_ff803018);
    uVar1 = FUN_202ffa74(param_1,1000000000);
    break;
  case 2:
    FUN_202b4b54(&local_c,&DAT_ff80301c);
    uVar1 = FUN_202ffa74(param_1,0x320fc7);
    break;
  case 3:
    FUN_202b4b54(&local_c,&DAT_ff803030);
    uVar1 = FUN_202ffa74(param_1,0x258bd5e);
    break;
  default:
    FUN_202b4b54(&local_c,&DAT_ff803010);
    uVar1 = FUN_202ffa74(param_1,1000000);
  }
  if (param_3 == 0) {
    uVar2 = 2;
    cVar3 = '\x03';
    if ((int)param_5 < 6) {
      uVar2 = param_5;
      cVar3 = '\x05' - (char)param_5;
    }
  }
  else {
    cVar3 = '\x01';
    uVar2 = 4;
    switch(param_6 + -2) {
    case 1:
      cVar3 = '\0';
      uVar2 = 5;
      break;
    case 2:
      cVar3 = '\x02';
      uVar2 = 3;
      break;
    case 3:
    }
  }
  FUN_2020c3f6(uVar1,param_2,uVar2 & 0xff,cVar3,0x2e,&local_c,param_4);
  return;
}


