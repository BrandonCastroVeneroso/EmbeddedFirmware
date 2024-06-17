#line 1 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA 1.0.1/FIRMWARE_SYA_ver_1_0_1.c"
#line 39 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA 1.0.1/FIRMWARE_SYA_ver_1_0_1.c"
bit clock0;
bit interruptC0;
bit interruptC1;
volatile int counter = 0;


bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_NegEdge_1;
bit sn_NegEdge_2;


bit GT1;
bit GT2;
bit GT3;
bit sn_GoTo;
short unsigned int current_state, next_state;





void InitMCU();
void InitInterrupt();
void FSM();
void Events();





void interrupt(){

 if(PIR0.TMR0IF){
 TMR0H = 0xB1;
 TMR0L = 0xE0;
 PIR0.TMR0IF = 0;
 counter++;
 if(counter >= 150){
 clock0 = 1;
  LATA.F4  = 0;
 counter = 0;
 }
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

 InitInterrupt();
 InitMCU();

 do{
 Events();
 }while((interruptC0 == 1) || (interruptC1 == 1));

 while(1){
 current_state = next_state;
 FSM();
 }

}





void FSM(){

 switch(current_state){
 case 0:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 sn_GoTo = 0;

 if((sn_PosEdge_1 == 1) && (clock0 == 1)){
 next_state = 6;
 }
 else{

 }
 break;
 case 1:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 4;
 }

 else{


 }
 break;
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 1;
 GT3 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;
 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 4;
 }

 else{


 }
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;
 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 4;
 }

 else{


 }
 break;
 case 4:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;

 if((sn_NegEdge_1) && (clock0 == 1)){
 next_state = 0;
 }
 else if((sn_NegEdge_2) && (clock0 == 1)){

 next_state = 5;
 sn_GoTo = 1;
 }

 else{


 }
 break;
 case 5:

 if((sn_GoTo == 1) && (GT1 == 1) && (clock0 == 1)){
 next_state = 2;
 }
 else if((sn_GoTo == 1) && (GT2 == 1) && (clock0 == 1)){
 next_state = 3;
 }
 else if((sn_GoTo == 1) && (GT3 == 1) && (clock0 == 1)){
 next_state = 1;
 }

 else{


 }
 break;
 case 6:
 if(sn_PosEdge_1){

 if((GT1) && (clock0 == 1)){

 next_state = 2;
 GT2 = 0;
 GT3 = 0;
 }

 else if((GT2) && (clock0 == 1)){

 next_state = 3;
 GT1 = 0;
 GT3 = 0;
 }

 else if((GT3) && (clock0 == 1)){

 next_state = 1;
 GT1 = 0;
 GT2 = 0;
 }

 else{


 }
 }
 break;
 default:
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 current_state = 0;
 next_state = 0;
 break;
 }

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
 interruptC0 = 0;
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
 interruptC1 = 0;
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
 T0CON1 = 0x40;
 TMR0H = 0xB1;
 TMR0L = 0xE0;
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
