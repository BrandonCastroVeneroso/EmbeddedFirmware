//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 1.0.4
//*******************************************************************
// Fecha: 01-04-2024
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

/* __I/O pin & estados_____________________________________________ */
#define LED LATA.F4 // LED de la placa en A4
#define M1 LATA.F5 // Actuador 1 en A5
#define M2 LATE.F0 // Actuador 2 en R0
#define M3 LATE.F1 // Actuador 3 en R1
#define M4 LATE.F2 // Actuador 4 en R2
#define SWITCH1 PORTC.F0 // Pastilla en C0
#define SWITCH2 PORTC.F1 // Pastilla en C1
/* __Boolean states________________________________________________ */
#define TRUE 1
#define FALSE 0
/* __Comandos ASM__________________________________________________ */
#define RESET asm{reset} // Por si necesitamos reiniciar el PIC en alguna parte
#define NOTHING asm{nop} // Do nothing
#define SLEEP asm{sleep} // Rutina de sleep

/*******************************************************************/
/************************ Variables Globales ***********************/
/*******************************************************************/

// Vector de interrupcion
bit interruptC0; // flag interrupcion en C0
bit interruptC1; // flag interrupcion en C1

// Posiciones del switch
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1

// Main

short unsigned int caso = 0;
short unsigned int caso_anterior = 3;

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void Events(); // Rutina de decision sentido de flanco

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

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

     do{
          Events();
     }while((1 == IOCCF.B0) || (1 == IOCCF.B1));

     while(1){
          switch(caso){
               case 0:
                    M1 = 0;
                    M2 = 0;
                    M3 = 0;
                    if(1 == sn_PosEdge_1){
                         if(1 == caso_anterior){
                              caso = 2;
                         }
                         else if(2 == caso_anterior){
                              caso = 3;
                         }
                         else if(3 == caso_anterior){
                              caso = 1;
                         }
                    }
                    break;
               case 1:
                    M1 = 1;
                    M2 = 1;
                    M3 = 0;
                    caso_anterior = 1;
                    if(1 == sn_NegEdge_1){
                         caso = 0;
                    }
                    else{
                         ;
                    }
                    break;
               case 2:
                    M1 = 0;
                    M2 = 1;
                    M3 = 1;
                    caso_anterior = 2;
                    if(1 == sn_NegEdge_1){
                         caso = 0;
                    }
                    else{
                         ;
                    }
                    break;
               case 3:
                    M1 = 1;
                    M2 = 0;
                    M3 = 1;
                    caso_anterior = 3;
                    if(1 == sn_NegEdge_1){
                         caso = 0;
                    }
                    else{
                         ;
                    }
                    break;
               default:
                    M1 = 0;
                    M2 = 0;
                    M3 = 0;
                    break;
          }
     }

}

//*******************************************************************
// Rutina de decision sentido de flanco
//*******************************************************************

void Events(){
     // Tenemos señal de bandera de interrupcion en C0?
     if(1 == interruptC0){
          // Si, el estado de SWITCH1 es 1?
          if(1 == SWITCH1){
               // Si, ponemos en 0 la señal de flanco positivo 1
               sn_PosEdge_1 = 0;
               sn_NegEdge_1 = 1;
          }
          // Si, el estado de SWITCH1 es 0?
          else{
               // Si, ponemos en 1 la señal de flanco positivo 1
               sn_PosEdge_1 = 1;
               sn_NegEdge_1 = 0;
          }
          interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
     }
     // Tenemos señal de bandera de interrupcion en C1?
     else if(1 == interruptC1){
          // Si, el estado de SWITCH2 es 1?
          if(1 == SWITCH2){
               // Si, ponemos en 0 la señal de flanco positivo 2
               sn_PosEdge_2 = 0;
               sn_NegEdge_2 = 1;
          }
          // Si, el estado de SWITCH2 es 0?
          else{
               // Si, ponemos en 1 la señal de flanco positivo 2
               sn_PosEdge_2 = 1;
               sn_NegEdge_2 = 0;
          }
          interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
     }
     else{
          interruptC0 = 0;
          interruptC1 = 0;
     }
     return;

}

//*******************************************************************
// Setup bits de configuracion interrupt
//*******************************************************************

void InitInterrupt(){

     PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
     PIR0 = 0x00;    // Limpiamos la bandera de IOC
     IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
     IOCCF = 0x00;   // Limpiamos la bandera de IOC
     INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)

}

//*******************************************************************
// Setup del MCU
//*******************************************************************

void InitMCU(){

     ADCON1 = 0x0F; // Desactivamos ADC
     ANSELC = 0;    // Ponemos en modo digital al puerto C
     ANSELE = 0;    //                ''                 E
     ANSELA = 0;    //                ''                 A

     TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
     TRISE = 0x00;  // Ponemos en modo salida al puerto E
     TRISA = 0x80;  //                ''                A

     PORTC = 0x00;  // Ponemos en linea baja en puerto C
     PORTE = 0x00;  //                ''             E
     PORTA = 0x10;  // Ponemos en linea alta en A4

     LATC = 0x00;   // Dejamos en cero el registro del puerto C
     LATE = 0x00;   //                ''                      E
     LATA = 0x10;   // Dejamos en 1 al pin A4

     WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
     INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
     CM1CON0 = 0x00; // Desactivamos el comparador 1
     CM2CON0 = 0x00; // Desactivamos el comparador 2

}
