#line 1 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.8/FIRMWARE_SYA_ver_0_8_8.c"
#line 43 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.8/FIRMWARE_SYA_ver_0_8_8.c"
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
 TMR0H = 0xEC;
 TMR0L = 0x78;
 PIR0.TMR0IF = 0;
 counter++;
 if(counter >= 200){
  LATA.F4  = ~ LATA.F4 ;
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
 }while((1 == IOCCF.B0) || (1 == IOCCF.B1));

 while(1){
 clock0 = 1;
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

 if((1 == sn_PosEdge_1) && (1 == clock0)){
 next_state = 6;
 }
 else{
 next_state = 0;
 }
 break;
 case 1:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;
 if((0 ==  PORTC.F3 ) && (1 == clock0)){
  LATE.F2  = 1;
 }

 if((1 == sn_NegEdge_1) && (1 == clock0)){

 next_state = 0;

 }

 else if((1 == sn_PosEdge_2) && (1 == clock0)){

 next_state = 4;
 }

 else{
 next_state = 1;
 }
 break;
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
 GT1 = 0;
 GT2 = 1;
 GT3 = 0;

 if((1 == sn_NegEdge_1) && (1 == clock0)){

 next_state = 0;
 }

 else if((1 == sn_PosEdge_2) && (1 == clock0)){

 next_state = 4;
 }

 else{
 next_state = 2;
 }
 break;
 case 3:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;

 if((1 == sn_NegEdge_1) && (1 == clock0)){

 next_state = 0;
 }

 else if((1 == sn_PosEdge_2) && (1 == clock0)){

 next_state = 4;
 }

 else{
 next_state = 3;
 }
 break;
 case 4:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;

 if((1 == sn_NegEdge_1) && (1 == clock0)){
 next_state = 0;
 }
 else if((1 == sn_NegEdge_2) && (1 == clock0)){

 next_state = 5;
 sn_GoTo = 1;
 }

 else{
 next_state = 4;
 }
 break;
 case 5:

 if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
 next_state = 2;
 }
 else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
 next_state = 3;
 }
 else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
 next_state = 1;
 }

 else{
 next_state = 5;
 }
 break;
 case 6:
 if(1 == sn_PosEdge_1){

 if((1 == GT1) && (1 == clock0)){

 next_state = 2;
 GT2 = 0;
 GT3 = 0;
 }

 else if((1 == GT2) && (1 == clock0)){

 next_state = 3;
 GT1 = 0;
 GT3 = 0;
 }

 else if((1 == GT3) && (1 == clock0)){

 next_state = 1;
 GT1 = 0;
 GT2 = 0;
 }

 else{
 next_state = 6;
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
 TMR0H = 0xEC;
 TMR0L = 0x78;

 IOCCN = 0x03;
 IOCCP = 0x03;
 IOCCF = 0x00;

 INTCON = 0xC0;

}





void InitMCU(){


 OSCCON1 = 0x70;
 OSCEN = 0x80;

 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;
 ANSELD = 0;

 TRISC = 0x0B;
 TRISE = 0x00;
 TRISA = 0x80;
 TRISD = 0x03;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;
 PORTD = 0x00;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;
 LATD = 0x00;

 WPUC = 0x0B;
 INLVLC = 0x0B;
 WPUD = 0x03;
 INLVLD = 0x03;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;

}
