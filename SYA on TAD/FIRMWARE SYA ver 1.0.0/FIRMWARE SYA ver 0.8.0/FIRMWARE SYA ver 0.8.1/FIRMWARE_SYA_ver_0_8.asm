
_interrupt:

;FIRMWARE_SYA_ver_0_8.c,58 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8.c,59 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_8.c,60 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt29:
	BZ          L__interrupt30
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt29
L__interrupt30:
;FIRMWARE_SYA_ver_0_8.c,72 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt26:
;FIRMWARE_SYA_ver_0_8.c,73 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8.c,74 :: 		interruptC0 = 1;
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8.c,75 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8.c,77 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt25:
;FIRMWARE_SYA_ver_0_8.c,78 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8.c,79 :: 		interruptC1 = 1;
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8.c,80 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8.c,82 :: 		}
L_end_interrupt:
L__interrupt28:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8.c,88 :: 		void main(){
;FIRMWARE_SYA_ver_0_8.c,90 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8.c,91 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8.c,92 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8.c,93 :: 		flag_init = 1;
	BSF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8.c,96 :: 		do{
L_main6:
;FIRMWARE_SYA_ver_0_8.c,97 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8.c,98 :: 		State();
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8.c,99 :: 		}while(1);
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8.c,100 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_State:

;FIRMWARE_SYA_ver_0_8.c,102 :: 		void State(){
;FIRMWARE_SYA_ver_0_8.c,105 :: 		if(flag_init){
	BTFSS       _flag_init+0, BitPos(_flag_init+0) 
	GOTO        L_State9
;FIRMWARE_SYA_ver_0_8.c,106 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,107 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,108 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,109 :: 		last_state = 0;
	CLRF        _last_state+0 
	CLRF        _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,110 :: 		flag_init = 0;
	BCF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8.c,111 :: 		}
L_State9:
;FIRMWARE_SYA_ver_0_8.c,113 :: 		while(PosEdge1){
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_State11
;FIRMWARE_SYA_ver_0_8.c,115 :: 		if((last_state == 0)){
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State33
	MOVLW       0
	XORWF       _last_state+0, 0 
L__State33:
	BTFSS       STATUS+0, 2 
	GOTO        L_State12
;FIRMWARE_SYA_ver_0_8.c,116 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,117 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,118 :: 		sm_state = 1;
	MOVLW       1
	MOVWF       _sm_state+0 
;FIRMWARE_SYA_ver_0_8.c,119 :: 		}
L_State12:
;FIRMWARE_SYA_ver_0_8.c,122 :: 		if((last_state == 1)){
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State34
	MOVLW       1
	XORWF       _last_state+0, 0 
L__State34:
	BTFSS       STATUS+0, 2 
	GOTO        L_State13
;FIRMWARE_SYA_ver_0_8.c,123 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,124 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,125 :: 		sm_state = 2;
	MOVLW       2
	MOVWF       _sm_state+0 
;FIRMWARE_SYA_ver_0_8.c,126 :: 		}
L_State13:
;FIRMWARE_SYA_ver_0_8.c,129 :: 		if((last_state == 2)){
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State35
	MOVLW       2
	XORWF       _last_state+0, 0 
L__State35:
	BTFSS       STATUS+0, 2 
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8.c,130 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,131 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,132 :: 		sm_state = 3;
	MOVLW       3
	MOVWF       _sm_state+0 
;FIRMWARE_SYA_ver_0_8.c,133 :: 		}
L_State14:
;FIRMWARE_SYA_ver_0_8.c,135 :: 		}
L_State11:
;FIRMWARE_SYA_ver_0_8.c,138 :: 		if(NegEdge1 == 1){
	BTFSS       _NegEdge1+0, BitPos(_NegEdge1+0) 
	GOTO        L_State15
;FIRMWARE_SYA_ver_0_8.c,139 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,140 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,141 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,142 :: 		if(sm_state == 1){
	MOVF        _sm_state+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8.c,143 :: 		last_state = 1;
	MOVLW       1
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,144 :: 		sm_state = 0;
	CLRF        _sm_state+0 
;FIRMWARE_SYA_ver_0_8.c,145 :: 		}
L_State16:
;FIRMWARE_SYA_ver_0_8.c,146 :: 		if(sm_state == 2){
	MOVF        _sm_state+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State17
;FIRMWARE_SYA_ver_0_8.c,147 :: 		last_state = 2;
	MOVLW       2
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,148 :: 		sm_state = 0;
	CLRF        _sm_state+0 
;FIRMWARE_SYA_ver_0_8.c,149 :: 		}
L_State17:
;FIRMWARE_SYA_ver_0_8.c,150 :: 		if(sm_state == 3){
	MOVF        _sm_state+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_State18
;FIRMWARE_SYA_ver_0_8.c,151 :: 		last_state = 3;
	MOVLW       3
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,152 :: 		sm_state = 0;
	CLRF        _sm_state+0 
;FIRMWARE_SYA_ver_0_8.c,153 :: 		}
L_State18:
;FIRMWARE_SYA_ver_0_8.c,154 :: 		}
L_State15:
;FIRMWARE_SYA_ver_0_8.c,156 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8.c,158 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8.c,160 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events19
;FIRMWARE_SYA_ver_0_8.c,161 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events20
;FIRMWARE_SYA_ver_0_8.c,162 :: 		PosEdge1 = 0;
	BCF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,163 :: 		NegEdge1 = 1;
	BSF         _NegEdge1+0, BitPos(_NegEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,164 :: 		}
L_Events20:
;FIRMWARE_SYA_ver_0_8.c,165 :: 		if(SWITCH1 == 0){
	BTFSC       PORTC+0, 0 
	GOTO        L_Events21
;FIRMWARE_SYA_ver_0_8.c,166 :: 		PosEdge1 = 1;
	BSF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,167 :: 		NegEdge1 = 0;
	BCF         _NegEdge1+0, BitPos(_NegEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,168 :: 		}
L_Events21:
;FIRMWARE_SYA_ver_0_8.c,169 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8.c,170 :: 		}
L_Events19:
;FIRMWARE_SYA_ver_0_8.c,171 :: 		if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events22
;FIRMWARE_SYA_ver_0_8.c,172 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events23
;FIRMWARE_SYA_ver_0_8.c,173 :: 		PosEdge2 = 0; // Ponemos en 1 la bandera de transicion positiva en SWITCH2
	BCF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,174 :: 		NegEdge2 = 1;
	BSF         _NegEdge2+0, BitPos(_NegEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,175 :: 		}
L_Events23:
;FIRMWARE_SYA_ver_0_8.c,176 :: 		if(SWITCH2 == 0){
	BTFSC       PORTC+0, 1 
	GOTO        L_Events24
;FIRMWARE_SYA_ver_0_8.c,177 :: 		PosEdge2 = 1;
	BSF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,178 :: 		NegEdge2 = 0; // Ponemos en 1 la bandera de transicion negativa en SWITCH2
	BCF         _NegEdge2+0, BitPos(_NegEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,179 :: 		}
L_Events24:
;FIRMWARE_SYA_ver_0_8.c,180 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8.c,181 :: 		}
L_Events22:
;FIRMWARE_SYA_ver_0_8.c,183 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8.c,189 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8.c,191 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8.c,192 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8.c,197 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8.c,198 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8.c,199 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8.c,200 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8.c,202 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8.c,208 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8.c,210 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8.c,211 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8.c,212 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8.c,213 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8.c,215 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8.c,216 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8.c,217 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8.c,219 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8.c,220 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8.c,221 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8.c,223 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8.c,224 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8.c,225 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8.c,227 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8.c,228 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8.c,229 :: 		CM1CON0 = 0x00;
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8.c,230 :: 		CM2CON0 = 0x00;
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8.c,232 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8.c,234 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
