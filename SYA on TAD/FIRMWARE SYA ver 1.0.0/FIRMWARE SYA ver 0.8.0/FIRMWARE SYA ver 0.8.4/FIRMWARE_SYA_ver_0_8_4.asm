
_interrupt:

;FIRMWARE_SYA_ver_0_8_4.c,68 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_4.c,69 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_8_4.c,70 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt110:
	BZ          L__interrupt111
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt110
L__interrupt111:
;FIRMWARE_SYA_ver_0_8_4.c,71 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_0_8_4.c,72 :: 		TMR0H = 0xE8;      // Timer para cada segundo y medio?
	MOVLW       232
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_4.c,73 :: 		TMR0L = 0x49;      //
	MOVLW       73
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_4.c,74 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,75 :: 		counter++;
	MOVF        _counter+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _counter+0 
;FIRMWARE_SYA_ver_0_8_4.c,76 :: 		if(counter >= 2){
	MOVLW       2
	SUBWF       _counter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_0_8_4.c,77 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_8_4.c,78 :: 		counter = 0;
	CLRF        _counter+0 
;FIRMWARE_SYA_ver_0_8_4.c,79 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_0_8_4.c,80 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_0_8_4.c,81 :: 		if(PIR4.TMR1IF){
	BTFSS       PIR4+0, 0 
	GOTO        L_interrupt2
;FIRMWARE_SYA_ver_0_8_4.c,82 :: 		TMR1H = 0x63;
	MOVLW       99
	MOVWF       TMR1H+0 
;FIRMWARE_SYA_ver_0_8_4.c,83 :: 		TMR1L = 0xBF;
	MOVLW       191
	MOVWF       TMR1L+0 
;FIRMWARE_SYA_ver_0_8_4.c,84 :: 		PIR4.TMR1IF = 0;
	BCF         PIR4+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,85 :: 		counter1++;
	MOVF        _counter1+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _counter1+0 
;FIRMWARE_SYA_ver_0_8_4.c,86 :: 		if(counter1 >= 1){
	MOVLW       1
	SUBWF       _counter1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt3
;FIRMWARE_SYA_ver_0_8_4.c,88 :: 		clock1 = 1;
	BSF         _clock1+0, BitPos(_clock1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,89 :: 		counter1 = 0;
	CLRF        _counter1+0 
;FIRMWARE_SYA_ver_0_8_4.c,90 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_0_8_4.c,91 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8_4.c,93 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt6
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt6
L__interrupt93:
;FIRMWARE_SYA_ver_0_8_4.c,94 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,95 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_4.c,96 :: 		}
L_interrupt6:
;FIRMWARE_SYA_ver_0_8_4.c,98 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt9
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt9
L__interrupt92:
;FIRMWARE_SYA_ver_0_8_4.c,99 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_4.c,100 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,101 :: 		}
L_interrupt9:
;FIRMWARE_SYA_ver_0_8_4.c,103 :: 		}
L_end_interrupt:
L__interrupt109:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_4.c,109 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_4.c,111 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_4.c,112 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_4.c,123 :: 		if(flag_init){
	BTFSS       _flag_init+0, BitPos(_flag_init+0) 
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_8_4.c,124 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,125 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,126 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_4.c,127 :: 		flag_init = 0;
	BCF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8_4.c,128 :: 		}
L_main10:
;FIRMWARE_SYA_ver_0_8_4.c,131 :: 		do{
L_main11:
;FIRMWARE_SYA_ver_0_8_4.c,132 :: 		Events(); // Initialize
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_4.c,133 :: 		State();  // functions
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8_4.c,134 :: 		}while(1);
	GOTO        L_main11
;FIRMWARE_SYA_ver_0_8_4.c,136 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_blink:

;FIRMWARE_SYA_ver_0_8_4.c,142 :: 		int blink(int *_next_state){
;FIRMWARE_SYA_ver_0_8_4.c,143 :: 		if(clock0){
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_blink14
;FIRMWARE_SYA_ver_0_8_4.c,144 :: 		if(state == next_state){
	MOVF        _state+0, 0 
	XORWF       _next_state+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_blink15
;FIRMWARE_SYA_ver_0_8_4.c,145 :: 		}
	GOTO        L_blink16
L_blink15:
;FIRMWARE_SYA_ver_0_8_4.c,147 :: 		state = next_state;
	MOVF        _next_state+0, 0 
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_4.c,148 :: 		}
L_blink16:
;FIRMWARE_SYA_ver_0_8_4.c,149 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_8_4.c,150 :: 		clock0 = 0;
	BCF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_8_4.c,151 :: 		}
L_blink14:
;FIRMWARE_SYA_ver_0_8_4.c,152 :: 		if(clock1){
	BTFSS       _clock1+0, BitPos(_clock1+0) 
	GOTO        L_blink17
;FIRMWARE_SYA_ver_0_8_4.c,153 :: 		wait++;
	MOVF        _wait+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _wait+0 
;FIRMWARE_SYA_ver_0_8_4.c,154 :: 		clock1 = 0;
	BCF         _clock1+0, BitPos(_clock1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,155 :: 		}
L_blink17:
;FIRMWARE_SYA_ver_0_8_4.c,156 :: 		return state;
	MOVF        _state+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;FIRMWARE_SYA_ver_0_8_4.c,157 :: 		}
L_end_blink:
	RETURN      0
; end of _blink

_State:

;FIRMWARE_SYA_ver_0_8_4.c,163 :: 		void State(){
;FIRMWARE_SYA_ver_0_8_4.c,165 :: 		blink(next_state);
	MOVF        _next_state+0, 0 
	MOVWF       FARG_blink__next_state+0 
	MOVLW       0
	MOVWF       FARG_blink__next_state+1 
	CALL        _blink+0, 0
;FIRMWARE_SYA_ver_0_8_4.c,167 :: 		switch(state){
	GOTO        L_State18
;FIRMWARE_SYA_ver_0_8_4.c,168 :: 		case 0: // S0 - Todo apagado
L_State20:
;FIRMWARE_SYA_ver_0_8_4.c,169 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,170 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,171 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_4.c,172 :: 		M4 = 1;
	BSF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_8_4.c,173 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_4.c,174 :: 		if(wait >= 5){
	MOVLW       5
	SUBWF       _wait+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_State21
;FIRMWARE_SYA_ver_0_8_4.c,175 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,176 :: 		wait = 0;
	CLRF        _wait+0 
;FIRMWARE_SYA_ver_0_8_4.c,177 :: 		}
L_State21:
;FIRMWARE_SYA_ver_0_8_4.c,179 :: 		if((sn_PosEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State24
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State24
L__State107:
;FIRMWARE_SYA_ver_0_8_4.c,180 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,181 :: 		}
	GOTO        L_State25
L_State24:
;FIRMWARE_SYA_ver_0_8_4.c,184 :: 		}
L_State25:
;FIRMWARE_SYA_ver_0_8_4.c,185 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,186 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_State26:
;FIRMWARE_SYA_ver_0_8_4.c,187 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,188 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,189 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_4.c,190 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,191 :: 		GT2 = 0; // Si comentarizo esto se rompe el codigo
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,192 :: 		GT3 = 0; // (why tho???)
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_4.c,194 :: 		if((sn_NegEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State29
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State29
L__State106:
;FIRMWARE_SYA_ver_0_8_4.c,196 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,198 :: 		}
	GOTO        L_State30
L_State29:
;FIRMWARE_SYA_ver_0_8_4.c,200 :: 		else if((sn_PosEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State33
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State33
L__State105:
;FIRMWARE_SYA_ver_0_8_4.c,202 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,203 :: 		}
	GOTO        L_State34
L_State33:
;FIRMWARE_SYA_ver_0_8_4.c,208 :: 		}
L_State34:
L_State30:
;FIRMWARE_SYA_ver_0_8_4.c,209 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,210 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_State35:
;FIRMWARE_SYA_ver_0_8_4.c,211 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,212 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,213 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_4.c,214 :: 		GT1 = 0; // Trouble
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,215 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,216 :: 		GT3 = 0; // Here comes trouble
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_4.c,218 :: 		if((sn_NegEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State38
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State38
L__State104:
;FIRMWARE_SYA_ver_0_8_4.c,220 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,221 :: 		}
	GOTO        L_State39
L_State38:
;FIRMWARE_SYA_ver_0_8_4.c,223 :: 		else if((sn_PosEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State42
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State42
L__State103:
;FIRMWARE_SYA_ver_0_8_4.c,225 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,226 :: 		}
	GOTO        L_State43
L_State42:
;FIRMWARE_SYA_ver_0_8_4.c,231 :: 		}
L_State43:
L_State39:
;FIRMWARE_SYA_ver_0_8_4.c,232 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,233 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_State44:
;FIRMWARE_SYA_ver_0_8_4.c,234 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,235 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,236 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_4.c,237 :: 		GT1 = 0; // Way way more
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,238 :: 		GT2 = 0; // trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,239 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_4.c,241 :: 		if((sn_NegEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State47
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State47
L__State102:
;FIRMWARE_SYA_ver_0_8_4.c,243 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,244 :: 		}
	GOTO        L_State48
L_State47:
;FIRMWARE_SYA_ver_0_8_4.c,246 :: 		else if((sn_PosEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State51
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State51
L__State101:
;FIRMWARE_SYA_ver_0_8_4.c,248 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,249 :: 		}
	GOTO        L_State52
L_State51:
;FIRMWARE_SYA_ver_0_8_4.c,254 :: 		}
L_State52:
L_State48:
;FIRMWARE_SYA_ver_0_8_4.c,255 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,256 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_State53:
;FIRMWARE_SYA_ver_0_8_4.c,257 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,258 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,259 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_4.c,261 :: 		if((sn_NegEdge_2 == 1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_State56
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State56
L__State100:
;FIRMWARE_SYA_ver_0_8_4.c,263 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,264 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_4.c,265 :: 		}
	GOTO        L_State57
L_State56:
;FIRMWARE_SYA_ver_0_8_4.c,270 :: 		}
L_State57:
;FIRMWARE_SYA_ver_0_8_4.c,271 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,272 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_State58:
;FIRMWARE_SYA_ver_0_8_4.c,274 :: 		if((sn_GoTo == 1) && (GT1 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State61
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State61
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State61
L__State99:
;FIRMWARE_SYA_ver_0_8_4.c,275 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,276 :: 		}
	GOTO        L_State62
L_State61:
;FIRMWARE_SYA_ver_0_8_4.c,277 :: 		else if((sn_GoTo == 1) && (GT2 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State65
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State65
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State65
L__State98:
;FIRMWARE_SYA_ver_0_8_4.c,278 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,279 :: 		}
	GOTO        L_State66
L_State65:
;FIRMWARE_SYA_ver_0_8_4.c,280 :: 		else if((sn_GoTo == 1) && (GT3 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State69
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State69
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State69
L__State97:
;FIRMWARE_SYA_ver_0_8_4.c,281 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,282 :: 		}
	GOTO        L_State70
L_State69:
;FIRMWARE_SYA_ver_0_8_4.c,287 :: 		}
L_State70:
L_State66:
L_State62:
;FIRMWARE_SYA_ver_0_8_4.c,288 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,289 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_State71:
;FIRMWARE_SYA_ver_0_8_4.c,290 :: 		M4 = 0;
	BCF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_8_4.c,291 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State72
;FIRMWARE_SYA_ver_0_8_4.c,293 :: 		if((GT1 == 1) && (clock0 == 1)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State75
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State75
L__State96:
;FIRMWARE_SYA_ver_0_8_4.c,295 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,296 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,297 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_4.c,298 :: 		}
	GOTO        L_State76
L_State75:
;FIRMWARE_SYA_ver_0_8_4.c,300 :: 		else if((GT2 == 1) && (clock0 == 1)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State79
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State79
L__State95:
;FIRMWARE_SYA_ver_0_8_4.c,302 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,303 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,304 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_4.c,305 :: 		}
	GOTO        L_State80
L_State79:
;FIRMWARE_SYA_ver_0_8_4.c,307 :: 		else if((GT3 == 1) && (clock0 == 1)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State83
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_State83
L__State94:
;FIRMWARE_SYA_ver_0_8_4.c,309 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_4.c,310 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,311 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,312 :: 		}
	GOTO        L_State84
L_State83:
;FIRMWARE_SYA_ver_0_8_4.c,317 :: 		}
L_State84:
L_State80:
L_State76:
;FIRMWARE_SYA_ver_0_8_4.c,318 :: 		}
L_State72:
;FIRMWARE_SYA_ver_0_8_4.c,319 :: 		break;
	GOTO        L_State19
;FIRMWARE_SYA_ver_0_8_4.c,320 :: 		}
L_State18:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State20
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State26
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State35
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State44
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State53
	MOVF        _state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_State58
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_State71
L_State19:
;FIRMWARE_SYA_ver_0_8_4.c,322 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8_4.c,328 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_4.c,330 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events85
;FIRMWARE_SYA_ver_0_8_4.c,332 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events86
;FIRMWARE_SYA_ver_0_8_4.c,334 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,335 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,336 :: 		}
	GOTO        L_Events87
L_Events86:
;FIRMWARE_SYA_ver_0_8_4.c,340 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,341 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,342 :: 		}
L_Events87:
;FIRMWARE_SYA_ver_0_8_4.c,343 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_4.c,344 :: 		}
	GOTO        L_Events88
L_Events85:
;FIRMWARE_SYA_ver_0_8_4.c,346 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events89
;FIRMWARE_SYA_ver_0_8_4.c,348 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events90
;FIRMWARE_SYA_ver_0_8_4.c,350 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,351 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,352 :: 		}
	GOTO        L_Events91
L_Events90:
;FIRMWARE_SYA_ver_0_8_4.c,356 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,357 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_4.c,358 :: 		}
L_Events91:
;FIRMWARE_SYA_ver_0_8_4.c,359 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_4.c,360 :: 		}
L_Events89:
L_Events88:
;FIRMWARE_SYA_ver_0_8_4.c,362 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_4.c,368 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_4.c,370 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_4.c,371 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_4.c,372 :: 		PIE4 = 0x01;
	MOVLW       1
	MOVWF       PIE4+0 
;FIRMWARE_SYA_ver_0_8_4.c,373 :: 		PIR4 = 0x00;
	CLRF        PIR4+0 
;FIRMWARE_SYA_ver_0_8_4.c,374 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_8_4.c,375 :: 		T0CON1 = 0x46;
	MOVLW       70
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_8_4.c,376 :: 		TMR0H = 0xE8;
	MOVLW       232
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_4.c,377 :: 		TMR0L = 0x49;
	MOVLW       73
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_4.c,378 :: 		T1CON = 0x23;
	MOVLW       35
	MOVWF       T1CON+0 
;FIRMWARE_SYA_ver_0_8_4.c,379 :: 		TMR1CLK = 0x01;
	MOVLW       1
	MOVWF       TMR1CLK+0 
;FIRMWARE_SYA_ver_0_8_4.c,380 :: 		TMR1H = 0x63;
	MOVLW       99
	MOVWF       TMR1H+0 
;FIRMWARE_SYA_ver_0_8_4.c,381 :: 		TMR1L = 0xBF;
	MOVLW       191
	MOVWF       TMR1L+0 
;FIRMWARE_SYA_ver_0_8_4.c,382 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_4.c,383 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_4.c,384 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_4.c,385 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_4.c,386 :: 		PIR4.TMR1IF = 0;
	BCF         PIR4+0, 0 
;FIRMWARE_SYA_ver_0_8_4.c,387 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_4.c,389 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_4.c,395 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_4.c,397 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_4.c,398 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_4.c,399 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_4.c,400 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_4.c,402 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_4.c,403 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_4.c,404 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_4.c,406 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_4.c,407 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_4.c,408 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_4.c,410 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_4.c,411 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_4.c,412 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_4.c,414 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_4.c,415 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_4.c,416 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_4.c,417 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_4.c,419 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_4.c,421 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
