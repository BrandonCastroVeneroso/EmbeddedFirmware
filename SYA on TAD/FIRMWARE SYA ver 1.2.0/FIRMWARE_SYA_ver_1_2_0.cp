#line 1 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.2.0/FIRMWARE_SYA_ver_1_2_0.c"
#line 40 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.2.0/FIRMWARE_SYA_ver_1_2_0.c"
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
bit GT4;
bit GT5;
bit GT6;
bit GT7;
bit GT8;
bit GT9;
bit GT10;
bit sn_GoTo;
short unsigned int current_state, next_state;
unsigned int num = 2;





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
 if(counter >= 100){
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
  LATE.F2  = 0;
  LATB.F0  = 0;
 sn_GoTo = 0;

 if((sn_PosEdge_1 == 1) && (clock0 == 1)){
 next_state = 13;
 }
 else{
 next_state = 0;
 }
 break;
 case 1:
 switch(num){
 case 2:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 default:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 }
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 1;
 }
 break;
 case 2:
 switch(num){
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 case 3:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 }
 GT1 = 0;
 GT2 = 1;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;
 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 2;
 }
 break;
 case 3:
 switch(num){
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 case 3:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 1;
  LATB.F0  = 1;
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;
 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 3;
 }
 break;
 case 4:
 switch(num){
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 1;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 1;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 1;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 4;
 }
 break;
 case 5:
 switch(num){
 case 2:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 default:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 0;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 1;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 5;
 }
 break;
 case 6:
 switch(num){
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 1;
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 1;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 6;
 }
 break;
 case 7:
 switch(num){
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 case 3:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 1;
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 1;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 7;
 }
 break;
 case 8:
 switch(num){
 case 2:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 default:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 1;
 GT9 = 0;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 8;
 }
 break;
 case 9:
 switch(num){
 case 2:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 case 3:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 default:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 1;
 GT10 = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 9;
 }
 break;
 case 10:
 switch(num){
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 1;
  LATB.F0  = 0;
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
  LATE.F2  = 0;
  LATB.F0  = 1;
 break;
 }
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 1;

 if((sn_NegEdge_1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2) && (clock0 == 1)){

 next_state = 11;
 }

 else{

 next_state = 10;
 }
 break;
 case 11:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 1;
  LATB.F0  = 0;

 if((sn_NegEdge_1) && (clock0 == 1)){
 next_state = 0;
 }
 else if((sn_NegEdge_2) && (clock0 == 1)){

 next_state = 12;
 sn_GoTo = 1;
 }

 else{

 next_state = 11;
 }
 break;
 case 12:

 if((sn_GoTo == 1) && (GT1 == 1) && (clock0 == 1)){
 next_state = 2;
 }
 else if((sn_GoTo == 1) && (GT2 == 1) && (clock0 == 1)){
 next_state = 3;
 }
 else if((sn_GoTo == 1) && (GT3 == 1) && (clock0 == 1)){
 next_state = 4;
 }
 else if((sn_GoTo == 1) && (GT4 == 1) && (clock0 == 1)){
 next_state = 5;
 }
 else if((sn_GoTo == 1) && (GT5 == 1) && (clock0 == 1)){
 next_state = 6;
 }
 else if((sn_GoTo == 1) && (GT6 == 1) && (clock0 == 1)){
 next_state = 7;
 }
 else if((sn_GoTo == 1) && (GT7 == 1) && (clock0 == 1)){
 next_state = 8;
 }
 else if((sn_GoTo == 1) && (GT8 == 1) && (clock0 == 1)){
 next_state = 9;
 }
 else if((sn_GoTo == 1) && (GT9 == 1) && (clock0 == 1)){
 next_state = 10;
 }
 else if((sn_GoTo == 1) && (GT10 == 1) && (clock0 == 1)){
 next_state = 1;
 }

 else{

 next_state = 11;
 }
 break;
 case 13:
 if(sn_PosEdge_1){

 if((GT1) && (clock0 == 1)){

 next_state = 2;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;
 }

 else if((GT2) && (clock0 == 1)){

 next_state = 3;
 GT1 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;
 }

 else if((GT3) && (clock0 == 1)){

 next_state = 4;
 GT1 = 0;
 GT2 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;
 }
 else if((GT4) && (clock0 == 1)){
 next_state = 5;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;
 }
 else if((GT5) && (clock0 == 1)){
 next_state = 6;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;
 }
 else if((GT6) && (clock0 == 1)){
 next_state = 7;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT7 = 0;
 }
 else if((GT7) && (clock0 == 1)){
 next_state = 8;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 }
 else if((GT8) && (clock0 == 1)){
 next_state = 9;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 }
 else if((GT9) && (clock0 == 1)){
 next_state = 10;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 }
 else if((GT10) && (clock0 == 1)){
 next_state = 1;
 GT1 = 0;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 }

 else{

 next_state = 10;
 }
 }
 break;
 default:
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;
 GT4 = 0;
 GT5 = 0;
 GT6 = 0;
 GT7 = 0;
 GT8 = 0;
 GT9 = 0;
 GT10 = 0;
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
  LATE.F2  = 0;
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
