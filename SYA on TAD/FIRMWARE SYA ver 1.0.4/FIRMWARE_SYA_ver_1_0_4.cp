#line 1 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.0.4/FIRMWARE_SYA_ver_1_0_4.c"
#line 41 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/Simultaneo y alternancia/FIRMWARE SYA ver 1.0.4/FIRMWARE_SYA_ver_1_0_4.c"
bit interruptC0;
bit interruptC1;


bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_NegEdge_1;
bit sn_NegEdge_2;



short unsigned int caso = 0;
short unsigned int caso_anterior = 3;





void InitMCU();
void InitInterrupt();
void Events();





void interrupt(){


 if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
 IOCCF.B0 = 0;
 interruptC0 = 1;
 }

 if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
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
 switch(caso){
 case 0:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 if(1 == sn_PosEdge_1){
 if(1 == caso_anterior){
 caso = 2;
 }
 else if(2 == caso_anterior){
 caso = 3;
 }
 else if(3 == caso_anterior){
 caso = 1;
 }
 }
 break;
 case 1:
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 0;
 caso_anterior = 1;
 if(1 == sn_NegEdge_1){
 caso = 0;
 }
 else{
 ;
 }
 break;
 case 2:
  LATA.F5  = 0;
  LATE.F0  = 1;
  LATE.F1  = 1;
 caso_anterior = 2;
 if(1 == sn_NegEdge_1){
 caso = 0;
 }
 else{
 ;
 }
 break;
 case 3:
  LATA.F5  = 1;
  LATE.F0  = 0;
  LATE.F1  = 1;
 caso_anterior = 3;
 if(1 == sn_NegEdge_1){
 caso = 0;
 }
 else{
 ;
 }
 break;
 default:
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 break;
 }
 }

}





void Events(){

 if(1 == interruptC0){

 if(1 ==  PORTC.F0 ){

 sn_PosEdge_1 = 0;
 sn_NegEdge_1 = 1;
 }

 else{

 sn_PosEdge_1 = 1;
 sn_NegEdge_1 = 0;
 }
 interruptC0 = 0;
 }

 else if(1 == interruptC1){

 if(1 ==  PORTC.F1 ){

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

}
