
_interrupt:

;FIRMWARE_SYA_ver_0_7.c,61 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_7.c,62 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_7.c,63 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt60:
	BZ          L__interrupt61
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt60
L__interrupt61:
;FIRMWARE_SYA_ver_0_7.c,65 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1) && (IOCCN.B0 == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
	BTFSS       IOCCN+0, 0 
	GOTO        L_interrupt2
L__interrupt49:
;FIRMWARE_SYA_ver_0_7.c,66 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_7.c,67 :: 		PosEdge1 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_7.c,68 :: 		count++;
	MOVLW       1
	ADDWF       _count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _count+0 
	MOVF        R1, 0 
	MOVWF       _count+1 
;FIRMWARE_SYA_ver_0_7.c,69 :: 		blink(); // Rutina de parpadeo LED
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0_7.c,70 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_7.c,72 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1) && ((IOCCN.B0 == 1))){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
	BTFSS       IOCCN+0, 0 
	GOTO        L_interrupt5
L__interrupt48:
;FIRMWARE_SYA_ver_0_7.c,73 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_7.c,74 :: 		PosEdge2 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_7.c,75 :: 		count++;
	MOVLW       1
	ADDWF       _count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _count+0 
	MOVF        R1, 0 
	MOVWF       _count+1 
;FIRMWARE_SYA_ver_0_7.c,76 :: 		blink(); // Rutina de parpadeo LED
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0_7.c,77 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_7.c,79 :: 		}
L_end_interrupt:
L__interrupt59:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_7.c,85 :: 		void main(){
;FIRMWARE_SYA_ver_0_7.c,87 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_7.c,88 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_7.c,89 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_7.c,92 :: 		while(1){
L_main6:
;FIRMWARE_SYA_ver_0_7.c,93 :: 		watcher(switch_count); // Mandamos a llamar a nuestra rutina watcher
	MOVF        _switch_count+0, 0 
	MOVWF       FARG_watcher__switch_count+0 
	MOVF        _switch_count+1, 0 
	MOVWF       FARG_watcher__switch_count+1 
	CALL        _watcher+0, 0
;FIRMWARE_SYA_ver_0_7.c,94 :: 		StateMachine();
	CALL        _StateMachine+0, 0
;FIRMWARE_SYA_ver_0_7.c,95 :: 		selector(); // Mandamos a llamar a nuestra rutina del selector
	CALL        _selector+0, 0
;FIRMWARE_SYA_ver_0_7.c,96 :: 		}
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_7.c,97 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_StateMachine:

;FIRMWARE_SYA_ver_0_7.c,103 :: 		void StateMachine(){
;FIRMWARE_SYA_ver_0_7.c,105 :: 		if((temp == 0xC0) || (temp == 0x80) || (temp == 0x40)){
	MOVLW       0
	XORWF       _temp+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StateMachine64
	MOVLW       192
	XORWF       _temp+0, 0 
L__StateMachine64:
	BTFSC       STATUS+0, 2 
	GOTO        L__StateMachine50
	MOVLW       0
	XORWF       _temp+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StateMachine65
	MOVLW       128
	XORWF       _temp+0, 0 
L__StateMachine65:
	BTFSC       STATUS+0, 2 
	GOTO        L__StateMachine50
	MOVLW       0
	XORWF       _temp+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StateMachine66
	MOVLW       64
	XORWF       _temp+0, 0 
L__StateMachine66:
	BTFSC       STATUS+0, 2 
	GOTO        L__StateMachine50
	GOTO        L_StateMachine10
L__StateMachine50:
;FIRMWARE_SYA_ver_0_7.c,106 :: 		switch_count++; // Incrementamos el contador del switch
	MOVLW       1
	ADDWF       _switch_count+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _switch_count+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _switch_count+0 
	MOVF        R1, 0 
	MOVWF       _switch_count+1 
;FIRMWARE_SYA_ver_0_7.c,107 :: 		LED = 0; // Apagamos el LED como demonstracion visual de la rutina
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_7.c,108 :: 		temp = 0x00; // Reiniciamos la lectura del puerto C
	CLRF        _temp+0 
	CLRF        _temp+1 
;FIRMWARE_SYA_ver_0_7.c,110 :: 		if(switch_count >= 4){
	MOVLW       128
	XORWF       _switch_count+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__StateMachine67
	MOVLW       4
	SUBWF       _switch_count+0, 0 
L__StateMachine67:
	BTFSS       STATUS+0, 0 
	GOTO        L_StateMachine11
;FIRMWARE_SYA_ver_0_7.c,111 :: 		switch_count = 0; // Si, lo reiniciamos
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0_7.c,112 :: 		}
L_StateMachine11:
;FIRMWARE_SYA_ver_0_7.c,113 :: 		}
L_StateMachine10:
;FIRMWARE_SYA_ver_0_7.c,115 :: 		}
L_end_StateMachine:
	RETURN      0
; end of _StateMachine

_selector:

;FIRMWARE_SYA_ver_0_7.c,121 :: 		void selector(){
;FIRMWARE_SYA_ver_0_7.c,123 :: 		if(flag_switch == 0){
	MOVF        _flag_switch+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_selector12
;FIRMWARE_SYA_ver_0_7.c,124 :: 		M1 = 0;    // Apagamos todas
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_7.c,125 :: 		M2 = 0;    // las
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_7.c,126 :: 		M3 = 0;    // bombas
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_7.c,127 :: 		}
L_selector12:
;FIRMWARE_SYA_ver_0_7.c,129 :: 		if((flag_switch == 2) && (PosEdge2 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_selector15
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_selector15
L__selector52:
;FIRMWARE_SYA_ver_0_7.c,130 :: 		M1 = 1;    // Encendemos todas
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_7.c,131 :: 		M2 = 1;    // las
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_7.c,132 :: 		M3 = 1;    // bombas
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_7.c,133 :: 		}
L_selector15:
;FIRMWARE_SYA_ver_0_7.c,135 :: 		if((flag_switch == 1) && (PosEdge1 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_selector18
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_selector18
L__selector51:
;FIRMWARE_SYA_ver_0_7.c,137 :: 		switch(reg){
	GOTO        L_selector19
;FIRMWARE_SYA_ver_0_7.c,138 :: 		case 1:
L_selector21:
;FIRMWARE_SYA_ver_0_7.c,139 :: 		GT1(reg);
	MOVF        _reg+0, 0 
	MOVWF       FARG_GT1__reg+0 
	MOVF        _reg+1, 0 
	MOVWF       FARG_GT1__reg+1 
	CALL        _GT1+0, 0
;FIRMWARE_SYA_ver_0_7.c,140 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_7.c,141 :: 		case 2:
L_selector22:
;FIRMWARE_SYA_ver_0_7.c,142 :: 		GT2(reg);
	MOVF        _reg+0, 0 
	MOVWF       FARG_GT2__reg+0 
	MOVF        _reg+1, 0 
	MOVWF       FARG_GT2__reg+1 
	CALL        _GT2+0, 0
;FIRMWARE_SYA_ver_0_7.c,143 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_7.c,144 :: 		case 3:
L_selector23:
;FIRMWARE_SYA_ver_0_7.c,145 :: 		GT3(reg);
	MOVF        _reg+0, 0 
	MOVWF       FARG_GT3__reg+0 
	MOVF        _reg+1, 0 
	MOVWF       FARG_GT3__reg+1 
	CALL        _GT3+0, 0
;FIRMWARE_SYA_ver_0_7.c,146 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_7.c,147 :: 		case 4:
L_selector24:
;FIRMWARE_SYA_ver_0_7.c,148 :: 		reg = 0; // Reiniciamos el registro a cero
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0_7.c,149 :: 		break;
	GOTO        L_selector20
;FIRMWARE_SYA_ver_0_7.c,150 :: 		}
L_selector19:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector69
	MOVLW       1
	XORWF       _reg+0, 0 
L__selector69:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector21
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector70
	MOVLW       2
	XORWF       _reg+0, 0 
L__selector70:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector22
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector71
	MOVLW       3
	XORWF       _reg+0, 0 
L__selector71:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector23
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector72
	MOVLW       4
	XORWF       _reg+0, 0 
L__selector72:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector24
L_selector20:
;FIRMWARE_SYA_ver_0_7.c,151 :: 		}
L_selector18:
;FIRMWARE_SYA_ver_0_7.c,153 :: 		}
L_end_selector:
	RETURN      0
; end of _selector

_watcher:

;FIRMWARE_SYA_ver_0_7.c,159 :: 		void watcher(int *_switch_count){
;FIRMWARE_SYA_ver_0_7.c,161 :: 		if((SWITCH1 == 0) && (PosEdge1 == 1)){
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher27
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_watcher27
L__watcher56:
;FIRMWARE_SYA_ver_0_7.c,162 :: 		flag_switch = 1; // Ponemos en 1 la bandera del switch
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_7.c,163 :: 		}
L_watcher27:
;FIRMWARE_SYA_ver_0_7.c,165 :: 		if((SWITCH1 == 1) && (SWITCH2 == 1)){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher30
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher30
L__watcher55:
;FIRMWARE_SYA_ver_0_7.c,166 :: 		flag_switch = 0; // Ponemos la bandera del switch en 0
	CLRF        _flag_switch+0 
;FIRMWARE_SYA_ver_0_7.c,167 :: 		once = TRUE; // Reiniciamos la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_7.c,168 :: 		reg = switch_count;
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0_7.c,169 :: 		}
L_watcher30:
;FIRMWARE_SYA_ver_0_7.c,171 :: 		if((SWITCH2 == 1) && (SWITCH1 == 0)){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher33
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher33
L__watcher54:
;FIRMWARE_SYA_ver_0_7.c,173 :: 		flag_switch = 1;
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_7.c,174 :: 		}
L_watcher33:
;FIRMWARE_SYA_ver_0_7.c,176 :: 		if((SWITCH2 == 0) && (PosEdge2 == 1)){
	BTFSC       PORTC+0, 1 
	GOTO        L_watcher36
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_watcher36
L__watcher53:
;FIRMWARE_SYA_ver_0_7.c,177 :: 		flag_switch = 2; // Ponemos en 2 la bandera del switch
	MOVLW       2
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_7.c,178 :: 		}
L_watcher36:
;FIRMWARE_SYA_ver_0_7.c,179 :: 		}
L_end_watcher:
	RETURN      0
; end of _watcher

_GT1:

;FIRMWARE_SYA_ver_0_7.c,185 :: 		void GT1(int _reg){
;FIRMWARE_SYA_ver_0_7.c,187 :: 		if(reg == 1){
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GT175
	MOVLW       1
	XORWF       _reg+0, 0 
L__GT175:
	BTFSS       STATUS+0, 2 
	GOTO        L_GT137
;FIRMWARE_SYA_ver_0_7.c,188 :: 		M1 = 1;     //
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_7.c,189 :: 		M2 = 1;     // GRUPO DE TRABAJO 1
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_7.c,190 :: 		M3 = 0;     //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_7.c,191 :: 		}
L_GT137:
;FIRMWARE_SYA_ver_0_7.c,193 :: 		}
L_end_GT1:
	RETURN      0
; end of _GT1

_GT2:

;FIRMWARE_SYA_ver_0_7.c,195 :: 		void GT2(int _reg){
;FIRMWARE_SYA_ver_0_7.c,197 :: 		if(reg == 2){
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GT277
	MOVLW       2
	XORWF       _reg+0, 0 
L__GT277:
	BTFSS       STATUS+0, 2 
	GOTO        L_GT238
;FIRMWARE_SYA_ver_0_7.c,198 :: 		M1 = 0;     //
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_7.c,199 :: 		M2 = 1;     // GRUPO DE TRABAJO 2
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_7.c,200 :: 		M3 = 1;     //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_7.c,201 :: 		}
L_GT238:
;FIRMWARE_SYA_ver_0_7.c,203 :: 		}
L_end_GT2:
	RETURN      0
; end of _GT2

_GT3:

;FIRMWARE_SYA_ver_0_7.c,205 :: 		void GT3(int _reg){
;FIRMWARE_SYA_ver_0_7.c,207 :: 		if(reg == 3){
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GT379
	MOVLW       3
	XORWF       _reg+0, 0 
L__GT379:
	BTFSS       STATUS+0, 2 
	GOTO        L_GT339
;FIRMWARE_SYA_ver_0_7.c,208 :: 		M1 = 1;     //
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_7.c,209 :: 		M2 = 0;     // GRUPO DE TRABAJO 3
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_7.c,210 :: 		M3 = 1;     //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_7.c,211 :: 		}
L_GT339:
;FIRMWARE_SYA_ver_0_7.c,213 :: 		}
L_end_GT3:
	RETURN      0
; end of _GT3

_blink:

;FIRMWARE_SYA_ver_0_7.c,219 :: 		void blink(){
;FIRMWARE_SYA_ver_0_7.c,221 :: 		while((PosEdge1 == 1) || (PosEdge2 == 1)){
	BTFSC       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L__blink57
	BTFSC       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L__blink57
	GOTO        L_blink41
L__blink57:
;FIRMWARE_SYA_ver_0_7.c,224 :: 		for(i = 0; i <= 4; i++){
	CLRF        R1 
L_blink44:
	MOVF        R1, 0 
	SUBLW       4
	BTFSS       STATUS+0, 0 
	GOTO        L_blink45
;FIRMWARE_SYA_ver_0_7.c,225 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_0_7.c,226 :: 		Delay_ms(20);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_blink47:
	DECFSZ      R13, 1, 1
	BRA         L_blink47
	DECFSZ      R12, 1, 1
	BRA         L_blink47
	NOP
	NOP
;FIRMWARE_SYA_ver_0_7.c,224 :: 		for(i = 0; i <= 4; i++){
	INCF        R1, 1 
;FIRMWARE_SYA_ver_0_7.c,227 :: 		}
	GOTO        L_blink44
L_blink45:
;FIRMWARE_SYA_ver_0_7.c,229 :: 		}
L_blink41:
;FIRMWARE_SYA_ver_0_7.c,231 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_InitInterrupt:

;FIRMWARE_SYA_ver_0_7.c,237 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_7.c,239 :: 		PIE0 = 0x10;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       16
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_7.c,240 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_7.c,241 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_7.c,243 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_7.c,244 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_7.c,246 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_7.c,252 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_7.c,254 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_7.c,255 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_7.c,256 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_7.c,257 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_7.c,259 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_7.c,260 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_7.c,261 :: 		TRISA = 0x00;  //                ''                A
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0_7.c,263 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_7.c,264 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_7.c,265 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_7.c,267 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_7.c,268 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_7.c,269 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_7.c,271 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_7.c,272 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_7.c,273 :: 		flag01 = 0;    // Reinicio de
	BCF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_7.c,274 :: 		flag02 = 0;    // banderas (no usadas aun)
	BCF         _flag02+0, BitPos(_flag02+0) 
;FIRMWARE_SYA_ver_0_7.c,276 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_7.c,278 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
