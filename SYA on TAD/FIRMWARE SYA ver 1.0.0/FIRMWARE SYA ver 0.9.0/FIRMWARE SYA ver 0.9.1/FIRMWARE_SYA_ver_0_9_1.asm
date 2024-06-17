
_interrupt:

;FIRMWARE_SYA_ver_0_9_1.c,61 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_9_1.c,63 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_0_9_1.c,64 :: 		TMR0H = 0x06;      // Timer para cada segundo y medio?
	MOVLW       6
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_9_1.c,65 :: 		TMR0L = 0x00;      //
	CLRF        TMR0L+0 
;FIRMWARE_SYA_ver_0_9_1.c,66 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_9_1.c,72 :: 		}*/
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;FIRMWARE_SYA_ver_0_9_1.c,73 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_0_9_1.c,75 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt3
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt3
L__interrupt64:
;FIRMWARE_SYA_ver_0_9_1.c,76 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_9_1.c,77 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_1.c,80 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_0_9_1.c,82 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt6
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt6
L__interrupt63:
;FIRMWARE_SYA_ver_0_9_1.c,83 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_9_1.c,84 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,87 :: 		}
L_interrupt6:
;FIRMWARE_SYA_ver_0_9_1.c,89 :: 		}
L_end_interrupt:
L__interrupt66:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_9_1.c,95 :: 		void main(){
;FIRMWARE_SYA_ver_0_9_1.c,97 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_9_1.c,98 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_9_1.c,100 :: 		while(1){
L_main7:
;FIRMWARE_SYA_ver_0_9_1.c,101 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_9_1.c,103 :: 		fsm_state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _fsm_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,104 :: 		switch(fsm_state){
	GOTO        L_main9
;FIRMWARE_SYA_ver_0_9_1.c,106 :: 		case 0:
L_main11:
;FIRMWARE_SYA_ver_0_9_1.c,107 :: 		LED = 0; // Idk if this breaks the code or not
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_9_1.c,109 :: 		if(sn_PosEdge_1 == 1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main12
;FIRMWARE_SYA_ver_0_9_1.c,110 :: 		switch(last_INC){
	GOTO        L_main13
;FIRMWARE_SYA_ver_0_9_1.c,112 :: 		case 1:
L_main15:
;FIRMWARE_SYA_ver_0_9_1.c,113 :: 		INC1 = 0;
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,114 :: 		INC2 = 1; // El siguiente estado en INC es 2
	BSF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,115 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,116 :: 		INC = 2;
	MOVLW       2
	MOVWF       _INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,117 :: 		next_state = 1; // Cambia a siguiente estado 1
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,118 :: 		break;
	GOTO        L_main14
;FIRMWARE_SYA_ver_0_9_1.c,120 :: 		case 2:
L_main16:
;FIRMWARE_SYA_ver_0_9_1.c,121 :: 		INC1 = 0;
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,122 :: 		INC2 = 0;
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,123 :: 		INC3 = 1; // El siguiente estado en INC es 3
	BSF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,124 :: 		INC = 3;
	MOVLW       3
	MOVWF       _INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,125 :: 		next_state = 1; // Cambia a siguiente estado 1
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,126 :: 		break;
	GOTO        L_main14
;FIRMWARE_SYA_ver_0_9_1.c,127 :: 		case 3:
L_main17:
;FIRMWARE_SYA_ver_0_9_1.c,128 :: 		INC1 = 1; // El siguiente estado en INC es 1
	BSF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,129 :: 		INC2 = 0;
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,130 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,131 :: 		INC = 1;
	MOVLW       1
	MOVWF       _INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,132 :: 		next_state = 1; // Cambia a siguiente estado 1
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,133 :: 		break;
	GOTO        L_main14
;FIRMWARE_SYA_ver_0_9_1.c,134 :: 		default:
L_main18:
;FIRMWARE_SYA_ver_0_9_1.c,135 :: 		INC1 = 1; // Por default el estado en INC sera uno
	BSF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,136 :: 		INC2 = 0;
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,137 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,138 :: 		INC = 1;
	MOVLW       1
	MOVWF       _INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,139 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,140 :: 		break;
	GOTO        L_main14
;FIRMWARE_SYA_ver_0_9_1.c,141 :: 		}
L_main13:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	GOTO        L_main18
L_main14:
;FIRMWARE_SYA_ver_0_9_1.c,142 :: 		}
L_main12:
;FIRMWARE_SYA_ver_0_9_1.c,143 :: 		break;
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_9_1.c,145 :: 		case 1:
L_main19:
;FIRMWARE_SYA_ver_0_9_1.c,146 :: 		AND_signal = 1; // Señal de confirmacion
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
;FIRMWARE_SYA_ver_0_9_1.c,147 :: 		switch(INC){
	GOTO        L_main20
;FIRMWARE_SYA_ver_0_9_1.c,149 :: 		case 1:
L_main22:
;FIRMWARE_SYA_ver_0_9_1.c,151 :: 		if(INC1){
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main23
;FIRMWARE_SYA_ver_0_9_1.c,153 :: 		if(CodigoGray(INC) == 1){
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main24
;FIRMWARE_SYA_ver_0_9_1.c,154 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_1.c,155 :: 		M2 = 1; // Grupo de trabajo 1 (Bombas 1 y 2)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_1.c,156 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_1.c,157 :: 		}
L_main24:
;FIRMWARE_SYA_ver_0_9_1.c,158 :: 		last_INC = 1; // Seteamos que el ultimo valor de INC es 1
	MOVLW       1
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,160 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main25
;FIRMWARE_SYA_ver_0_9_1.c,161 :: 		next_state = 0; // Regresa a estado 0
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,162 :: 		INC1 = 0; // Baja la señal de redundancia
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,163 :: 		}
	GOTO        L_main26
L_main25:
;FIRMWARE_SYA_ver_0_9_1.c,165 :: 		INC1 = 1; // Manten la señal de redundancia
	BSF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,166 :: 		}
L_main26:
;FIRMWARE_SYA_ver_0_9_1.c,167 :: 		}
L_main23:
;FIRMWARE_SYA_ver_0_9_1.c,168 :: 		break;
	GOTO        L_main21
;FIRMWARE_SYA_ver_0_9_1.c,170 :: 		case 2:
L_main27:
;FIRMWARE_SYA_ver_0_9_1.c,172 :: 		if(INC2){
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main28
;FIRMWARE_SYA_ver_0_9_1.c,174 :: 		if(CodigoGray(INC) == 2){
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
;FIRMWARE_SYA_ver_0_9_1.c,175 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_1.c,176 :: 		M2 = 1; // Grupo de trabajo 2 (Bombas 2 y 3)
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_1.c,177 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_1.c,178 :: 		}
L_main29:
;FIRMWARE_SYA_ver_0_9_1.c,179 :: 		last_INC = 2; // Seteamos que el ultimo valor de INC es 2
	MOVLW       2
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,181 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main30
;FIRMWARE_SYA_ver_0_9_1.c,182 :: 		next_state = 0; // Regresa a estado 0
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,183 :: 		INC2 = 0; // Baja la señal de redundancia
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,184 :: 		}
	GOTO        L_main31
L_main30:
;FIRMWARE_SYA_ver_0_9_1.c,186 :: 		INC2 = 1; // Manten la señal de redundancia
	BSF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,187 :: 		}
L_main31:
;FIRMWARE_SYA_ver_0_9_1.c,188 :: 		}
L_main28:
;FIRMWARE_SYA_ver_0_9_1.c,189 :: 		break;
	GOTO        L_main21
;FIRMWARE_SYA_ver_0_9_1.c,191 :: 		case 3:
L_main32:
;FIRMWARE_SYA_ver_0_9_1.c,193 :: 		if(INC3){
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main33
;FIRMWARE_SYA_ver_0_9_1.c,195 :: 		if(CodigoGray(INC) == 3){
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main34
;FIRMWARE_SYA_ver_0_9_1.c,196 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_1.c,197 :: 		M2 = 0; // Grupo de trabajo 3 (Bombas 1 y 3)
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_1.c,198 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_1.c,199 :: 		}
L_main34:
;FIRMWARE_SYA_ver_0_9_1.c,200 :: 		last_INC = 3; // Seteamos que el ultimo valor de INC es 3
	MOVLW       3
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,202 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main35
;FIRMWARE_SYA_ver_0_9_1.c,203 :: 		next_state = 0; // Regresa a estado 0
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,204 :: 		INC3 = 0; // Baja la señal de redundancia
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,205 :: 		}
	GOTO        L_main36
L_main35:
;FIRMWARE_SYA_ver_0_9_1.c,207 :: 		INC3 = 1; // Manten la señal de redundancia
	BSF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,208 :: 		}
L_main36:
;FIRMWARE_SYA_ver_0_9_1.c,209 :: 		}
L_main33:
;FIRMWARE_SYA_ver_0_9_1.c,210 :: 		break;
	GOTO        L_main21
;FIRMWARE_SYA_ver_0_9_1.c,211 :: 		}
L_main20:
	MOVF        _INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	MOVF        _INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
	MOVF        _INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
L_main21:
;FIRMWARE_SYA_ver_0_9_1.c,212 :: 		break;
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_9_1.c,213 :: 		default:
L_main37:
;FIRMWARE_SYA_ver_0_9_1.c,214 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,215 :: 		fsm_state = 0;
	CLRF        _fsm_state+0 
;FIRMWARE_SYA_ver_0_9_1.c,216 :: 		INC1 = 0;
	BCF         _INC1+0, BitPos(_INC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,217 :: 		INC2 = 0; // Por default dejamos todo en 0 y el ultimo estado de INC en 2
	BCF         _INC2+0, BitPos(_INC2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,218 :: 		INC3 = 0;
	BCF         _INC3+0, BitPos(_INC3+0) 
;FIRMWARE_SYA_ver_0_9_1.c,219 :: 		INC = 0;
	CLRF        _INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,220 :: 		last_INC = 2;
	MOVLW       2
	MOVWF       _last_INC+0 
;FIRMWARE_SYA_ver_0_9_1.c,221 :: 		break;
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_9_1.c,222 :: 		}
L_main9:
	MOVF        _fsm_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _fsm_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
	GOTO        L_main37
L_main10:
;FIRMWARE_SYA_ver_0_9_1.c,223 :: 		}
	GOTO        L_main7
;FIRMWARE_SYA_ver_0_9_1.c,225 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_CodigoGray:

;FIRMWARE_SYA_ver_0_9_1.c,231 :: 		char CodigoGray(short unsigned int INC){
;FIRMWARE_SYA_ver_0_9_1.c,233 :: 		gray = INC ^ (INC >> 1);
	MOVF        FARG_CodigoGray_INC+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	XORWF       FARG_CodigoGray_INC+0, 0 
	MOVWF       _gray+0 
	CLRF        _gray+1 
	MOVLW       0
	XORWF       _gray+1, 1 
	MOVLW       0
	MOVWF       _gray+1 
;FIRMWARE_SYA_ver_0_9_1.c,235 :: 		sprintf(result, "%u%u", (gray >> 1) & 1, (gray >> 0) & 1);
	MOVLW       _result+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_result+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_9_1+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_9_1+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_9_1+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _gray+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _gray+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	RRCF        FARG_sprintf_wh+6, 1 
	RRCF        FARG_sprintf_wh+5, 1 
	BCF         FARG_sprintf_wh+6, 7 
	BTFSC       FARG_sprintf_wh+6, 6 
	BSF         FARG_sprintf_wh+6, 7 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+5, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+6, 1 
	MOVF        _gray+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _gray+1, 0 
	MOVWF       FARG_sprintf_wh+8 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+7, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+8, 1 
	CALL        _sprintf+0, 0
;FIRMWARE_SYA_ver_0_9_1.c,237 :: 		switch(result[0]){
	GOTO        L_CodigoGray38
;FIRMWARE_SYA_ver_0_9_1.c,238 :: 		case '0':
L_CodigoGray40:
;FIRMWARE_SYA_ver_0_9_1.c,239 :: 		switch(result[1]){
	GOTO        L_CodigoGray41
;FIRMWARE_SYA_ver_0_9_1.c,240 :: 		case '1':
L_CodigoGray43:
;FIRMWARE_SYA_ver_0_9_1.c,242 :: 		if(AND_signal == 1){
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray44
;FIRMWARE_SYA_ver_0_9_1.c,244 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CodigoGray
;FIRMWARE_SYA_ver_0_9_1.c,245 :: 		}
L_CodigoGray44:
;FIRMWARE_SYA_ver_0_9_1.c,247 :: 		return 99;
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
;FIRMWARE_SYA_ver_0_9_1.c,250 :: 		}
L_CodigoGray41:
	MOVF        _result+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray43
;FIRMWARE_SYA_ver_0_9_1.c,251 :: 		break;
	GOTO        L_CodigoGray39
;FIRMWARE_SYA_ver_0_9_1.c,252 :: 		case '1':
L_CodigoGray46:
;FIRMWARE_SYA_ver_0_9_1.c,253 :: 		switch(result[1]){
	GOTO        L_CodigoGray47
;FIRMWARE_SYA_ver_0_9_1.c,254 :: 		case '1':
L_CodigoGray49:
;FIRMWARE_SYA_ver_0_9_1.c,256 :: 		if(AND_signal == 1){
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray50
;FIRMWARE_SYA_ver_0_9_1.c,258 :: 		return 2;
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_CodigoGray
;FIRMWARE_SYA_ver_0_9_1.c,259 :: 		}
L_CodigoGray50:
;FIRMWARE_SYA_ver_0_9_1.c,261 :: 		return 99;
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
;FIRMWARE_SYA_ver_0_9_1.c,264 :: 		case '0':
L_CodigoGray52:
;FIRMWARE_SYA_ver_0_9_1.c,266 :: 		if(AND_signal == 1){
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray53
;FIRMWARE_SYA_ver_0_9_1.c,268 :: 		return 3;
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_CodigoGray
;FIRMWARE_SYA_ver_0_9_1.c,269 :: 		}
L_CodigoGray53:
;FIRMWARE_SYA_ver_0_9_1.c,271 :: 		return 99;
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
;FIRMWARE_SYA_ver_0_9_1.c,274 :: 		}
L_CodigoGray47:
	MOVF        _result+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray49
	MOVF        _result+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray52
;FIRMWARE_SYA_ver_0_9_1.c,275 :: 		break;
	GOTO        L_CodigoGray39
;FIRMWARE_SYA_ver_0_9_1.c,276 :: 		}
L_CodigoGray38:
	MOVF        _result+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray40
	MOVF        _result+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray46
L_CodigoGray39:
;FIRMWARE_SYA_ver_0_9_1.c,278 :: 		return 0;
	CLRF        R0 
;FIRMWARE_SYA_ver_0_9_1.c,280 :: 		}
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_Events:

;FIRMWARE_SYA_ver_0_9_1.c,286 :: 		void Events(){
;FIRMWARE_SYA_ver_0_9_1.c,288 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events55
;FIRMWARE_SYA_ver_0_9_1.c,290 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events56
;FIRMWARE_SYA_ver_0_9_1.c,291 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,292 :: 		sn_NegEdge_1 = 1; // Set señal de flanco negativo en s1
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,293 :: 		}
	GOTO        L_Events57
L_Events56:
;FIRMWARE_SYA_ver_0_9_1.c,295 :: 		sn_PosEdge_1 = 1; // Set señal de flanco positivo en s1
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,296 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,297 :: 		}
L_Events57:
;FIRMWARE_SYA_ver_0_9_1.c,298 :: 		}
	GOTO        L_Events58
L_Events55:
;FIRMWARE_SYA_ver_0_9_1.c,300 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events59
;FIRMWARE_SYA_ver_0_9_1.c,302 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events60
;FIRMWARE_SYA_ver_0_9_1.c,303 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,304 :: 		sn_NegEdge_2 = 1; // Set señal de flanco negativo en s2
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,305 :: 		}
	GOTO        L_Events61
L_Events60:
;FIRMWARE_SYA_ver_0_9_1.c,307 :: 		sn_PosEdge_2 = 1; // Set señal de flanco positivo en s2
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,308 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_1.c,309 :: 		}
L_Events61:
;FIRMWARE_SYA_ver_0_9_1.c,310 :: 		}
	GOTO        L_Events62
L_Events59:
;FIRMWARE_SYA_ver_0_9_1.c,312 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_1.c,313 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_1.c,314 :: 		}
L_Events62:
L_Events58:
;FIRMWARE_SYA_ver_0_9_1.c,315 :: 		return;
;FIRMWARE_SYA_ver_0_9_1.c,316 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_9_1.c,322 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_9_1.c,324 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_9_1.c,325 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_9_1.c,326 :: 		T0CON0 = 0x90;  //
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_9_1.c,327 :: 		T0CON1 = 0x40;  // Configuracion para Timer0, 16 bits, prescaler 1:1
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_9_1.c,328 :: 		TMR0H = 0x06;   // Usamos el oscilador seleccionado Fosc/4, aprox 1 ms de interrupt @ 20 Mhz
	MOVLW       6
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_9_1.c,329 :: 		TMR0L = 0x00;   //
	CLRF        TMR0L+0 
;FIRMWARE_SYA_ver_0_9_1.c,330 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_9_1.c,331 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_9_1.c,332 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_9_1.c,333 :: 		PIR0.TMR0IF = 0; // Limpiamos bandera de interrupt en Timer0
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_9_1.c,334 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_9_1.c,336 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_9_1.c,342 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_9_1.c,344 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_9_1.c,345 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_9_1.c,346 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_9_1.c,347 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_9_1.c,349 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_9_1.c,350 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_9_1.c,351 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_9_1.c,353 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_9_1.c,354 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_9_1.c,355 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_9_1.c,357 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_9_1.c,358 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_9_1.c,359 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_9_1.c,361 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_9_1.c,362 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_9_1.c,363 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_9_1.c,364 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_9_1.c,366 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
