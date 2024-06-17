#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.1.0/FIRMWARE_SYA_ver_0_1.c"










bit flag_switch;
bit once;
bit flag01;
bit flag02;
int switch_count;
int MR1;
int MR2;
int MR1P;
int MR2P;
int stop;
int reg;

void main(){
 ADCON1 = 0x0F;
 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x00;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;

 flag_switch = 0;
 flag01 = 0;
 flag02 = 0;
 once =  1 ;

 while(1){
 if(1== PORTC.F0 ){
 flag_switch = 0;
 reg = switch_count;
 once =  1 ;
 }
 if(0== PORTC.F0 ){
 flag_switch = 1;
 if(once){
 switch_count++;
 once =  0 ;
 if(switch_count > 3){
 switch_count = 0;
 }
 }
 }

 while(flag_switch){
 reg = switch_count;
 break;
 }


 if(flag_switch){
 switch(reg){
 case 0:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 case 1:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 break;
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 break;
 case 4:
 reg = 0;

 }
 }
 }
}
