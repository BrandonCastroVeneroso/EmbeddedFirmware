#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.1/FIRMWARE_SYA_ver_0_8.c"
#line 26 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.1/FIRMWARE_SYA_ver_0_8.c"
bit flag01;
bit flag02;
bit flag_init;
bit interruptC0;
bit interruptC1;
bit PosEdge1;
bit PosEdge2;
bit NegEdge1;
bit NegEdge2;
bit once;
int i;
volatile int counter = 0;
int last_state = 0;
short unsigned int sm_state = 0;
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
#line 72 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.1/FIRMWARE_SYA_ver_0_8.c"
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


 if(flag_init){
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 last_state = 0;
 flag_init = 0;
 }

 while(PosEdge1){

 if((last_state == 0)){
  LATA.F5  = 1;
  LATE.F0  = 1;
 sm_state = 1;
 }


 if((last_state == 1)){
  LATE.F0  = 1;
  LATE.F1  = 1;
 sm_state = 2;
 }


 if((last_state == 2)){
  LATA.F5  = 1;
  LATE.F1  = 1;
 sm_state = 3;
 }
 break;
 }


 if(NegEdge1 == 1){
  LATA.F5  = 0;
  LATE.F0  = 0;
  LATE.F1  = 0;
 if(sm_state == 1){
 last_state = 1;
 sm_state = 0;
 }
 if(sm_state == 2){
 last_state = 2;
 sm_state = 0;
 }
 if(sm_state == 3){
 last_state = 3;
 sm_state = 0;
 }
 }

}

void Events(){

 if(interruptC0){
 if( PORTC.F0  == 1){
 PosEdge1 = 0;
 NegEdge1 = 1;
 }
 if( PORTC.F0  == 0){
 PosEdge1 = 1;
 NegEdge1 = 0;
 }
 interruptC0 = 0;
 }
 if(interruptC1){
 if( PORTC.F1  == 1){
 PosEdge2 = 0;
 NegEdge2 = 1;
 }
 if( PORTC.F1  == 0){
 PosEdge2 = 1;
 NegEdge2 = 0;
 }
 interruptC1 = 0;
 }

}





void InitInterrupt(){

 PIE0 = 0x30;
 PIR0 = 0x00;
#line 197 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/FIRMWARE SYA ver 0.8.0/FIRMWARE SYA ver 0.8.1/FIRMWARE_SYA_ver_0_8.c"
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
