
_interrupt:

;FIRMWARE_SYA_ver_0_8.c,59 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8.c,60 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_8.c,61 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt65:
	BZ          L__interrupt66
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt65
L__interrupt66:
;FIRMWARE_SYA_ver_0_8.c,73 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt59:
;FIRMWARE_SYA_ver_0_8.c,74 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8.c,75 :: 		interruptC0 = 1;
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8.c,76 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8.c,78 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt58:
;FIRMWARE_SYA_ver_0_8.c,79 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8.c,80 :: 		interruptC1 = 1;
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8.c,81 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8.c,83 :: 		}
L_end_interrupt:
L__interrupt64:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8.c,89 :: 		void main(){
;FIRMWARE_SYA_ver_0_8.c,91 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8.c,92 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8.c,93 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8.c,94 :: 		flag_init = 1;
	BSF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8.c,97 :: 		do{
L_main6:
;FIRMWARE_SYA_ver_0_8.c,98 :: 		Events(current_state, next_state);
	MOVF        _current_state+0, 0 
	MOVWF       FARG_Events__current_state+0 
	MOVLW       0
	MOVWF       FARG_Events__current_state+1 
	MOVF        _next_state+0, 0 
	MOVWF       FARG_Events__next_state+0 
	MOVLW       0
	MOVWF       FARG_Events__next_state+1 
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8.c,99 :: 		NextStateCalc(current_state, last_state);
	MOVF        _current_state+0, 0 
	MOVWF       FARG_NextStateCalc__current_state+0 
	MOVLW       0
	MOVWF       FARG_NextStateCalc__current_state+1 
	MOVF        _last_state+0, 0 
	MOVWF       FARG_NextStateCalc__PosEdge1+0 
	MOVF        _last_state+1, 0 
	MOVWF       FARG_NextStateCalc__PosEdge1+1 
	CALL        _NextStateCalc+0, 0
;FIRMWARE_SYA_ver_0_8.c,100 :: 		State(current_state, PosEdge1);
	MOVF        _current_state+0, 0 
	MOVWF       FARG_State__current_state+0 
	MOVLW       0
	MOVWF       FARG_State__current_state+1 
	MOVLW       0
	BTFSC       _PosEdge1+0, BitPos(_PosEdge1+0) 
	MOVLW       1
	MOVWF       FARG_State__last_state+0 
	CLRF        FARG_State__last_state+1 
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8.c,101 :: 		}while(1);
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8.c,102 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_NextStateCalc:

;FIRMWARE_SYA_ver_0_8.c,104 :: 		void NextStateCalc(int _current_state, int _last_state){
;FIRMWARE_SYA_ver_0_8.c,106 :: 		switch(current_state){
	GOTO        L_NextStateCalc9
;FIRMWARE_SYA_ver_0_8.c,107 :: 		case 0:
L_NextStateCalc11:
;FIRMWARE_SYA_ver_0_8.c,108 :: 		if(PosEdge1){
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_NextStateCalc12
;FIRMWARE_SYA_ver_0_8.c,109 :: 		switch(last_state){
	GOTO        L_NextStateCalc13
;FIRMWARE_SYA_ver_0_8.c,110 :: 		case 0:
L_NextStateCalc15:
;FIRMWARE_SYA_ver_0_8.c,111 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,112 :: 		current_state = next_state;
	MOVLW       1
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,113 :: 		break;
	GOTO        L_NextStateCalc14
;FIRMWARE_SYA_ver_0_8.c,114 :: 		case 1:
L_NextStateCalc16:
;FIRMWARE_SYA_ver_0_8.c,115 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,116 :: 		current_state = next_state;
	MOVLW       2
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,117 :: 		break;
	GOTO        L_NextStateCalc14
;FIRMWARE_SYA_ver_0_8.c,118 :: 		case 2:
L_NextStateCalc17:
;FIRMWARE_SYA_ver_0_8.c,119 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,120 :: 		current_state = next_state;
	MOVLW       3
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,121 :: 		break;
	GOTO        L_NextStateCalc14
;FIRMWARE_SYA_ver_0_8.c,122 :: 		case 3:
L_NextStateCalc18:
;FIRMWARE_SYA_ver_0_8.c,123 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,124 :: 		current_state = next_state;
	MOVLW       1
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,125 :: 		break;
	GOTO        L_NextStateCalc14
;FIRMWARE_SYA_ver_0_8.c,126 :: 		case 4:
L_NextStateCalc19:
;FIRMWARE_SYA_ver_0_8.c,127 :: 		next_state = rand()%3;
	CALL        _rand+0, 0
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,128 :: 		current_state = next_state;
	MOVF        R0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,129 :: 		break;
	GOTO        L_NextStateCalc14
;FIRMWARE_SYA_ver_0_8.c,130 :: 		}
L_NextStateCalc13:
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NextStateCalc69
	MOVLW       0
	XORWF       _last_state+0, 0 
L__NextStateCalc69:
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc15
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NextStateCalc70
	MOVLW       1
	XORWF       _last_state+0, 0 
L__NextStateCalc70:
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc16
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NextStateCalc71
	MOVLW       2
	XORWF       _last_state+0, 0 
L__NextStateCalc71:
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc17
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NextStateCalc72
	MOVLW       3
	XORWF       _last_state+0, 0 
L__NextStateCalc72:
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc18
	MOVLW       0
	XORWF       _last_state+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__NextStateCalc73
	MOVLW       4
	XORWF       _last_state+0, 0 
L__NextStateCalc73:
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc19
L_NextStateCalc14:
;FIRMWARE_SYA_ver_0_8.c,131 :: 		}
	GOTO        L_NextStateCalc20
L_NextStateCalc12:
;FIRMWARE_SYA_ver_0_8.c,133 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,134 :: 		}
L_NextStateCalc20:
;FIRMWARE_SYA_ver_0_8.c,135 :: 		break;
	GOTO        L_NextStateCalc10
;FIRMWARE_SYA_ver_0_8.c,136 :: 		case 1:
L_NextStateCalc21:
;FIRMWARE_SYA_ver_0_8.c,137 :: 		if(NegEdge1){
	BTFSS       _NegEdge1+0, BitPos(_NegEdge1+0) 
	GOTO        L_NextStateCalc22
;FIRMWARE_SYA_ver_0_8.c,138 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,139 :: 		}
	GOTO        L_NextStateCalc23
L_NextStateCalc22:
;FIRMWARE_SYA_ver_0_8.c,140 :: 		else if(PosEdge2 && PosEdge1){
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_NextStateCalc26
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_NextStateCalc26
L__NextStateCalc62:
;FIRMWARE_SYA_ver_0_8.c,141 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,142 :: 		}
	GOTO        L_NextStateCalc27
L_NextStateCalc26:
;FIRMWARE_SYA_ver_0_8.c,144 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,145 :: 		}
L_NextStateCalc27:
L_NextStateCalc23:
;FIRMWARE_SYA_ver_0_8.c,146 :: 		break;
	GOTO        L_NextStateCalc10
;FIRMWARE_SYA_ver_0_8.c,147 :: 		case 2:
L_NextStateCalc28:
;FIRMWARE_SYA_ver_0_8.c,148 :: 		if(NegEdge1){
	BTFSS       _NegEdge1+0, BitPos(_NegEdge1+0) 
	GOTO        L_NextStateCalc29
;FIRMWARE_SYA_ver_0_8.c,149 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,150 :: 		}
	GOTO        L_NextStateCalc30
L_NextStateCalc29:
;FIRMWARE_SYA_ver_0_8.c,151 :: 		else if(PosEdge2 && PosEdge1){
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_NextStateCalc33
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_NextStateCalc33
L__NextStateCalc61:
;FIRMWARE_SYA_ver_0_8.c,152 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,153 :: 		}
	GOTO        L_NextStateCalc34
L_NextStateCalc33:
;FIRMWARE_SYA_ver_0_8.c,155 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,156 :: 		}
L_NextStateCalc34:
L_NextStateCalc30:
;FIRMWARE_SYA_ver_0_8.c,157 :: 		break;
	GOTO        L_NextStateCalc10
;FIRMWARE_SYA_ver_0_8.c,158 :: 		case 3:
L_NextStateCalc35:
;FIRMWARE_SYA_ver_0_8.c,159 :: 		if(NegEdge1){
	BTFSS       _NegEdge1+0, BitPos(_NegEdge1+0) 
	GOTO        L_NextStateCalc36
;FIRMWARE_SYA_ver_0_8.c,160 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,161 :: 		}
	GOTO        L_NextStateCalc37
L_NextStateCalc36:
;FIRMWARE_SYA_ver_0_8.c,162 :: 		else if(PosEdge2 && PosEdge1){
	BTFSS       _PosEdge2+0, BitPos(_PosEdge2+0) 
	GOTO        L_NextStateCalc40
	BTFSS       _PosEdge1+0, BitPos(_PosEdge1+0) 
	GOTO        L_NextStateCalc40
L__NextStateCalc60:
;FIRMWARE_SYA_ver_0_8.c,163 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,164 :: 		}
	GOTO        L_NextStateCalc41
L_NextStateCalc40:
;FIRMWARE_SYA_ver_0_8.c,166 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,167 :: 		}
L_NextStateCalc41:
L_NextStateCalc37:
;FIRMWARE_SYA_ver_0_8.c,168 :: 		break;
	GOTO        L_NextStateCalc10
;FIRMWARE_SYA_ver_0_8.c,169 :: 		case 4:
L_NextStateCalc42:
;FIRMWARE_SYA_ver_0_8.c,170 :: 		if(NegEdge2){
	BTFSS       _NegEdge2+0, BitPos(_NegEdge2+0) 
	GOTO        L_NextStateCalc43
;FIRMWARE_SYA_ver_0_8.c,171 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,172 :: 		}
	GOTO        L_NextStateCalc44
L_NextStateCalc43:
;FIRMWARE_SYA_ver_0_8.c,174 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8.c,175 :: 		}
L_NextStateCalc44:
;FIRMWARE_SYA_ver_0_8.c,176 :: 		break;
	GOTO        L_NextStateCalc10
;FIRMWARE_SYA_ver_0_8.c,177 :: 		}
L_NextStateCalc9:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc11
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc21
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc28
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc35
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_NextStateCalc42
L_NextStateCalc10:
;FIRMWARE_SYA_ver_0_8.c,179 :: 		}
L_end_NextStateCalc:
	RETURN      0
; end of _NextStateCalc

_State:

;FIRMWARE_SYA_ver_0_8.c,181 :: 		void State(int _current_state, int _PosEdge1){
;FIRMWARE_SYA_ver_0_8.c,183 :: 		switch(current_state){
	GOTO        L_State45
;FIRMWARE_SYA_ver_0_8.c,184 :: 		case 0:
L_State47:
;FIRMWARE_SYA_ver_0_8.c,185 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,186 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,187 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,188 :: 		last_state = 0;
	CLRF        _last_state+0 
	CLRF        _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,189 :: 		break;
	GOTO        L_State46
;FIRMWARE_SYA_ver_0_8.c,190 :: 		case 1:
L_State48:
;FIRMWARE_SYA_ver_0_8.c,191 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,192 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,193 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,194 :: 		last_state = 1;
	MOVLW       1
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,195 :: 		break;
	GOTO        L_State46
;FIRMWARE_SYA_ver_0_8.c,196 :: 		case 2:
L_State49:
;FIRMWARE_SYA_ver_0_8.c,197 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,198 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,199 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,200 :: 		last_state = 2;
	MOVLW       2
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,201 :: 		break;
	GOTO        L_State46
;FIRMWARE_SYA_ver_0_8.c,202 :: 		case 3:
L_State50:
;FIRMWARE_SYA_ver_0_8.c,203 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,204 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,205 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,206 :: 		last_state = 3;
	MOVLW       3
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,207 :: 		break;
	GOTO        L_State46
;FIRMWARE_SYA_ver_0_8.c,208 :: 		case 4:
L_State51:
;FIRMWARE_SYA_ver_0_8.c,209 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8.c,210 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8.c,211 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8.c,212 :: 		last_state = 4;
	MOVLW       4
	MOVWF       _last_state+0 
	MOVLW       0
	MOVWF       _last_state+1 
;FIRMWARE_SYA_ver_0_8.c,213 :: 		break;
	GOTO        L_State46
;FIRMWARE_SYA_ver_0_8.c,214 :: 		}
L_State45:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State47
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State48
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State49
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State50
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State51
L_State46:
;FIRMWARE_SYA_ver_0_8.c,216 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8.c,218 :: 		void Events(int _current_state, int _next_state){
;FIRMWARE_SYA_ver_0_8.c,220 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events52
;FIRMWARE_SYA_ver_0_8.c,221 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events53
;FIRMWARE_SYA_ver_0_8.c,222 :: 		PosEdge1 = 0;
	BCF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,223 :: 		NegEdge1 = 1;
	BSF         _NegEdge1+0, BitPos(_NegEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,224 :: 		}
L_Events53:
;FIRMWARE_SYA_ver_0_8.c,225 :: 		if(SWITCH1 == 0){
	BTFSC       PORTC+0, 0 
	GOTO        L_Events54
;FIRMWARE_SYA_ver_0_8.c,226 :: 		PosEdge1 = 1;
	BSF         _PosEdge1+0, BitPos(_PosEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,227 :: 		NegEdge1 = 0;
	BCF         _NegEdge1+0, BitPos(_NegEdge1+0) 
;FIRMWARE_SYA_ver_0_8.c,228 :: 		current_state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,229 :: 		}
L_Events54:
;FIRMWARE_SYA_ver_0_8.c,230 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8.c,231 :: 		}
L_Events52:
;FIRMWARE_SYA_ver_0_8.c,232 :: 		if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events55
;FIRMWARE_SYA_ver_0_8.c,233 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events56
;FIRMWARE_SYA_ver_0_8.c,234 :: 		PosEdge2 = 0; // Ponemos en 1 la bandera de transicion positiva en SWITCH2
	BCF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,235 :: 		NegEdge2 = 1;
	BSF         _NegEdge2+0, BitPos(_NegEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,236 :: 		}
L_Events56:
;FIRMWARE_SYA_ver_0_8.c,237 :: 		if(SWITCH2 == 0){
	BTFSC       PORTC+0, 1 
	GOTO        L_Events57
;FIRMWARE_SYA_ver_0_8.c,238 :: 		PosEdge2 = 1;
	BSF         _PosEdge2+0, BitPos(_PosEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,239 :: 		NegEdge2 = 0; // Ponemos en 1 la bandera de transicion negativa en SWITCH2
	BCF         _NegEdge2+0, BitPos(_NegEdge2+0) 
;FIRMWARE_SYA_ver_0_8.c,240 :: 		current_state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8.c,241 :: 		}
L_Events57:
;FIRMWARE_SYA_ver_0_8.c,242 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8.c,243 :: 		}
L_Events55:
;FIRMWARE_SYA_ver_0_8.c,245 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8.c,251 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8.c,253 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8.c,254 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8.c,259 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8.c,260 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8.c,261 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8.c,262 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8.c,264 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8.c,270 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8.c,272 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8.c,273 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8.c,274 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8.c,275 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8.c,277 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8.c,278 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8.c,279 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8.c,281 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8.c,282 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8.c,283 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8.c,285 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8.c,286 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8.c,287 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8.c,289 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8.c,290 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8.c,291 :: 		CM1CON0 = 0x00;
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8.c,292 :: 		CM2CON0 = 0x00;
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8.c,294 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8.c,296 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
