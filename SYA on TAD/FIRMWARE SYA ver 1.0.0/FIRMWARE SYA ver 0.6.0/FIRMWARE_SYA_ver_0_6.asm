
_interrupt:

;FIRMWARE_SYA_ver_0_6.c,56 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_6.c,57 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_6.c,58 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt57:
	BZ          L__interrupt58
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt57
L__interrupt58:
;FIRMWARE_SYA_ver_0_6.c,60 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1) && (IOCCN.B0 == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
	BTFSS       IOCCN+0, 0 
	GOTO        L_interrupt2
L__interrupt46:
;FIRMWARE_SYA_ver_0_6.c,61 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_6.c,62 :: 		PosEdge1 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_6.c,63 :: 		blink(); // Rutina de parpadeo LED
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0_6.c,64 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_6.c,66 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1) && ((IOCCN.B0 == 1))){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
	BTFSS       IOCCN+0, 0 
	GOTO        L_interrupt5
L__interrupt45:
;FIRMWARE_SYA_ver_0_6.c,67 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_6.c,68 :: 		PosEdge2 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_6.c,69 :: 		blink(); // Rutina de parpadeo LED
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0_6.c,70 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_6.c,72 :: 		}
L_end_interrupt:
L__interrupt56:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_6.c,78 :: 		void main(){
;FIRMWARE_SYA_ver_0_6.c,80 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_6.c,81 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_6.c,82 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_6.c,91 :: 		while(1){
L_main6:
;FIRMWARE_SYA_ver_0_6.c,92 :: 		if((temp == 0xC0) || (temp == 0x80) || (temp == 0x40)){
	MOVLW       0
	XORWF       _temp+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main60
	MOVLW       192
	XORWF       _temp+0, 0 
L__main60:
	BTFSC       STATUS+0, 2 
	GOTO        L__main47
	MOVLW       0
	XORWF       _temp+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main61
	MOVLW       128
	XORWF       _temp+0, 0 
L__main61:
	BTFSC       STATUS+0, 2 
	GOTO        L__main47
	MOVLW       0
	XORWF       _temp+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main62
	MOVLW       64
	XORWF       _temp+0, 0 
L__main62:
	BTFSC       STATUS+0, 2 
	GOTO        L__main47
	GOTO        L_main10
L__main47:
;FIRMWARE_SYA_ver_0_6.c,93 :: 		switch_count++;
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0_6.c,94 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_6.c,95 :: 		temp = 0x00;
	CLRF        _temp+0 
	CLRF        _temp+1 
;FIRMWARE_SYA_ver_0_6.c,96 :: 		if(switch_count >= 4){
	MOVLW       128
	XORWF       _switch_count+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main63
	MOVLW       4
	SUBWF       _switch_count+0, 0 
L__main63:
	BTFSS       STATUS+0, 0 
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_6.c,97 :: 		switch_count = 0;
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0_6.c,98 :: 		}
L_main11:
;FIRMWARE_SYA_ver_0_6.c,99 :: 		}
L_main10:
;FIRMWARE_SYA_ver_0_6.c,100 :: 		watcher(switch_count); // Mandamos a llamar a nuestra rutina watcher
	MOVF        _switch_count+0, 0 
	MOVWF       FARG_watcher__switch_count+0 
	MOVF        _switch_count+1, 0 
	MOVWF       FARG_watcher__switch_count+1 
	CALL        _watcher+0, 0
;FIRMWARE_SYA_ver_0_6.c,101 :: 		selector(); // Mandamos a llamar a nuestra rutina del selector
	CALL        _selector+0, 0
;FIRMWARE_SYA_ver_0_6.c,102 :: 		}
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_6.c,103 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_selector:

;FIRMWARE_SYA_ver_0_6.c,109 :: 		void selector(){
;FIRMWARE_SYA_ver_0_6.c,111 :: 		if(flag_switch == 0){
	MOVF        _flag_switch+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_selector12
;FIRMWARE_SYA_ver_0_6.c,112 :: 		M1 = 0;    // Apagamos todas
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_6.c,113 :: 		M2 = 0;    // las
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_6.c,114 :: 		M3 = 0;    // bombas
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_6.c,115 :: 		}
L_selector12:
;FIRMWARE_SYA_ver_0_6.c,117 :: 		if((flag_switch == 2) && (PosEdge2 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_selector15
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_selector15
L__selector49:
;FIRMWARE_SYA_ver_0_6.c,118 :: 		M1 = 1;    // Encendemos todas
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_6.c,119 :: 		M2 = 1;    // las
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_6.c,120 :: 		M3 = 1;    // bombas
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_6.c,121 :: 		}
L_selector15:
;FIRMWARE_SYA_ver_0_6.c,123 :: 		if((flag_switch == 1) && (PosEdge1 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_selector18
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_selector18
L__selector48:
;FIRMWARE_SYA_ver_0_6.c,125 :: 		switch(reg){
	GOTO        L_selector19
;FIRMWARE_SYA_ver_0_6.c,126 :: 		case 1:
L_selector21:
;FIRMWARE_SYA_ver_0_6.c,127 :: 		M1 = 1; // Grupo de trabajo 1
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_6.c,128 :: 		M2 = 1; // (Bomba 1 y 2 encendidas)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_6.c,129 :: 		M3 = 0; //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_6.c,130 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_6.c,131 :: 		case 2:
L_selector22:
;FIRMWARE_SYA_ver_0_6.c,132 :: 		M1 = 0; // Grupo de trabajo 2
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_6.c,133 :: 		M2 = 1; // (Bomba 2 y 3 encendidas)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_6.c,134 :: 		M3 = 1; //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_6.c,135 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_6.c,136 :: 		case 3:
L_selector23:
;FIRMWARE_SYA_ver_0_6.c,137 :: 		M1 = 1; // Grupo de trabajo 3
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_6.c,138 :: 		M2 = 0; // (Bomba 1 y 3 encendidas)
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_6.c,139 :: 		M3 = 1; //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_6.c,140 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_6.c,141 :: 		case 4:
L_selector24:
;FIRMWARE_SYA_ver_0_6.c,142 :: 		reg = 0; // Reiniciamos el registro a cero, potencialmente
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0_6.c,143 :: 		break;   // moverlo a caso 3 para evitar doble encendido de caso 1
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_6.c,144 :: 		}
L_selector19:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector65
	MOVLW       1
	XORWF       _reg+0, 0 
L__selector65:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector21
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector66
	MOVLW       2
	XORWF       _reg+0, 0 
L__selector66:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector22
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector67
	MOVLW       3
	XORWF       _reg+0, 0 
L__selector67:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector23
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector68
	MOVLW       4
	XORWF       _reg+0, 0 
L__selector68:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector24
L_selector20:
;FIRMWARE_SYA_ver_0_6.c,145 :: 		}
L_selector18:
;FIRMWARE_SYA_ver_0_6.c,147 :: 		}
L_end_selector:
	RETURN      0
; end of _selector

_watcher:

;FIRMWARE_SYA_ver_0_6.c,153 :: 		void watcher(int *_switch_count){
;FIRMWARE_SYA_ver_0_6.c,155 :: 		if((SWITCH1 == 0) && (PosEdge1 == 1)){
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher27
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_watcher27
L__watcher53:
;FIRMWARE_SYA_ver_0_6.c,156 :: 		flag_switch = 1; // Ponemos en 1 la bandera del switch
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_6.c,157 :: 		M4 = 1;
	BSF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_6.c,167 :: 		}
L_watcher27:
;FIRMWARE_SYA_ver_0_6.c,169 :: 		if((SWITCH1 == 1) && (SWITCH2 == 1)){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher30
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher30
L__watcher52:
;FIRMWARE_SYA_ver_0_6.c,170 :: 		flag_switch = 0; // Ponemos la bandera del switch en 0
	CLRF        _flag_switch+0 
;FIRMWARE_SYA_ver_0_6.c,171 :: 		once = TRUE; // Reiniciamos la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_6.c,172 :: 		reg = switch_count;
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0_6.c,173 :: 		}
L_watcher30:
;FIRMWARE_SYA_ver_0_6.c,175 :: 		if((SWITCH2 == 1) && (SWITCH1 == 0)){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher33
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher33
L__watcher51:
;FIRMWARE_SYA_ver_0_6.c,177 :: 		flag_switch = 1;
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_6.c,183 :: 		}
L_watcher33:
;FIRMWARE_SYA_ver_0_6.c,185 :: 		if((SWITCH2 == 0) && (PosEdge2 == 1)){
	BTFSC       PORTC+0, 1 
	GOTO        L_watcher36
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_watcher36
L__watcher50:
;FIRMWARE_SYA_ver_0_6.c,186 :: 		flag_switch = 2; // Ponemos en 2 la bandera del switch
	MOVLW       2
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_6.c,187 :: 		}
L_watcher36:
;FIRMWARE_SYA_ver_0_6.c,188 :: 		}
L_end_watcher:
	RETURN      0
; end of _watcher

_blink:

;FIRMWARE_SYA_ver_0_6.c,194 :: 		void blink(){
;FIRMWARE_SYA_ver_0_6.c,196 :: 		while((PosEdge1 == 1) || (PosEdge2 == 1)){
	BTFSC       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L__blink54
	BTFSC       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L__blink54
	GOTO        L_blink38
L__blink54:
;FIRMWARE_SYA_ver_0_6.c,199 :: 		for(i = 0; i < 4; i++){
	CLRF        R1 
L_blink41:
	MOVLW       4
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink42
;FIRMWARE_SYA_ver_0_6.c,200 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_0_6.c,201 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_blink44:
	DECFSZ      R13, 1, 1
	BRA         L_blink44
	DECFSZ      R12, 1, 1
	BRA         L_blink44
	DECFSZ      R11, 1, 1
	BRA         L_blink44
	NOP
	NOP
;FIRMWARE_SYA_ver_0_6.c,199 :: 		for(i = 0; i < 4; i++){
	INCF        R1, 1 
;FIRMWARE_SYA_ver_0_6.c,202 :: 		}
	GOTO        L_blink41
L_blink42:
;FIRMWARE_SYA_ver_0_6.c,204 :: 		}
L_blink38:
;FIRMWARE_SYA_ver_0_6.c,206 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_InitInterrupt:

;FIRMWARE_SYA_ver_0_6.c,212 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_6.c,214 :: 		PIE0 = 0x10;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       16
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_6.c,215 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_6.c,216 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_6.c,218 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_6.c,219 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_6.c,221 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_6.c,227 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_6.c,229 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_6.c,230 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_6.c,231 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_6.c,232 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_6.c,234 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_6.c,235 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_6.c,236 :: 		TRISA = 0x00;  //                ''                A
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0_6.c,238 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_6.c,239 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_6.c,240 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_6.c,242 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_6.c,243 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_6.c,244 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_6.c,246 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_6.c,247 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_6.c,248 :: 		flag01 = 0;    // Reinicio de
	BCF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_6.c,249 :: 		flag02 = 0;    // banderas (no usadas aun)
	BCF         _flag02+0, BitPos(_flag02+0) 
;FIRMWARE_SYA_ver_0_6.c,251 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_6.c,253 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
