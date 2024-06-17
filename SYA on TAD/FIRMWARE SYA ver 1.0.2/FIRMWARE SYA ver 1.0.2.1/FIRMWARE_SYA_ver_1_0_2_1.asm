
_interrupt:

;FIRMWARE_SYA_ver_1_0_2_1.c,72 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_0_2_1.c,86 :: 		if((1 == IOCCF.B0) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt93:
;FIRMWARE_SYA_ver_1_0_2_1.c,87 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,88 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,89 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_0_2_1.c,91 :: 		if((1 == IOCCF.B1) && (1 == IOCIE_bit)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt92:
;FIRMWARE_SYA_ver_1_0_2_1.c,92 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,93 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,94 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_1_0_2_1.c,96 :: 		}
L_end_interrupt:
L__interrupt111:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_0_2_1.c,102 :: 		void main(){
;FIRMWARE_SYA_ver_1_0_2_1.c,104 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_0_2_1.c,105 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_0_2_1.c,107 :: 		do{
L_main6:
;FIRMWARE_SYA_ver_1_0_2_1.c,108 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_0_2_1.c,109 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main6
	BTFSC       IOCCF+0, 1 
	GOTO        L_main6
L__main94:
;FIRMWARE_SYA_ver_1_0_2_1.c,111 :: 		while(1){
L_main11:
;FIRMWARE_SYA_ver_1_0_2_1.c,112 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,113 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_0_2_1.c,114 :: 		}
	GOTO        L_main11
;FIRMWARE_SYA_ver_1_0_2_1.c,116 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_0_2_1.c,122 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_0_2_1.c,123 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,124 :: 		switch(current_state){
	GOTO        L_FSM13
;FIRMWARE_SYA_ver_1_0_2_1.c,125 :: 		case 0: // S0 - Todo apagado
L_FSM15:
;FIRMWARE_SYA_ver_1_0_2_1.c,126 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,127 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,128 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,129 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,131 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM18
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM18
L__FSM109:
;FIRMWARE_SYA_ver_1_0_2_1.c,132 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,133 :: 		}
	GOTO        L_FSM19
L_FSM18:
;FIRMWARE_SYA_ver_1_0_2_1.c,136 :: 		}
L_FSM19:
;FIRMWARE_SYA_ver_1_0_2_1.c,137 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,138 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_FSM20:
;FIRMWARE_SYA_ver_1_0_2_1.c,139 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,140 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,141 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,142 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,143 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,144 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,146 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM23
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM23
L__FSM108:
;FIRMWARE_SYA_ver_1_0_2_1.c,148 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,150 :: 		}
	GOTO        L_FSM24
L_FSM23:
;FIRMWARE_SYA_ver_1_0_2_1.c,152 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM27
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM27
L__FSM107:
;FIRMWARE_SYA_ver_1_0_2_1.c,154 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,155 :: 		}
	GOTO        L_FSM28
L_FSM27:
;FIRMWARE_SYA_ver_1_0_2_1.c,159 :: 		}
L_FSM28:
L_FSM24:
;FIRMWARE_SYA_ver_1_0_2_1.c,160 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,161 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_FSM29:
;FIRMWARE_SYA_ver_1_0_2_1.c,162 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,163 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,164 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,165 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,166 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,167 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,169 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM32
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM32
L__FSM106:
;FIRMWARE_SYA_ver_1_0_2_1.c,171 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,172 :: 		}
	GOTO        L_FSM33
L_FSM32:
;FIRMWARE_SYA_ver_1_0_2_1.c,174 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM36
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM36
L__FSM105:
;FIRMWARE_SYA_ver_1_0_2_1.c,176 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,177 :: 		}
	GOTO        L_FSM37
L_FSM36:
;FIRMWARE_SYA_ver_1_0_2_1.c,181 :: 		}
L_FSM37:
L_FSM33:
;FIRMWARE_SYA_ver_1_0_2_1.c,182 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,183 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_FSM38:
;FIRMWARE_SYA_ver_1_0_2_1.c,184 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,185 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,186 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,187 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,188 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,189 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,191 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM41
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM41
L__FSM104:
;FIRMWARE_SYA_ver_1_0_2_1.c,193 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,194 :: 		}
	GOTO        L_FSM42
L_FSM41:
;FIRMWARE_SYA_ver_1_0_2_1.c,196 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM45
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM45
L__FSM103:
;FIRMWARE_SYA_ver_1_0_2_1.c,198 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,199 :: 		}
	GOTO        L_FSM46
L_FSM45:
;FIRMWARE_SYA_ver_1_0_2_1.c,203 :: 		}
L_FSM46:
L_FSM42:
;FIRMWARE_SYA_ver_1_0_2_1.c,204 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,205 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_FSM47:
;FIRMWARE_SYA_ver_1_0_2_1.c,206 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,207 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,208 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,210 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM50
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM50
L__FSM102:
;FIRMWARE_SYA_ver_1_0_2_1.c,211 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,212 :: 		}
	GOTO        L_FSM51
L_FSM50:
;FIRMWARE_SYA_ver_1_0_2_1.c,213 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM54
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM54
L__FSM101:
;FIRMWARE_SYA_ver_1_0_2_1.c,215 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,216 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,217 :: 		}
	GOTO        L_FSM55
L_FSM54:
;FIRMWARE_SYA_ver_1_0_2_1.c,221 :: 		}
L_FSM55:
L_FSM51:
;FIRMWARE_SYA_ver_1_0_2_1.c,222 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,223 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_FSM56:
;FIRMWARE_SYA_ver_1_0_2_1.c,225 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM59
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM59
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM59
L__FSM100:
;FIRMWARE_SYA_ver_1_0_2_1.c,226 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,227 :: 		}
	GOTO        L_FSM60
L_FSM59:
;FIRMWARE_SYA_ver_1_0_2_1.c,228 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM63
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM63
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM63
L__FSM99:
;FIRMWARE_SYA_ver_1_0_2_1.c,229 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,230 :: 		}
	GOTO        L_FSM64
L_FSM63:
;FIRMWARE_SYA_ver_1_0_2_1.c,231 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM67
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM67
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM67
L__FSM98:
;FIRMWARE_SYA_ver_1_0_2_1.c,232 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,233 :: 		}
	GOTO        L_FSM68
L_FSM67:
;FIRMWARE_SYA_ver_1_0_2_1.c,237 :: 		}
L_FSM68:
L_FSM64:
L_FSM60:
;FIRMWARE_SYA_ver_1_0_2_1.c,238 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,239 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_FSM69:
;FIRMWARE_SYA_ver_1_0_2_1.c,240 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM70
;FIRMWARE_SYA_ver_1_0_2_1.c,242 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM73
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM73
L__FSM97:
;FIRMWARE_SYA_ver_1_0_2_1.c,244 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,245 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,246 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,247 :: 		}
	GOTO        L_FSM74
L_FSM73:
;FIRMWARE_SYA_ver_1_0_2_1.c,249 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM77
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM77
L__FSM96:
;FIRMWARE_SYA_ver_1_0_2_1.c,251 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,252 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,253 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,254 :: 		}
	GOTO        L_FSM78
L_FSM77:
;FIRMWARE_SYA_ver_1_0_2_1.c,256 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM81
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM81
L__FSM95:
;FIRMWARE_SYA_ver_1_0_2_1.c,258 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,259 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,260 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,261 :: 		}
	GOTO        L_FSM82
L_FSM81:
;FIRMWARE_SYA_ver_1_0_2_1.c,265 :: 		}
L_FSM82:
L_FSM78:
L_FSM74:
;FIRMWARE_SYA_ver_1_0_2_1.c,266 :: 		}
L_FSM70:
;FIRMWARE_SYA_ver_1_0_2_1.c,267 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,268 :: 		default:
L_FSM83:
;FIRMWARE_SYA_ver_1_0_2_1.c,269 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,270 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,271 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,272 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,273 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_0_2_1.c,274 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_0_2_1.c,275 :: 		current_state = 0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,276 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,277 :: 		break;
	GOTO        L_FSM14
;FIRMWARE_SYA_ver_1_0_2_1.c,278 :: 		}
L_FSM13:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM15
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM20
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM29
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM38
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM47
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM56
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM69
	GOTO        L_FSM83
L_FSM14:
;FIRMWARE_SYA_ver_1_0_2_1.c,280 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_0_2_1.c,286 :: 		void Events(){
;FIRMWARE_SYA_ver_1_0_2_1.c,288 :: 		if(1 == interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events84
;FIRMWARE_SYA_ver_1_0_2_1.c,290 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events85
;FIRMWARE_SYA_ver_1_0_2_1.c,292 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,293 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,294 :: 		}
	GOTO        L_Events86
L_Events85:
;FIRMWARE_SYA_ver_1_0_2_1.c,298 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,299 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,300 :: 		}
L_Events86:
;FIRMWARE_SYA_ver_1_0_2_1.c,301 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,302 :: 		}
	GOTO        L_Events87
L_Events84:
;FIRMWARE_SYA_ver_1_0_2_1.c,304 :: 		else if(1 == interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events88
;FIRMWARE_SYA_ver_1_0_2_1.c,306 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events89
;FIRMWARE_SYA_ver_1_0_2_1.c,308 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,309 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,310 :: 		}
	GOTO        L_Events90
L_Events89:
;FIRMWARE_SYA_ver_1_0_2_1.c,314 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,315 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,316 :: 		}
L_Events90:
;FIRMWARE_SYA_ver_1_0_2_1.c,317 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,318 :: 		}
	GOTO        L_Events91
L_Events88:
;FIRMWARE_SYA_ver_1_0_2_1.c,320 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,321 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_1_0_2_1.c,322 :: 		}
L_Events91:
L_Events87:
;FIRMWARE_SYA_ver_1_0_2_1.c,323 :: 		return;
;FIRMWARE_SYA_ver_1_0_2_1.c,325 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_1_0_2_1.c,331 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_0_2_1.c,333 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,334 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,335 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,336 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,337 :: 		TMR0H = 0xEC;
	MOVLW       236
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,338 :: 		TMR0L = 0x78;
	MOVLW       120
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,339 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,340 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,341 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,342 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_0_2_1.c,343 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,345 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_0_2_1.c,351 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_0_2_1.c,353 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,354 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,355 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,356 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,358 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,359 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,360 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,362 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,363 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,364 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,366 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,367 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,368 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,370 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,371 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,372 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,373 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_0_2_1.c,375 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
