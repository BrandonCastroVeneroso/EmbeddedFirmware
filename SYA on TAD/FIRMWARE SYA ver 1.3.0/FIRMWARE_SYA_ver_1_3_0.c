//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas (3 bombas y 3 peras)
// Autor(es): Brandon Castro.
// Version: 1.3.0
//*******************************************************************
// Fecha: 13-05-2024
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
#define SWITCH3 PORTC.F2 // Pastilla en C2
#define TEST1 PORTC.F3 // Testigo de M1
#define TEST2 PORTD.F0 // Testigo de M2
#define TEST3 PORTD.F1 // Testigo de M3
#define TEST4 PORTD.F2 // Testigo de M4
/* --Boolean states------------------------------------------------ */
#define TRUE 1
#define FALSE 0
/* --Comandos ASM-------------------------------------------------- */
#define RESET asm{reset} // Por si necesitamos reiniciar el PIC en alguna parte
#define NOTHING asm{nop} // Do nothing
#define SLEEP asm{sleep} // Rutina de sleep
/* --FSM States---------------------------------------------------- */
typedef enum{
     s0, // S0 Todo apagado
     s1, // S1 GT1 - 100
     s2, // S2 GT2 - 010
     s3, // S3 GT3 - 001
     s4, // S4 Seleccion segundo motor
     s5, // S5 Simultaneo
     s6, // S6 Alternancia de segundo motor
     s7  // S7 Alternancia GT
} State;

/*******************************************************************/
/************************ Variables Globales ***********************/
/*******************************************************************/

// Vector de interrupcion
int clock0; // Bandera de reloj
volatile int interruptC0 = 0; // flag interrupcion en C0
volatile int interruptC1 = 0; // flag interrupcion en C1
volatile int interruptC2 = 0; // flag interrupcion en C1
volatile int counter = 0; // Contador
volatile int counter1 = 0; // Contador

// Posiciones del switch
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_PosEdge_3; // Bandera de señal para transicion positiva en C2
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1
bit sn_NegEdge_3; // Bandera de señal para transicion negativa en C2

// Maquina de estados
bit GT1; // Bandera de señal para grupo de trabajo 1
bit GT2; // Bandera de señal para grupo de trabajo 1
bit GT3; // Bandera de señal para grupo de trabajo 1
int sn_GoTo = 0; // Bandera de señal para señal intermedia
int sn_GoToGT = 0;
int sn_error = 0;
short unsigned int current_state, next_state;

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void InitSystems(); // Inicia sistema
void FSM(); // FSM
void Events(); // Rutina de decision sentido de flanco
void M1On(){M1 = 1;}
void M1Off(){M1 = 0;}
void M2On(){M2 = 1;}
void M2Off(){M2 = 0;}
void M3On(){M3 = 1;}
void M3Off(){M3 = 0;}

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

     if(PIR0.TMR0IF){
          TMR0H = 0x3C;      // Timer para cada segundo y medio?
          TMR0L = 0xB0;      //
          PIR0.TMR0IF = 0;
          counter++;
          if(counter >= 200){
               LED = ~LED;
               Events();
               PIE0.TMR0IE = 0;
               counter = 0;
          }
     }
     if(1 == IOCCF.B0){
          IOCCF.B0 = 0; // Limpiamos la bandera de IOC
          interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
          Delay_ms(100); 
          if(1 == SWITCH1){
               sn_PosEdge_1 = 0;
               sn_NegEdge_1 = 1;
               interruptC0 = 0;
               if(!SWITCH3){
                    next_state = s5;
               }
          }
          else{
               sn_GoToGT = 1;
               sn_PosEdge_1 = 1;
               sn_NegEdge_1 = 0;
               interruptC0 = 0; 
               if(!SWITCH2){
                    next_state = s4;
                    if(!SWITCH3){
                         next_state = s5;
                    }
                    else{
                         next_state = s4;
                    }
               }
               else{
                    next_state = s7;
                    if(!SWITCH3){
                         next_state = s5;
                    }
               }
          }
     }
     // Tenemos bandera de IOC en C1? y el bit de enable en IOC esta en 1?
     if(1 == IOCCF.B1){
          IOCCF.B1 = 0; // Limpiamos la bandera de IOC
          interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
          Delay_ms(100);
          if(1 == SWITCH2){
               sn_PosEdge_2 = 0;
               sn_NegEdge_2 = 1;
               interruptC1 = 0; 
               if(!SWITCH1){
                    sn_GoToGT = 1;
               }
          }
          else{
               sn_PosEdge_2 = 1;
               sn_NegEdge_2 = 0;
               next_state = s4;
               interruptC1 = 0;
               if(!SWITCH3){
                    next_state = s5;
               }
               else{
                    next_state = s4;
               }
          }
     }
     // Tenemos bandera de IOC en C0? y el bit de enable en IOC esta en 1?
     if(1 == IOCCF.B2){
          IOCCF.B2 = 0; // Limpiamos la bandera de IOC
          interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
          Delay_ms(100);
          if(1 == SWITCH3){
               sn_PosEdge_3 = 0;
               sn_NegEdge_3 = 1;
               interruptC2 = 0;
               if(!SWITCH1){
                    sn_GoToGT = 1;
                    sn_error = 1;
               }
               if(!SWITCH2){
                    sn_GoTo = 1;
               }
          }
          else{
               sn_PosEdge_3 = 1;
               sn_NegEdge_3 = 0;
               next_state = s5;
               interruptC2 = 0;
               if(!SWITCH1){
                    next_state = s5;
               }
          }
     }

}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){

     InitSystems();

     while(1){
          current_state = next_state; // Maybe move this with Events
          FSM();
     }

}

//*******************************************************************
// FSM
//*******************************************************************

void FSM(){
     switch(current_state){
          case s0: 
               M1 = 0;
               M2 = 0;
               M3 = 0;
               // sn_GoToGT = 1;
               if(1 == sn_PosEdge_1){
                    next_state = s7; 
               }
               else{
               }
               break;
          case s1: 
               M1 = 1;
               M2 = 0;
               M3 = 0;
               GT1 = 1;
               GT2 = 0;
               GT3 = 0;
               if(1 == sn_NegEdge_1){
               
                    next_state = s0;
               }
               else if(1 == sn_PosEdge_2){
                    next_state = s4;
               }
               else{
               }
               break;
          case s2: 
               M1 = 0;
               M2 = 1;
               M3 = 0;
               GT1 = 0;
               GT2 = 1;
               GT3 = 0;
               if(1 == sn_NegEdge_1){
                    next_state = s0;
               }
               else if(1 == sn_PosEdge_2){
                    next_state = s4;
               }
               else{
               }
               break;
          case s3: 
               M1 = 0;
               M2 = 0;
               M3 = 1;
               GT1 = 0;
               GT2 = 0;
               GT3 = 1;
               if(1 == sn_NegEdge_1){
                    next_state = s0;
               }
               else if(1 == sn_PosEdge_2){
                    next_state = s4;
               }
               else{
               }
               break;
          case s4:
               sn_GoTo = 1;
               if((1 == GT1) && (0 == GT2) && (0 == GT3)){
                    M1 = 1;
                    M2 = 1;
                    M3 = 0;
                    GT2 = 0;
                    GT3 = 0;
               }
               else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
                    M1 = 0;
                    M2 = 1;
                    M3 = 1;
                    GT1 = 0;
                    GT3 = 0;
               }
               else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
                    M1 = 1;
                    M2 = 0;
                    M3 = 1;
                    GT1 = 0;
                    GT2 = 0;
               }
               if(1 == sn_NegEdge_2){
                    next_state = s7;
               }
               else if(1 == sn_PosEdge_3){
                    next_state = s5;
               }
               else{
               }
               break;
          case s5:
               M1 = 1;
               M2 = 1;
               M3 = 1;
               if(1 == sn_NegEdge_3){
                    next_state = s6;
               }
               else{
               }
               break;
          case s6:
               if(sn_GoTo){
                    if((1 == GT1) && (0 == GT2) && (0 == GT3)){
                         GT2 = 1;
                         GT3 = 0;
                         GT1 = 0;
                         next_state = s4;
                    }
                    else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
                         GT2 = 0;
                         GT1 = 0;
                         GT3 = 1;
                         next_state = s4;
                    }
                    else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
                         GT1 = 1;
                         GT2 = 0;
                         GT3 = 0;
                         next_state = s4;
                    }
                    else{
                    }
               }
               else if(sn_error){
                    next_state = s7;
               }
               else{
                    next_state = s0;
               }
               break;
          case s7:
               clock0 = 0;
                if(!SWITCH3){
                    next_state = s5;
               }
               else if(sn_GoToGT){
                    if((1 == GT1) && (0 == GT2) && (0 == GT3)){
                         next_state = s2;
                    }
                    else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
                         next_state = s3;
                    }
                    else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
                         next_state = s1;
                    }
               }
               else{
                    next_state = s0;
               }
               break;
          default:
               current_state = s0;
               next_state = s0;
               break;
     }

}

//*******************************************************************
// Rutina de decision sentido de flanco
//*******************************************************************

void Events(){
     sn_NegEdge_1 = 0;
     sn_NegEdge_2 = 0;
     sn_NegEdge_3 = 0;
     sn_PosEdge_1 = 0;
     sn_PosEdge_2 = 0;
     sn_PosEdge_3 = 0;
     switch(SWITCH1){
          case 0:
               next_state = s1;
               switch(SWITCH2){
                    case 0:
                         next_state = s4;
                         switch(SWITCH3){
                              case 0:
                                   next_state = s5;
                                   break;
                              case 1:
                                   next_state = s4;
                                   break;
                         }
                         break;
                    case 1:
                         switch(SWITCH3){
                              case 0:
                                   next_state = s5;
                                   break;
                              case 1:
                                   next_state = s1;
                                   break;
                         }
                         break;
               }
               break;
          case 1:
               switch(SWITCH2){
                    case 0:
                         next_state = s4;
                         switch(SWITCH3){
                              case 0:
                                   next_state = s5;
                                   break;
                              case 1:
                                   next_state = s4;
                                   break;
                         }
                         break;
                    case 1:
                         switch(SWITCH3){
                              case 0:
                                   next_state = s5;
                                   break;
                              case 1:
                                   next_state = s0;
                                   break;
                         }
                         break;
               }
               break;
     }
     return;

}

//*******************************************************************
// Inicio del sistema
//*******************************************************************

void InitSystems(){
     Delay_ms(1000);
     InitInterrupt();
     InitMCU();
     Delay_ms(1000);
     Events();
}

//*******************************************************************
// Setup bits de configuracion interrupt
//*******************************************************************

void InitInterrupt(){
     // Peripheral Interrupt 0
     PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
     PIR0 = 0x00;    // Limpiamos la bandera de IOC
     // Timer 0 Setup
     T0CON0 = 0x90;
     T0CON1 = 0x40;
     TMR0H = 0x3C;
     TMR0L = 0xB0;
     // IOC Setup
     IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
     IOCCF = 0x00;   // Limpiamos la bandera de IOC
     PIR0.TMR0IF = 0;
     // Peripheral Interrupt 4
     PIE4 = 0x02;
     PIR4 = 0x00;
     // Timer 1 Setup
     T1CON = 0x03;   // ~7, ~6, ![5, 4], ~3, ~2, #1(RD16), #0(ON)
     T1GCON = 0x00;  // !7, !6, !5, !4, !3, !2, ~1, ~0
     TMR1CLK = 0x01; // ~7, ~6, ~5, ~4, [!3, !2, !1, #0] = Fosc/4
     TMR1 = 0xEC78;   // Timer para
     INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)

}

//*******************************************************************
// Setup del MCU
//*******************************************************************

void InitMCU(){

     ADCON0 = 0x08; // Desactivamos ADC
     ANSELC = 0x00;    // Ponemos en modo digital al puerto C
     ANSELE = 0x00;    //                ''                 E
     ANSELA = 0x00;    //                ''                 A
     ANSELD = 0x00;

     TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
     TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
     TRISE = 0x00;  // Ponemos en modo salida al puerto E
     TRISA = 0x80;  //                ''                A

     PORTC = 0x00;  // Ponemos en linea baja en puerto C
     PORTD = 0x00;
     PORTE = 0x00;  //                ''             E
     PORTA = 0x10;  // Ponemos en linea alta en A4

     LATC = 0x00;   // Dejamos en cero el registro del puerto C
     LATD = 0x00;
     LATE = 0x00;   //                ''                      E
     LATA = 0x10;   // Dejamos en 1 al pin A4

     WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
     INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
     CM1CON0 = 0x00; // Desactivamos el comparador 1
     CM2CON0 = 0x00; // Desactivamos el comparador 2
     GT3 = 1;
     GT2 = 0;
     GT1 = 0;

}