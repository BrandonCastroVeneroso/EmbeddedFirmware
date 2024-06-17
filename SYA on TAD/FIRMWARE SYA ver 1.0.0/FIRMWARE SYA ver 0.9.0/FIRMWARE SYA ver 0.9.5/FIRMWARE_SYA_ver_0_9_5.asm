
_interrupt:

;FIRMWARE_SYA_ver_0_9_5.c,69 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_9_5.c,71 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_0_9_5.c,72 :: 		TMR0H = 0x06;      // Timer para cada segundo y medio?
	MOVLW       6
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_9_5.c,73 :: 		TMR0L = 0x00;      //
	CLRF        TMR0L+0 
;FIRMWARE_SYA_ver_0_9_5.c,74 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_9_5.c,80 :: 		}*/
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;FIRMWARE_SYA_ver_0_9_5.c,81 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_0_9_5.c,83 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt3
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt3
L__interrupt44:
;FIRMWARE_SYA_ver_0_9_5.c,84 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_9_5.c,85 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_5.c,88 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_0_9_5.c,90 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt6
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt6
L__interrupt43:
;FIRMWARE_SYA_ver_0_9_5.c,91 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_9_5.c,92 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,95 :: 		}
L_interrupt6:
;FIRMWARE_SYA_ver_0_9_5.c,97 :: 		}
L_end_interrupt:
L__interrupt46:
	RETFIE      1
; end of _interrupt

_Events:

;FIRMWARE_SYA_ver_0_9_5.c,103 :: 		void Events(){
;FIRMWARE_SYA_ver_0_9_5.c,105 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events7
;FIRMWARE_SYA_ver_0_9_5.c,107 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events8
;FIRMWARE_SYA_ver_0_9_5.c,108 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,109 :: 		sn_NegEdge_1 = 1; // Set señal de flanco negativo en s1
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,110 :: 		}
	GOTO        L_Events9
L_Events8:
;FIRMWARE_SYA_ver_0_9_5.c,112 :: 		sn_PosEdge_1 = 1; // Set señal de flanco positivo en s1
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,113 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,114 :: 		}
L_Events9:
;FIRMWARE_SYA_ver_0_9_5.c,115 :: 		}
	GOTO        L_Events10
L_Events7:
;FIRMWARE_SYA_ver_0_9_5.c,117 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events11
;FIRMWARE_SYA_ver_0_9_5.c,119 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events12
;FIRMWARE_SYA_ver_0_9_5.c,120 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,121 :: 		sn_NegEdge_2 = 1; // Set señal de flanco negativo en s2
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,122 :: 		}
	GOTO        L_Events13
L_Events12:
;FIRMWARE_SYA_ver_0_9_5.c,124 :: 		sn_PosEdge_2 = 1; // Set señal de flanco positivo en s2
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,125 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,126 :: 		}
L_Events13:
;FIRMWARE_SYA_ver_0_9_5.c,127 :: 		}
	GOTO        L_Events14
L_Events11:
;FIRMWARE_SYA_ver_0_9_5.c,129 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_5.c,130 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,131 :: 		}
L_Events14:
L_Events10:
;FIRMWARE_SYA_ver_0_9_5.c,132 :: 		return;
;FIRMWARE_SYA_ver_0_9_5.c,133 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_main:

;FIRMWARE_SYA_ver_0_9_5.c,139 :: 		void main(){
;FIRMWARE_SYA_ver_0_9_5.c,141 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_9_5.c,142 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_9_5.c,144 :: 		while(1){
L_main15:
;FIRMWARE_SYA_ver_0_9_5.c,145 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_9_5.c,147 :: 		fsm_state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _fsm_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,148 :: 		switch(fsm_state){
	GOTO        L_main17
;FIRMWARE_SYA_ver_0_9_5.c,150 :: 		case 0:
L_main19:
;FIRMWARE_SYA_ver_0_9_5.c,151 :: 		LED = 0; // Idk if this breaks the code or not
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_9_5.c,153 :: 		if(sn_PosEdge_1 == 1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main20
;FIRMWARE_SYA_ver_0_9_5.c,154 :: 		switch(last_INC){
	GOTO        L_main21
;FIRMWARE_SYA_ver_0_9_5.c,156 :: 		case 1:
L_main23:
;FIRMWARE_SYA_ver_0_9_5.c,157 :: 		INC1 = 0;
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,158 :: 		INC2 = 1; // El siguiente estado en INC es 2
	BSF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,159 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,160 :: 		INC = 2;
	MOVLW       2
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
;FIRMWARE_SYA_ver_0_9_5.c,161 :: 		next_state = 1; // Cambia a siguiente estado 1
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,162 :: 		break;
	GOTO        L_main22
;FIRMWARE_SYA_ver_0_9_5.c,164 :: 		case 2:
L_main24:
;FIRMWARE_SYA_ver_0_9_5.c,165 :: 		INC1 = 0;
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,166 :: 		INC2 = 0;
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,167 :: 		INC3 = 1; // El siguiente estado en INC es 3
	BSF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,168 :: 		INC = 3;
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
;FIRMWARE_SYA_ver_0_9_5.c,169 :: 		next_state = 1; // Cambia a siguiente estado 1
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,170 :: 		break;
	GOTO        L_main22
;FIRMWARE_SYA_ver_0_9_5.c,171 :: 		case 3:
L_main25:
;FIRMWARE_SYA_ver_0_9_5.c,172 :: 		INC1 = 1; // El siguiente estado en INC es 1
	BSF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,173 :: 		INC2 = 0;
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,174 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,175 :: 		INC = 1;
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
;FIRMWARE_SYA_ver_0_9_5.c,176 :: 		next_state = 1; // Cambia a siguiente estado 1
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,177 :: 		break;
	GOTO        L_main22
;FIRMWARE_SYA_ver_0_9_5.c,178 :: 		default:
L_main26:
;FIRMWARE_SYA_ver_0_9_5.c,179 :: 		INC1 = 1; // Por default el estado en INC sera uno
	BSF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,180 :: 		INC2 = 0;
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,181 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,182 :: 		INC = 1;
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
;FIRMWARE_SYA_ver_0_9_5.c,183 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,184 :: 		break;
	GOTO        L_main22
;FIRMWARE_SYA_ver_0_9_5.c,185 :: 		}
L_main21:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	GOTO        L_main26
L_main22:
;FIRMWARE_SYA_ver_0_9_5.c,186 :: 		}
L_main20:
;FIRMWARE_SYA_ver_0_9_5.c,187 :: 		break;
	GOTO        L_main18
;FIRMWARE_SYA_ver_0_9_5.c,189 :: 		case 1:
L_main27:
;FIRMWARE_SYA_ver_0_9_5.c,190 :: 		AND_signal = 1; // Señal de confirmacion
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
;FIRMWARE_SYA_ver_0_9_5.c,191 :: 		switch(INC){
	GOTO        L_main28
;FIRMWARE_SYA_ver_0_9_5.c,193 :: 		case 1:
L_main30:
;FIRMWARE_SYA_ver_0_9_5.c,195 :: 		if(INC1){
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main31
;FIRMWARE_SYA_ver_0_9_5.c,196 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_5.c,197 :: 		M2 = 1; // Grupo de trabajo 1 (Bombas 1 y 2)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_5.c,198 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_5.c,199 :: 		last_INC = 1; // Seteamos que el ultimo valor de INC es 1
	MOVLW       1
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_5.c,201 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main32
;FIRMWARE_SYA_ver_0_9_5.c,202 :: 		next_state = 0; // Regresa a estado 0
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,203 :: 		INC1 = 0; // Baja la señal de redundancia
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,204 :: 		}
	GOTO        L_main33
L_main32:
;FIRMWARE_SYA_ver_0_9_5.c,206 :: 		INC1 = 1; // Manten la señal de redundancia
	BSF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,207 :: 		}
L_main33:
;FIRMWARE_SYA_ver_0_9_5.c,208 :: 		}
L_main31:
;FIRMWARE_SYA_ver_0_9_5.c,209 :: 		break;
	GOTO        L_main29
;FIRMWARE_SYA_ver_0_9_5.c,211 :: 		case 2:
L_main34:
;FIRMWARE_SYA_ver_0_9_5.c,213 :: 		if(INC2){
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main35
;FIRMWARE_SYA_ver_0_9_5.c,214 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_5.c,215 :: 		M2 = 1; // Grupo de trabajo 2 (Bombas 2 y 3)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_5.c,216 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_5.c,217 :: 		last_INC = 2; // Seteamos que el ultimo valor de INC es 2
	MOVLW       2
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_5.c,219 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main36
;FIRMWARE_SYA_ver_0_9_5.c,220 :: 		next_state = 0; // Regresa a estado 0
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,221 :: 		INC2 = 0; // Baja la señal de redundancia
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,222 :: 		}
	GOTO        L_main37
L_main36:
;FIRMWARE_SYA_ver_0_9_5.c,224 :: 		INC2 = 1; // Manten la señal de redundancia
	BSF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,225 :: 		}
L_main37:
;FIRMWARE_SYA_ver_0_9_5.c,226 :: 		}
L_main35:
;FIRMWARE_SYA_ver_0_9_5.c,227 :: 		break;
	GOTO        L_main29
;FIRMWARE_SYA_ver_0_9_5.c,229 :: 		case 3:
L_main38:
;FIRMWARE_SYA_ver_0_9_5.c,231 :: 		if(INC3){
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main39
;FIRMWARE_SYA_ver_0_9_5.c,232 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_5.c,233 :: 		M2 = 0; // Grupo de trabajo 3 (Bombas 1 y 3)
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_5.c,234 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_5.c,235 :: 		last_INC = 3; // Seteamos que el ultimo valor de INC es 3
	MOVLW       3
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_5.c,237 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main40
;FIRMWARE_SYA_ver_0_9_5.c,238 :: 		next_state = 0; // Regresa a estado 0
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,239 :: 		INC3 = 0; // Baja la señal de redundancia
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,240 :: 		}
	GOTO        L_main41
L_main40:
;FIRMWARE_SYA_ver_0_9_5.c,242 :: 		INC3 = 1; // Manten la señal de redundancia
	BSF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,243 :: 		}
L_main41:
;FIRMWARE_SYA_ver_0_9_5.c,244 :: 		}
L_main39:
;FIRMWARE_SYA_ver_0_9_5.c,245 :: 		break;
	GOTO        L_main29
;FIRMWARE_SYA_ver_0_9_5.c,246 :: 		}
L_main28:
	MOVLW       0
	XORWF       _INC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main49
	MOVLW       1
	XORWF       _INC+0, 0 
L__main49:
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
	MOVLW       0
	XORWF       _INC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main50
	MOVLW       2
	XORWF       _INC+0, 0 
L__main50:
	BTFSC       STATUS+0, 2 
	GOTO        L_main34
	MOVLW       0
	XORWF       _INC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main51
	MOVLW       3
	XORWF       _INC+0, 0 
L__main51:
	BTFSC       STATUS+0, 2 
	GOTO        L_main38
L_main29:
;FIRMWARE_SYA_ver_0_9_5.c,247 :: 		break;
	GOTO        L_main18
;FIRMWARE_SYA_ver_0_9_5.c,248 :: 		default:
L_main42:
;FIRMWARE_SYA_ver_0_9_5.c,249 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,250 :: 		fsm_state = 0;
	CLRF        _fsm_state+0 
;FIRMWARE_SYA_ver_0_9_5.c,251 :: 		INC1 = 0;
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_5.c,252 :: 		INC2 = 0; // Por default dejamos todo en 0 y el ultimo estado de INC en 2
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_5.c,253 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_5.c,254 :: 		INC = 0;
	CLRF        _INC+0 
	CLRF        _INC+1 
;FIRMWARE_SYA_ver_0_9_5.c,255 :: 		last_INC = 2;
	MOVLW       2
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_5.c,256 :: 		break;
	GOTO        L_main18
;FIRMWARE_SYA_ver_0_9_5.c,257 :: 		}
L_main17:
	MOVF        _fsm_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
	MOVF        _fsm_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
	GOTO        L_main42
L_main18:
;FIRMWARE_SYA_ver_0_9_5.c,258 :: 		}
	GOTO        L_main15
;FIRMWARE_SYA_ver_0_9_5.c,260 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_InitInterrupt:

;FIRMWARE_SYA_ver_0_9_5.c,266 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_9_5.c,268 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_9_5.c,269 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_9_5.c,270 :: 		T0CON0 = 0x90;  //
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_9_5.c,271 :: 		T0CON1 = 0x40;  // Configuracion para Timer0, 16 bits, prescaler 1:1
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_9_5.c,272 :: 		TMR0H = 0x06;   // Usamos el oscilador seleccionado Fosc/4, aprox 1 ms de interrupt @ 20 Mhz
	MOVLW       6
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_9_5.c,273 :: 		TMR0L = 0x00;   //
	CLRF        TMR0L+0 
;FIRMWARE_SYA_ver_0_9_5.c,274 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_9_5.c,275 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_9_5.c,276 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_9_5.c,277 :: 		PIR0.TMR0IF = 0; // Limpiamos bandera de interrupt en Timer0
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_9_5.c,278 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_9_5.c,280 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_9_5.c,286 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_9_5.c,288 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_9_5.c,289 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_9_5.c,290 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_9_5.c,291 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_9_5.c,293 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_9_5.c,294 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_9_5.c,295 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_9_5.c,297 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_9_5.c,298 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_9_5.c,299 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_9_5.c,301 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_9_5.c,302 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_9_5.c,303 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_9_5.c,305 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_9_5.c,306 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_9_5.c,307 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_9_5.c,308 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_9_5.c,310 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
