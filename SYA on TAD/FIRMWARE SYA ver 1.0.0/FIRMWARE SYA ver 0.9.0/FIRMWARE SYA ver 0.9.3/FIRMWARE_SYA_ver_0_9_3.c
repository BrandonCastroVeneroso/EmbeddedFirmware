//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 0.9.3
//*******************************************************************
// Fecha: 19-03-2024
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

/*******************************************************************/
/************************ Variables Globales ***********************/
/*******************************************************************/

// Vector de interrupcion
bit interruptC0; // flag interrupcion en C0
bit interruptC1; // flag interrupcion en C1
bit clock0; // Bandera de reloj
unsigned int counter = 0; // Contador

// Posiciones del switch
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1

// Generador Maquina Gray
int gray;
char result[3];
int bit0;
int bit1;
bit GT1;
bit GT2;
bit GT3;

// Maquina de estados
short unsigned int last_INC; // Ultimo estado de la variable de incremento
unsigned int INC; // Variable de incremento
short unsigned int fsm_state, next_state; // Variables de maquina de estado
bit INC1; // Señal de redundancia para el valor 1 en INC
bit INC2; // Señal de redundancia para el valor 2 en INC
bit INC3; // Señal de redundancia para el valor 3 en INC
bit AND_signal; // Señal de confirmacion

/*******************************************************************/
/*************************** Prototipos ****************************/
/*******************************************************************/

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void Events(); // Rutina de decision sentido de flanco
void CodigoGray(short unsigned int INC); // Generador de codigo gray

/*******************************************************************
                       Rutina de interrupcion
********************************************************************/

void interrupt(){

     // if(PIR0.TMR0IF){
     //      TMR0H = 0x3C;      // Timer para cada segundo y medio?
     //      TMR0L = 0xB0;      //
     //      PIR0.TMR0IF = 0;
     //      //counter++;
     //      /*
     //      if(counter >= 100){
     //           clock0 = 1;
     //           LED = 0;
     //           counter = 0;
     //      }*/
     // }
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

/*******************************************************************
                          Gray Code Machine
********************************************************************/

void CodigoGray(unsigned int INC){
     // Realizamos generacion de codigos gray apartir de un valor inicial en INC
     gray = INC ^ (INC >> 1);
     bit0 = (gray >> 0) & 1;
     bit1 = (gray >> 1) & 1;
     // Generamos una cadena de texto con los dos caracteres que conforman el codigo Gray
     sprintf(result, "%u%u", bit1, bit0);
     // Switcheamos el primer caracter (solo tenemos 3 posibilidades de codigos: 01, 11, 10)
     switch(result[0]){
          case '0':
               switch(result[1]){
                    case '1':
                         // Tenemos señal de confirmacion?
                         if(AND_signal == 1){
                              // Regresamos 1
                              GT1 = 1;
                              return;
                         }
                         else{
                              return;
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
                              GT2 = 1;
                              return;
                         }
                         else{
                              return;
                         }
                         break;
                    case '0':
                         // Tenemos señal de confirmacion?
                         if(AND_signal == 1){
                              // Regresamos 3
                              GT3 = 1;
                              return;
                         }
                         else{
                              return;
                         }
                         break;
               }
               break;
     }
     // Regresamos 0
     return;

}

/*******************************************************************
     Rutina de decision sentido de flanco (usamos logica inversa)
********************************************************************/

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

/*******************************************************************
                          Programa principal
********************************************************************/

void main(){

     InitInterrupt(); // MCU interrupt config
     InitMCU();       // MCU pin/reg config

     while(1){
          Events();
          // Cambiamos de estado al siguiente estado establecido
          fsm_state = next_state;
          switch(fsm_state){
               // Estado 0
               case 0:
                    LED = 0; // Idk if this breaks the code or not
                    // Tenemos señal de flanco positivo en s1?
                    if(sn_PosEdge_1 == 1){
                         switch(last_INC){
                              // Si el ultimo estado en INC fue 1
                              case 1:
                                   INC1 = 0;
                                   INC2 = 1; // El siguiente estado en INC es 2
                                   INC3 = 0;
                                   INC = 2;
                                   next_state = 1; // Cambia a siguiente estado 1
                                   break;
                              // Si el ultimo estado en INC fue 2
                              case 2:
                                   INC1 = 0;
                                   INC2 = 0;
                                   INC3 = 1; // El siguiente estado en INC es 3
                                   INC = 3;
                                   next_state = 1; // Cambia a siguiente estado 1
                                   break;
                              case 3:
                                   INC1 = 1; // El siguiente estado en INC es 1
                                   INC2 = 0;
                                   INC3 = 0;
                                   INC = 1;
                                   next_state = 1; // Cambia a siguiente estado 1
                                   break;
                              default:
                                   INC1 = 1; // Por default el estado en INC sera uno
                                   INC2 = 0;
                                   INC3 = 0;
                                   INC = 1;
                                   next_state = 1;
                                   break;
                         }
                    }
                    break;
               // Estado 1
               case 1:
                    AND_signal = 1; // Señal de confirmacion
                    switch(INC){
                         // Valor 1 para INC
                         case 1:
                              // Tenemos señal de redundancia?
                              if(INC1){
                                   // El resultado de la funcion es 1?
                                   CodigoGray(INC);
                                   switch(GT1){
                                        case 0:
                                             M1 = 0;
                                             M2 = 0;
                                             M3 = 0;
                                             break;
                                        case 1:
                                             M1 = 1;
                                             M2 = 1; // Grupo de trabajo 1 (Bombas 1 y 2)
                                             M3 = 0;
                                             break;
                                   }
                                   last_INC = 1; // Seteamos que el ultimo valor de INC es 1
                                   // Tenemos señal de flanco negativo en s1?
                                   if(sn_NegEdge_1){
                                        next_state = 0; // Regresa a estado 0
                                        INC1 = 0; // Baja la señal de redundancia
                                        GT1 = 0;
                                   }
                                   else{
                                        INC1 = 1; // Manten la señal de redundancia
                                   }
                              }
                              break;
                         // Valor 2 para INC
                         case 2:
                              // Tenemos señal de redundancia?
                              if(INC2){
                                   // El resultado de la funcion es 2?
                                   CodigoGray(INC);
                                   switch(GT2){
                                        case 0:
                                             M1 = 0;
                                             M2 = 0;
                                             M3 = 0;
                                             break;
                                        case 1:
                                             M1 = 0;
                                             M2 = 1; // Grupo de trabajo 2 (Bombas 2 y 3)
                                             M3 = 1;
                                             break;
                                   }
                                   last_INC = 2; // Seteamos que el ultimo valor de INC es 2
                                   // Tenemos señal de flanco negativo en s1?
                                   if(sn_NegEdge_1){
                                        next_state = 0; // Regresa a estado 0
                                        INC2 = 0; // Baja la señal de redundancia
                                        GT2 = 0;
                                   }
                                   else{
                                        INC2 = 1; // Manten la señal de redundancia
                                   }
                              }
                              break;
                         // Valor 3 para INC
                         case 3:
                              // Tenemos señal de redundancia?
                              if(INC3){
                                   // El resultado de la funcion es 3?
                                   CodigoGray(INC);
                                   switch(GT3){
                                        case 0:
                                             M1 = 0;
                                             M2 = 0;
                                             M3 = 0;
                                             break;
                                        case 1:
                                             M1 = 1;
                                             M2 = 0; // Grupo de trabajo 3 (Bombas 1 y 3)
                                             M3 = 1;
                                             break;
                                   }
                                   last_INC = 3; // Seteamos que el ultimo valor de INC es 3
                                   // Tenemos señal de flanco negativo en s1?
                                   if(sn_NegEdge_1){
                                        next_state = 0; // Regresa a estado 0
                                        INC3 = 0; // Baja la señal de redundancia
                                        GT3 = 0;
                                   }
                                   else{
                                        INC3 = 1; // Manten la señal de redundancia
                                   }
                              }
                              break;
                    }
                    break;
               default:
                    next_state = 0;
                    fsm_state = 0;
                    INC1 = 0;
                    INC2 = 0; // Por default dejamos todo en 0 y el ultimo estado de INC en 2
                    INC3 = 0;
                    INC = 0;
                    last_INC = 2;
                    GT1 = 0;
                    GT2 = 0;
                    GT3 = 0;
                    break;
               }
          }

}

/*******************************************************************
                  Setup bits de configuracion interrupt
********************************************************************/

void InitInterrupt(){

     PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
     PIR0 = 0x00;    // Limpiamos la bandera de IOC
     // T0CON0 = 0x90;  //
     // T0CON1 = 0x40;  // Configuracion para Timer0, 16 bits, prescaler 1:1
     // TMR0H = 0x3C;   // Usamos el oscilador seleccionado Fosc/4, aprox 1 ms de interrupt @ 20 Mhz
     // TMR0L = 0xB0;   //
     IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
     IOCCF = 0x00;   // Limpiamos la bandera de IOC
     PIR0.TMR0IF = 0; // Limpiamos bandera de interrupt en Timer0
     INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)

}

/*******************************************************************
                             Setup del MCU
********************************************************************/

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
