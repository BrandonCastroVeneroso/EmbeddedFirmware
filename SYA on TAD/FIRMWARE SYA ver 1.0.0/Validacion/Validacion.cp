#line 1 "C:/Users/USER/Downloads/Simultaneo y alternancia/FIRMWARE SYM ver 1.0.0/Validacion/Validacion.c"










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
 once =  1 ;

 watcher();

 while(1){
 reg = conteo;
 if(conteo > 3){
  LATA.F4  = 0;
 conteo = 0;
 }
 if(flag_switch1){
 if(once){
 conteo++;
 once =  0 ;
 }
  LATA.F5  = 1;
  LATE.F0  = 1;
 }
 if(flag_switch2){
  LATA.F5  = 1;
  LATE.F0  = 1;
  LATE.F1  = 1;
  LATE.F2  = 1;
 }
 }
}

void watcher(){

 if( PORTC.F0 ){
 while( PORTC.F0 ){
 flag_switch1 = 1;
 break;
 }
 }
 while(0 ==  PORTC.F0 ){
 flag_switch1 = 0;
 break;
 }
 if( PORTC.F1 ){
 while( PORTC.F1 ){
 flag_switch2 = 1;
 break;
 }
 }
 while(0 ==  PORTC.F1 ){
 flag_switch2 = 0;
 break;
 }

}
