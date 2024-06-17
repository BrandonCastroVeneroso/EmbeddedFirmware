#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.5.0/FIRMWARE_SYA_ver_0.c"
#line 24 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.5.0/FIRMWARE_SYA_ver_0.c"
char flag_switch;
bit PosEdge1;
bit PosEdge2;
bit once;
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





void selector();
void watcher();
void InitMCU();
void InitInterrupt();
void blink();





void interrupt(){

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


 while(1){
 watcher();
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
#line 112 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.5.0/FIRMWARE_SYA_ver_0.c"
 switch(reg){
#line 118 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.5.0/FIRMWARE_SYA_ver_0.c"
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





void watcher(){
 while(1){

 if(( PORTC.F0  == 0) && (PosEdge1 == 1)){
 flag_switch = 1;
  LATE.F2  = 1;

 if(once){
 switch_count++;
 once =  0 ;

 if(switch_count >= 4){
 switch_count = 0;
 }
 }
 }

 if(( PORTC.F0  == 1) && ( PORTC.F1  == 1)){
 flag_switch = 0;
 reg = switch_count;
 once =  1 ;
 }

 if(( PORTC.F1  == 1) && ( PORTC.F0  == 0)){

 flag_switch = 1;

 if(once){
 switch_count++;
 once =  0 ;
 }
 }

 if(( PORTC.F1  == 0) && (PosEdge2 == 1)){
 flag_switch = 2;
 }
 break;
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
