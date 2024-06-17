#line 1 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE ModBus ver 0.1.0/FIRMWARE_ModBus_ver_0_1_0.c"
#line 41 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE ModBus ver 0.1.0/FIRMWARE_ModBus_ver_0_1_0.c"
bit clock0;
bit interruptC0;
bit interruptC1;
volatile int counter = 0;





void InitMCU();
void InitInterrupt();
void UART1_Write_Text1(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);

void interrupt(){
 if(PIR0.TMR0IF){
 TMR0H = 0x3C;
 TMR0L = 0xB0;
 PIR0.TMR0IF = 0;
 counter++;
 if(counter >= 5){
 clock0 = 1;
 counter = 0;
 }
 }
}





void main() {

 InitInterrupt();
 InitMCU();

 while(1){
  LATA.F4  = 1;
 Delay_ms(100);
  LATA.F4  = 0;
 Delay_ms(100);
 }

}





void InitInterrupt(){

 INTCON = 0xC3;
 PIR0 = 0x00;
 PIR4 = 0x00;
 PIE0 = 0x33;
 PIE3 = 0x30;
 T0CON0 = 0x90;
 T0CON1 = 0x40;
 TMR0H = 0x3C;
 TMR0L = 0xB0;
 TMR1IE_bit = 1;
 IOCCN = 0x03;
 IOCCP = 0x03;
 IOCCF = 0x00;
 PIR0.TMR0IF = 0;

}




void InitMCU(){
#line 137 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE ModBus ver 0.1.0/FIRMWARE_ModBus_ver_0_1_0.c"
 ADCON1 = 0x0F;
 ANSELC = 0;
 ANSELE = 0;
 ANSELA = 0;
 ANSELB = 0x00;

 TRISC = 0x03;
 TRISE = 0x00;
 TRISA = 0x80;
 TRISB.B0 = 0;
 TRISB.B1 = 0;
 TRISB.B2 = 0;
 TRISB.B5 = 0;
 TRISB.B3 = 1;
 TRISB.B4 = 0;

 PORTC = 0x00;
 PORTE = 0x00;
 PORTA = 0x10;

 LATC = 0x00;
 LATE = 0x00;
 LATA = 0x10;

 RX1PPS = 0x0B;
 RB4PPS = 0x09;

 WPUC = 0x03;
 INLVLC = 0x03;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;

 UART1_Remappable_Init(9600);


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
