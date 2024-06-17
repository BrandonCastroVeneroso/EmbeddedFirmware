//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 0.8.9.4
//*******************************************************************
// Fecha: 08-03-2024
//*******************************************************************
// Declaración de Constantes Generales.
//*******************************************************************
// HS(crystal oscillator) above 8 MHz
// EXTOSC with 4xPLL, with EXTOSC operating per FEXTOSC bits
// MCU Clock Frequenc: 64 MHz
//*******************************************************************

#define LED LATA.F4 // LED de la placa en A4
#define M1 LATA.F5 // Actuador 1 en A5
#define M2 LATE.F0 // Actuador 2 en R0
#define M3 LATE.F1 // Actuador 3 en R1
#define M4 LATE.F2 // Actuador 4 en R2
#define SWITCH1 PORTC.F0 // Pastilla en C0
#define SWITCH2 PORTC.F1
#define TRUE 1
#define FALSE 0
#define RESET asm{reset} // Por si necesitamos reiniciar el PIC en alguna parte

//*******************************************************************
// Variables
//*******************************************************************

bit flag01;    //
bit flag02;    // Banderas varias
bit clock0; // Bandera de reloj
bit interruptC0; // flag interrupcion en C0
bit interruptC1; // flag interrupcion en C1
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1
volatile unsigned int counter = 0; // Contador
//short unsigned int state = 0;         // Variable de barrido de la FSM
short unsigned int INC = 1;
bit AND_signal;
bit OR_signal;
// short unsigned int state = 0;
// short unsigned int next_state = 0;

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void FSM(); // FSM
void Events(); // Rutina de decision sentido de flanco
void CodigoGray(int _INC);

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

     if(PIR0.TMR0IF){
          TMR0H = 0x63;      // Timer para cada segundo y medio?
          TMR0L = 0xC0;      //
          PIR0.TMR0IF = 0;
          counter++;/*
          if(counter >= 50){
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
// Programa principal
//*******************************************************************

void main(){

     InitMCU();       // MCU pin/reg config
     InitInterrupt(); // MCU interrupt config

     while(1){
          short unsigned int state, next_state;

          Events();
          state = next_state;
          INC++;

          switch(state){
               case 0:
                    M1 = 1;
                    M3 = 0;
                    if(sn_PosEdge_1 == 1){
                         next_state = 1;
                    }
                    else{
                         next_state = 0;
                    }
                    break;
               case 1:
                    M2 = 1;
                    M1 = 0;
                    if(counter >= 30){
                         next_state = 2;
                         counter = 0;
                    }
                    break;
               case 2:
                    AND_signal = 1;
                    M3 = 1;
                    M2 = 0;
                    if(INC == 2){
                         M4 = 1;
                    }
                    else if(INC > 3){
                         LED = 0;
                         INC = 1;
                    }
                    // CodigoGray(INC);
                    if(sn_NegEdge_1){
                         next_state = 0;
                    }
                    else{
                         next_state = 2;
                    }
                    break;
               default:
                    next_state = 0;
                    state = 0;
                    break;
               }
     }

}

//*******************************************************************
// FSM
//*******************************************************************

void FSM(){
      short unsigned int state = 0;
      short unsigned int next_state = 0;

      state = next_state;
      switch(state){
           case 0:
               M1 = 1;
                M3 = 0;
                if(sn_PosEdge_1 == 1){
                     next_state = 1;
                     if(state == 1){
                          M4 = 1;
                     }
                     LED = ~LED;
                }
                else{
                     next_state = 0;
                }
                break;
           case 1:
                INC++;
                M2 = 1;
                M1 = 0;
                next_state = 2;
                break;
           case 2:
                LED = ~LED;
                AND_signal = 1;
                M3 = 1;
                M2 = 0;
                // CodigoGray(INC);
                if(sn_NegEdge_1){
                     next_state = 0;
                }
                else{
                     next_state = 2;
                }
                break;
      }

}

//*******************************************************************
// Generador de Codigo Gray
//*******************************************************************

void CodigoGray(int _INC){
     int gray = INC ^ (INC >> 1);
     char result[3];
     sprintf(result, "%u%u", (gray >> 1) & 1, (gray >> 0) & 1);
     switch(result[0]){
          case '0':
               switch(result[1]){
                    case '1':
                         if(AND_signal == 1){
                              M1 = 1;
                              M2 = 1;
                              M3 = 0;
                         }
                         else{
                              M1 = 0;
                              M2 = 0;
                              M3 = 0;
                         }
                         break;
               }
               break;
          case '1':
               switch(result[1]){
                    case '1':
                         if(AND_signal == 1){
                              M1 = 0;
                              M2 = 1;
                              M3 = 1;
                         }
                         else{
                              M1 = 0;
                              M2 = 0;
                              M3 = 0;
                         }
                         break;
                    case '0':
                         if(AND_signal == 1){
                              M1 = 1;
                              M2 = 0;
                              M3 = 1;
                         }
                         else{
                              M1 = 0;
                              M2 = 0;
                              M3 = 0;
                         }
                         break;
               }
               break;
     }
     return;
}

//*******************************************************************
// Rutina de decision sentido de flanco
//*******************************************************************

void Events(){
     if(interruptC0){
          if(SWITCH1 == 1){
               sn_PosEdge_1 = 0;
               sn_NegEdge_1 = 1;
          }
          else{
               sn_PosEdge_1 = 1;
               sn_NegEdge_1 = 0;
               // INC++;
          }
          // interruptC0 = 0;
     }
     else if(interruptC1){
          if(SWITCH2 == 1){
               sn_PosEdge_2 = 0;
               sn_NegEdge_2 = 1;
          }
          else{
               sn_PosEdge_2 = 1;
               sn_NegEdge_2 = 0;
               // INC++;
          }
          // interruptC1 = 0;
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
     T0CON0 = 0x90;
     T0CON1 = 0x44;
     TMR0H = 0x63;
     TMR0L = 0xC0;
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
