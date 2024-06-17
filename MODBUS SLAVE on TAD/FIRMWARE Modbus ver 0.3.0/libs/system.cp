#line 1 "D:/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.3.0/libs/system.c"
#line 1 "d:/documents/brandon castro veneroso/01 programas en desarrollo/modbus/firmware modbus ver 0.3.0/libs/system.h"



void DeviceConfig();
void ClockConfig();
void EUSARTConfig();
void InterruptConfig();
void InitSystem();
void EnableTimer0();
#line 28 "D:/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.3.0/libs/system.c"
void DeviceConfig(){
 LATA = 0x10;
 LATB = 0x00;
 LATC = 0x00;
 LATD = 0x00;
 LATE = 0x00;

 TRISA = 0xCF;
 TRISB = 0xC8;
 TRISC = 0xFF;
 TRISD = 0xFF;
 TRISE = 0x00;

 ANSELA = 0xCF;
 ANSELB = 0xC0;
 ANSELC = 0x00;
 ANSELD = 0x00;
 ANSELE = 0x00;

 WPUA = 0x00;
 WPUB = 0x00;
 WPUC = 0x00;
 WPUD = 0x00;
 WPUE = 0x00;

 SLRCONA = 0xFF;
 SLRCONB = 0xFF;
 SLRCONC = 0xFF;
 SLRCOND = 0xFF;
 SLRCONE = 0x07;

 INLVLA = 0xFF;
 INLVLB = 0xFF;
 INLVLC = 0xFF;
 INLVLD = 0xFF;
 INLVLE = 0x07;

 RB4PPS = 0x09;
 RX1PPS = 0x0B;
}

void ClockConfig(){
 OSCCON1 = 0x70;
 OSCEN = 0x80;
}

void InitEUSART(){
 UART1_Remappable_Init(19200);
}

void InterruptConfig(){
 INTCON = 0xC0;

 T0CON0 = 0x90;
 T0CON1 = 0x43;
 TMR0H = 0xB;
 TMR0L = 0xDC;

 T2CLKCON = 0x01;
 T2HLT = 0x00;
 T2RST = 0x00;
 T2PR = 0x4D;
 T2TMR = 0x00;
 T2CON = 0xE0;

 PIR0 = 0x00;
 PIE3 = 0x20;
 PIR3 = 0x00;
 PIR4 = 0x00;
}

void InitSystem(){
 InterruptConfig();
 DeviceConfig();
 ClockConfig();
 InitEUSART();
}

void EnableTimer0(){
 PIE0.TMR0IE = 1;
}
