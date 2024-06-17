
_interrupt:

;FIRMWARE_SYA_ver_0_8_9_2.c,71 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_9_2.c,85 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt54:
;FIRMWARE_SYA_ver_0_8_9_2.c,86 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,87 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,90 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8_9_2.c,92 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt53:
;FIRMWARE_SYA_ver_0_8_9_2.c,93 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,94 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,97 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8_9_2.c,99 :: 		}
L_end_interrupt:
L__interrupt56:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_9_2.c,105 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_9_2.c,107 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_9_2.c,108 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_9_2.c,110 :: 		while(1){
L_main6:
;FIRMWARE_SYA_ver_0_8_9_2.c,111 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_9_2.c,112 :: 		FSM(); // Revisar bien los estados de la FSM tumorrow
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_0_8_9_2.c,113 :: 		}
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8_9_2.c,115 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_0_8_9_2.c,121 :: 		void FSM(){
;FIRMWARE_SYA_ver_0_8_9_2.c,122 :: 		short unsigned int state = 0;         // Variable de barrido de la FSM
	CLRF        FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,123 :: 		switch(state){
	GOTO        L_FSM8
;FIRMWARE_SYA_ver_0_8_9_2.c,124 :: 		case 0:
L_FSM10:
;FIRMWARE_SYA_ver_0_8_9_2.c,125 :: 		if(sn_PosEdge_1 == 1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_0_8_9_2.c,126 :: 		state = 1;
	MOVLW       1
	MOVWF       FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,127 :: 		}
	GOTO        L_FSM12
L_FSM11:
;FIRMWARE_SYA_ver_0_8_9_2.c,129 :: 		state = 0;
	CLRF        FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,130 :: 		}
L_FSM12:
;FIRMWARE_SYA_ver_0_8_9_2.c,131 :: 		break;
	GOTO        L_FSM9
;FIRMWARE_SYA_ver_0_8_9_2.c,132 :: 		case 1:
L_FSM13:
;FIRMWARE_SYA_ver_0_8_9_2.c,133 :: 		INC++;
	INFSNZ      _INC+0, 1 
	INCF        _INC+1, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,134 :: 		state = 2;
	MOVLW       2
	MOVWF       FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,135 :: 		break;
	GOTO        L_FSM9
;FIRMWARE_SYA_ver_0_8_9_2.c,136 :: 		case 2:
L_FSM14:
;FIRMWARE_SYA_ver_0_8_9_2.c,137 :: 		AND_signal = 1;
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,138 :: 		CodigoGray(INC);
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVF        _INC+1, 0 
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
;FIRMWARE_SYA_ver_0_8_9_2.c,139 :: 		if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM15
;FIRMWARE_SYA_ver_0_8_9_2.c,140 :: 		state = 3;
	MOVLW       3
	MOVWF       FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,141 :: 		}
	GOTO        L_FSM16
L_FSM15:
;FIRMWARE_SYA_ver_0_8_9_2.c,142 :: 		else if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM17
;FIRMWARE_SYA_ver_0_8_9_2.c,143 :: 		state = 0;
	CLRF        FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,144 :: 		}
	GOTO        L_FSM18
L_FSM17:
;FIRMWARE_SYA_ver_0_8_9_2.c,146 :: 		state = 2;
	MOVLW       2
	MOVWF       FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,147 :: 		}
L_FSM18:
L_FSM16:
;FIRMWARE_SYA_ver_0_8_9_2.c,148 :: 		break;
	GOTO        L_FSM9
;FIRMWARE_SYA_ver_0_8_9_2.c,149 :: 		case 3:
L_FSM19:
;FIRMWARE_SYA_ver_0_8_9_2.c,150 :: 		OR_signal = 1;
	BSF         _OR_signal+0, BitPos(_OR_signal+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,151 :: 		if(sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM20
;FIRMWARE_SYA_ver_0_8_9_2.c,152 :: 		state = 1;
	MOVLW       1
	MOVWF       FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,153 :: 		}
	GOTO        L_FSM21
L_FSM20:
;FIRMWARE_SYA_ver_0_8_9_2.c,154 :: 		else if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM22
;FIRMWARE_SYA_ver_0_8_9_2.c,155 :: 		state = 0;
	CLRF        FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,156 :: 		}
	GOTO        L_FSM23
L_FSM22:
;FIRMWARE_SYA_ver_0_8_9_2.c,158 :: 		state = 3;
	MOVLW       3
	MOVWF       FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,159 :: 		}
L_FSM23:
L_FSM21:
;FIRMWARE_SYA_ver_0_8_9_2.c,160 :: 		default:
L_FSM24:
;FIRMWARE_SYA_ver_0_8_9_2.c,161 :: 		state = 0;
	CLRF        FSM_state_L0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,162 :: 		break;
	GOTO        L_FSM9
;FIRMWARE_SYA_ver_0_8_9_2.c,163 :: 		}
L_FSM8:
	MOVF        FSM_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM10
	MOVF        FSM_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM13
	MOVF        FSM_state_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM14
	MOVF        FSM_state_L0+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM19
	GOTO        L_FSM24
L_FSM9:
;FIRMWARE_SYA_ver_0_8_9_2.c,165 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_CodigoGray:

;FIRMWARE_SYA_ver_0_8_9_2.c,171 :: 		void CodigoGray(int _INC){
;FIRMWARE_SYA_ver_0_8_9_2.c,172 :: 		int gray = INC ^ (INC >> 1u);
	MOVF        _INC+0, 0 
	MOVWF       R0 
	MOVF        _INC+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	XORWF       _INC+0, 0 
	MOVWF       R2 
	MOVF        _INC+1, 0 
	XORWF       R1, 0 
	MOVWF       R3 
;FIRMWARE_SYA_ver_0_8_9_2.c,174 :: 		sprintf(result, "%u%u", (gray >> 1u) & 1, (gray >> 0) & 1u);
	MOVLW       CodigoGray_result_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(CodigoGray_result_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_8_9_2+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_2+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_2+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        R2, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R3, 0 
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
	MOVLW       1
	ANDWF       R2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        R3, 0 
	MOVWF       FARG_sprintf_wh+8 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+8, 1 
	CALL        _sprintf+0, 0
;FIRMWARE_SYA_ver_0_8_9_2.c,175 :: 		switch(result[0]){
	GOTO        L_CodigoGray25
;FIRMWARE_SYA_ver_0_8_9_2.c,176 :: 		case '0':
L_CodigoGray27:
;FIRMWARE_SYA_ver_0_8_9_2.c,177 :: 		switch(result[1]){
	GOTO        L_CodigoGray28
;FIRMWARE_SYA_ver_0_8_9_2.c,178 :: 		case '1':
L_CodigoGray30:
;FIRMWARE_SYA_ver_0_8_9_2.c,179 :: 		if(AND_signal == 1){
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray31
;FIRMWARE_SYA_ver_0_8_9_2.c,180 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,181 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,182 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,183 :: 		if(OR_signal == 1){
	BTFSS       _OR_signal+0, BitPos(_OR_signal+0) 
	GOTO        L_CodigoGray32
;FIRMWARE_SYA_ver_0_8_9_2.c,184 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,185 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,186 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,187 :: 		}
L_CodigoGray32:
;FIRMWARE_SYA_ver_0_8_9_2.c,188 :: 		}
	GOTO        L_CodigoGray33
L_CodigoGray31:
;FIRMWARE_SYA_ver_0_8_9_2.c,190 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,191 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,192 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,193 :: 		}
L_CodigoGray33:
;FIRMWARE_SYA_ver_0_8_9_2.c,194 :: 		break;
	GOTO        L_CodigoGray29
;FIRMWARE_SYA_ver_0_8_9_2.c,195 :: 		}
L_CodigoGray28:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray30
L_CodigoGray29:
;FIRMWARE_SYA_ver_0_8_9_2.c,196 :: 		break;
	GOTO        L_CodigoGray26
;FIRMWARE_SYA_ver_0_8_9_2.c,197 :: 		case '1':
L_CodigoGray34:
;FIRMWARE_SYA_ver_0_8_9_2.c,198 :: 		switch(result[1]){
	GOTO        L_CodigoGray35
;FIRMWARE_SYA_ver_0_8_9_2.c,199 :: 		case '1':
L_CodigoGray37:
;FIRMWARE_SYA_ver_0_8_9_2.c,200 :: 		if(AND_signal == 1){
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray38
;FIRMWARE_SYA_ver_0_8_9_2.c,201 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,202 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,203 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,204 :: 		if(OR_signal == 1){
	BTFSS       _OR_signal+0, BitPos(_OR_signal+0) 
	GOTO        L_CodigoGray39
;FIRMWARE_SYA_ver_0_8_9_2.c,205 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,206 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,207 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,208 :: 		}
L_CodigoGray39:
;FIRMWARE_SYA_ver_0_8_9_2.c,209 :: 		}
	GOTO        L_CodigoGray40
L_CodigoGray38:
;FIRMWARE_SYA_ver_0_8_9_2.c,211 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,212 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,213 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,214 :: 		}
L_CodigoGray40:
;FIRMWARE_SYA_ver_0_8_9_2.c,215 :: 		break;
	GOTO        L_CodigoGray36
;FIRMWARE_SYA_ver_0_8_9_2.c,216 :: 		case '0':
L_CodigoGray41:
;FIRMWARE_SYA_ver_0_8_9_2.c,217 :: 		if(AND_signal == 1){
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray42
;FIRMWARE_SYA_ver_0_8_9_2.c,218 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,219 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,220 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,221 :: 		if(OR_signal == 1){
	BTFSS       _OR_signal+0, BitPos(_OR_signal+0) 
	GOTO        L_CodigoGray43
;FIRMWARE_SYA_ver_0_8_9_2.c,222 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,223 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,224 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,225 :: 		}
L_CodigoGray43:
;FIRMWARE_SYA_ver_0_8_9_2.c,226 :: 		}
	GOTO        L_CodigoGray44
L_CodigoGray42:
;FIRMWARE_SYA_ver_0_8_9_2.c,228 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,229 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_2.c,230 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_2.c,231 :: 		}
L_CodigoGray44:
;FIRMWARE_SYA_ver_0_8_9_2.c,232 :: 		break;
	GOTO        L_CodigoGray36
;FIRMWARE_SYA_ver_0_8_9_2.c,233 :: 		}
L_CodigoGray35:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray37
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray41
L_CodigoGray36:
;FIRMWARE_SYA_ver_0_8_9_2.c,234 :: 		break;
	GOTO        L_CodigoGray26
;FIRMWARE_SYA_ver_0_8_9_2.c,235 :: 		}
L_CodigoGray25:
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray27
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray34
L_CodigoGray26:
;FIRMWARE_SYA_ver_0_8_9_2.c,236 :: 		return;
;FIRMWARE_SYA_ver_0_8_9_2.c,237 :: 		}
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_Events:

;FIRMWARE_SYA_ver_0_8_9_2.c,243 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_9_2.c,244 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events45
;FIRMWARE_SYA_ver_0_8_9_2.c,245 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events46
;FIRMWARE_SYA_ver_0_8_9_2.c,246 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,247 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,248 :: 		}
	GOTO        L_Events47
L_Events46:
;FIRMWARE_SYA_ver_0_8_9_2.c,250 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,251 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,252 :: 		}
L_Events47:
;FIRMWARE_SYA_ver_0_8_9_2.c,254 :: 		}
	GOTO        L_Events48
L_Events45:
;FIRMWARE_SYA_ver_0_8_9_2.c,255 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events49
;FIRMWARE_SYA_ver_0_8_9_2.c,256 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events50
;FIRMWARE_SYA_ver_0_8_9_2.c,257 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,258 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,259 :: 		}
	GOTO        L_Events51
L_Events50:
;FIRMWARE_SYA_ver_0_8_9_2.c,261 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,262 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,263 :: 		}
L_Events51:
;FIRMWARE_SYA_ver_0_8_9_2.c,265 :: 		}
	GOTO        L_Events52
L_Events49:
;FIRMWARE_SYA_ver_0_8_9_2.c,267 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,268 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,269 :: 		}
L_Events52:
L_Events48:
;FIRMWARE_SYA_ver_0_8_9_2.c,271 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_9_2.c,277 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_9_2.c,279 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,280 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,281 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,282 :: 		T0CON1 = 0x44;
	MOVLW       68
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,283 :: 		TMR0H = 0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,284 :: 		TMR0L = 0xC0;
	MOVLW       192
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,285 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,286 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,287 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,288 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_9_2.c,289 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,291 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_9_2.c,297 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_9_2.c,299 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,300 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,301 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,302 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,304 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,305 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,306 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,308 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,309 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,310 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,312 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,313 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,314 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,316 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,317 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,318 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,319 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_9_2.c,321 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_9_2.c,323 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
