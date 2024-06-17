
_interrupt:

;FIRMWARE_SYA_ver_0_8_5.c,69 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_5.c,70 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_8_5.c,71 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt104:
	BZ          L__interrupt105
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt104
L__interrupt105:
;FIRMWARE_SYA_ver_0_8_5.c,84 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt87:
;FIRMWARE_SYA_ver_0_8_5.c,85 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_5.c,86 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_5.c,87 :: 		flag01 = 1;
	BSF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_8_5.c,88 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8_5.c,90 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt86:
;FIRMWARE_SYA_ver_0_8_5.c,91 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_5.c,92 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,93 :: 		flag01 = 1;
	BSF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_8_5.c,94 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8_5.c,96 :: 		}
L_end_interrupt:
L__interrupt103:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_5.c,102 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_5.c,104 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_5.c,105 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_5.c,114 :: 		if(flag_init){
	BTFSS       _flag_init+0, BitPos(_flag_init+0) 
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8_5.c,115 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,116 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,117 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_5.c,118 :: 		flag_init = 0;
	BCF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8_5.c,119 :: 		}
L_main6:
;FIRMWARE_SYA_ver_0_8_5.c,122 :: 		do{
L_main7:
;FIRMWARE_SYA_ver_0_8_5.c,123 :: 		Events(); // Initialize
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_5.c,124 :: 		State();  // functions
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8_5.c,125 :: 		}while(1);
	GOTO        L_main7
;FIRMWARE_SYA_ver_0_8_5.c,127 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_blink:

;FIRMWARE_SYA_ver_0_8_5.c,133 :: 		int blink(int *_next_state){
;FIRMWARE_SYA_ver_0_8_5.c,134 :: 		if(flag01){
	BTFSS       _flag01+0, BitPos(_flag01+0) 
	GOTO        L_blink10
;FIRMWARE_SYA_ver_0_8_5.c,135 :: 		if(state == next_state){
	MOVF        _state+0, 0 
	XORWF       _next_state+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_blink11
;FIRMWARE_SYA_ver_0_8_5.c,136 :: 		}
	GOTO        L_blink12
L_blink11:
;FIRMWARE_SYA_ver_0_8_5.c,138 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_5.c,139 :: 		}
L_blink12:
;FIRMWARE_SYA_ver_0_8_5.c,140 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_8_5.c,141 :: 		flag01 = 0;
	BCF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_8_5.c,142 :: 		}
L_blink10:
;FIRMWARE_SYA_ver_0_8_5.c,143 :: 		return state;
	MOVF        _state+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;FIRMWARE_SYA_ver_0_8_5.c,144 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_State:

;FIRMWARE_SYA_ver_0_8_5.c,150 :: 		void State(){
;FIRMWARE_SYA_ver_0_8_5.c,154 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_5.c,156 :: 		switch(state){
	GOTO        L_State13
;FIRMWARE_SYA_ver_0_8_5.c,157 :: 		case 0: // S0 - Todo apagado
L_State15:
;FIRMWARE_SYA_ver_0_8_5.c,158 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_5.c,159 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_5.c,160 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_5.c,161 :: 		M4 = 1;
	BSF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_8_5.c,162 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_5.c,164 :: 		if((sn_PosEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State18
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State18
L__State101:
;FIRMWARE_SYA_ver_0_8_5.c,165 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,166 :: 		}
	GOTO        L_State19
L_State18:
;FIRMWARE_SYA_ver_0_8_5.c,169 :: 		}
L_State19:
;FIRMWARE_SYA_ver_0_8_5.c,170 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,171 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_State20:
;FIRMWARE_SYA_ver_0_8_5.c,172 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_5.c,173 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_5.c,174 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_5.c,175 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,176 :: 		GT2 = 0; // Si comentarizo esto se rompe el codigo
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,177 :: 		GT3 = 0; // (why tho???)
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_5.c,179 :: 		if((sn_NegEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State23
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State23
L__State100:
;FIRMWARE_SYA_ver_0_8_5.c,181 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,183 :: 		}
	GOTO        L_State24
L_State23:
;FIRMWARE_SYA_ver_0_8_5.c,185 :: 		else if((sn_PosEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State27
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State27
L__State99:
;FIRMWARE_SYA_ver_0_8_5.c,187 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,188 :: 		}
	GOTO        L_State28
L_State27:
;FIRMWARE_SYA_ver_0_8_5.c,193 :: 		}
L_State28:
L_State24:
;FIRMWARE_SYA_ver_0_8_5.c,194 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,195 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_State29:
;FIRMWARE_SYA_ver_0_8_5.c,196 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_5.c,197 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_5.c,198 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_5.c,199 :: 		GT1 = 0; // Trouble
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,200 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,201 :: 		GT3 = 0; // Here comes trouble
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_5.c,203 :: 		if((sn_NegEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State32
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State32
L__State98:
;FIRMWARE_SYA_ver_0_8_5.c,205 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,206 :: 		}
	GOTO        L_State33
L_State32:
;FIRMWARE_SYA_ver_0_8_5.c,208 :: 		else if((sn_PosEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State36
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State36
L__State97:
;FIRMWARE_SYA_ver_0_8_5.c,210 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,211 :: 		}
	GOTO        L_State37
L_State36:
;FIRMWARE_SYA_ver_0_8_5.c,216 :: 		}
L_State37:
L_State33:
;FIRMWARE_SYA_ver_0_8_5.c,217 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,218 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_State38:
;FIRMWARE_SYA_ver_0_8_5.c,219 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_5.c,220 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_5.c,221 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_5.c,222 :: 		GT1 = 0; // Way way more
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,223 :: 		GT2 = 0; // trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,224 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_5.c,226 :: 		if((sn_NegEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State41
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State41
L__State96:
;FIRMWARE_SYA_ver_0_8_5.c,228 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,229 :: 		}
	GOTO        L_State42
L_State41:
;FIRMWARE_SYA_ver_0_8_5.c,231 :: 		else if((sn_PosEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State45
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State45
L__State95:
;FIRMWARE_SYA_ver_0_8_5.c,233 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,234 :: 		}
	GOTO        L_State46
L_State45:
;FIRMWARE_SYA_ver_0_8_5.c,239 :: 		}
L_State46:
L_State42:
;FIRMWARE_SYA_ver_0_8_5.c,240 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,241 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_State47:
;FIRMWARE_SYA_ver_0_8_5.c,242 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_5.c,243 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_5.c,244 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_5.c,246 :: 		if((sn_NegEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_State50
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State50
L__State94:
;FIRMWARE_SYA_ver_0_8_5.c,248 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,249 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_5.c,250 :: 		}
	GOTO        L_State51
L_State50:
;FIRMWARE_SYA_ver_0_8_5.c,255 :: 		}
L_State51:
;FIRMWARE_SYA_ver_0_8_5.c,256 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,257 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_State52:
;FIRMWARE_SYA_ver_0_8_5.c,259 :: 		if((sn_GoTo == 1) && (GT1 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State55
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State55
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State55
L__State93:
;FIRMWARE_SYA_ver_0_8_5.c,260 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,261 :: 		}
	GOTO        L_State56
L_State55:
;FIRMWARE_SYA_ver_0_8_5.c,262 :: 		else if((sn_GoTo == 1) && (GT2 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State59
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State59
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State59
L__State92:
;FIRMWARE_SYA_ver_0_8_5.c,263 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,264 :: 		}
	GOTO        L_State60
L_State59:
;FIRMWARE_SYA_ver_0_8_5.c,265 :: 		else if((sn_GoTo == 1) && (GT3 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State63
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State63
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State63
L__State91:
;FIRMWARE_SYA_ver_0_8_5.c,266 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,267 :: 		}
	GOTO        L_State64
L_State63:
;FIRMWARE_SYA_ver_0_8_5.c,272 :: 		}
L_State64:
L_State60:
L_State56:
;FIRMWARE_SYA_ver_0_8_5.c,273 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,274 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_State65:
;FIRMWARE_SYA_ver_0_8_5.c,275 :: 		M4 = 0;
	BCF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_8_5.c,276 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State66
;FIRMWARE_SYA_ver_0_8_5.c,278 :: 		if((GT1 == 1) && (clock0 == 1)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State69
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State69
L__State90:
;FIRMWARE_SYA_ver_0_8_5.c,280 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,281 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,282 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_5.c,283 :: 		}
	GOTO        L_State70
L_State69:
;FIRMWARE_SYA_ver_0_8_5.c,285 :: 		else if((GT2 == 1) && (clock0 == 1)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State73
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State73
L__State89:
;FIRMWARE_SYA_ver_0_8_5.c,287 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,288 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,289 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_5.c,290 :: 		}
	GOTO        L_State74
L_State73:
;FIRMWARE_SYA_ver_0_8_5.c,292 :: 		else if((GT3 == 1) && (clock0 == 1)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State77
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State77
L__State88:
;FIRMWARE_SYA_ver_0_8_5.c,294 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_5.c,295 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,296 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,297 :: 		}
	GOTO        L_State78
L_State77:
;FIRMWARE_SYA_ver_0_8_5.c,302 :: 		}
L_State78:
L_State74:
L_State70:
;FIRMWARE_SYA_ver_0_8_5.c,303 :: 		}
L_State66:
;FIRMWARE_SYA_ver_0_8_5.c,304 :: 		break;
	GOTO        L_State14
;FIRMWARE_SYA_ver_0_8_5.c,305 :: 		}
L_State13:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State15
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State20
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State29
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State38
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State47
	MOVF        _state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_State52
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_State65
L_State14:
;FIRMWARE_SYA_ver_0_8_5.c,307 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8_5.c,313 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_5.c,315 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events79
;FIRMWARE_SYA_ver_0_8_5.c,317 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events80
;FIRMWARE_SYA_ver_0_8_5.c,319 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,320 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,321 :: 		}
	GOTO        L_Events81
L_Events80:
;FIRMWARE_SYA_ver_0_8_5.c,325 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,326 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,327 :: 		}
L_Events81:
;FIRMWARE_SYA_ver_0_8_5.c,328 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_5.c,329 :: 		}
	GOTO        L_Events82
L_Events79:
;FIRMWARE_SYA_ver_0_8_5.c,331 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events83
;FIRMWARE_SYA_ver_0_8_5.c,333 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events84
;FIRMWARE_SYA_ver_0_8_5.c,335 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,336 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,337 :: 		}
	GOTO        L_Events85
L_Events84:
;FIRMWARE_SYA_ver_0_8_5.c,341 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,342 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_5.c,343 :: 		}
L_Events85:
;FIRMWARE_SYA_ver_0_8_5.c,344 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_5.c,345 :: 		}
L_Events83:
L_Events82:
;FIRMWARE_SYA_ver_0_8_5.c,347 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_5.c,353 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_5.c,355 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_5.c,356 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_5.c,357 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_8_5.c,358 :: 		T0CON1 = 0x46;
	MOVLW       70
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_8_5.c,359 :: 		TMR0H = 0xE8;
	MOVLW       232
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_5.c,360 :: 		TMR0L = 0x49;
	MOVLW       73
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_5.c,361 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_5.c,362 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_5.c,363 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_5.c,364 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_5.c,365 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_5.c,367 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_5.c,373 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_5.c,375 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_5.c,376 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_5.c,377 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_5.c,378 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_5.c,380 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_5.c,381 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_5.c,382 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_5.c,384 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_5.c,385 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_5.c,386 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_5.c,388 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_5.c,389 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_5.c,390 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_5.c,392 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_5.c,393 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_5.c,394 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_5.c,395 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_5.c,397 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_5.c,399 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
