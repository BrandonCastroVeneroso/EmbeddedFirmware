//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 0.9.0
//*******************************************************************
// Fecha: 15-03-2024
//*******************************************************************
// Declaración de Constantes Generales.
//*******************************************************************
// HS(crystal oscillator) above 8 MHz
// EXTOSC operating per FEXTOSC bits (device manufacturing default)
// MCU Clock Frequenc: 20 MHz
//*******************************************************************

#define LED LATA.F4 // LED de la placa en A4
#define M1 LATA.F5 // Actuador 1 en A5
#define M2 LATE.F0 // Actuador 2 en R0
#define M3 LATE.F1 // Actuador 3 en R1
#define M4 LATE.F2 // Actuador 4 en R2
#define SWITCH1 PORTC.F0 // Pastilla en C0
#define SWITCH2 PORTC.F1 // Pastilla en C1
#define TRUE 1
#define FALSE 0
#define RESET asm{reset} // Por si necesitamos reiniciar el PIC en alguna parte

//*******************************************************************
// Variables
//*******************************************************************

bit clock0; // Bandera de reloj
bit interruptC0; // flag interrupcion en C0
bit interruptC1; // flag interrupcion en C1
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1
volatile unsigned int counter = 0; // Contador
short unsigned int last_INC; // Ultimo estado de la variable de incremento
short unsigned int INC; // Variable de incremento
bit INC1; // Señal de redundancia para el valor 1 en INC
bit INC2; // Señal de redundancia para el valor 2 en INC
bit INC3; // Señal de redundancia para el valor 3 en INC
bit AND_signal; // Señal de confirmacion

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void Events(); // Rutina de decision sentido de flanco
char CodigoGray(short unsigned int *_INC); // Generador de codigo gray

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

     if(PIR0.TMR0IF){
          TMR0H = 0x06;      // Timer para cada segundo y medio?
          TMR0L = 0x00;      //
          PIR0.TMR0IF = 0;
          counter++;/*
          if(counter >= 100){
               clock0 = 1;
               LED = 0;
               counter = 0;
          }*/
     }
     // Tenemos bandera de IOC en C0? y el bit de enable en IOC esta en 1?
     if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
          IOCCF.B0 = 0; // Limpiamos la bandera de IOC
          interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
          // flag01 = 1;
          // clock0 = 1;
     }
     // Tenemos bandera de IOC en C1? y el bit de enable en IOC esta en 1?
     if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
          IOCCF.B1 = 0; // Limpiamos la bandera de IOC
          interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
          // flag01 = 1;
          // clock0 = 1;
     }

}

//*******************************************************************
// Rutina de decision sentido de flanco (usamos logica inversa)
//*******************************************************************

void Events(){
     // Tenemos señal de interrupcion en C0?
     if(interruptC0){
          // El switch esta en linea alta?
          if(SWITCH1 == 1){
               sn_PosEdge_1 = 0;
               sn_NegEdge_1 = 1; // Set señal de flanco negativo en s1
          }
          else{
               sn_PosEdge_1 = 1; // Set señal de flanco positivo en s1
               sn_NegEdge_1 = 0;
          }
     }
     // Tenemos señal de interrupcion en C1?
     else if(interruptC1){
          // El switch esta en linea alta?
          if(SWITCH2 == 1){
               sn_PosEdge_2 = 0;
               sn_NegEdge_2 = 1; // Set señal de flanco negativo en s2
          }
          else{
               sn_PosEdge_2 = 1; // Set señal de flanco positivo en s2
               sn_NegEdge_2 = 0;
          }
     }
     else{
          interruptC0 = 0;
          interruptC1 = 0;
     }
     return;
}

//*******************************************************************
// Gray Code Machine
//*******************************************************************

char CodigoGray(short unsigned int *_INC){
     // Realizamos generacion de codigos gray apartir de un valor inicial en INC
     int gray = INC ^ (INC >> 1);
     char result[5];
     // Generamos una cadena de texto con los dos caracteres que conforman el codigo Gray
     sprintf(result, "%u%u%u%u", (gray >> 3) & 1, (gray >> 2) & 1, (gray >> 1) & 1, (gray >> 0) & 1);
     // Switcheamos el primer caracter (solo tenemos 3 posibilidades de codigos: 01, 11, 10)
     switch(result[0]){
          case '0':
               switch(result[1]){
                    case '1':
                         // Tenemos señal de confirmacion?
                         if(AND_signal == 1){
                              // Regresamos 1
                              return 1;
                         }
                         else{
                              return 99;
                         }
                         break;
               }
               break;
          case '1':
               switch(result[1]){
                    case '1':
                         // Tenemos señal de confirmacion?
                         if(AND_signal == 1){
                              // Regresamos 2
                              return 2;
                         }
                         else{
                              return 99;
                         }
                         break;
                    case '0':
                         // Tenemos señal de confirmacion?
                         if(AND_signal == 1){
                              // Regresamos 3
                              return 3;
                         }
                         else{
                              return 99;
                         }
                         break;
               }
               break;
     }
     // Regresamos 0
     return 0;

}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){

     InitInterrupt(); // MCU interrupt config
     InitMCU();       // MCU pin/reg config

     while(1){
          short unsigned int state, next_state;
          Events();
          state = next_state;
          switch(state){
               case 0:
                    if(sn_PosEdge_1 == 1){
                         switch(last_INC){
                              case 1:
                                   INC1 = 0;
                                   INC2 = 1;
                                   INC3 = 0;
                                   INC = 2;
                                   next_state = 1;
                                   break;
                              case 2:
                                   INC1 = 0;
                                   INC2 = 0;
                                   INC3 = 1;
                                   INC = 3;
                                   next_state = 1;
                                   break;
                              case 3:
                                   INC1 = 1;
                                   INC2 = 0;
                                   INC3 = 0;
                                   INC = 1;
                                   next_state = 1;
                                   break;
                              default:
                                   INC1 = 1;
                                   INC2 = 0;
                                   INC3 = 0;
                                   INC = 1;
                                   next_state = 1;
                                   break;
                         }
                    }
                    break;
               case 1:
                    AND_signal = 1;
                    switch(INC){
                         case 1:
                              if(INC1){
                                   if(CodigoGray(INC) == 1){
                                        M1 = 1;
                                        M2 = 1;
                                        M3 = 0;
                                   }
                                   last_INC = 1;
                                   if(sn_NegEdge_1){
                                        next_state = 0;
                                        INC1 = 0;
                                   }
                                   else{
                                        INC1 = 1;
                                   }
                              }
                              break;
                         case 2:
                              if(INC2){
                                   if(CodigoGray(INC) == 2){
                                        M1 = 0;
                                        M2 = 1;
                                        M3 = 1;
                                   }
                                   last_INC = 2;
                                   if(sn_NegEdge_1){
                                        next_state = 0;
                                        INC2 = 0;
                                   }
                                   else{
                                        INC2 = 1;
                                   }
                              }
                              break;
                         case 3:
                              if(INC3){
                                   if(CodigoGray(INC) == 3){
                                        M1 = 1;
                                        M2 = 0; // Maybe these are the problem???
                                        M3 = 1;
                                   }
                                   last_INC = 3;
                                   if(sn_NegEdge_1){
                                        next_state = 0;
                                        INC3 = 0;
                                   }
                                   else{
                                        INC3 = 1;
                                   }
                              }
                              break;
                    }
                    break;
               default:
                    next_state = 0;
                    state = 0;
                    INC1 = 0;
                    INC2 = 0;
                    INC3 = 0;
                    INC = 0;
                    last_INC = 2;
                    break;
               }
          }

}

//*******************************************************************
// Setup bits de configuracion interrupt
//*******************************************************************

void InitInterrupt(){

     PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
     PIR0 = 0x00;    // Limpiamos la bandera de IOC
     T0CON0 = 0x90;  //
     T0CON1 = 0x40;  // Configuracion para Timer0, 16 bits, prescaler 1:1
     TMR0H = 0x06;   // Usamos el oscilador seleccionado Fosc/4, aprox 1 ms de interrupt @ 20 Mhz
     TMR0L = 0x00;   //
     IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
     IOCCF = 0x00;   // Limpiamos la bandera de IOC
     PIR0.TMR0IF = 0; // Limpiamos bandera de interrupt en Timer0
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
