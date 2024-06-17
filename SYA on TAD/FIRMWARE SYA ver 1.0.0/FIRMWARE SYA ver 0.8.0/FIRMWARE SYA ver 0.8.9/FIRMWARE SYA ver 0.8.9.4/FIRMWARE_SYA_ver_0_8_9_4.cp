#line 1 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.9/FIRMWARE SYA ver 0.8.9.4/FIRMWARE_SYA_ver_0_8_9_4.c"
#line 30 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.9/FIRMWARE SYA ver 0.8.9.4/FIRMWARE_SYA_ver_0_8_9_4.c"
bit flag01;
bit flag02;
bit clock0;
bit interruptC0;
bit interruptC1;
bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_NegEdge_1;
bit sn_NegEdge_2;
volatile unsigned int counter = 0;

short unsigned int INC = 1;
bit AND_signal;
bit OR_signal;







void InitMCU();
void InitInterrupt();
void FSM();
void Events();
void CodigoGray(int _INC);





void interrupt(){

 if(PIR0.TMR0IF){
 TMR0H = 0x63;
 TMR0L = 0xC0;
 PIR0.TMR0IF = 0;
#line 72 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.9/FIRMWARE SYA ver 0.8.9.4/FIRMWARE_SYA_ver_0_8_9_4.c"
 counter++;
 }

 if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
 IOCCF.B0 = 0;
 interruptC0 = 1;


 }

 if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
 IOCCF.B1 = 0;
 interruptC1 = 1;


 }

}





void main(){

 InitMCU();
 InitInterrupt();

 while(1){
 short unsigned int state, next_state;

 Events();
 state = next_state;
 INC++;

 switch(state){
 case 0:
  LATA.F5  = 1;
  LATE.F1  = 0;
 if(sn_PosEdge_1 == 1){
 next_state = 1;
 }
 else{
 next_state = 0;
 }
 break;
 case 1:
  LATE.F0  = 1;
  LATA.F5  = 0;
 if(counter >= 30){
 next_state = 2;
 counter = 0;
 }
 break;
 case 2:
 AND_signal = 1;
  LATE.F1  = 1;
  LATE.F0  = 0;
 if(INC == 2){
  LATE.F2  = 1;
 }
 else if(INC > 1000){
  LATA.F4  = 0;
 INC = 1;
 }

 if(sn_NegEdge_1){
 next_state = 0;
 }
 else{
 next_state = 2;
 }
 break;
 default:
 next_state = 0;
 state = 0;
 break;
 }
 }

}





void FSM(){
 short unsigned int state = 0;
 short unsigned int next_state = 0;

 state = next_state;
 switch(state){
 case 0:
  LATA.F5  = 1;
  LATE.F1  = 0;
 if(sn_PosEdge_1 == 1){
 next_state = 1;
 if(state == 1){
  LATE.F2  = 1;
 }
  LATA.F4  = ~ LATA.F4 ;
 }
 else{
 next_state = 0;
 }
 break;
 case 1:
 INC++;
  LATE.F0  = 1;
  LATA.F5  = 0;
 next_state = 2;
 break;
 case 2:
  LATA.F4  = ~ LATA.F4 ;
 AND_signal = 1;
  LATE.F1  = 1;
  LATE.F0  = 0;

 if(sn_NegEdge_1){
 next_state = 0;
 }
 else{
 next_state = 2;
 }
 break;
 }

}





void CodigoGray(int _INC){
 int gray = INC ^ (INC >> 1);
 char result[3];
 sprintf(result, "%u%u", (gray >> 1) & 1, (gray >> 0) & 1);
 switch(result[0]){
 case '0':
 switch(result[1]){
 case '1':
 if(AND_signal == 1){
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 }
 else{
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 }
 break;
 }
 break;
 case '1':
 switch(result[1]){
 case '1':
 if(AND_signal == 1){
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 }
 else{
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 }
 break;
 case '0':
 if(AND_signal == 1){
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 }
 else{
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 }
 break;
 }
 break;
 }
 return;
}





void Events(){
 if(interruptC0){
 if( PORTC.F0  == 1){
 sn_PosEdge_1 = 0;
 sn_NegEdge_1 = 1;
 }
 else{
 sn_PosEdge_1 = 1;
 sn_NegEdge_1 = 0;

 }

 }
 else if(interruptC1){
 if( PORTC.F1  == 1){
 sn_PosEdge_2 = 0;
 sn_NegEdge_2 = 1;
 }
 else{
 sn_PosEdge_2 = 1;
 sn_NegEdge_2 = 0;

 }

 }
 else{
 interruptC0 = 0;
 interruptC1 = 0;
 }
 return;
}





void InitInterrupt(){

 PIE0 = 0x30;
 PIR0 = 0x00;
 T0CON0 = 0x90;
 T0CON1 = 0x44;
 TMR0H = 0x63;
 TMR0L = 0xC0;
 IOCCN = 0x03;
 IOCCP = 0x03;
 IOCCF = 0x00;
 PIR0.TMR0IF = 0;
 INTCON = 0xC0;

}





void InitMCU(){

 ADCON1 = 0x0F;
 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x80;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;

 WPUC = 0x03;
 INLVLC = 0x03;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;

}
