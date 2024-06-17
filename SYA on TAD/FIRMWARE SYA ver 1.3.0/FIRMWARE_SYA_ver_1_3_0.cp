#line 1 "D:/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.3.0/FIRMWARE_SYA_ver_1_3_0.c"
#line 41 "D:/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.3.0/FIRMWARE_SYA_ver_1_3_0.c"
typedef enum{
 s0,
 s1,
 s2,
 s3,
 s4,
 s5,
 s6,
 s7
} State;






int clock0;
volatile int interruptC0 = 0;
volatile int interruptC1 = 0;
volatile int interruptC2 = 0;
volatile int counter = 0;
volatile int counter1 = 0;


bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_PosEdge_3;
bit sn_NegEdge_1;
bit sn_NegEdge_2;
bit sn_NegEdge_3;


bit GT1;
bit GT2;
bit GT3;
int sn_GoTo = 0;
int sn_GoToGT = 0;
int sn_error = 0;
short unsigned int current_state, next_state;





void InitMCU();
void InitInterrupt();
void InitSystems();
void FSM();
void Events();
void M1On(){ LATA.F5  = 1;}
void M1Off(){ LATA.F5  = 0;}
void M2On(){ LATE.F0  = 1;}
void M2Off(){ LATE.F0  = 0;}
void M3On(){ LATE.F1  = 1;}
void M3Off(){ LATE.F1  = 0;}





void interrupt(){

 if(PIR0.TMR0IF){
 TMR0H = 0x3C;
 TMR0L = 0xB0;
 PIR0.TMR0IF = 0;
 counter++;
 if(counter >= 200){
  LATA.F4  = ~ LATA.F4 ;
 Events();
 PIE0.TMR0IE = 0;
 counter = 0;
 }
 }
 if(1 == IOCCF.B0){
 IOCCF.B0 = 0;
 interruptC0 = 1;
 Delay_ms(50);
 if(1 ==  PORTC.F0 ){
 sn_PosEdge_1 = 0;
 sn_NegEdge_1 = 1;
 interruptC0 = 0;
 if(! PORTC.F2 ){
 next_state = s5;
 }
 }
 else{
 sn_GoToGT = 1;
 sn_PosEdge_1 = 1;
 sn_NegEdge_1 = 0;
 interruptC0 = 0;
 if(! PORTC.F1 ){
 next_state = s4;
 if(! PORTC.F2 ){
 next_state = s5;
 }
 else{
 next_state = s4;
 }
 }
 else{
 next_state = s7;
 if(! PORTC.F2 ){
 next_state = s5;
 }
 }
 }
 }

 if(1 == IOCCF.B1){
 IOCCF.B1 = 0;
 interruptC1 = 1;
 Delay_ms(100);
 if(1 ==  PORTC.F1 ){
 sn_PosEdge_2 = 0;
 sn_NegEdge_2 = 1;
 interruptC1 = 0;
 if(! PORTC.F0 ){
 sn_GoToGT = 1;
 }
 }
 else{
 sn_PosEdge_2 = 1;
 sn_NegEdge_2 = 0;
 next_state = s4;
 interruptC1 = 0;
 if(! PORTC.F2 ){
 next_state = s5;
 }
 else{
 next_state = s4;
 }
 }
 }

 if(1 == IOCCF.B2){
 IOCCF.B2 = 0;
 interruptC2 = 1;
 Delay_ms(100);
 if(1 ==  PORTC.F2 ){
 sn_PosEdge_3 = 0;
 sn_NegEdge_3 = 1;
 interruptC2 = 0;
 if(! PORTC.F0 ){
 sn_GoToGT = 1;
 sn_error = 1;
 }
 if(! PORTC.F1 ){
 sn_GoTo = 1;
 }
 }
 else{
 sn_PosEdge_3 = 1;
 sn_NegEdge_3 = 0;
 next_state = s5;
 interruptC2 = 0;
 if(! PORTC.F0 ){
 next_state = s5;
 }
 }
 }

}





void main(){

 InitSystems();

 while(1){
 current_state = next_state;
 FSM();
 }

}





void FSM(){
 switch(current_state){
 case s0:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;

 if(1 == sn_PosEdge_1){
 next_state = s7;
 }
 else{
 }
 break;
 case s1:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 0;
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;
 if(1 == sn_NegEdge_1){

 next_state = s0;
 }
 else if(1 == sn_PosEdge_2){
 next_state = s4;
 }
 else{
 }
 break;
 case s2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
 GT1 = 0;
 GT2 = 1;
 GT3 = 0;
 if(1 == sn_NegEdge_1){
 next_state = s0;
 }
 else if(1 == sn_PosEdge_2){
 next_state = s4;
 }
 else{
 }
 break;
 case s3:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;
 if(1 == sn_NegEdge_1){
 next_state = s0;
 }
 else if(1 == sn_PosEdge_2){
 next_state = s4;
 }
 else{
 }
 break;
 case s4:
 sn_GoTo = 1;
 if((1 == GT1) && (0 == GT2) && (0 == GT3)){
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 GT2 = 0;
 GT3 = 0;
 }
 else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 GT1 = 0;
 GT3 = 0;
 }
 else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 0;
 }
 if(1 == sn_NegEdge_2){
 next_state = s7;
 }
 else if(1 == sn_PosEdge_3){
 next_state = s5;
 }
 else{
 }
 break;
 case s5:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;
 if(1 == sn_NegEdge_3){
 next_state = s6;
 }
 else{
 }
 break;
 case s6:
 if(sn_GoTo){
 if((1 == GT1) && (0 == GT2) && (0 == GT3)){
 GT2 = 1;
 GT3 = 0;
 GT1 = 0;
 next_state = s4;
 }
 else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
 GT2 = 0;
 GT1 = 0;
 GT3 = 1;
 next_state = s4;
 }
 else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;
 next_state = s4;
 }
 else{
 }
 }
 else if(sn_error){
 next_state = s7;
 }
 else{
 next_state = s0;
 }
 break;
 case s7:
 clock0 = 0;
 if(! PORTC.F2 ){
 next_state = s5;
 }
 else if(sn_GoToGT){
 if((1 == GT1) && (0 == GT2) && (0 == GT3)){
 next_state = s2;
 }
 else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
 next_state = s3;
 }
 else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
 next_state = s1;
 }
 }
 else{
 next_state = s0;
 }
 break;
 default:
 current_state = s0;
 next_state = s0;
 break;
 }

}





void Events(){
 sn_NegEdge_1 = 0;
 sn_NegEdge_2 = 0;
 sn_NegEdge_3 = 0;
 sn_PosEdge_1 = 0;
 sn_PosEdge_2 = 0;
 sn_PosEdge_3 = 0;
 switch( PORTC.F0 ){
 case 0:
 next_state = s1;
 switch( PORTC.F1 ){
 case 0:
 next_state = s4;
 switch( PORTC.F2 ){
 case 0:
 next_state = s5;
 break;
 case 1:
 next_state = s4;
 break;
 }
 break;
 case 1:
 switch( PORTC.F2 ){
 case 0:
 next_state = s5;
 break;
 case 1:
 next_state = s1;
 break;
 }
 break;
 }
 break;
 case 1:
 switch( PORTC.F1 ){
 case 0:
 next_state = s4;
 switch( PORTC.F2 ){
 case 0:
 next_state = s5;
 break;
 case 1:
 next_state = s4;
 break;
 }
 break;
 case 1:
 switch( PORTC.F2 ){
 case 0:
 next_state = s5;
 break;
 case 1:
 next_state = s0;
 break;
 }
 break;
 }
 break;
 }
 return;

}





void InitSystems(){
 Delay_ms(1000);
 InitInterrupt();
 InitMCU();
 Delay_ms(1000);
 Events();
}





void InitInterrupt(){

 PIE0 = 0x30;
 PIR0 = 0x00;

 T0CON0 = 0x90;
 T0CON1 = 0x40;
 TMR0H = 0x3C;
 TMR0L = 0xB0;

 IOCCN = 0x07;
 IOCCP = 0x07;
 IOCCF = 0x00;
 PIR0.TMR0IF = 0;

 PIE4 = 0x02;
 PIR4 = 0x00;

 T1CON = 0x03;
 T1GCON = 0x00;
 TMR1CLK = 0x01;
 TMR1 = 0xEC78;
 INTCON = 0xC0;

}





void InitMCU(){

 ADCON0 = 0x08;
 ANSELC = 0x00;
 ANSELE = 0x00;
 ANSELA = 0x00;
 ANSELD = 0x00;

 TRISC = 0x0F;
 TRISD = 0x07;
 TRISE = 0x00;
 TRISA = 0x80;

 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATD = 0x00;
 LATE = 0x00;
 LATA = 0x10;

 WPUD = 0x07;
 INLVLD = 0x07;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;
 GT3 = 1;
 GT2 = 0;
 GT1 = 0;

}
