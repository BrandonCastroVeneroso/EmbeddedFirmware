//*******************************************************************
// Programa: Implementacion Modbus para TAD
// Autor(es): Brandon Castro.
// Version: 0.3.0
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

#include "libs/system.h"
#include "libs/struct.h"
#include "libs/convert.h"

#define ID "TAD1"

/* --Misc I/O------------------------------------------------------ */
#define LED LATA.F4 // LED de la placa en A4
/* --Reles--------------------------------------------------------- */
#define R1 LATA.F5 // Actuador 1 en A5
#define R2 LATE.F0 // Actuador 2 en R0
#define R3 LATE.F1 // Actuador 3 en R1
#define R4 LATE.F2 // Actuador 4 en R2
/* --DIGITAL I/O--------------------------------------------------- */
#define DIG1 PORTC.F0 // Pastilla en C0
#define DIG2 PORTC.F1 // Pastilla en C1
#define DIG3 PORTC.F2
#define DIG4 PORTC.F3
#define DIG5 PORTD.F0
#define DIG6 PORTD.F1
#define DIG7 PORTD.F2
#define DIG8 PORTD.F3
#define DIG9 PORTC.F4
#define DIG10 PORTC.F5
#define DIG11 PORTC.F6
#define DIG12 PORTC.F7
#define DIG13 PORTD.F4
#define DIG14 PORTD.F5
#define DIG15 PORTD.F6
#define DIG16 PORTD.F7
/* --ANALOG INPUTS------------------------------------------------- */
#define EAN1 PORTA.F0
#define EAN2 PORTA.F1
#define EAN3 PORTA.F2
#define EAN4 PORTA.F3
/* --ANALOG INPUTS------------------------------------------------- */
#define OAN1 PORTB.F0
#define OAN2 PORTB.F1
#define OAN3 PORTB.F2
#define OAN4 PORTB.F5
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
volatile int count = 0;

// UART
bit uart1;
char uart1_byte;
unsigned char uart1_array[50];
char i = 0;
char letra_i[] = "12345678123456789123456789123456789123456789123456789123456789123456789";
COMINPUT in;
COMOUTPUT out;
char id[] = ID;

//*******************************************************************
// Prototipos
//*******************************************************************

void UART1_Write_Text1(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);
void Read_SerialPort();
void rxfunction();
char CheckID(char *s);

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){
     if(PIR0.TMR0IF){
          PIR0.TMR0IF = 0;
          TMR0H = 0xB;
          TMR0L = 0xDC;
     }
     if(PIR3.RC1IF){
          LED = ~LED;
          if(UART1_Data_Ready() == 1){
               rxfunction();
          }
     }
}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){

     InitSystem();
     EnableTimer0();
     in.rxIndex = 0;

     while(1){
          if(PIR4.TMR2IF){
               T2TMR = 0;
               if(in.TimeOutEnable){
                    in.TimeOut++;
                    if(in.TimeOut >= 100){
                         in.TimeOut = 0;
                         in.rxIndex = 0;
                    }
               }
          }
          if(in.rxFlag){
               in.rxFlag = 0;
          }
     }

}

//*******************************************************************
// Leemos datos en RX
//*******************************************************************

void rxfunction(){
     in.in_string[in.rxIndex++] = UART1_Remappable_Read();
     in.TimeOutEnable = 1;

     if(in.rxIndex >= 24){
          in.rxIndex = 0;
          in.rxFlag = 1;
          in.TimeOutEnable = 0;
          in.TimeOut = 0;
     }
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
