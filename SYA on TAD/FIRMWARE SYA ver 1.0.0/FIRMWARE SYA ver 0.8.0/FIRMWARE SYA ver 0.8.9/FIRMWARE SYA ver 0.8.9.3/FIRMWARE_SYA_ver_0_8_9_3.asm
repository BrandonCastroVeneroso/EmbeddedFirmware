
_interrupt:

;FIRMWARE_SYA_ver_0_8_9_3.c,69 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_9_3.c,71 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_0_8_9_3.c,72 :: 		TMR0H = 0xB1;      // Timer para cada segundo y medio?
	MOVLW       177
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,73 :: 		TMR0L = 0xE0;      //
	MOVLW       224
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,74 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,75 :: 		counter++;
	MOVLW       1
	ADDWF       _counter+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _counter+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _counter+0 
	MOVF        R1, 0 
	MOVWF       _counter+1 
;FIRMWARE_SYA_ver_0_8_9_3.c,76 :: 		if(counter >= 100){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt111
	MOVLW       100
	SUBWF       _counter+0, 0 
L__interrupt111:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_0_8_9_3.c,77 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,78 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_8_9_3.c,79 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_0_8_9_3.c,80 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_0_8_9_3.c,81 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_0_8_9_3.c,83 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt4
L__interrupt93:
;FIRMWARE_SYA_ver_0_8_9_3.c,84 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_9_3.c,85 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,86 :: 		}
L_interrupt4:
;FIRMWARE_SYA_ver_0_8_9_3.c,88 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt92:
;FIRMWARE_SYA_ver_0_8_9_3.c,89 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_9_3.c,90 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,91 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_0_8_9_3.c,93 :: 		}
L_end_interrupt:
L__interrupt110:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_9_3.c,99 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_9_3.c,101 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_9_3.c,102 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_9_3.c,114 :: 		if(flag_init){
	BTFSS       _flag_init+0, BitPos(_flag_init+0) 
	GOTO        L_main8
;FIRMWARE_SYA_ver_0_8_9_3.c,115 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,116 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,117 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,118 :: 		M4 = 1;
	BSF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_8_9_3.c,119 :: 		flag_init = 0;
	BCF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,120 :: 		}
L_main8:
;FIRMWARE_SYA_ver_0_8_9_3.c,122 :: 		do{
L_main9:
;FIRMWARE_SYA_ver_0_8_9_3.c,123 :: 		Events(); // Initialize
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_9_3.c,124 :: 		State();  // functions
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8_9_3.c,125 :: 		}while(1);
	GOTO        L_main9
;FIRMWARE_SYA_ver_0_8_9_3.c,127 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_blink:

;FIRMWARE_SYA_ver_0_8_9_3.c,133 :: 		int blink(int *_next_state){
;FIRMWARE_SYA_ver_0_8_9_3.c,134 :: 		if(clock0){
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_blink12
;FIRMWARE_SYA_ver_0_8_9_3.c,135 :: 		if(state == next_state){
	MOVF        _state+0, 0 
	XORWF       _next_state+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_blink13
;FIRMWARE_SYA_ver_0_8_9_3.c,136 :: 		}
	GOTO        L_blink14
L_blink13:
;FIRMWARE_SYA_ver_0_8_9_3.c,138 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,139 :: 		}
L_blink14:
;FIRMWARE_SYA_ver_0_8_9_3.c,140 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_8_9_3.c,141 :: 		clock0 = 0;
	BCF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,142 :: 		}
L_blink12:
;FIRMWARE_SYA_ver_0_8_9_3.c,143 :: 		return state;
	MOVF        _state+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;FIRMWARE_SYA_ver_0_8_9_3.c,144 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_State:

;FIRMWARE_SYA_ver_0_8_9_3.c,150 :: 		void State(){
;FIRMWARE_SYA_ver_0_8_9_3.c,153 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,155 :: 		switch(state){
	GOTO        L_State15
;FIRMWARE_SYA_ver_0_8_9_3.c,156 :: 		case 0: // S0 - Todo apagado
L_State17:
;FIRMWARE_SYA_ver_0_8_9_3.c,157 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,158 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_3.c,159 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_3.c,160 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,162 :: 		if((sn_PosEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State20
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State20
L__State108:
;FIRMWARE_SYA_ver_0_8_9_3.c,163 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,164 :: 		}
	GOTO        L_State21
L_State20:
;FIRMWARE_SYA_ver_0_8_9_3.c,167 :: 		}
L_State21:
;FIRMWARE_SYA_ver_0_8_9_3.c,168 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,169 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_State22:
;FIRMWARE_SYA_ver_0_8_9_3.c,170 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,171 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_3.c,172 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_3.c,173 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,174 :: 		GT2 = 0; // Si comentarizo esto se rompe el codigo
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,175 :: 		GT3 = 0; // (why tho???)
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,177 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State25
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State25
L__State107:
;FIRMWARE_SYA_ver_0_8_9_3.c,179 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,181 :: 		}
	GOTO        L_State26
L_State25:
;FIRMWARE_SYA_ver_0_8_9_3.c,183 :: 		else if((sn_PosEdge_2) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State29
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State29
L__State106:
;FIRMWARE_SYA_ver_0_8_9_3.c,185 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,186 :: 		}
	GOTO        L_State30
L_State29:
;FIRMWARE_SYA_ver_0_8_9_3.c,191 :: 		}
L_State30:
L_State26:
;FIRMWARE_SYA_ver_0_8_9_3.c,192 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,193 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_State31:
;FIRMWARE_SYA_ver_0_8_9_3.c,194 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,195 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_3.c,196 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_3.c,197 :: 		GT1 = 0; // Trouble
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,198 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,199 :: 		GT3 = 0; // Here comes trouble
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,201 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State34
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State34
L__State105:
;FIRMWARE_SYA_ver_0_8_9_3.c,203 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,204 :: 		}
	GOTO        L_State35
L_State34:
;FIRMWARE_SYA_ver_0_8_9_3.c,206 :: 		else if((sn_PosEdge_2) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State38
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State38
L__State104:
;FIRMWARE_SYA_ver_0_8_9_3.c,208 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,209 :: 		}
	GOTO        L_State39
L_State38:
;FIRMWARE_SYA_ver_0_8_9_3.c,214 :: 		}
L_State39:
L_State35:
;FIRMWARE_SYA_ver_0_8_9_3.c,215 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,216 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_State40:
;FIRMWARE_SYA_ver_0_8_9_3.c,217 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,218 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_3.c,219 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_3.c,220 :: 		GT1 = 0; // Way way more
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,221 :: 		GT2 = 0; // trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,222 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,224 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State43
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State43
L__State103:
;FIRMWARE_SYA_ver_0_8_9_3.c,226 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,227 :: 		}
	GOTO        L_State44
L_State43:
;FIRMWARE_SYA_ver_0_8_9_3.c,229 :: 		else if((sn_PosEdge_2) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State47
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State47
L__State102:
;FIRMWARE_SYA_ver_0_8_9_3.c,231 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,232 :: 		}
	GOTO        L_State48
L_State47:
;FIRMWARE_SYA_ver_0_8_9_3.c,237 :: 		}
L_State48:
L_State44:
;FIRMWARE_SYA_ver_0_8_9_3.c,238 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,239 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_State49:
;FIRMWARE_SYA_ver_0_8_9_3.c,240 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,241 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_9_3.c,242 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_9_3.c,244 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State52
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State52
L__State101:
;FIRMWARE_SYA_ver_0_8_9_3.c,245 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,246 :: 		}
	GOTO        L_State53
L_State52:
;FIRMWARE_SYA_ver_0_8_9_3.c,247 :: 		else if((sn_NegEdge_2) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_State56
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State56
L__State100:
;FIRMWARE_SYA_ver_0_8_9_3.c,249 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,250 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,251 :: 		}
	GOTO        L_State57
L_State56:
;FIRMWARE_SYA_ver_0_8_9_3.c,256 :: 		}
L_State57:
L_State53:
;FIRMWARE_SYA_ver_0_8_9_3.c,257 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,258 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_State58:
;FIRMWARE_SYA_ver_0_8_9_3.c,260 :: 		if((sn_GoTo == 1) && (GT1 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State61
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State61
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State61
L__State99:
;FIRMWARE_SYA_ver_0_8_9_3.c,261 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,262 :: 		}
	GOTO        L_State62
L_State61:
;FIRMWARE_SYA_ver_0_8_9_3.c,263 :: 		else if((sn_GoTo == 1) && (GT2 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State65
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State65
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State65
L__State98:
;FIRMWARE_SYA_ver_0_8_9_3.c,264 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,265 :: 		}
	GOTO        L_State66
L_State65:
;FIRMWARE_SYA_ver_0_8_9_3.c,266 :: 		else if((sn_GoTo == 1) && (GT3 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State69
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State69
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State69
L__State97:
;FIRMWARE_SYA_ver_0_8_9_3.c,267 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,268 :: 		}
	GOTO        L_State70
L_State69:
;FIRMWARE_SYA_ver_0_8_9_3.c,273 :: 		}
L_State70:
L_State66:
L_State62:
;FIRMWARE_SYA_ver_0_8_9_3.c,274 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,275 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_State71:
;FIRMWARE_SYA_ver_0_8_9_3.c,276 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State72
;FIRMWARE_SYA_ver_0_8_9_3.c,278 :: 		if((GT1) && (clock0 == 1)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State75
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State75
L__State96:
;FIRMWARE_SYA_ver_0_8_9_3.c,280 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,281 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,282 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,283 :: 		}
	GOTO        L_State76
L_State75:
;FIRMWARE_SYA_ver_0_8_9_3.c,285 :: 		else if((GT2) && (clock0 == 1)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State79
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State79
L__State95:
;FIRMWARE_SYA_ver_0_8_9_3.c,287 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,288 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,289 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,290 :: 		}
	GOTO        L_State80
L_State79:
;FIRMWARE_SYA_ver_0_8_9_3.c,292 :: 		else if((GT3) && (clock0 == 1)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State83
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State83
L__State94:
;FIRMWARE_SYA_ver_0_8_9_3.c,294 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,295 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,296 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,297 :: 		}
	GOTO        L_State84
L_State83:
;FIRMWARE_SYA_ver_0_8_9_3.c,302 :: 		}
L_State84:
L_State80:
L_State76:
;FIRMWARE_SYA_ver_0_8_9_3.c,303 :: 		}
L_State72:
;FIRMWARE_SYA_ver_0_8_9_3.c,304 :: 		break;
	GOTO        L_State16
;FIRMWARE_SYA_ver_0_8_9_3.c,305 :: 		}
L_State15:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State17
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State22
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State31
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State40
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State49
	MOVF        _state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_State58
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_State71
L_State16:
;FIRMWARE_SYA_ver_0_8_9_3.c,307 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8_9_3.c,313 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_9_3.c,315 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events85
;FIRMWARE_SYA_ver_0_8_9_3.c,317 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events86
;FIRMWARE_SYA_ver_0_8_9_3.c,319 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,320 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,321 :: 		}
	GOTO        L_Events87
L_Events86:
;FIRMWARE_SYA_ver_0_8_9_3.c,325 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,326 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,327 :: 		}
L_Events87:
;FIRMWARE_SYA_ver_0_8_9_3.c,328 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,329 :: 		}
	GOTO        L_Events88
L_Events85:
;FIRMWARE_SYA_ver_0_8_9_3.c,331 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events89
;FIRMWARE_SYA_ver_0_8_9_3.c,333 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events90
;FIRMWARE_SYA_ver_0_8_9_3.c,335 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,336 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,337 :: 		}
	GOTO        L_Events91
L_Events90:
;FIRMWARE_SYA_ver_0_8_9_3.c,341 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,342 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,343 :: 		}
L_Events91:
;FIRMWARE_SYA_ver_0_8_9_3.c,344 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,345 :: 		}
L_Events89:
L_Events88:
;FIRMWARE_SYA_ver_0_8_9_3.c,347 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_9_3.c,353 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_9_3.c,355 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,356 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,357 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,358 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,359 :: 		TMR0H = 0xB1;
	MOVLW       177
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,360 :: 		TMR0L = 0xE0;
	MOVLW       224
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,361 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,362 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,363 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,364 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_9_3.c,365 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,367 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_9_3.c,373 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_9_3.c,375 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,376 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,377 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,378 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,380 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,381 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,382 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,384 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,385 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,386 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,388 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,389 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,390 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,392 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,393 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,394 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,395 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_9_3.c,397 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_9_3.c,399 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
