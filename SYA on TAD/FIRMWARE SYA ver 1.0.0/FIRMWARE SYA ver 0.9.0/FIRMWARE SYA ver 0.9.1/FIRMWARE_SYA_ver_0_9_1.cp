#line 1 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.9.0/FIRMWARE SYA ver 0.9.1/FIRMWARE_SYA_ver_0_9_1.c"
#line 30 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.9.0/FIRMWARE SYA ver 0.9.1/FIRMWARE_SYA_ver_0_9_1.c"
bit clock0;
bit interruptC0;
bit interruptC1;
bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_NegEdge_1;
bit sn_NegEdge_2;
unsigned int counter = 0;
short unsigned int last_INC;
short unsigned int INC;
short unsigned int fsm_state, next_state;
int gray;
char result[3];
bit INC1;
bit INC2;
bit INC3;
bit AND_signal;





void InitMCU();
void InitInterrupt();
void Events();
char CodigoGray(short unsigned int INC);





void interrupt(){

 if(PIR0.TMR0IF){
 TMR0H = 0x06;
 TMR0L = 0x00;
 PIR0.TMR0IF = 0;
#line 72 "C:/Users/USER/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.9.0/FIRMWARE SYA ver 0.9.1/FIRMWARE_SYA_ver_0_9_1.c"
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

 InitInterrupt();
 InitMCU();

 while(1){
 Events();

 fsm_state = next_state;
 switch(fsm_state){

 case 0:
  LATA.F4  = 0;

 if(sn_PosEdge_1 == 1){
 switch(last_INC){

 case 1:
 INC1 = 0;
 INC2 = 1;
 INC3 = 0;
 INC = 2;
 next_state = 1;
 break;

 case 2:
 INC1 = 0;
 INC2 = 0;
 INC3 = 1;
 INC = 3;
 next_state = 1;
 break;
 case 3:
 INC1 = 1;
 INC2 = 0;
 INC3 = 0;
 INC = 1;
 next_state = 1;
 break;
 default:
 INC1 = 1;
 INC2 = 0;
 INC3 = 0;
 INC = 1;
 next_state = 1;
 break;
 }
 }
 break;

 case 1:
 AND_signal = 1;
 switch(INC){

 case 1:

 if(INC1){

 if(CodigoGray(INC) == 1){
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 }
 last_INC = 1;

 if(sn_NegEdge_1){
 next_state = 0;
 INC1 = 0;
 }
 else{
 INC1 = 1;
 }
 }
 break;

 case 2:

 if(INC2){

 if(CodigoGray(INC) == 2){
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 }
 last_INC = 2;

 if(sn_NegEdge_1){
 next_state = 0;
 INC2 = 0;
 }
 else{
 INC2 = 1;
 }
 }
 break;

 case 3:

 if(INC3){

 if(CodigoGray(INC) == 3){
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 }
 last_INC = 3;

 if(sn_NegEdge_1){
 next_state = 0;
 INC3 = 0;
 }
 else{
 INC3 = 1;
 }
 }
 break;
 }
 break;
 default:
 next_state = 0;
 fsm_state = 0;
 INC1 = 0;
 INC2 = 0;
 INC3 = 0;
 INC = 0;
 last_INC = 2;
 break;
 }
 }

}





char CodigoGray(short unsigned int INC){

 gray = INC ^ (INC >> 1);

 sprintf(result, "%u%u", (gray >> 1) & 1, (gray >> 0) & 1);

 switch(result[0]){
 case '0':
 switch(result[1]){
 case '1':

 if(AND_signal == 1){

 return 1;
 }
 else{
 return 99;
 }
 break;
 }
 break;
 case '1':
 switch(result[1]){
 case '1':

 if(AND_signal == 1){

 return 2;
 }
 else{
 return 99;
 }
 break;
 case '0':

 if(AND_signal == 1){

 return 3;
 }
 else{
 return 99;
 }
 break;
 }
 break;
 }

 return 0;

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
 T0CON1 = 0x40;
 TMR0H = 0x06;
 TMR0L = 0x00;
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
