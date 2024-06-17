//******************************************************************************************************************
// Programa: Simultaneo y Alternancia para bombas
// Autor(es): Brandon Castro.
//******************************************************************************************************************
// Fecha: 01-02-2024
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

char flag_switch; // Bandera para switch
bit PosEdge1; // Bandera para transicion positiva en C0
bit PosEdge2; // Bandera para transicion positiva en C1
bit once; // Bandera para lazo de control
bit gflag;
bit flag01; //
bit flag02; // Basura que aun 
bit flag_a; // no se usa
bit flag_s; //
volatile int switch_count = 1; // Contador para el switch
int MR1;  //
int MR2;  // Registros para las bombas
int MR1P; // (Usado en metodo anterior)
int MR2P; //
int reg; // Contador del registro
volatile int count;
int temp;

//*******************************************************************
// Prototipos
//*******************************************************************

void selector(); // Rutina selector de grupo de trabajo
void watcher(int *_switch_count); // Rutina vigilante de pastilla
void InitMCU(); // Configuracion inicial MCU
void InitInterrupt(); // Configuracion interrupciones MCU
void blink(); // Rutina de parpadeo del LED
void counter(); // "Maquina de estados" (contador)
void GT1(int _reg); // Grupo de trabajo 1
void GT2(int _reg); // Grupo de trabajo 2
void GT3(int _reg); // Grupo de trabajo 3

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){ 
     temp = PORTC;
     temp = temp << 6;
     // Tenemos bandera de IOC en C0? y el bit de enable en IOC esta en 1?
     if((IOCCF.B0 == 1) && (IOCIE_bit == 1) && (IOCCN.B0 == 1)){
          IOCCF.B0 = 0; // Limpiamos la bandera de IOC  
          PosEdge1 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
          count++;
          blink(); // Rutina de parpadeo LED
     }
     // Tenemos bandera de IOC en C1? y el bit de enable en IOC esta en 1?
     if((IOCCF.B1 == 1) && (IOCIE_bit == 1) && ((IOCCN.B0 == 1))){    
          IOCCF.B1 = 0; // Limpiamos la bandera de IOC     
          PosEdge2 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
          count++;
          blink(); // Rutina de parpadeo LED
     }

}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){
                        
     InitMCU();       // Configuraciones iniciales del MCU
     InitInterrupt(); //       ''        de interrupciones del MCU
     once = TRUE;     // Seteo de la condicion del lazo
     
     // Lazo infinito
     while(1){                                                 
          watcher(switch_count); // Mandamos a llamar a nuestra rutina watcher  
          counter(); 
          selector(); // Mandamos a llamar a nuestra rutina del selector
     }
}

//*******************************************************************
//Contador
//*******************************************************************

void counter(){
     // Tenemos que el puerto C tiene el pin C0 y C1 en 1 o C0 en 1 o C1 en 1?
     if((temp == 0xC0) || (temp == 0x80) || (temp == 0x40)){
          switch_count++; // Incrementamos el contador del switch
          LED = 0; // Apagamos el LED como demonstracion visual de la rutina
          temp = 0x00; // Reiniciamos la lectura del puerto C
          // El contador del switch es mayor o igual a 4?
          if(switch_count >= 4){
               switch_count = 0; // Si, lo reiniciamos
          }
     }
     
}

//*******************************************************************
// Rutina de seleccion de Grupo de trabajo
//*******************************************************************

void selector(){
     // Bandera del switch en 0?
     if(flag_switch == 0){
          M1 = 0;    // Apagamos todas 
          M2 = 0;    // las
          M3 = 0;    // bombas
     }     
     // Bandera del switch en 2?
     if((flag_switch == 2) && (PosEdge2 == 1)){
          M1 = 1;    // Encendemos todas 
          M2 = 1;    // las
          M3 = 1;    // bombas
     }       
     // Bandera del switch en 1?
     if((flag_switch == 1) && (PosEdge1 == 1)){    
          // Switcheamos los valores del registro          
          switch(reg){
               case 1:
                    GT1(reg); 
                    break;
               case 2:
                    GT2(reg);   
                    break;
               case 3:
                    GT3(reg);   
                    break;
               case 4:
                    reg = 0; // Reiniciamos el registro a cero                
                    break;   
          }
     }

}

void StateMachine(){

     /*
     *  S0 Todo apagado, cargamos el valor actual de reg en posanterior
     *  S1
     *  S2
     *  S3
     *  S4
     *  S5
     */

}

//*******************************************************************
// Rutina de verificacion del estado de la pastilla
//*******************************************************************

void watcher(int *_switch_count){
     // Tenemos a switch 1 en cero y la bandera de transicion positiva en 1?
     if((SWITCH1 == 0) && (PosEdge1 == 1)){
          flag_switch = 1; // Ponemos en 1 la bandera del switch
     }
     // Mientras switch 1 este en uno
     if((SWITCH1 == 1) && (SWITCH2 == 1)){  
          flag_switch = 0; // Ponemos la bandera del switch en 0
          once = TRUE; // Reiniciamos la condicion del lazo
          reg = switch_count;
     }
     // Switch 2 en uno y switch 1 en cero?
     if((SWITCH2 == 1) && (SWITCH1 == 0)){
          // Ponemos la bandera del switch en 1
          flag_switch = 1;
     }
     // Tenemos a switch 2 en cero y la bandera de transicion positiva en 1?
     if((SWITCH2 == 0) && (PosEdge2 == 1)){
          flag_switch = 2; // Ponemos en 2 la bandera del switch    
     }
}

//*******************************************************************
// Grupos de Trabajo
//*******************************************************************

void GT1(int _reg){

     if(reg == 1){
          M1 = 1;     //
          M2 = 1;     // GRUPO DE TRABAJO 1
          M3 = 0;     //
     }

}

void GT2(int _reg){

     if(reg == 2){
          M1 = 0;     //
          M2 = 1;     // GRUPO DE TRABAJO 2
          M3 = 1;     //
     }
     
}

void GT3(int _reg){
     
     if(reg == 3){
          M1 = 1;     //
          M2 = 0;     // GRUPO DE TRABAJO 3
          M3 = 1;     //
     }
     
}

//*******************************************************************
// Rutina de parpadeo del LED
//*******************************************************************

void blink(){
     // Mientras se detecta IOC en C0 o en C1
     while((PosEdge1 == 1) || (PosEdge2 == 1)){
          char i;
          // Rutina de parpadeo del LED 4 veces durante 120 ms
          for(i = 0; i <= 4; i++){
               LED = ~LED;
               Delay_ms(20);
          }
          break;
     }
     
}

//*******************************************************************
// Setup bits de configuracion interupt
//*******************************************************************

void InitInterrupt(){

     PIE0 = 0x10;    // Enable bit de IOC (Interrupt on Change)
     PIR0 = 0x00;    // Limpiamos la bandera de IOC
     IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
     //IOCCP = 0x03;
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
     TRISA = 0x00;  //                ''                A
     
     PORTC = 0x00;  // Ponemos en linea baja en puerto C
     PORTE = 0x00;  //                ''             E
     PORTA = 0x10;  // Ponemos en linea alta en A4

     LATC = 0x00;   // Dejamos en cero el registro del puerto C
     LATE = 0x00;   //                ''                      E
     LATA = 0x10;   // Dejamos en 1 al pin A4
        
     WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
     INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
     flag01 = 0;    // Reinicio de
     flag02 = 0;    // banderas (no usadas aun)
     
     once = TRUE;   // Seteo de la condicion para lazo

}