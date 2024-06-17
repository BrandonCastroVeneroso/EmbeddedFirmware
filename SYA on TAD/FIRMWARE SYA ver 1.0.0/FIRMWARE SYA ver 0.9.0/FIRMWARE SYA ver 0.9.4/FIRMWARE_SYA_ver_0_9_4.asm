
_interrupt:

;FIRMWARE_SYA_ver_0_9_4.c,70 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_9_4.c,72 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_0_9_4.c,73 :: 		TMR0H = 0xB1;      // Timer para cada segundo y medio?
	MOVLW       177
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_9_4.c,74 :: 		TMR0L = 0xE0;      //
	MOVLW       224
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_9_4.c,75 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,76 :: 		counter++;
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
;FIRMWARE_SYA_ver_0_9_4.c,77 :: 		if(counter >= 100){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt114
	MOVLW       100
	SUBWF       _counter+0, 0 
L__interrupt114:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_0_9_4.c,78 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_9_4.c,79 :: 		LED = 0;
	BCF         LATA+0, 4 
;FIRMWARE_SYA_ver_0_9_4.c,80 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_0_9_4.c,81 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_0_9_4.c,82 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_0_9_4.c,84 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt4
L__interrupt95:
;FIRMWARE_SYA_ver_0_9_4.c,85 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,86 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_4.c,87 :: 		}
L_interrupt4:
;FIRMWARE_SYA_ver_0_9_4.c,89 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt94:
;FIRMWARE_SYA_ver_0_9_4.c,90 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,91 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,92 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_0_9_4.c,94 :: 		}
L_end_interrupt:
L__interrupt113:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_9_4.c,100 :: 		void main(){
;FIRMWARE_SYA_ver_0_9_4.c,102 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_9_4.c,103 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_9_4.c,105 :: 		do{
L_main8:
;FIRMWARE_SYA_ver_0_9_4.c,106 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_9_4.c,107 :: 		}while((interruptC0 == 1) || (interruptC1 == 1));
	BTFSC       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_main8
	BTFSC       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_main8
L__main96:
;FIRMWARE_SYA_ver_0_9_4.c,109 :: 		while(1){
L_main13:
;FIRMWARE_SYA_ver_0_9_4.c,110 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,111 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_0_9_4.c,112 :: 		}
	GOTO        L_main13
;FIRMWARE_SYA_ver_0_9_4.c,114 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_0_9_4.c,120 :: 		void FSM(){
;FIRMWARE_SYA_ver_0_9_4.c,122 :: 		switch(current_state){
	GOTO        L_FSM15
;FIRMWARE_SYA_ver_0_9_4.c,123 :: 		case 0: // S0 - Todo apagado
L_FSM17:
;FIRMWARE_SYA_ver_0_9_4.c,124 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,125 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,126 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,127 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_9_4.c,129 :: 		if((sn_PosEdge_1 == 1) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM20
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM20
L__FSM111:
;FIRMWARE_SYA_ver_0_9_4.c,130 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,131 :: 		}
	GOTO        L_FSM21
L_FSM20:
;FIRMWARE_SYA_ver_0_9_4.c,134 :: 		}
L_FSM21:
;FIRMWARE_SYA_ver_0_9_4.c,135 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,136 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_FSM22:
;FIRMWARE_SYA_ver_0_9_4.c,137 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,138 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,139 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,140 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,141 :: 		GT2 = 0; // Si comentarizo esto se rompe el codigo
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,142 :: 		GT3 = 0; // (why tho???)
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_9_4.c,144 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM25
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM25
L__FSM110:
;FIRMWARE_SYA_ver_0_9_4.c,146 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,148 :: 		}
	GOTO        L_FSM26
L_FSM25:
;FIRMWARE_SYA_ver_0_9_4.c,150 :: 		else if((sn_PosEdge_2) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM29
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM29
L__FSM109:
;FIRMWARE_SYA_ver_0_9_4.c,152 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,153 :: 		}
	GOTO        L_FSM30
L_FSM29:
;FIRMWARE_SYA_ver_0_9_4.c,158 :: 		}
L_FSM30:
L_FSM26:
;FIRMWARE_SYA_ver_0_9_4.c,159 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,160 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_FSM31:
;FIRMWARE_SYA_ver_0_9_4.c,161 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,162 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,163 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,164 :: 		GT1 = 0; // Trouble
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,165 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,166 :: 		GT3 = 0; // Here comes trouble
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_9_4.c,168 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM34
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM34
L__FSM108:
;FIRMWARE_SYA_ver_0_9_4.c,170 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,171 :: 		}
	GOTO        L_FSM35
L_FSM34:
;FIRMWARE_SYA_ver_0_9_4.c,173 :: 		else if((sn_PosEdge_2) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM38
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM38
L__FSM107:
;FIRMWARE_SYA_ver_0_9_4.c,175 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,176 :: 		}
	GOTO        L_FSM39
L_FSM38:
;FIRMWARE_SYA_ver_0_9_4.c,181 :: 		}
L_FSM39:
L_FSM35:
;FIRMWARE_SYA_ver_0_9_4.c,182 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,183 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_FSM40:
;FIRMWARE_SYA_ver_0_9_4.c,184 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,185 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,186 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,187 :: 		GT1 = 0; // Way way more
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,188 :: 		GT2 = 0; // trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,189 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_9_4.c,191 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM43
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM43
L__FSM106:
;FIRMWARE_SYA_ver_0_9_4.c,193 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,194 :: 		}
	GOTO        L_FSM44
L_FSM43:
;FIRMWARE_SYA_ver_0_9_4.c,196 :: 		else if((sn_PosEdge_2) && (clock0 == 1)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM47
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM47
L__FSM105:
;FIRMWARE_SYA_ver_0_9_4.c,198 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,199 :: 		}
	GOTO        L_FSM48
L_FSM47:
;FIRMWARE_SYA_ver_0_9_4.c,204 :: 		}
L_FSM48:
L_FSM44:
;FIRMWARE_SYA_ver_0_9_4.c,205 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,206 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_FSM49:
;FIRMWARE_SYA_ver_0_9_4.c,207 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,208 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,209 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,211 :: 		if((sn_NegEdge_1) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM52
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM52
L__FSM104:
;FIRMWARE_SYA_ver_0_9_4.c,212 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,213 :: 		}
	GOTO        L_FSM53
L_FSM52:
;FIRMWARE_SYA_ver_0_9_4.c,214 :: 		else if((sn_NegEdge_2) && (clock0 == 1)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM56
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM56
L__FSM103:
;FIRMWARE_SYA_ver_0_9_4.c,216 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,217 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_9_4.c,218 :: 		}
	GOTO        L_FSM57
L_FSM56:
;FIRMWARE_SYA_ver_0_9_4.c,223 :: 		}
L_FSM57:
L_FSM53:
;FIRMWARE_SYA_ver_0_9_4.c,224 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,225 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_FSM58:
;FIRMWARE_SYA_ver_0_9_4.c,227 :: 		if((sn_GoTo == 1) && (GT1 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM61
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM61
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM61
L__FSM102:
;FIRMWARE_SYA_ver_0_9_4.c,228 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,229 :: 		}
	GOTO        L_FSM62
L_FSM61:
;FIRMWARE_SYA_ver_0_9_4.c,230 :: 		else if((sn_GoTo == 1) && (GT2 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM65
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM65
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM65
L__FSM101:
;FIRMWARE_SYA_ver_0_9_4.c,231 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,232 :: 		}
	GOTO        L_FSM66
L_FSM65:
;FIRMWARE_SYA_ver_0_9_4.c,233 :: 		else if((sn_GoTo == 1) && (GT3 == 1) && (clock0 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM69
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM69
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM69
L__FSM100:
;FIRMWARE_SYA_ver_0_9_4.c,234 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,235 :: 		}
	GOTO        L_FSM70
L_FSM69:
;FIRMWARE_SYA_ver_0_9_4.c,240 :: 		}
L_FSM70:
L_FSM66:
L_FSM62:
;FIRMWARE_SYA_ver_0_9_4.c,241 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,242 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_FSM71:
;FIRMWARE_SYA_ver_0_9_4.c,243 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM72
;FIRMWARE_SYA_ver_0_9_4.c,245 :: 		if((GT1) && (clock0 == 1)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM75
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM75
L__FSM99:
;FIRMWARE_SYA_ver_0_9_4.c,247 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,248 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,249 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_9_4.c,250 :: 		}
	GOTO        L_FSM76
L_FSM75:
;FIRMWARE_SYA_ver_0_9_4.c,252 :: 		else if((GT2) && (clock0 == 1)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM79
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM79
L__FSM98:
;FIRMWARE_SYA_ver_0_9_4.c,254 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,255 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,256 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_9_4.c,257 :: 		}
	GOTO        L_FSM80
L_FSM79:
;FIRMWARE_SYA_ver_0_9_4.c,259 :: 		else if((GT3) && (clock0 == 1)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM83
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM83
L__FSM97:
;FIRMWARE_SYA_ver_0_9_4.c,261 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,262 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,263 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,264 :: 		}
	GOTO        L_FSM84
L_FSM83:
;FIRMWARE_SYA_ver_0_9_4.c,269 :: 		}
L_FSM84:
L_FSM80:
L_FSM76:
;FIRMWARE_SYA_ver_0_9_4.c,270 :: 		}
L_FSM72:
;FIRMWARE_SYA_ver_0_9_4.c,271 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,272 :: 		default:
L_FSM85:
;FIRMWARE_SYA_ver_0_9_4.c,273 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,274 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,275 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_9_4.c,276 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,277 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_9_4.c,278 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_9_4.c,279 :: 		current_state = 0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,280 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_9_4.c,281 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_9_4.c,282 :: 		}
L_FSM15:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM17
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM22
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM31
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM40
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM49
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM58
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM71
	GOTO        L_FSM85
L_FSM16:
;FIRMWARE_SYA_ver_0_9_4.c,284 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_0_9_4.c,290 :: 		void Events(){
;FIRMWARE_SYA_ver_0_9_4.c,292 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events86
;FIRMWARE_SYA_ver_0_9_4.c,294 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events87
;FIRMWARE_SYA_ver_0_9_4.c,296 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,297 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,298 :: 		}
	GOTO        L_Events88
L_Events87:
;FIRMWARE_SYA_ver_0_9_4.c,302 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,303 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,304 :: 		}
L_Events88:
;FIRMWARE_SYA_ver_0_9_4.c,305 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_4.c,306 :: 		}
	GOTO        L_Events89
L_Events86:
;FIRMWARE_SYA_ver_0_9_4.c,308 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events90
;FIRMWARE_SYA_ver_0_9_4.c,310 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events91
;FIRMWARE_SYA_ver_0_9_4.c,312 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,313 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,314 :: 		}
	GOTO        L_Events92
L_Events91:
;FIRMWARE_SYA_ver_0_9_4.c,318 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,319 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_9_4.c,320 :: 		}
L_Events92:
;FIRMWARE_SYA_ver_0_9_4.c,321 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,322 :: 		}
	GOTO        L_Events93
L_Events90:
;FIRMWARE_SYA_ver_0_9_4.c,324 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_9_4.c,325 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_9_4.c,326 :: 		}
L_Events93:
L_Events89:
;FIRMWARE_SYA_ver_0_9_4.c,327 :: 		return;
;FIRMWARE_SYA_ver_0_9_4.c,329 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_9_4.c,335 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_9_4.c,337 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_9_4.c,338 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_9_4.c,339 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_9_4.c,340 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_9_4.c,341 :: 		TMR0H = 0xB1;
	MOVLW       177
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_9_4.c,342 :: 		TMR0L = 0xE0;
	MOVLW       224
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_9_4.c,343 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_9_4.c,344 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_9_4.c,345 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_9_4.c,346 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_9_4.c,347 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_9_4.c,349 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_9_4.c,355 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_9_4.c,357 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_9_4.c,358 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_9_4.c,359 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_9_4.c,360 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_9_4.c,362 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_9_4.c,363 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_9_4.c,364 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_9_4.c,366 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_9_4.c,367 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_9_4.c,368 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_9_4.c,370 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_9_4.c,371 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_9_4.c,372 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_9_4.c,374 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_9_4.c,375 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_9_4.c,376 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_9_4.c,377 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_9_4.c,379 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
