//******************************************************************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 0.8.0
//******************************************************************************************************************
// Fecha: 06-02-2024
//******************************************************************************************************************
// Declaración de Constantes Generales.
//******************************************************************************************************************

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

bit flag01;
bit flag02;
bit flag_init;
bit interruptC0; // Bandera de interrupcion en C0
bit interruptC1; // Bandera de interrupcion en C1
bit PosEdge1; // Bandera para transicion positiva en C0
bit PosEdge2; // Bandera para transicion positiva en C1
bit NegEdge1; // Bandera para transicion negatica en C0
bit NegEdge2; // Bandera para transicion negatica en C1
bit once; // Bandera para lazo de control
int i;
volatile int counter = 0;
int last_state = 0;
short unsigned int sm_state = 0;      //
short unsigned int current_state = 0; // Ni recuerdo que son
short unsigned int next_state;        //
short unsigned int cases = 0;         //
int temp = 0;

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void State(int _current_state, int _last_state); // FSM
void NextStateCalc(int _current_state, int _PosEdge1); // Calculo de FSM
void Events(int _current_state, int _next_state); // Rutina de decision sentido de flanco

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){ 
     temp = PORTC;
     temp = temp << 6;
     /*if(PIR0.TMR0IF){
          PIR0.TMR0IF = 0;
          TMR0H = 0xF3;
          TMR0L = 0xCA;
          counter++;
          if(counter >= 125){
               M4 = 1;
               counter = 0;
          }
     }*/
     // Tenemos bandera de IOC en C0? y el bit de enable en IOC esta en 1?
     if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
          IOCCF.B0 = 0; // Limpiamos la bandera de IOC
          interruptC0 = 1; // Bandera de interrupcion en C0
     }
     // Tenemos bandera de IOC en C1? y el bit de enable en IOC esta en 1?
     if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){    
          IOCCF.B1 = 0; // Limpiamos la bandera de IOC      
          interruptC1 = 1; // Bandera de interrupcion en C1
     }

}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){
                        
     InitMCU();       // Configuraciones iniciales del MCU
     InitInterrupt(); //       ''        de interrupciones del MCU
     once = TRUE;     // Seteo de la condicion del lazo
     flag_init = 1;
         
     // Lazo infinito
     do{                                                             
          Events(current_state, next_state);        //
          NextStateCalc(current_state, last_state); // Iniciamos funciones
          State(current_state, PosEdge1);           //
     }while(1);
}

//*******************************************************************
// Calculo FSM
//*******************************************************************

void NextStateCalc(int _current_state, int _last_state){

     switch(current_state){
          // Estado inicial - esperando por señal de flanco positivo 1
          case 0:
               // Tenemos señal de flanco positivo 1?
               if(PosEdge1){
                    switch(last_state){
                         case 0: // Caso 0 de last_state
                              next_state = 1; // Pasamos al siguiente estado 1
                              current_state = next_state; // Cargamos el siguiente estado
                              break;
                         case 1: // Caso 1 de last_state
                              next_state = 2; // Pasamos al siguiente estado 2
                              current_state = next_state; // Cargamos el siguiente estado
                              break;
                         case 2: // Caso 2 de last_state
                              next_state = 3; // Pasamos al siguiente estado 3
                              current_state = next_state; // Cargamos el siguiente estado
                              break;
                         case 3: // Caso 3 de last_state
                              next_state = 1; // Pasamos al siguiente estado 1
                              current_state = next_state; // Cargamos el siguiente estado
                              break;
                         case 4: // Caso 4 de last_state
                              next_state = rand()%3; // Pasamos a un estado random entre 0 y 3
                              current_state = next_state; // Cargamos el siguiente estado
                              break;
                    }
               }
               else{
                    // No, seguimos en estado 0
                    next_state = 0;
               }
               break;
          case 1: // Estado 1 - GT1, esperamos a señal de flanco negativo1 o flanco positivo 2
               // Tenemos señal de flanco negativo 1?
               if(NegEdge1){
                    // Si, pasamos al siguiente estado 0
                    next_state = 0;
               }
               // Tenemos señal de flanco positivo 2 y flanco positivo 1?
               else if(PosEdge2 && PosEdge1){
                    // Si, pasamos al siguiente estado 4
                    next_state = 4;
               }
               else{
                    // No, seguimos en estado 1
                    next_state = 1;
               }
               break;
          case 2: // Estado 2 - GT2, esperamos señal de flanco negativo 1 o flanco positivo 2
               // Tenemos señal de flanco negativo 1?
               if(NegEdge1){
                    // Si, pasamos al siguiente estado 0
                    next_state = 0;
               }
               // Tenemos señal de flanco positivo 2 y flanco positivo 1?
               else if(PosEdge2 && PosEdge1){
                    // Si, pasamos al siguiente estado 4
                    next_state = 4;
               }
               else{
                    // No, seguimos en estado 2
                    next_state = 2;
               }
               break;
          case 3: // Estado 3 - GT3, esperamos señal de flanco negativo 1 o flanco positivo 2
               // Tenemos señal de flanco negativo 1?
               if(NegEdge1){
                    // Si, pasamos al siguiente estado 0
                    next_state = 0;
               }
               // Tenemos señal de flanco positivo 2 y flanco positivo 1?
               else if(PosEdge2 && PosEdge1){
                    // Si, pasamos al siguiente estado 4
                    next_state = 4;
               }
               else{
                    // No, seguimos en estado 3
                    next_state = 3;
               }
               break;
          case 4: // Estado 4 - GT4, esperamos señal de flanco negativo 2
               // Tenemos señal de flanco negativo 2?
               if(NegEdge2){
                    // Si, pasamos al siguiente estado 0
                    next_state = 0;
               }
               else{
                    // No, seguimos en estado 4
                    next_state = 4; 
               }
               break;
     }
    
}

//*******************************************************************
// FSM
//*******************************************************************

void State(int _current_state, int _PosEdge1){
     
     switch(current_state){
          case 0: // Estado inicial, todo apagado
               M1 = 0;
               M2 = 0;
               M3 = 0;
               last_state = 0; // Ponemos el ultimo estado en 0
               break;
          case 1: // Estado 1 - GT1
               M1 = 1;
               M2 = 1;
               M3 = 0;
               last_state = 1; // Ponemos el ultimo estado en 1
               break;
          case 2: // Estado 2 - GT2
               M1 = 0;
               M2 = 1;
               M3 = 1;
               last_state = 2; // Ponemos el ultimo estado en 2
               break;
          case 3: // Estado 3 - GT3
               M1 = 1;
               M2 = 0;
               M3 = 1;
               last_state = 3; // Ponemos el ultimo estado en 3
               break;
          case 4: // Estado 4 - GT4
               M1 = 1;
               M2 = 1;
               M3 = 1;
               last_state = 4; // Ponemos el ultimo estado en 4
               break;
     }
     
}

//*******************************************************************
// Rutina de decision flanco de interrupcion
//*******************************************************************

void Events(int _current_state, int _next_state){
     // Tenemos señal de interrupcion en C0?
     if(interruptC0){      
          // Si, tenemos al switch1 en 1?
          if(SWITCH1 == 1){        
               // Si, señal de flanco negativo 1 en 1 y flanco positivo 1 en 0
               PosEdge1 = 0;
               NegEdge1 = 1;   
          }  
          // Si, tenemos switch1 en 0?
          if(SWITCH1 == 0){   
               // Si, señal de flanco positivo 1 en 1 y flanco negativo 1 en 0
               PosEdge1 = 1;
               NegEdge1 = 0;           
               current_state = next_state; // Cargamos el siguiente estado en el actual
          }
          interruptC0 = 0; // Limpiamos la bandera de señal de la interrupcion
     }
     // Tenemos señal de interrupcion en C1?
     if(interruptC1){                
          // Si, tenemos al switch2 en 1?
          if(SWITCH2 == 1){  
               // Si, señal de flanco positivo 2 en 0 y flanco negativo 2 en 1
                PosEdge2 = 0;
                NegEdge2 = 1;
          }
          // Si, tenemos al switch2 en 0?
          if(SWITCH2 == 0){
               // Si, señal de flanco positivo 2 en 1 y flanco negativo 2 en 0
               PosEdge2 = 1;
               NegEdge2 = 0;
               current_state = next_state; // Cargamos el siguiente estado en el actual
          }               
          interruptC1 = 0; // Limpiamos la bandera de señal de la interrupcion
     }
     
}

//*******************************************************************
// Setup bits de configuracion interupt
//*******************************************************************

void InitInterrupt(){

     PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
     PIR0 = 0x00;    // Limpiamos la bandera de IOC
     /*T0CON0 = 0x90;
     T0CON1 = 0x46;
     TMR0H = 0x9C;
     TMR0L = 0x40;*/
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
       
     once = TRUE;   // Seteo de la condicion para lazo

}
