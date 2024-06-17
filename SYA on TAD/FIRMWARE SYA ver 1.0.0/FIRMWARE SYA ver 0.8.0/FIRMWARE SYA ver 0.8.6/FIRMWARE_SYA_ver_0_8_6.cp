#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.6/FIRMWARE_SYA_ver_0_8_6.c"
#line 30 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.6/FIRMWARE_SYA_ver_0_8_6.c"
bit flag01;
bit flag02;
bit flag_init;
bit clock0;
bit interruptC0;
bit interruptC1;
bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_NegEdge_1;
bit sn_NegEdge_2;
bit once;
bit GT1;
bit GT2;
bit GT3;
bit sn_GoTo;
int i;
volatile int counter = 0;
int last_state = 0;
short unsigned int sm_state = 0;
short unsigned int state = 0;
short unsigned int current_state = 0;
short unsigned int next_state;
short unsigned int cases = 0;
int temp = 0;





void InitMCU();
void InitInterrupt();
void State();
void Events();
int blink(int *_next_state);





void interrupt(){
 temp = PORTC;
 temp = temp << 6;
#line 84 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.6/FIRMWARE_SYA_ver_0_8_6.c"
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
#line 115 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.6/FIRMWARE_SYA_ver_0_8_6.c"
 if(flag_init){
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;
 flag_init = 0;
 }


 do{
 Events();
 State();
 }while(1);

}





int blink(int *_next_state){
 if(clock0){
 if(state == next_state){
 }
 else{
 state = next_state;
 }
  LATA.F4  = 0;
 clock0 = 0;
 }
 return state;
}





void State(){


 state = next_state;

 switch(state){
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
  LATE.F0  = 0;
  LATE.F1  = 0;
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;

 if((sn_NegEdge_1 == 1) && (clock0 == 1)){

 next_state = 0;

 }

 else if((sn_PosEdge_2 == 1) && (clock0 == 1)){

 next_state = 4;
 }

 else{


 }
 break;
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 0;
 GT1 = 0;
 GT2 = 1;
 GT3 = 0;

 if((sn_NegEdge_1 == 1) && (clock0 == 1)){

 next_state = 0;
 }

 else if((sn_PosEdge_2 == 1) && (clock0 == 1)){

 next_state = 4;
 }

 else{


 }
 break;
 case 3:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;

 if((sn_NegEdge_1 == 1) && (clock0 == 1)){

 next_state = 0;
 }

 else if((sn_PosEdge_2 == 1) && (clock0 == 1)){

 next_state = 4;
 }

 else{


 }
 break;
 case 4:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;

 if((sn_NegEdge_2 == 1) && (clock0 == 1)){

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

 if((GT1 == 1) && (clock0 == 1)){

 next_state = 2;
 GT2 = 0;
 GT3 = 0;
 }

 else if((GT2 == 1) && (clock0 == 1)){

 next_state = 3;
 GT1 = 0;
 GT3 = 0;
 }

 else if((GT3 == 1) && (clock0 == 1)){

 next_state = 1;
 GT1 = 0;
 GT2 = 0;
 }

 else{


 }
 }
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

}





void InitInterrupt(){

 PIE0 = 0x30;
 PIR0 = 0x00;
 T0CON0 = 0x90;
 T0CON1 = 0x46;
 TMR0H = 0xE8;
 TMR0L = 0x49;
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

 once =  1 ;

}
