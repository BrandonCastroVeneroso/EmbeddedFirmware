//*******************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
// Version: 0.8.9
//*******************************************************************
// Fecha: 22-02-2024
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
bit flag_init; //
bit clock0; // Bandera de reloj
bit interruptC0; // flag interrupcion en C0
bit interruptC1; // flag interrupcion en C1
bit sn_PosEdge_1; // Bandera de señal para transicion positiva en C0
bit sn_PosEdge_2; // Bandera de señal para transicion positiva en C1
bit sn_NegEdge_1; // Bandera de señal para transicion negativa en C0
bit sn_NegEdge_2; // Bandera de señal para transicion negativa en C1
bit once; // Bandera para lazo de control
bit GT1; // Bandera de señal para grupo de trabajo 1
bit GT2; // Bandera de señal para grupo de trabajo 1
bit GT3; // Bandera de señal para grupo de trabajo 1
bit sn_GoTo; // Bandera de señal para señal intermedia
int i;  //
volatile unsigned int counter = 0; // Contador
int last_state = 0; // Basura
short unsigned int sm_state = 0;      // Basura
short unsigned int state = 0;         // Variable de barrido de la FSM
short unsigned int current_state = 0; // Basura
short unsigned int next_state;        // Basura
short unsigned int cases = 0;         // Basura
int temp = 0; // Temporal?

//*******************************************************************
// Prototipos
//*******************************************************************

void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void State(); // FSM
void Events(); // Rutina de decision sentido de flanco
int blink(int *_next_state);