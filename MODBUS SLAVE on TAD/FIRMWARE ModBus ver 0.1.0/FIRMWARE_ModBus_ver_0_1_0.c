//*******************************************************************
// Programa: Implementacion Modbus para TAD
// Autor(es): Brandon Castro.
// Version: 0.1.0
//*******************************************************************
// Fecha: 10-04-2024
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

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU();
void InitInterrupt();
void UART1_Write_Text1(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);

void interrupt(){
     if(PIR0.TMR0IF){
          TMR0H = 0x3C;      // Timer para cada segundo y medio?
          TMR0L = 0xB0;      //
          PIR0.TMR0IF = 0;
          counter++;
          if(counter >= 5){
               clock0 = 1;
               counter = 0;
          }
     }
}

//*******************************************************************
// Programa principal
//*******************************************************************

void main() {

     InitInterrupt();
     InitMCU();

     while(1){
          LED = 1;
          Delay_ms(100);
          LED = 0;
          Delay_ms(100);
     }

}

//*******************************************************************
// Setup bits de configuracion interrupt
//*******************************************************************

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

     ADCON1 = 0x0F; // Desactivamos ADC
     ANSELC = 0;    // Ponemos en modo digital al puerto C
     ANSELE = 0;    //                ''                 E
     ANSELA = 0;    //                ''                 A
     ANSELB = 0x00; // Pines en analogico B0-B2 y B5

     TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
     TRISE = 0x00;  // Ponemos en modo salida al puerto E
     TRISA = 0x80;  //                ''                A
     TRISB.B0 = 0; //
     TRISB.B1 = 0; //
     TRISB.B2 = 0; // Salidas analogicas en B0-B2 y B5
     TRISB.B5 = 0; //
     TRISB.B3 = 1; // RX entrada
     TRISB.B4 = 0; // TX salida

     PORTC = 0x00;  // Ponemos en linea baja en puerto C
     PORTE = 0x00;  //                ''             E
     PORTA = 0x10;  // Ponemos en linea alta en A4

     LATC = 0x00;   // Dejamos en cero el registro del puerto C
     LATE = 0x00;   //                ''                      E
     LATA = 0x10;   // Dejamos en 1 al pin A4

     RX1PPS = 0x0B; // UART1 RX1 en RB3
     RB4PPS = 0x09; // UART1 TX1 en RB4

     WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
     INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
     CM1CON0 = 0x00; // Desactivamos el comparador 1
     CM2CON0 = 0x00; // Desactivamos el comparador 2

     UART1_Remappable_Init(9600); // Iniciamos a UART1 en 9600 bauds
     // Delay_ms(100);

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