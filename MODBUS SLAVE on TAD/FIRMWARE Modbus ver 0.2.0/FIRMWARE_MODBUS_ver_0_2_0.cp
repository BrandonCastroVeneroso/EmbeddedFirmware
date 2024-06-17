#line 1 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.2.0/FIRMWARE_MODBUS_ver_0_2_0.c"
#line 43 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.2.0/FIRMWARE_MODBUS_ver_0_2_0.c"
bit clock0;
bit interruptC0;
bit interruptC1;
volatile int counter = 0;
volatile int counter1 = 0;
volatile int counter2 = 0;
bit timer0;
bit timer1;
bit timer3;


bit sn_PosEdge_1;
bit sn_PosEdge_2;
bit sn_NegEdge_1;
bit sn_NegEdge_2;


bit uart1;
char uart1_byte;
unsigned char uart1_array[50];
char i = 0;
char letra_i[] = "12345678123456789123456789123456789123456789123456789123456789123456789";





void InitMCU();
void InitInterrupt();
void Events();
void UART1_Write_Text1(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);





void interrupt(){

 if(PIR0.TMR0IF){
 TMR0H = 0xEC;
 TMR0L = 0x78;
 PIR0.TMR0IF = 0;
 counter++;
 timer0 = ~timer0;
 if(counter >= 500){
  LATA.F4  = ~ LATA.F4 ;
 counter = 0;
 }
 }
 if(PIR4.TMR1IF){
 TMR1H = 0x3C;
 TMR1L = 0xB0;
 PIR4.TMR1IF = 0;
 counter1++;
 timer1 = ~timer1;
 if(counter1 >= 50){
  LATA.F5  = ~ LATA.F5 ;
 counter1 = 0;
 }
 }
 if(PIR4.TMR3IF){
 TMR3H = 0x0B;
 TMR3L = 0xDC;
 PIR4.TMR3IF = 0;
 counter2++;
 if(counter2 >= 10){
  LATE.F0  = ~ LATE.F0 ;
 timer3 = ~timer3;
 counter2 = 0;
 }
 }
 if(PIR3.RC1IF){
 PIR3.RC1IF = 0;
 }

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

 while(1){
  LATE.F2  = ~ LATE.F2 ;
 UART1_Remappable_Write(0x65);
 Delay_ms(200);
 Events();
 switch(sn_PosEdge_1){
 case 0:
  LATE.F1  = 0;
 break;
 case 1:
  LATE.F1  = 1;
 break;
 default:
  LATE.F1  = 0;
 break;
 }
 }

}





void Events(){
 switch(interruptC0){
 case 0:
 interruptC0 = 0;
 break;
 case 1:
 switch( PORTC.F0 ){
 case 0:
 sn_PosEdge_1 = 1;
 sn_NegEdge_1 = 0;
 break;
 case 1:
 sn_PosEdge_1 = 0;
 sn_NegEdge_1 = 1;
 break;
 default:
 sn_PosEdge_1 = 0;
 sn_NegEdge_1 = 1;
 break;
 }
 interruptC0 = 0;
 break;
 default:
 interruptC0 = 0;
 break;
 }
 switch(interruptC1){
 case 0:
 interruptC1 = 0;
 break;
 case 1:
 switch( PORTC.F1 ){
 case 0:
 sn_PosEdge_2 = 1;
 sn_NegEdge_2 = 0;
 break;
 case 1:
 sn_PosEdge_2 = 0;
 sn_NegEdge_2 = 1;
 break;
 default:
 sn_PosEdge_2 = 0;
 sn_NegEdge_2 = 1;
 break;
 }
 interruptC1 = 0;
 break;
 default:
 interruptC1 = 0;
 break;
 }
 return;

}





void InitInterrupt(){

 PIE0 = 0x33;
 PIR0 = 0x00;
 PIE3 = 0x20;
 PIE4 = 0x05;
 PIR4 = 0x00;

 T0CON0 = 0x90;
 T0CON1 = 0x40;
 TMR0H = 0xEC;
 TMR0L = 0x78;

 T1CON = 0x03;
 T1GCON = 0x00;
 TMR1CLK = 0x01;
 TMR1H = 0x3C;
 TMR1L = 0xB0;

 T3CON = 0x33;
 T3GCON = 0x00;
 TMR3CLK = 0x01;
 TMR3H = 0x0B;
 TMR3L = 0xDC;

 IOCCN = 0x03;
 IOCCP = 0x03;
 IOCCF = 0x00;
 PIR0.TMR0IF = 0;

 INTCON = 0xC3;

}





void InitMCU(){
#line 287 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.2.0/FIRMWARE_MODBUS_ver_0_2_0.c"
 OSCCON1 = 0x70;
 OSCEN = 0x80;
 ADCON0 = 0x00;
 ANSELC = 0x00;
 ANSELE = 0x00;
 ANSELA = 0x00;
 ANSELB = 0x00;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x80;
 TRISB.B3 = 1;
 TRISB.B4 = 0;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;
 LATB = 0x00;

 WPUC = 0x03;
 INLVLC = 0x03;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;

 Unlock_IOLOCK();
 PPS_Mapping_NoLock(36, _INPUT, _RX1);
 PPS_Mapping_NoLock(37, _OUTPUT, _TX1);
 Lock_IOLOCK();




 UART1_Remappable_Init(9600);

 Delay_ms(100);






}

void UART1_Write_Text1(char *_cadena){
 while(*_cadena){
 UART1_Write(*_cadena);
 _cadena++;
 }
}

void UART1_Write_Text2(char *_text, int _long){
 while(_long--){
 UART1_Write(*_text++);
 }
}

void Read_SerialPort(){
 uart1_byte = UART1_Read();
 uart1_array[i] = uart1_byte;
 i++;
}
