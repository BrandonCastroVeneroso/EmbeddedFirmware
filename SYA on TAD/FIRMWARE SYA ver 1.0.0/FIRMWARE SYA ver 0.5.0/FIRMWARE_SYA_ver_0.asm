
_interrupt:

;FIRMWARE_SYA_ver_0.c,54 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0.c,56 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1) && (IOCCN.B0 == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
	BTFSS       IOCCN+0, 0 
	GOTO        L_interrupt2
L__interrupt47:
;FIRMWARE_SYA_ver_0.c,57 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0.c,58 :: 		PosEdge1 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0.c,59 :: 		blink(); // Rutina de parpadeo LED
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0.c,60 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0.c,62 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1) && ((IOCCN.B0 == 1))){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
	BTFSS       IOCCN+0, 0 
	GOTO        L_interrupt5
L__interrupt46:
;FIRMWARE_SYA_ver_0.c,63 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0.c,64 :: 		PosEdge2 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0.c,65 :: 		blink(); // Rutina de parpadeo LED
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0.c,66 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0.c,68 :: 		}
L_end_interrupt:
L__interrupt56:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0.c,74 :: 		void main(){
;FIRMWARE_SYA_ver_0.c,76 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0.c,77 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0.c,78 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.c,81 :: 		while(1){
L_main6:
;FIRMWARE_SYA_ver_0.c,82 :: 		watcher(); // Mandamos a llamar a nuestra rutina watcher
	CALL        _watcher+0, 0
;FIRMWARE_SYA_ver_0.c,83 :: 		selector(); // Mandamos a llamar a nuestra rutina del selector
	CALL        _selector+0, 0
;FIRMWARE_SYA_ver_0.c,84 :: 		}
	GOTO        L_main6
;FIRMWARE_SYA_ver_0.c,85 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_selector:

;FIRMWARE_SYA_ver_0.c,91 :: 		void selector(){
;FIRMWARE_SYA_ver_0.c,93 :: 		if(flag_switch == 0){
	MOVF        _flag_switch+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_selector8
;FIRMWARE_SYA_ver_0.c,94 :: 		M1 = 0;    // Apagamos todas las
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.c,95 :: 		M2 = 0;    // bombas
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.c,96 :: 		M3 = 0;    //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.c,97 :: 		}
L_selector8:
;FIRMWARE_SYA_ver_0.c,99 :: 		if((flag_switch == 2) && (PosEdge2 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_selector11
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_selector11
L__selector49:
;FIRMWARE_SYA_ver_0.c,100 :: 		M1 = 1;    // Encendemos todas las
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.c,101 :: 		M2 = 1;    // bombas
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.c,102 :: 		M3 = 1;    //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.c,103 :: 		}
L_selector11:
;FIRMWARE_SYA_ver_0.c,105 :: 		if((flag_switch == 1) && (PosEdge1 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_selector14
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_selector14
L__selector48:
;FIRMWARE_SYA_ver_0.c,112 :: 		switch(reg){
	GOTO        L_selector15
;FIRMWARE_SYA_ver_0.c,118 :: 		case 1:
L_selector17:
;FIRMWARE_SYA_ver_0.c,119 :: 		M1 = 1; // Grupo de trabajo 1
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.c,120 :: 		M2 = 1; // (Bomba 1 y 2 encendidas)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.c,121 :: 		M3 = 0; //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.c,122 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0.c,123 :: 		case 2:
L_selector18:
;FIRMWARE_SYA_ver_0.c,124 :: 		M1 = 0; // Grupo de trabajo 2
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.c,125 :: 		M2 = 1; // (Bomba 2 y 3 encendidas)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.c,126 :: 		M3 = 1; //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.c,127 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0.c,128 :: 		case 3:
L_selector19:
;FIRMWARE_SYA_ver_0.c,129 :: 		M1 = 1; // Grupo de trabajo 3
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.c,130 :: 		M2 = 0; // (Bomba 1 y 3 encendidas)
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.c,131 :: 		M3 = 1; //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.c,132 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0.c,133 :: 		case 4:
L_selector20:
;FIRMWARE_SYA_ver_0.c,134 :: 		reg = 0; // Reiniciamos el registro a cero, potencialmente
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0.c,135 :: 		break;   // moverlo a caso 3 para evitar doble encendido de caso 1
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0.c,136 :: 		}
L_selector15:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector59
	MOVLW       1
	XORWF       _reg+0, 0 
L__selector59:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector17
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector60
	MOVLW       2
	XORWF       _reg+0, 0 
L__selector60:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector18
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector61
	MOVLW       3
	XORWF       _reg+0, 0 
L__selector61:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector19
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector62
	MOVLW       4
	XORWF       _reg+0, 0 
L__selector62:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector20
L_selector16:
;FIRMWARE_SYA_ver_0.c,137 :: 		}
L_selector14:
;FIRMWARE_SYA_ver_0.c,139 :: 		}
L_end_selector:
	RETURN      0
; end of _selector

_watcher:

;FIRMWARE_SYA_ver_0.c,145 :: 		void watcher(){
;FIRMWARE_SYA_ver_0.c,148 :: 		if((SWITCH1 == 0) && (PosEdge1 == 1)){
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher25
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_watcher25
L__watcher53:
;FIRMWARE_SYA_ver_0.c,149 :: 		flag_switch = 1; // Ponemos en 1 la bandera del switch
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0.c,150 :: 		M4 = 1;
	BSF         LATE+0, 2 
;FIRMWARE_SYA_ver_0.c,152 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_watcher26
;FIRMWARE_SYA_ver_0.c,153 :: 		switch_count++; // Incrementamos el contador del switch
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0.c,154 :: 		once = FALSE; // Rompemos la condicion del lazo
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.c,156 :: 		if(switch_count >= 4){
	MOVLW       128
	XORWF       _switch_count+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__watcher64
	MOVLW       4
	SUBWF       _switch_count+0, 0 
L__watcher64:
	BTFSS       STATUS+0, 0 
	GOTO        L_watcher27
;FIRMWARE_SYA_ver_0.c,157 :: 		switch_count = 0; // Si, entonces lo reiniciamos
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0.c,158 :: 		}
L_watcher27:
;FIRMWARE_SYA_ver_0.c,159 :: 		}
L_watcher26:
;FIRMWARE_SYA_ver_0.c,160 :: 		}
L_watcher25:
;FIRMWARE_SYA_ver_0.c,162 :: 		if((SWITCH1 == 1) && (SWITCH2 == 1)){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher30
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher30
L__watcher52:
;FIRMWARE_SYA_ver_0.c,163 :: 		flag_switch = 0; // Ponemos la bandera del switch en 0
	CLRF        _flag_switch+0 
;FIRMWARE_SYA_ver_0.c,164 :: 		reg = switch_count; // Asignamos el valor del contador al registro
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0.c,165 :: 		once = TRUE; // Reiniciamos la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.c,166 :: 		}
L_watcher30:
;FIRMWARE_SYA_ver_0.c,168 :: 		if((SWITCH2 == 1) && (SWITCH1 == 0)){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher33
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher33
L__watcher51:
;FIRMWARE_SYA_ver_0.c,170 :: 		flag_switch = 1;
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0.c,172 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_watcher34
;FIRMWARE_SYA_ver_0.c,173 :: 		switch_count++; // Incrementamos el contador del registro
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0.c,174 :: 		once = FALSE; // Reiniciamos la condicion del lazo
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.c,175 :: 		}
L_watcher34:
;FIRMWARE_SYA_ver_0.c,176 :: 		}
L_watcher33:
;FIRMWARE_SYA_ver_0.c,178 :: 		if((SWITCH2 == 0) && (PosEdge2 == 1)){
	BTFSC       PORTC+0, 1 
	GOTO        L_watcher37
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_watcher37
L__watcher50:
;FIRMWARE_SYA_ver_0.c,179 :: 		flag_switch = 2; // Ponemos en 2 la bandera del switch
	MOVLW       2
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0.c,180 :: 		}
L_watcher37:
;FIRMWARE_SYA_ver_0.c,182 :: 		}
L_watcher22:
;FIRMWARE_SYA_ver_0.c,183 :: 		}
L_end_watcher:
	RETURN      0
; end of _watcher

_blink:

;FIRMWARE_SYA_ver_0.c,189 :: 		void blink(){
;FIRMWARE_SYA_ver_0.c,191 :: 		while((PosEdge1 == 1) || (PosEdge2 == 1)){
	BTFSC       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L__blink54
	BTFSC       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L__blink54
	GOTO        L_blink39
L__blink54:
;FIRMWARE_SYA_ver_0.c,194 :: 		for(i = 0; i < 4; i++){
	CLRF        R1 
L_blink42:
	MOVLW       4
	SUBWF       R1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_blink43
;FIRMWARE_SYA_ver_0.c,195 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_0.c,196 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_blink45:
	DECFSZ      R13, 1, 1
	BRA         L_blink45
	DECFSZ      R12, 1, 1
	BRA         L_blink45
	DECFSZ      R11, 1, 1
	BRA         L_blink45
	NOP
	NOP
;FIRMWARE_SYA_ver_0.c,194 :: 		for(i = 0; i < 4; i++){
	INCF        R1, 1 
;FIRMWARE_SYA_ver_0.c,197 :: 		}
	GOTO        L_blink42
L_blink43:
;FIRMWARE_SYA_ver_0.c,199 :: 		}
L_blink39:
;FIRMWARE_SYA_ver_0.c,201 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_InitInterrupt:

;FIRMWARE_SYA_ver_0.c,207 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0.c,209 :: 		PIE0 = 0x10;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       16
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0.c,210 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0.c,211 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0.c,213 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0.c,214 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0.c,216 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0.c,222 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0.c,224 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0.c,225 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0.c,226 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0.c,227 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0.c,229 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0.c,230 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0.c,231 :: 		TRISA = 0x00;  //                ''                A
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0.c,233 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0.c,234 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0.c,235 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0.c,237 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0.c,238 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0.c,239 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0.c,241 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0.c,242 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0.c,243 :: 		flag01 = 0;    // Reinicio de
	BCF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0.c,244 :: 		flag02 = 0;    // banderas (no usadas aun)
	BCF         _flag02+0, BitPos(_flag02+0) 
;FIRMWARE_SYA_ver_0.c,246 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.c,248 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
