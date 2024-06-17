#include "configTAD_Modbus.h"

//*******************************************************************
// Setup bits de configuracion interrupt
//*******************************************************************

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
//*******************************************************************
// Setup del MCU
//*******************************************************************

void InitMCU(){

/*         _______
     MCLR-|°    B7|- ICSPDAT
     EA1 -|A0   B6|- ICSPCLK
     EA2 -|A1   B5|- SA4
     EA3 -|A2   B4|- TX
     EA4 -|A3   B3|- RX
     LED -|A4   B2|- SA3
     REL1-|A5   B1|- SA2
     REL2-|E0   B0|- SA1
     REL3-|E1     |- VDD
     REL4-|E2     |- VSS
     VDD -|     D7|- DIG16
     VSS -|     D6|- DIG15
     OSCE-|A6   D5|- DIG14
     OSCS-|A7   D4|- DIG13
     DIG1-|C0   C7|- DIG12
     DIG2-|C1   C6|- DIG11
     DIG3-|C2   C5|- DIG10
     DIG4-|C3   C4|- DIG9
     DIG5-|D0   D3|- DIG8
     DIG6-|D1___D2|- DIG7
*/
     ADCON0 = 0x80; // Desactivamos ADC
     ANSELA = 0x0F; // Pines en analogico A0-A3, A4-A7 digital
     ANSELB = 0x27; // Pines en analogico B0-B2 y B5
     ANSELC = 0x00; // Todos los pines en modo digital
     ANSELD = 0x00; // Todos los pines en modo digital
     ANSELE = 0x00; // Todos los pines en modo digital

     TRISA = 0x8F; // Entradas analogicas en A0-A3, entrada EXTOSC en A7
     TRISB.B0 = 0; //
     TRISB.B1 = 0; //
     TRISB.B2 = 0; // Salidas analogicas en B0-B2 y B5
     TRISB.B5 = 0; //
     TRISB.B3 = 1; // RX entrada
     TRISB.B4 = 0; // TX salida
     TRISC = 0x03; // C0 y C1 como salidas digitales
     TRISD = 0x00; // Salidas digitales
     TRISE = 0x00; // Salidas digitales

     PORTA = 0x10; // A4 en HIGH, los demas en LOW
     PORTC = 0x00; // Todos los pines en LOW
     PORTD = 0x00; // Todos los pines en LOW
     PORTE = 0x00; // Todos los pines en LOW

     LATA = 0x10; // A4 en HIGH, los demas en LOW
     LATB = 0x00; // Todos los pines en LOW
     LATC = 0x00; // Todos los pines en LOW
     LATD = 0x00; // Todos los pines en LOW
     LATE = 0x00; // Todos los pines en LOW

     RX1PPS = 0x0B; // UART1 RX1 en RB3
     RB4PPS = 0x09; // UART1 TX1 en RB4

     WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
     INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
     CM1CON0 = 0x00; // Desactivamos el comparador 1
     CM2CON0 = 0x00; // Desactivamos el comparador 2

     UART1_Remappable_Init(9600); // Iniciamos a UART1 en 9600 bauds
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