
_interrupt:

;FIRMWARE_SYA_ver_0_8_9.c,69 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_9.c,83 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt113:
;FIRMWARE_SYA_ver_0_8_9.c,84 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,85 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_9.c,88 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8_9.c,90 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt112:
;FIRMWARE_SYA_ver_0_8_9.c,91 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,92 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,95 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8_9.c,97 :: 		}
L_end_interrupt:
L__interrupt121:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_9.c,103 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_9.c,105 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_9.c,106 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_9.c,116 :: 		if(flag_init){
	BTFSS       _flag_init+0, BitPos(_flag_init+0) 
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8_9.c,117 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,118 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,119 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,120 :: 		flag_init = 0;
	BCF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8_9.c,121 :: 		}
L_main6:
;FIRMWARE_SYA_ver_0_8_9.c,123 :: 		do{
L_main7:
;FIRMWARE_SYA_ver_0_8_9.c,124 :: 		Events(); // Initialize
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_9.c,125 :: 		switch(state){
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_8_9.c,126 :: 		case 0: // S0 - Todo apagado
L_main12:
;FIRMWARE_SYA_ver_0_8_9.c,127 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,128 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,129 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,130 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_9.c,132 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main13
;FIRMWARE_SYA_ver_0_8_9.c,133 :: 		state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,134 :: 		}
	GOTO        L_main14
L_main13:
;FIRMWARE_SYA_ver_0_8_9.c,137 :: 		}
L_main14:
;FIRMWARE_SYA_ver_0_8_9.c,138 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,139 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_main15:
;FIRMWARE_SYA_ver_0_8_9.c,140 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,141 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,142 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,143 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,144 :: 		GT2 = 0; // Si comentarizo esto se rompe el codigo
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,145 :: 		GT3 = 0; // (why tho???)
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,147 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main16
;FIRMWARE_SYA_ver_0_8_9.c,149 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,151 :: 		}
	GOTO        L_main17
L_main16:
;FIRMWARE_SYA_ver_0_8_9.c,153 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_main18
;FIRMWARE_SYA_ver_0_8_9.c,155 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,156 :: 		}
	GOTO        L_main19
L_main18:
;FIRMWARE_SYA_ver_0_8_9.c,161 :: 		}
L_main19:
L_main17:
;FIRMWARE_SYA_ver_0_8_9.c,162 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,163 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_main20:
;FIRMWARE_SYA_ver_0_8_9.c,164 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,165 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,166 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,167 :: 		GT1 = 0; // Trouble
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,168 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,169 :: 		GT3 = 0; // Here comes trouble
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,171 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main21
;FIRMWARE_SYA_ver_0_8_9.c,173 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,174 :: 		}
	GOTO        L_main22
L_main21:
;FIRMWARE_SYA_ver_0_8_9.c,176 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_main23
;FIRMWARE_SYA_ver_0_8_9.c,178 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,179 :: 		}
	GOTO        L_main24
L_main23:
;FIRMWARE_SYA_ver_0_8_9.c,184 :: 		}
L_main24:
L_main22:
;FIRMWARE_SYA_ver_0_8_9.c,185 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,186 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_main25:
;FIRMWARE_SYA_ver_0_8_9.c,187 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,188 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,189 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,190 :: 		GT1 = 0; // Way way more
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,191 :: 		GT2 = 0; // trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,192 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,194 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main26
;FIRMWARE_SYA_ver_0_8_9.c,196 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,197 :: 		}
	GOTO        L_main27
L_main26:
;FIRMWARE_SYA_ver_0_8_9.c,199 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_main28
;FIRMWARE_SYA_ver_0_8_9.c,201 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,202 :: 		}
	GOTO        L_main29
L_main28:
;FIRMWARE_SYA_ver_0_8_9.c,207 :: 		}
L_main29:
L_main27:
;FIRMWARE_SYA_ver_0_8_9.c,208 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,209 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_main30:
;FIRMWARE_SYA_ver_0_8_9.c,210 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,211 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,212 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,214 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main31
;FIRMWARE_SYA_ver_0_8_9.c,215 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,216 :: 		}
	GOTO        L_main32
L_main31:
;FIRMWARE_SYA_ver_0_8_9.c,217 :: 		else if(sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_main33
;FIRMWARE_SYA_ver_0_8_9.c,219 :: 		state = 5;
	MOVLW       5
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,220 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_9.c,221 :: 		}
	GOTO        L_main34
L_main33:
;FIRMWARE_SYA_ver_0_8_9.c,226 :: 		}
L_main34:
L_main32:
;FIRMWARE_SYA_ver_0_8_9.c,227 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,228 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_main35:
;FIRMWARE_SYA_ver_0_8_9.c,230 :: 		if((sn_GoTo == 1) && (GT1 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_main38
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_main38
L__main116:
;FIRMWARE_SYA_ver_0_8_9.c,231 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,232 :: 		}
	GOTO        L_main39
L_main38:
;FIRMWARE_SYA_ver_0_8_9.c,233 :: 		else if((sn_GoTo == 1) && (GT2 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_main42
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_main42
L__main115:
;FIRMWARE_SYA_ver_0_8_9.c,234 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,235 :: 		}
	GOTO        L_main43
L_main42:
;FIRMWARE_SYA_ver_0_8_9.c,236 :: 		else if((sn_GoTo == 1) && (GT3 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_main46
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_main46
L__main114:
;FIRMWARE_SYA_ver_0_8_9.c,237 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,238 :: 		}
	GOTO        L_main47
L_main46:
;FIRMWARE_SYA_ver_0_8_9.c,243 :: 		}
L_main47:
L_main43:
L_main39:
;FIRMWARE_SYA_ver_0_8_9.c,244 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,245 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_main48:
;FIRMWARE_SYA_ver_0_8_9.c,246 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main49
;FIRMWARE_SYA_ver_0_8_9.c,248 :: 		if(GT1){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_main50
;FIRMWARE_SYA_ver_0_8_9.c,250 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,251 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,252 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,253 :: 		}
	GOTO        L_main51
L_main50:
;FIRMWARE_SYA_ver_0_8_9.c,255 :: 		else if(GT2){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_main52
;FIRMWARE_SYA_ver_0_8_9.c,257 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,258 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,259 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,260 :: 		}
	GOTO        L_main53
L_main52:
;FIRMWARE_SYA_ver_0_8_9.c,262 :: 		else if(GT3){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_main54
;FIRMWARE_SYA_ver_0_8_9.c,264 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,265 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,266 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,267 :: 		}
	GOTO        L_main55
L_main54:
;FIRMWARE_SYA_ver_0_8_9.c,272 :: 		}
L_main55:
L_main53:
L_main51:
;FIRMWARE_SYA_ver_0_8_9.c,273 :: 		}
L_main49:
;FIRMWARE_SYA_ver_0_8_9.c,274 :: 		break;
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_9.c,275 :: 		}
L_main10:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
	MOVF        _state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
L_main11:
;FIRMWARE_SYA_ver_0_8_9.c,277 :: 		}while(1);
	GOTO        L_main7
;FIRMWARE_SYA_ver_0_8_9.c,279 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_blink:

;FIRMWARE_SYA_ver_0_8_9.c,285 :: 		int blink(int *_next_state){
;FIRMWARE_SYA_ver_0_8_9.c,286 :: 		if(clock0){
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_blink56
;FIRMWARE_SYA_ver_0_8_9.c,287 :: 		if(state != next_state){
	MOVF        _state+0, 0 
	XORWF       _next_state+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_blink57
;FIRMWARE_SYA_ver_0_8_9.c,288 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,289 :: 		}
	GOTO        L_blink58
L_blink57:
;FIRMWARE_SYA_ver_0_8_9.c,291 :: 		}
L_blink58:
;FIRMWARE_SYA_ver_0_8_9.c,292 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_8_9.c,293 :: 		clock0 = 0;
	BCF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_8_9.c,294 :: 		}
L_blink56:
;FIRMWARE_SYA_ver_0_8_9.c,295 :: 		return state;
	MOVF        _state+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;FIRMWARE_SYA_ver_0_8_9.c,296 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_State:

;FIRMWARE_SYA_ver_0_8_9.c,302 :: 		void State(){
;FIRMWARE_SYA_ver_0_8_9.c,305 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9.c,307 :: 		switch(state){
	GOTO        L_State59
;FIRMWARE_SYA_ver_0_8_9.c,308 :: 		case 0: // S0 - Todo apagado
L_State61:
;FIRMWARE_SYA_ver_0_8_9.c,309 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,310 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,311 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,312 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_9.c,314 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State62
;FIRMWARE_SYA_ver_0_8_9.c,315 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,316 :: 		}
	GOTO        L_State63
L_State62:
;FIRMWARE_SYA_ver_0_8_9.c,319 :: 		}
L_State63:
;FIRMWARE_SYA_ver_0_8_9.c,320 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,321 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_State64:
;FIRMWARE_SYA_ver_0_8_9.c,322 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,323 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,324 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,325 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,326 :: 		GT2 = 0; // Si comentarizo esto se rompe el codigo
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,327 :: 		GT3 = 0; // (why tho???)
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,329 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State65
;FIRMWARE_SYA_ver_0_8_9.c,331 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,333 :: 		}
	GOTO        L_State66
L_State65:
;FIRMWARE_SYA_ver_0_8_9.c,335 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State67
;FIRMWARE_SYA_ver_0_8_9.c,337 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,338 :: 		}
	GOTO        L_State68
L_State67:
;FIRMWARE_SYA_ver_0_8_9.c,343 :: 		}
L_State68:
L_State66:
;FIRMWARE_SYA_ver_0_8_9.c,344 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,345 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_State69:
;FIRMWARE_SYA_ver_0_8_9.c,346 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,347 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,348 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,349 :: 		GT1 = 0; // Trouble
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,350 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,351 :: 		GT3 = 0; // Here comes trouble
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,353 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State70
;FIRMWARE_SYA_ver_0_8_9.c,355 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,356 :: 		}
	GOTO        L_State71
L_State70:
;FIRMWARE_SYA_ver_0_8_9.c,358 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State72
;FIRMWARE_SYA_ver_0_8_9.c,360 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,361 :: 		}
	GOTO        L_State73
L_State72:
;FIRMWARE_SYA_ver_0_8_9.c,366 :: 		}
L_State73:
L_State71:
;FIRMWARE_SYA_ver_0_8_9.c,367 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,368 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_State74:
;FIRMWARE_SYA_ver_0_8_9.c,369 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,370 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,371 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,372 :: 		GT1 = 0; // Way way more
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,373 :: 		GT2 = 0; // trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,374 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,376 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State75
;FIRMWARE_SYA_ver_0_8_9.c,378 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,379 :: 		}
	GOTO        L_State76
L_State75:
;FIRMWARE_SYA_ver_0_8_9.c,381 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State77
;FIRMWARE_SYA_ver_0_8_9.c,383 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,384 :: 		}
	GOTO        L_State78
L_State77:
;FIRMWARE_SYA_ver_0_8_9.c,389 :: 		}
L_State78:
L_State76:
;FIRMWARE_SYA_ver_0_8_9.c,390 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,391 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_State79:
;FIRMWARE_SYA_ver_0_8_9.c,392 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,393 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9.c,394 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9.c,396 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State80
;FIRMWARE_SYA_ver_0_8_9.c,397 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,398 :: 		}
	GOTO        L_State81
L_State80:
;FIRMWARE_SYA_ver_0_8_9.c,399 :: 		else if(sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_State82
;FIRMWARE_SYA_ver_0_8_9.c,401 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,402 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_9.c,403 :: 		}
	GOTO        L_State83
L_State82:
;FIRMWARE_SYA_ver_0_8_9.c,408 :: 		}
L_State83:
L_State81:
;FIRMWARE_SYA_ver_0_8_9.c,409 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,410 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_State84:
;FIRMWARE_SYA_ver_0_8_9.c,412 :: 		if((sn_GoTo == 1) && (GT1 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State87
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State87
L__State119:
;FIRMWARE_SYA_ver_0_8_9.c,413 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,414 :: 		}
	GOTO        L_State88
L_State87:
;FIRMWARE_SYA_ver_0_8_9.c,415 :: 		else if((sn_GoTo == 1) && (GT2 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State91
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State91
L__State118:
;FIRMWARE_SYA_ver_0_8_9.c,416 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,417 :: 		}
	GOTO        L_State92
L_State91:
;FIRMWARE_SYA_ver_0_8_9.c,418 :: 		else if((sn_GoTo == 1) && (GT3 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State95
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State95
L__State117:
;FIRMWARE_SYA_ver_0_8_9.c,419 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,420 :: 		}
	GOTO        L_State96
L_State95:
;FIRMWARE_SYA_ver_0_8_9.c,425 :: 		}
L_State96:
L_State92:
L_State88:
;FIRMWARE_SYA_ver_0_8_9.c,426 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,427 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_State97:
;FIRMWARE_SYA_ver_0_8_9.c,428 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State98
;FIRMWARE_SYA_ver_0_8_9.c,430 :: 		if(GT1){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State99
;FIRMWARE_SYA_ver_0_8_9.c,432 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,433 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,434 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,435 :: 		}
	GOTO        L_State100
L_State99:
;FIRMWARE_SYA_ver_0_8_9.c,437 :: 		else if(GT2){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State101
;FIRMWARE_SYA_ver_0_8_9.c,439 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,440 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,441 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9.c,442 :: 		}
	GOTO        L_State102
L_State101:
;FIRMWARE_SYA_ver_0_8_9.c,444 :: 		else if(GT3){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State103
;FIRMWARE_SYA_ver_0_8_9.c,446 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9.c,447 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,448 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,449 :: 		}
	GOTO        L_State104
L_State103:
;FIRMWARE_SYA_ver_0_8_9.c,454 :: 		}
L_State104:
L_State102:
L_State100:
;FIRMWARE_SYA_ver_0_8_9.c,455 :: 		}
L_State98:
;FIRMWARE_SYA_ver_0_8_9.c,456 :: 		break;
	GOTO        L_State60
;FIRMWARE_SYA_ver_0_8_9.c,457 :: 		}
L_State59:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State61
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State64
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State69
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State74
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State79
	MOVF        _state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_State84
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_State97
L_State60:
;FIRMWARE_SYA_ver_0_8_9.c,459 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8_9.c,465 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_9.c,467 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events105
;FIRMWARE_SYA_ver_0_8_9.c,469 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events106
;FIRMWARE_SYA_ver_0_8_9.c,471 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,472 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,473 :: 		}
	GOTO        L_Events107
L_Events106:
;FIRMWARE_SYA_ver_0_8_9.c,477 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,478 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,479 :: 		}
L_Events107:
;FIRMWARE_SYA_ver_0_8_9.c,480 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_9.c,481 :: 		}
	GOTO        L_Events108
L_Events105:
;FIRMWARE_SYA_ver_0_8_9.c,483 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events109
;FIRMWARE_SYA_ver_0_8_9.c,485 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events110
;FIRMWARE_SYA_ver_0_8_9.c,487 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,488 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,489 :: 		}
	GOTO        L_Events111
L_Events110:
;FIRMWARE_SYA_ver_0_8_9.c,493 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,494 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9.c,495 :: 		}
L_Events111:
;FIRMWARE_SYA_ver_0_8_9.c,496 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_9.c,497 :: 		}
L_Events109:
L_Events108:
;FIRMWARE_SYA_ver_0_8_9.c,499 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_9.c,505 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_9.c,507 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_9.c,508 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_9.c,509 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_8_9.c,510 :: 		T0CON1 = 0x44;
	MOVLW       68
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_8_9.c,511 :: 		TMR0H = 0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_9.c,512 :: 		TMR0L = 0xC0;
	MOVLW       192
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_9.c,513 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_9.c,514 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_9.c,515 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_9.c,516 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_9.c,517 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_9.c,519 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_9.c,525 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_9.c,527 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_9.c,528 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_9.c,529 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_9.c,530 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_9.c,532 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_9.c,533 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_9.c,534 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_9.c,536 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_9.c,537 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_9.c,538 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_9.c,540 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_9.c,541 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_9.c,542 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_9.c,544 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_9.c,545 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_9.c,546 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_9.c,547 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_9.c,549 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_9.c,551 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
