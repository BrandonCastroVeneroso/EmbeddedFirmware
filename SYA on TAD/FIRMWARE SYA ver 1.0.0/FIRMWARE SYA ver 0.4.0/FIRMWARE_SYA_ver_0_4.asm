
_interrupt:

;FIRMWARE_SYA_ver_0_4.c,54 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_4.c,56 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt34:
;FIRMWARE_SYA_ver_0_4.c,57 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_4.c,58 :: 		PosEdge1 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_4.c,59 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_4.c,61 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt33:
;FIRMWARE_SYA_ver_0_4.c,62 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_4.c,63 :: 		PosEdge2 = 1; // Ponemos en 1 la bandera de transicion positiva en 1
	BSF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_4.c,64 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_4.c,66 :: 		}
L_end_interrupt:
L__interrupt40:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_4.c,72 :: 		void main(){
;FIRMWARE_SYA_ver_0_4.c,74 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_4.c,75 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_4.c,76 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_4.c,79 :: 		while(1){
L_main6:
;FIRMWARE_SYA_ver_0_4.c,80 :: 		watcher(); // Mandamos a llamar a nuestra rutina watcher
	CALL        _watcher+0, 0
;FIRMWARE_SYA_ver_0_4.c,81 :: 		selector(); // Mandamos a llamar a nuestra rutina del selector
	CALL        _selector+0, 0
;FIRMWARE_SYA_ver_0_4.c,82 :: 		}
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_4.c,83 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_selector:

;FIRMWARE_SYA_ver_0_4.c,89 :: 		void selector(){
;FIRMWARE_SYA_ver_0_4.c,91 :: 		if(flag_switch == 0){
	MOVF        _flag_switch+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_selector8
;FIRMWARE_SYA_ver_0_4.c,92 :: 		M1 = 0;    // Apagamos todas las
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_4.c,93 :: 		M2 = 0;    // bombas
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_4.c,94 :: 		M3 = 0;    //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_4.c,95 :: 		}
L_selector8:
;FIRMWARE_SYA_ver_0_4.c,97 :: 		if((flag_switch == 2) && (PosEdge2 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_selector11
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_selector11
L__selector36:
;FIRMWARE_SYA_ver_0_4.c,98 :: 		M1 = 1;    // Encendemos todas las
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_4.c,99 :: 		M2 = 1;    // bombas
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_4.c,100 :: 		M3 = 1;    //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_4.c,101 :: 		}
L_selector11:
;FIRMWARE_SYA_ver_0_4.c,103 :: 		if((flag_switch == 1) && (PosEdge1 == 1)){
	MOVF        _flag_switch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_selector14
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_selector14
L__selector35:
;FIRMWARE_SYA_ver_0_4.c,105 :: 		switch(reg){
	GOTO        L_selector15
;FIRMWARE_SYA_ver_0_4.c,106 :: 		case 0:
L_selector17:
;FIRMWARE_SYA_ver_0_4.c,107 :: 		M1 = 0; // Grupo de trabajo 0
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_4.c,108 :: 		M2 = 0; // (Todas apagadas)
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_4.c,109 :: 		M3 = 0; //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_4.c,110 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0_4.c,111 :: 		case 1:
L_selector18:
;FIRMWARE_SYA_ver_0_4.c,112 :: 		M1 = 1; // Grupo de trabajo 1
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_4.c,113 :: 		M2 = 1; // (Bomba 1 y 2 encendidas)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_4.c,114 :: 		M3 = 0; //
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_4.c,115 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0_4.c,116 :: 		case 2:
L_selector19:
;FIRMWARE_SYA_ver_0_4.c,117 :: 		M1 = 0; // Grupo de trabajo 2
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_4.c,118 :: 		M2 = 1; // (Bomba 2 y 3 encendidas)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_4.c,119 :: 		M3 = 1; //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_4.c,120 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0_4.c,121 :: 		case 3:
L_selector20:
;FIRMWARE_SYA_ver_0_4.c,122 :: 		M1 = 1; // Grupo de trabajo 3
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_4.c,123 :: 		M2 = 0; // (Bomba 1 y 3 encendidas)
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_4.c,124 :: 		M3 = 1; //
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_4.c,125 :: 		break;
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0_4.c,126 :: 		case 4:
L_selector21:
;FIRMWARE_SYA_ver_0_4.c,127 :: 		reg = 0; // Reiniciamos el registro a cero, potencialmente
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0_4.c,128 :: 		break;   // moverlo a caso 3 para evitar doble encendido de caso 1
	GOTO        L_selector16
;FIRMWARE_SYA_ver_0_4.c,129 :: 		}
L_selector15:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector43
	MOVLW       0
	XORWF       _reg+0, 0 
L__selector43:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector17
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector44
	MOVLW       1
	XORWF       _reg+0, 0 
L__selector44:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector18
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector45
	MOVLW       2
	XORWF       _reg+0, 0 
L__selector45:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector19
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector46
	MOVLW       3
	XORWF       _reg+0, 0 
L__selector46:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector20
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__selector47
	MOVLW       4
	XORWF       _reg+0, 0 
L__selector47:
	BTFSC       STATUS+0, 2 
	GOTO        L_selector21
L_selector16:
;FIRMWARE_SYA_ver_0_4.c,130 :: 		}
L_selector14:
;FIRMWARE_SYA_ver_0_4.c,132 :: 		}
L_end_selector:
	RETURN      0
; end of _selector

_watcher:

;FIRMWARE_SYA_ver_0_4.c,138 :: 		void watcher(){
;FIRMWARE_SYA_ver_0_4.c,140 :: 		if((SWITCH1 == 0) && (PosEdge1 == 1)){
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher24
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_watcher24
L__watcher38:
;FIRMWARE_SYA_ver_0_4.c,141 :: 		flag_switch = 1; // Ponemos en 1 la bandera del switch
	MOVLW       1
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_4.c,143 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_watcher25
;FIRMWARE_SYA_ver_0_4.c,144 :: 		switch_count++; // Incrementamos el contador del switch
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0_4.c,145 :: 		once = FALSE; // Rompemos la condicion del lazo
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_4.c,147 :: 		if(switch_count > 3){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _switch_count+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__watcher49
	MOVF        _switch_count+0, 0 
	SUBLW       3
L__watcher49:
	BTFSC       STATUS+0, 0 
	GOTO        L_watcher26
;FIRMWARE_SYA_ver_0_4.c,148 :: 		switch_count = 0; // Si, entonces lo reiniciamos
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0_4.c,149 :: 		}
L_watcher26:
;FIRMWARE_SYA_ver_0_4.c,150 :: 		}
L_watcher25:
;FIRMWARE_SYA_ver_0_4.c,151 :: 		}
L_watcher24:
;FIRMWARE_SYA_ver_0_4.c,153 :: 		while(SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher28
;FIRMWARE_SYA_ver_0_4.c,154 :: 		flag_switch = 0; // Ponemos la bandera del switch en 0
	CLRF        _flag_switch+0 
;FIRMWARE_SYA_ver_0_4.c,155 :: 		reg = switch_count; // Asignamos el valor del contador al registro
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0_4.c,156 :: 		once = TRUE; // Reiniciamos la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_4.c,158 :: 		}
L_watcher28:
;FIRMWARE_SYA_ver_0_4.c,160 :: 		if((SWITCH2 == 0) && (PosEdge2 == 1)){
	BTFSC       PORTC+0, 1 
	GOTO        L_watcher31
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_watcher31
L__watcher37:
;FIRMWARE_SYA_ver_0_4.c,161 :: 		flag_switch = 2; // Ponemos en 2 la bandera del switch
	MOVLW       2
	MOVWF       _flag_switch+0 
;FIRMWARE_SYA_ver_0_4.c,163 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_watcher32
;FIRMWARE_SYA_ver_0_4.c,164 :: 		switch_count++; // Incrementamos el contador del switch
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0_4.c,165 :: 		once = FALSE; // Rompemos la condicion del lazo
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_4.c,166 :: 		}
L_watcher32:
;FIRMWARE_SYA_ver_0_4.c,167 :: 		}
L_watcher31:
;FIRMWARE_SYA_ver_0_4.c,168 :: 		}
L_end_watcher:
	RETURN      0
; end of _watcher

_InitInterrupt:

;FIRMWARE_SYA_ver_0_4.c,174 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_4.c,176 :: 		PIE0 = 0x10;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       16
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_4.c,177 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_4.c,178 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_4.c,180 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_4.c,181 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_4.c,183 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_4.c,189 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_4.c,191 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_4.c,192 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_4.c,193 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_4.c,194 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_4.c,196 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_4.c,197 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_4.c,198 :: 		TRISA = 0x00;  //                ''                A
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0_4.c,200 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_4.c,201 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_4.c,202 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_4.c,204 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_4.c,205 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_4.c,206 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_4.c,208 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_4.c,209 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_4.c,210 :: 		flag01 = 0;    // Reinicio de
	BCF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_4.c,211 :: 		flag02 = 0;    // banderas (no usadas aun)
	BCF         _flag02+0, BitPos(_flag02+0) 
;FIRMWARE_SYA_ver_0_4.c,213 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_4.c,215 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
