//*******************************************************************
// Programa: Implementacion Modbus para TAD
// Autor(es): Brandon Castro.
// Version: 0.2.0
//*******************************************************************
// Fecha: 15-04-2024
//*******************************************************************
// Declaración de Constantes Generales.
//*******************************************************************
// HS(crystal oscillator) above 8 MHz
// EXTOSC operating per FEXTOSC bits (device manufacturing default)
// MCU Clock Frequenc: 20 MHz
// MCU: PIC18LF47K40
//*******************************************************************

/********************************************************************/
/************* Declaración de Constantes Generales ******************/
/********************************************************************/

/* --I/O pin & estados--------------------------------------------- */
#define LED LATA.F4 // LED de la placa en A4
#define M1 LATA.F5 // Actuador 1 en A5
#define M2 LATE.F0 // Actuador 2 en R0
#define M3 LATE.F1 // Actuador 3 en R1
#define M4 LATE.F2 // Actuador 4 en R2
#define SWITCH1 PORTC.F0 // Pastilla en C0
#define SWITCH2 PORTC.F1 // Pastilla en C1
#define P0 LATC.F2
#define P1 LATC.F3
/* --Boolean states------------------------------------------------ */
#define TRUE 1
#define FALSE 0
/* --Comandos ASM-------------------------------------------------- */
#define RESET asm{reset} // Por si necesitamos reiniciar el PIC en alguna parte
#define NOTHING asm{nop} // Do nothing
#define SLEEP asm{sleep} // Rutina de sleep

/*******************************************************************/
/************************ Variables Globales ***********************/
/*******************************************************************/

// Vector de interrupcion
bit clock0; // Bandera de reloj
bit interruptC0; // flag interrupcion en C0
bit interruptC1; // flag interrupcion en C1
volatile int counter = 0; // Contador
volatile int counter1 = 0;
volatile int counter2 = 0;
bit timer0;
bit timer1;
bit timer3;

// Posiciones del switch
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1

// UART
bit uart1;
char uart1_byte;
unsigned char uart1_array[50];
char i = 0;
char letra_i[] = "12345678123456789123456789123456789123456789123456789123456789123456789";

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void Events(); // Rutina de decision sentido de flanco
void UART1_Write_Text1(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

     if(PIR0.TMR0IF){
          TMR0H = 0xEC;
          TMR0L = 0x78;
          PIR0.TMR0IF = 0;
          counter++;
          timer0 = ~timer0;
          if(counter >= 500){
               LED = ~LED;
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
               M1 = ~M1;
               counter1 = 0;
          }
     }
     if(PIR4.TMR3IF){
          TMR3H = 0x0B;
          TMR3L = 0xDC;
          PIR4.TMR3IF = 0;
          counter2++;
          if(counter2 >= 10){
               M2 = ~M2;
          timer3 = ~timer3;
               counter2 = 0;
          }
     }
     if(PIR3.RC1IF){
          PIR3.RC1IF = 0;
          M4 = ~M4;
     }
     // Tenemos bandera de IOC en C0? y el bit de enable en IOC esta en 1?
     if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
          IOCCF.B0 = 0; // Limpiamos la bandera de IOC
          interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
     }
     // Tenemos bandera de IOC en C1? y el bit de enable en IOC esta en 1?
     if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
          IOCCF.B1 = 0; // Limpiamos la bandera de IOC
          interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
     }

}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){

     InitInterrupt(); // MCU interrupt config
     InitMCU();       // MCU pin/reg config

     while(1){
          UART1_Remappable_Write(0x65);
          Delay_ms(200);
          Events();
          switch(sn_PosEdge_1){
          case 0:
               M3 = 0;
               break;
          case 1:
               M3 = 1;
               break;
          default:
               M3 = 0;
               break;
          }
     }

}

//*******************************************************************
// Rutina de decision sentido de flanco
//*******************************************************************

void Events(){
     switch(interruptC0){
          case 0:
               interruptC0 = 0;
               break;
          case 1:
               switch(SWITCH1){
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
               switch(SWITCH2){
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

//*******************************************************************
// Setup bits de configuracion interrupt
//*******************************************************************

void InitInterrupt(){
     // Enable and flags of interruptions
     PIE0 = 0x33;    // ~7, ~6, #5(TMR0IE), #4(IOCIE), ~3, !2, #1(INT1IE), #0(INT0IE)
     PIR0 = 0x00;    // ~7, ~6, RW#5(TMR0IF), R#4(IOCIF), ~3, RW[!2, #1(INT1IF), #0(INT0IF)]
     PIE3 = 0x20;    // !7, !6, #5(RC1IE), #4(TX1IE), !3, !2, !1, !0
     PIE4 = 0x05;    // ~7, ~6, !5, !4, !3, #2(TMR3IE), !1, #0(TMR1IE)
     PIR4 = 0x00;    // ~7, ~6, !5, !4, !3, RW[#2(TMR3IF), #0(TMR1IF)]
     // Timer 0
     T0CON0 = 0x90;  // #7(T0EN), ~6, !5, #4(T016BIT), ![3,2,1,0]
     T0CON1 = 0x40;  // [!7, #6, !5] = 010 (Fosc/4), !4, ![3, 2, 1, 0]
     TMR0H = 0xEC;   // Timer para 
     TMR0L = 0x78;   // 1 ms
     // Timer 1
     T1CON = 0x03;   // ~7, ~6, ![5, 4], ~3, ~2, #1(RD16), #0(ON)
     T1GCON = 0x00;  // !7, !6, !5, !4, !3, !2, ~1, ~0
     TMR1CLK = 0x01; // ~7, ~6, ~5, ~4, [!3, !2, !1, #0] = Fosc/4
     TMR1H = 0x3C;   // Timer para
     TMR1L = 0xB0;   // 10 ms
     // Timer 3
     T3CON = 0x33;   // ~7, ~6, [#5, #4] = 1:8 PRE, ~3, ~2, #1(RD16), #0(ON)
     T3GCON = 0x00;  // !7, !6, !5, !4, !3, !2, ~1, ~0
     TMR3CLK = 0x01; // ~7, ~6, ~5, ~4, [!3, !2, !1, #0] = Fosc/4
     TMR3H = 0x0B;   // Timer para
     TMR3L = 0xDC;   // 100 ms
     // Interrupt on change
     IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
     IOCCF = 0x00;   // Limpiamos la bandera de IOC
     PIR0.TMR0IF = 0;
     // Enable of interrupts
     INTCON = 0xC3;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)

}

//*******************************************************************
// Setup del MCU
//*******************************************************************

void InitMCU(){

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
     OSCCON1 = 0x70;   // ~7, [#6, #5, #4] = EXTOSC, ![3, 2, 1, 0]
     OSCEN = 0x80;     // #7(EXTOEN), !6, !5, !4, !3, !2, #1, #0
     ADCON0 = 0x00;    // !7, !6, ~5, !4, ~3, !2, ~1, !0
     ANSELC = 0x00;    // Ponemos en modo digital al puerto C
     ANSELE = 0x00;    //                ''                 E
     ANSELA = 0x00;    //                ''                 A
     ANSELB = 0x00;

     TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
     TRISE = 0x00;  // Ponemos en modo salida al puerto E
     TRISA = 0x80;  //                ''                A
     TRISB.B3 = 1;  // RX 
     TRISB.B4 = 0;  // TX

     PORTC = 0x00;  // Ponemos en linea baja en puerto C
     PORTE = 0x00;  //                ''             E
     PORTA = 0x10;  // Ponemos en linea alta en A4

     LATC = 0x00;   // Dejamos en cero el registro del puerto C
     LATE = 0x00;   //                ''                      E
     LATA = 0x10;   // Dejamos en 1 al pin A4
     LATB = 0x00;

     WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
     INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
     CM1CON0 = 0x00; // Desactivamos el comparador 1
     CM2CON0 = 0x00; // Desactivamos el comparador 2

     Unlock_IOLOCK();
     PPS_Mapping_NoLock(36, _INPUT, _RX1);
     PPS_Mapping_NoLock(37, _OUTPUT, _TX1);
     Lock_IOLOCK();

     // RX1PPS = 0x0B; // UART1 RX1 en RB3
     // RB4PPS = 0x09; // UART1 TX1 en RB4

     UART1_Remappable_Init(9600); // Iniciamos a UART1 en 115200 bauds

     Delay_ms(100);

     // do{
     //      char junk;
     //      junk++;
     // }while(0 == timer3);

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