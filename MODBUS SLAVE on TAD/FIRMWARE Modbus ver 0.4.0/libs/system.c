#include "system.h"

/*         _______
          |       |
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
     DIG6-|D1   D2|- DIG7
          |_______|
*/

void DeviceConfig(){
     LATA = 0x10; // #7 (LED), !6, !5, !4, !3, !2, !1, !0
     LATB = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
     LATC = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
     LATD = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
     LATE = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0

     TRISA = 0xCF; // #7 (OSC1), #6 (OSC2), !5 (RELE 1), !4 (LED), #3 (ANA_INPUT 4), #2 (ANA_INPUT 3), #1 (ANA_INPUT 2), #0 (ANA_INPUT 1)
     TRISB = 0xC8; // #7 (ICSPD), #6 (ICSPC), !5 (ANA_OUTPUT 4), !4 (TX), #3 (RX), !2 (ANA_OUTPUT 3), !1 (ANA_OUTPUT 2), !0 (ANA_OUTPUT 1)
     TRISC = 0xFF; // DIG 1 - 16
     TRISD = 0xFF; // Input
     TRISE = 0x00; // ~[7,6,5,4,3], !2 (RELE 4), !1 (RELE 3), !0 (RELE 2)

     ANSELA = 0xCF; // #7 (OSC1), #6 (OSC2), !5 (RELE 1), !4 (LED), #3 (ANA_INPUT 4), #2 (ANA_INPUT 3), #1 (ANA_INPUT 2), #0 (ANA_INPUT 1)
     ANSELB = 0xC0; // #7 (ICSPD), #6 (ICSPC), !5 (ANA_OUTPUT 4), !4 (TX), !3 (RX), !2 (ANA_OUTPUT 3), !1 (ANA_OUTPUT 2), !0 (ANA_OUTPUT 1)
     ANSELC = 0x00; // DIG 1 - 16 
     ANSELD = 0x00; // Digital
     ANSELE = 0x00; // RELE 4 - 2 

     WPUA = 0x00; //
     WPUB = 0x00; //
     WPUC = 0x00; // Desactivamos los Weak-PullUps
     WPUD = 0x00; //
     WPUE = 0x00; //

     SLRCONA = 0xFF; //
     SLRCONB = 0xFF; //
     SLRCONC = 0xFF; // Dejamos el limite de SlewRate
     SLRCOND = 0xFF; //
     SLRCONE = 0x07; //

     INLVLA = 0xFF; // 
     INLVLB = 0xFF; // 
     INLVLC = 0xFF; // Dejamos los niveles TTL
     INLVLD = 0xFF; // 
     INLVLE = 0x07; // 

     RB4PPS = 0x09; // TX1 --> RB4
     RX1PPS = 0x0B; // RX1 --> RB3
}

void ClockConfig(){
     OSCCON1 = 0x70;   // ~7, [#6, #5, #4] = EXTOSC, ![3, 2, 1, 0]
     OSCEN = 0x80;     // #7(EXTOEN), !6, !5, !4, !3, !2, #1, #0
}

void InitEUSART(){
     BAUD1CON = 0x58;
     RC1STA = 0x90;
     TX1STA = 0x26;
     SP1BRGL = 0x3;
     SP1BRGH = 0x1;
     //UART1_Remappable_Init(115200); // EUSART 1 con 19200 baud
}

void InterruptConfig(){
     INTCON = 0xC0; // GIE = 1, PIE = 1
     // Timer 0-100 ms, 1:8 pre, 16 bit, FOSC/4
     T0CON0 = 0x90;
     T0CON1 = 0x43;
     TMR0H = 0xB;
     TMR0L = 0xDC;
     // Timer 2-1 ms, 1:64 pre, FOSC/4, Rising Edge pol, roll over pulse, software control
     T2CLKCON = 0x01;
     T2HLT = 0x00;
     T2RST = 0x00;
     T2PR = 0x4D;
     T2TMR = 0x00;
     T2CON = 0xE0;
     // Interrup Enable
     PIR0 = 0x00;
     PIE3 = 0x20; // RC1IE = 1 (EUSART 1 RX)
     PIR3 = 0x00;
     PIR4 = 0x00;
}

void InitSystem(){
     InterruptConfig();
     DeviceConfig();
     ClockConfig();
     InitEUSART();
     LATA.F4 = ~LATA.F4;
}

void EnableTimer0(){
     PIE0.TMR0IE = 1;
}