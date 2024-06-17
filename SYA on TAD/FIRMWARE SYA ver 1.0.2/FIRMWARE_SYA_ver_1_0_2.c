//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 1.0.2
//*******************************************************************
// Fecha: 21-03-2024
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

// Posiciones del switch
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1

// Maquina de estados
bit GT1; // Bandera de señal para grupo de trabajo 1
bit GT2; // Bandera de señal para grupo de trabajo 1
bit GT3; // Bandera de señal para grupo de trabajo 1
bit sn_GoTo; // Bandera de señal para señal intermedia
short unsigned int current_state, next_state;

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void FSM(); // FSM
void Events(); // Rutina de decision sentido de flanco

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

     // if(PIR0.TMR0IF){
     //      TMR0H = 0x3C;      // Timer para cada segundo y medio?
     //      TMR0L = 0xB0;      //
     //      PIR0.TMR0IF = 0;
     //      counter++;
     //      if(counter >= 5){
     //           clock0 = 1;
     //           counter = 0;
     //      }
     // }
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
          clock0 = 1;
          current_state = next_state; // Maybe move this with Events
          FSM();
     }

}

//*******************************************************************
// FSM
//*******************************************************************

void FSM(){

     switch(current_state){
          case 0: // S0 - Todo apagado
               M1 = 0;
               M2 = 0;
               M3 = 0;
               sn_GoTo = 0;
               // Tenemos señal de flanco positivo 1?
               if((1 == sn_PosEdge_1) && (1 == clock0)){
                    next_state = 6; // Si, pasamos a estado 6
               }
               else{
                    next_state = 0;
               }
               break;
          case 1: // S1 - Grupo de trabajo 1 110
               M1 = 1;
               M2 = 1;
               M3 = 0;
               GT1 = 1;
               GT2 = 0;
               GT3 = 0;
               // Tenemos señal de flanco negativo 1?
               if((1 == sn_NegEdge_1) && (1 == clock0)){
                    // Si, pasamos a estado 5
                    next_state = 0;
                    //sn_GoTo = 1; // Ponemos en 1 la señal de transicion
               }
               // Tenemos señal de flanco positivo 2?
               else if((1 == sn_PosEdge_2) && (1 == clock0)){
                    // Si, pasamos a estado 4
                    next_state = 4;
               }
               // Si no,
               else{
                    next_state = 1;
               }
               break;
          case 2: // S2 - Grupo de trabajo 2 011
               M1 = 0;
               M2 = 1;
               M3 = 1;
               GT1 = 0;
               GT2 = 1;
               GT3 = 0;
               // Tenemos señal de flanco negativo 1?
               if((1 == sn_NegEdge_1) && (1 == clock0)){
                    // Si, pasamos a estado 5
                    next_state = 0;
               }
               // Tenemos señal de flanco positivo 2?
               else if((1 == sn_PosEdge_2) && (1 == clock0)){
                    // Si, pasamos a estado 4
                    next_state = 4;
               }
               // Si no,
               else{
                    next_state = 2;
               }
               break;
          case 3: // S3 - Grupo de trabajo 3 101
               M1 = 1;
               M2 = 0;
               M3 = 1;
               GT1 = 0;
               GT2 = 0;
               GT3 = 1;
               // Tenemos señal de flanco negativo 1?
               if((1 == sn_NegEdge_1) && (1 == clock0)){
                    // Si, pasamos a estado 5
                    next_state = 0;
               }
               // Tenemos señal de flanco positivo 2?
               else if((1 == sn_PosEdge_2) && (1 == clock0)){
                    // Si, pasamos a estado 4
                    next_state = 4;
               }
               // Si no,
               else{
                    next_state = 3;
               }
               break;
          case 4: // S4 - Grupo de trabajo 4 111
               M1 = 1;
               M2 = 1;
               M3 = 1;
               // Tenemos señal de flango negativo 2?
               if((1 == sn_NegEdge_1) && (1 == clock0)){
                    next_state = 0;
               }
               else if((1 == sn_NegEdge_2) && (1 == clock0)){
                    // Si, pasamos a estado 5
                    next_state = 5;
                    sn_GoTo = 1; // Ponemos en 1 la señal de transicion
               }
               // Si no,
               else{
                    next_state = 4;
               }
               break;
          case 5: // S5 - Estado de transicion para flanco negativo 2
               // Tenemos señal de transicion?
               if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
                    next_state = 2;
               }
               else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
                    next_state = 3;
               }
               else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
                    next_state = 1;
               }
               // Si no,
               else{
                    next_state = 5;
               }
               break;
          case 6: // S6 - Estado de transicion para flanco positivo
               if(1 == sn_PosEdge_1){
                    // Tenemos señal de GT1 y GT2 junto con GT3 en 0?
                    if((1 == GT1) && (1 == clock0)){
                         // Si, pasa a estado 2
                         next_state = 2;
                         GT2 = 0; // DO NOT
                         GT3 = 0; // DELETE !!!!
                    }
                    // // Tenemos señal de GT2 y GT1 junto con GT3 en 0?
                    else if((1 == GT2) && (1 == clock0)){
                         // Si, pasa a estado 3
                         next_state = 3;
                         GT1 = 0; // DO NOT
                         GT3 = 0; // DELETE !!!!
                    }
                    // Tenemos señal de GT3 y GT1 junto con GT2 en 0?
                    else if((1 == GT3) && (1 == clock0)){
                         // Si, pasa a estado 1
                         next_state = 1;
                         GT1 = 0; // DO NOT
                         GT2 = 0; // DELETE !!!!
                    }
                    // Si no,
                    else{
                         next_state = 6;
                    }
               }
               break;
          default:
               GT1 = 0;
               GT2 = 0;
               GT3 = 1;
               M1 = 0;
               M2 = 0;
               M3 = 0;
               current_state = 0;
               next_state = 0;
               break;
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
     // T0CON0 = 0x90;
     // T0CON1 = 0x40;
     // TMR0H = 0x3C;
     // TMR0L = 0xB0;
     IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
     IOCCF = 0x00;   // Limpiamos la bandera de IOC
     PIR0.TMR0IF = 0;
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
