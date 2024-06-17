#define LED LATA.F4
#define M1 LATA.F5
#define M2 LATE.F0
#define M3 LATE.F1
#define M4 LATE.F2
#define SWITCH1 PORTC.F0
#define SWITCH2 PORTC.F1
#define TRUE 1
#define FALSE 0

bit flag_switch1;
bit flag_switch2;
bit once;
int conteo;
int reg;

void watcher();

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
	conteo = 0;
	once = TRUE;
	
	watcher();
	
	while(1){ 
	     reg = conteo;
	     if(conteo > 3){
	          LED = 0;
	          conteo = 0;
	     }
	     if(flag_switch1){
	          if(once){
	               conteo++;
	               once = FALSE;
	          }
	          M1 = 1;
	          M2 = 1;
	     }
	     if(flag_switch2){
	          M1 = 1;
	          M2 = 1;
	          M3 = 1;
	          M4 = 1;
	     }
	}
}

void watcher(){

     if(SWITCH1){
	     while(SWITCH1){
	          flag_switch1 = 1;
	          break;         
	     }
	}
	while(0 == SWITCH1){
	     flag_switch1 = 0;
	     break;
	}
	if(SWITCH2){
	     while(SWITCH2){
	          flag_switch2 = 1;
	          break;
	     }
	}
	while(0 == SWITCH2){
	     flag_switch2 = 0;
	     break;
	}

}