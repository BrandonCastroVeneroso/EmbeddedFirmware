//******************************************************************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 0.8.1
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
bit NegEdge1; // Bandera para transicion negativa en C0
bit NegEdge2; // Bandera para transicion negativa en C1
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
void State(); // FSM
void Events(); // Rutina de decision sentido de flanco

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){ 
     temp = PORTC;
     temp = temp << 6;
     // Tenemos bandera de interrupcion por Timer0?
     /*if(PIR0.TMR0IF){
          // Si, limpiamos la bandera de interrupcion
          PIR0.TMR0IF = 0;
          TMR0H = 0xF3; // Iniciamos la cuenta de 40 ms
          TMR0L = 0xCA;
          counter++; // Aumentamos el contador
          // Tenemos que el contador es mayor o igual a 125 (1s aprox)
          if(counter >= 125){
               // Si, prendemos M4 (Nadamas para ver que se ejecute a tiempo)
               M4 = 1;
               counter = 0; // Reiniciamos el contador
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
          Events(); // Iniciamos
          State();  // funciones
     }while(1);
}

//*******************************************************************
// FSM
//*******************************************************************

void State(){
     
     // Estado inicial - todo apagado
     // Tenemos la señal de que el MCU inicio?
     if(flag_init){
          // Si, ejecutamos S0
          M1 = 0;
          M2 = 0;
          M3 = 0;
          last_state = 0; // Seteamos ultimo estado en 0
          flag_init = 0; // Apagamos la bandera de inicio
     }
     // Mientras que tengamos señal de flanco positivo 1
     while(PosEdge1){
          // Estado 1 - GT1
          // Tenemos que el ultimo estado fue 0?
          if((last_state == 0)){
               // Si, iniciamos GT1
               M1 = 1;
               M2 = 1;
               sm_state = 1; // Seteamos el estado actual en 1
          }
          // Estado 2 - GT2
          // Tenemos que el ultimo estado fue 1?
          if((last_state == 1)){
               // Si, iniciamos GT2
               M2 = 1;
               M3 = 1;
               sm_state = 2; // Seteamos el estado actual en 2
          }
          // Estado 3 - GT3
          // Tenemos que el estado fue 2?
          if((last_state == 2)){
               // Si, iniciamos GT3
               M1 = 1;
               M3 = 1;
               sm_state = 3; // Seteamos el estado actual en 3
          }
          break;
     }

     // Estado 4 - GT4
     // Tenemos señal de flanco negativo 1?
     if(NegEdge1 == 1){
          // Si, ejecutamos GT4
          M1 = 0;
          M2 = 0;
          M3 = 0;
          // Tenemos que el estado actual fue 1?
          if(sm_state == 1){
               // Si, seteamos el ultimo estado en 1 y el estado actual en 0
               last_state = 1;
               sm_state = 0;
          }
          // Tenemos que el estado actual fue 2?
          if(sm_state == 2){
               // Si, seteamos el ultimo estado en 2 y el estado actual en 0
               last_state = 2;
               sm_state = 0;
          }
          // Tenemos que el estado actual fue 3?
          if(sm_state == 3){
               // Si, seteamos el ultimo estado en 3 y el estado actual en 0
               last_state = 3;
               sm_state = 0;
          }
     }
     
}

//*******************************************************************
// Rutina de decision sentido de flanco
//*******************************************************************

void Events(){
     // Tenemos señal de interrupcion en C0?
     if(interruptC0){      
          // Si, tenemos al switch1 en 1?
          if(SWITCH1 == 1){        
               // Si, señal de flanco positivo 1 en 0 y flanco negativo 1 en 0
               PosEdge1 = 0;
               NegEdge1 = 1;   
          }  
          // Si, tenemos switch1 en 0?
          if(SWITCH1 == 0){   
               // Si, señal de flanco positivo 1 en 1 y flanco negativo 1 en 0
               PosEdge1 = 1;
               NegEdge1 = 0;           
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
          // Si, tenemos al switch 2 en 0?
          if(SWITCH2 == 0){
               // Si, señal de flanco positivo 2 en 1 y flanco negativo 2 en 0
               PosEdge2 = 1;
               NegEdge2 = 0;
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
     /*T0CON0 = 0x90; // Registro Control 0 de Timer0
     T0CON1 = 0x46;   // Registro Control 1 de Timer0
     TMR0H = 0x9C;    // Inicia la cuenta en no me acuerdo cuanto pero son como 40 ms
     TMR0L = 0x40;*/  // O 4 ms? algo de eso
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
     CM1CON0 = 0x00;
     CM2CON0 = 0x00;
       
     once = TRUE;   // Seteo de la condicion para lazo

}
