//******************************************************************************************************************
// Programa: Simultaneo y Alternancia para bombas en UTR DREAM LAGOONS
// Autor(es): Brandon Castro.
//******************************************************************************************************************
// Fecha: 30-01-2024
//******************************************************************************************************************
// Declaración de Constantes Generales.
//******************************************************************************************************************

#define LED LATA.F4 // LED de la placa en A4
#define M1 LATA.F5 // Bomba 1 en A5
#define M2 LATE.F0 // Bomba 2 en R0
#define M3 LATE.F1 // Bomba 3 en R1
#define M4 LATE.F2 // Bomba 4 en R2
#define SWITCH1 PORTC.F0 // Pastilla en C0
#define SWITCH2 PORTC.F1 // Pastilla en C1
#define TRUE 1
#define FALSE 0

//*******************************************************************
// Variables
//*******************************************************************

bit flag_switch1;
bit flag_switch2;
bit once;
bit flag01;
bit flag02;
int switch_count;
int MR1;
int MR2;
int MR1P;
int MR2P;
int stop;
int reg;

//*******************************************************************
// Prototipos
//*******************************************************************

void watcher();
void InitMCU();
void InitInterrupt

//*******************************************************************
// Rutina de interrupcion
//*******************************************************************

void interrupt(){

     if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
          IOCCF.B0 = 0;
          LED = 0;
          PORTC.B7 = 1;
     }
     if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
          IOCCF.B1 = 0;
          LED = 0;
          PORTC.B6 = 1;
     }

}

//*******************************************************************
// Programa principal
//*******************************************************************

void main(){
        
     InitMCU();
     InitInterrupt();

        while(1){
             watcher();
                
             if(flag_switch2){
                  M1 = 1;
                  M2 = 1;
                  M3 = 1;
             }
             else{
                  if(flag_switch1){
                       switch(reg){
                            case 0:
                                 M1 = 0;
                                 M2 = 0;
                                 M3 = 0;
                            case 1:
                                 M1 = 1;
                                 M2 = 1;
                                 M3 = 0;
                                 break;
                            case 2:
                                 M1 = 0;
                                 M2 = 1;
                                 M3 = 1;
                                 break;
                            case 3:
                                 M1 = 1;
                                 M2 = 0;
                                 M3 = 1;
                                 break;
                            case 4: 
                                 reg = 0;
                                 break;
                       }
                  }
             }
        }
}

//*******************************************************************
// Rutina de verificacion del estado de la pastilla
//*******************************************************************

void watcher(){
     // SWITCH1 en linea alta?
     if(SWITCH1){
          // Si, entonces entramos al loop
          while(SWITCH1){
               flag_switch1 = 0; // Ponemos en cero la bandera del switch 1
               reg = switch_count; // Sumamos al registro el contador 
               once = TRUE;
               break;
          }
     }
     // Loop mientras SWITCH1 este en linea baja
     while(0 == SWITCH1){
          flag_switch1 = 1; // Ponemos en uno la bandera del switch 1
          // Hacemos una sola vez el siguiente lazo
          if(once){
               switch_count++; // Incrementamos el contador
               once = FALSE; // Rompemos la condicion del lazo
               // El contador es mayor a 3?
               if(switch_count > 3){
                    switch_count = 0; // Si, entonces lo reiniciamos
               }
          }
          break;
     }
     // SWITCH2 en linea alta?
     if(SWITCH2){
          // Si, entramos en el loop
          while(SWITCH2){
               flag_switch2 = 0; // Ponemos en cero la bandera del switch 2
               break;
          }       
     }
     // Loop mientras SWITCH2 este en linea baja
     while(0 == SWITCH2){       
          flag_switch2 = 1; // Ponemos en uno la bandera del switch 2
          // Lazo de una sola ejecucion
          if(once){
               switch_count++; // Incrementamos el contador del switch
               once = FALSE; // Rompemos la condicion del lazo
          }
          break;
     }

}

void InitInterrupt(){

     PIE0 = 0x10;
     PIR0 = 0x00;
     IOCCN = 0x03;
     IOCCP = 0x03;
     INTCON = 0xC0;

}

//*******************************************************************
// Setup del MCU
//*******************************************************************

void InitMCU(){

     ADCON1 = 0x0F;
     ANSELC = 0;
     ANSELE = 0;
     ANSELA = 0;

     TRISC = 0x03;
     TRISE = 0x00;
     TRISA = 0x00;
     
     PORTC = 0x00;
     PORTE = 0x00;
     PORTA = 0x10;

     LATC = 0x00;
     LATE = 0x00;
     LATA = 0x10;
        
     WPUC = 0x03;
     INLVLC = 0x03;

     flag_switch1 = 0;
     flag_switch2 = 0;
     once = TRUE;  

}