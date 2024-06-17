#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.6.0/FIRMWARE_SYA_ver_0_6.c"
#line 24 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.6.0/FIRMWARE_SYA_ver_0_6.c"
char flag_switch;
bit PosEdge1;
bit PosEdge2;
bit once;
bit gflag;
bit flag01;
bit flag02;
bit flag_a;
bit flag_s;
int switch_count = 1;
int MR1;
int MR2;
int MR1P;
int MR2P;
int reg;
int count;
int temp;





void selector();
void watcher(int *_switch_count);
void InitMCU();
void InitInterrupt();
void blink();





void interrupt(){
 temp = PORTC;
 temp = temp << 6;

 if((IOCCF.B0 == 1) && (IOCIE_bit == 1) && (IOCCN.B0 == 1)){
 IOCCF.B0 = 0;
 PosEdge1 = 1;
 blink();
 }

 if((IOCCF.B1 == 1) && (IOCIE_bit == 1) && ((IOCCN.B0 == 1))){
 IOCCF.B1 = 0;
 PosEdge2 = 1;
 blink();
 }

}





void main(){

 InitMCU();
 InitInterrupt();
 once =  1 ;
#line 91 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.6.0/FIRMWARE_SYA_ver_0_6.c"
 while(1){
 if((temp == 0xC0) || (temp == 0x80) || (temp == 0x40)){
 switch_count++;
  LATA.F4  = 0;
 temp = 0x00;
 if(switch_count >= 4){
 switch_count = 0;
 }
 }
 watcher(switch_count);
 selector();
 }
}





void selector(){

 if(flag_switch == 0){
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 }

 if((flag_switch == 2) && (PosEdge2 == 1)){
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;
 }

 if((flag_switch == 1) && (PosEdge1 == 1)){

 switch(reg){
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
 break;
 }
 }

}





void watcher(int *_switch_count){

 if(( PORTC.F0  == 0) && (PosEdge1 == 1)){
 flag_switch = 1;
  LATE.F2  = 1;
#line 167 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.6.0/FIRMWARE_SYA_ver_0_6.c"
 }

 if(( PORTC.F0  == 1) && ( PORTC.F1  == 1)){
 flag_switch = 0;
 once =  1 ;
 reg = switch_count;
 }

 if(( PORTC.F1  == 1) && ( PORTC.F0  == 0)){

 flag_switch = 1;
#line 183 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.6.0/FIRMWARE_SYA_ver_0_6.c"
 }

 if(( PORTC.F1  == 0) && (PosEdge2 == 1)){
 flag_switch = 2;
 }
}





void blink(){

 while((PosEdge1 == 1) || (PosEdge2 == 1)){
 char i;

 for(i = 0; i < 4; i++){
  LATA.F4  = ~ LATA.F4 ;
 Delay_ms(50);
 }
 break;
 }

}





void InitInterrupt(){

 PIE0 = 0x10;
 PIR0 = 0x00;
 IOCCN = 0x03;

 IOCCF = 0x00;
 INTCON = 0xC0;

}





void InitMCU(){

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
 flag01 = 0;
 flag02 = 0;

 once =  1 ;

}
