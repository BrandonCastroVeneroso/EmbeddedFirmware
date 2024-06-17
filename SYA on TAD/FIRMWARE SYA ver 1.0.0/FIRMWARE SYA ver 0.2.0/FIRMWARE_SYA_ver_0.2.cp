#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.2.0/FIRMWARE_SYA_ver_0.2.c"
#line 12 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.2.0/FIRMWARE_SYA_ver_0.2.c"
bit flag_switch1;
bit flag_switch2;
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

 WPUC = 0x03;
 INLVLC = 0x03;

 flag_switch1 = 0;
 flag_switch2 = 0;
 once =  1 ;

 while(1){
 if( PORTC.F0 ){
 flag_switch1 = 0;
 reg = switch_count;
 once =  1 ;
 }
 else{
 flag_switch1 = 1;
 if(once){
 switch_count++;
 once =  0 ;
 if(switch_count > 3){
 switch_count = 0;
 }
 }
 }
 if( PORTC.F1 ){
 flag_switch2 = 0;
 }
 else{
 flag_switch2 = 1;
 }
#line 78 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.2.0/FIRMWARE_SYA_ver_0.2.c"
 if(flag_switch2){
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;
 }
 else{
 if(flag_switch1){
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
}
