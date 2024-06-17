#line 1 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE ModBus ver 0.1.0/libs/configTAD_Modbus.c"
#line 1 "c:/users/brandon castro/documents/brandon castro veneroso/01 programas en desarrollo/modbus/firmware modbus ver 0.1.0/libs/configtad_modbus.h"




void InitMCU();
void InitInterrupt();
void UART1_Write_Text(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);
#line 7 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE ModBus ver 0.1.0/libs/configTAD_Modbus.c"
void InitInterrupt(){

 INTCON = 0xC3;
 PIR0 = 0x00;
 PIR4 = 0x00;
 PIE0 = 0x33;
 PIE3 = 0x30;
 TMR1IE_bit = 1;
 IOCCN = 0x03;
 IOCCP = 0x03;
 IOCCF = 0x00;
 PIR0.TMR0IF = 0;

}




void InitMCU(){
#line 49 "C:/Users/Brandon Castro/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE ModBus ver 0.1.0/libs/configTAD_Modbus.c"
 ADCON0 = 0x80;
 ANSELA = 0x0F;
 ANSELB = 0x27;
 ANSELC = 0x00;
 ANSELD = 0x00;
 ANSELE = 0x00;

 TRISA = 0x8F;
 TRISB.B0 = 0;
 TRISB.B1 = 0;
 TRISB.B2 = 0;
 TRISB.B5 = 0;
 TRISB.B3 = 1;
 TRISB.B4 = 0;
 TRISC = 0x03;
 TRISD = 0x00;
 TRISE = 0x00;

 PORTA = 0x10;
 PORTC = 0x00;
 PORTD = 0x00;
 PORTE = 0x00;

 LATA = 0x10;
 LATB = 0x00;
 LATC = 0x00;
 LATD = 0x00;
 LATE = 0x00;

 RX1PPS = 0x0B;
 RB4PPS = 0x09;

 WPUC = 0x03;
 INLVLC = 0x03;
 CM1CON0 = 0x00;
 CM2CON0 = 0x00;

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
