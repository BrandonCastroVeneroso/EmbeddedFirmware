#define LED LATA.F4 // LED de la placa en A4
#define M1 LATA.F5 // Actuador 1 en A5
#define M2 LATE.F0 // Actuador 2 en R0
#define M3 LATE.F1 // Actuador 3 en R1
#define M4 LATE.F2 // Actuador 4 en R2
#define SWITCH1 PORTC.F0 // Pastilla en C0
#define SWITCH2 PORTC.F1
#define TRUE 1
#define FALSE 0
#define justonce flags.f0

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

void main(){
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

        while(1){
                if(SWITCH1){
                     flag_switch1 = 0; 
                     reg = switch_count;
                     once = TRUE;
                }
                else{
                        flag_switch1 = 1;
                        if(once){
                             switch_count++;
                             once = FALSE;
                             if(switch_count > 3){
                                  switch_count = 0;
                             }
                        }
                }
                if(SWITCH2){
                     flag_switch2 = 0;
                }
                else{
                     flag_switch2 = 1;
                }
                
                /*while(flag_switch){
                     reg = switch_count;     
                     break;  
                }*/
                
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
                        
                        }
                }
                }
        }
}