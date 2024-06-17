#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.3/FIRMWARE_SYA_ver_0_8_3.c"
#line 26 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.3/FIRMWARE_SYA_ver_0_8_3.c"
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





void interrupt(){
 temp = PORTC;
 temp = temp << 6;
#line 77 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.3/FIRMWARE_SYA_ver_0_8_3.c"
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
 once =  1 ;
 flag_init = 1;


 do{
 Events();
 State();
 }while(1);
}





void State(){

 switch(state){
 case 0:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 sn_GoTo = 0;
#line 124 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.3/FIRMWARE_SYA_ver_0_8_3.c"
 if(sn_PosEdge_1){
 state = 7;
 }
 else{
 state = 0;
 }
 break;
 case 1:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 GT1 = 1;
 GT2 = 0;
 GT3 = 0;

 if(sn_NegEdge_1){

 state = 0;

 }

 else if(sn_PosEdge_2){

 state = 4;
 }

 else{

 state = 1;
 }
 break;
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 1;
 GT3 = 0;

 if(sn_NegEdge_1){

 state = 0;
 }

 else if(sn_PosEdge_2){

 state = 4;
 }

 else{

 state = 2;
 }
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 GT1 = 0;
 GT2 = 0;
 GT3 = 1;

 if(sn_NegEdge_1){

 state = 0;
 }

 else if(sn_PosEdge_2){

 state = 4;
 }

 else{

 state = 3;
 }
 break;
 case 4:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;

 if(sn_NegEdge_2){

 state = 6;
 sn_GoTo = 1;
 }

 else{

 state = 4;
 }
 break;
 case 6:

 if((sn_GoTo == 1) && (GT1 == 1)){
 state = 2;
 }
 else if((sn_GoTo == 1) && (GT2 == 1)){
 state = 3;
 }
 else if((sn_GoTo == 1) && (GT3 == 1)){
 state = 1;
 }

 else{

 state = 4;
 }
 break;
 case 7:

 if(GT1){

 state = 2;
 GT2 = 0;
 GT3 = 0;
 }

 else if(GT2){

 state = 3;
 GT1 = 0;
 GT3 = 0;
 }

 else if(GT3){

 state = 1;
 GT1 = 0;
 GT2 = 0;
 }

 else{

 state = 7;
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
 else{

 }

}





void InitInterrupt(){

 PIE0 = 0x30;
 PIR0 = 0x00;
#line 321 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.3/FIRMWARE_SYA_ver_0_8_3.c"
 IOCCN = 0x03;
 IOCCP = 0x03;
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
