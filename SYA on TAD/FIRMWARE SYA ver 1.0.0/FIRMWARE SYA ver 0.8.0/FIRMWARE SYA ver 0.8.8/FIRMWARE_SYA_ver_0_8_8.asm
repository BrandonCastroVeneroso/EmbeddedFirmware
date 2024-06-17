
_interrupt:

;FIRMWARE_SYA_ver_0_8_8.c,74 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_8.c,76 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_0_8_8.c,77 :: 		TMR0H = 0xEC;      // Timer para cada segundo y medio?
	MOVLW       236
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_8.c,78 :: 		TMR0L = 0x78;      //
	MOVLW       120
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_8.c,79 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,80 :: 		counter++;
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
;FIRMWARE_SYA_ver_0_8_8.c,81 :: 		if(counter >= 200){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt118
	MOVLW       200
	SUBWF       _counter+0, 0 
L__interrupt118:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_0_8_8.c,82 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_0_8_8.c,83 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_0_8_8.c,84 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_0_8_8.c,85 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_0_8_8.c,87 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt4
L__interrupt98:
;FIRMWARE_SYA_ver_0_8_8.c,88 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,89 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_8.c,90 :: 		}
L_interrupt4:
;FIRMWARE_SYA_ver_0_8_8.c,92 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt97:
;FIRMWARE_SYA_ver_0_8_8.c,93 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,94 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,95 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_0_8_8.c,97 :: 		}
L_end_interrupt:
L__interrupt117:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_8.c,103 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_8.c,105 :: 		InitInterrupt(); // MCU interrupt config
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_8.c,106 :: 		InitMCU();       // MCU pin/reg config
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_8.c,108 :: 		do{
L_main8:
;FIRMWARE_SYA_ver_0_8_8.c,109 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_8.c,110 :: 		}while((1 == IOCCF.B0) || (1 == IOCCF.B1));
	BTFSC       IOCCF+0, 0 
	GOTO        L_main8
	BTFSC       IOCCF+0, 1 
	GOTO        L_main8
L__main99:
;FIRMWARE_SYA_ver_0_8_8.c,112 :: 		while(1){
L_main13:
;FIRMWARE_SYA_ver_0_8_8.c,113 :: 		clock0 = 1;
	BSF         _clock0+0, BitPos(_clock0+0) 
;FIRMWARE_SYA_ver_0_8_8.c,114 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,115 :: 		FSM();  // functions
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_0_8_8.c,116 :: 		}
	GOTO        L_main13
;FIRMWARE_SYA_ver_0_8_8.c,118 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_0_8_8.c,124 :: 		void FSM(){
;FIRMWARE_SYA_ver_0_8_8.c,126 :: 		switch(current_state){
	GOTO        L_FSM15
;FIRMWARE_SYA_ver_0_8_8.c,127 :: 		case 0: // S0 - Todo apagado
L_FSM17:
;FIRMWARE_SYA_ver_0_8_8.c,128 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,129 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,130 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,131 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_8.c,133 :: 		if((1 == sn_PosEdge_1) && (1 == clock0)){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM20
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM20
L__FSM115:
;FIRMWARE_SYA_ver_0_8_8.c,134 :: 		next_state = 6; // Si, pasamos a estado 6
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,135 :: 		}
	GOTO        L_FSM21
L_FSM20:
;FIRMWARE_SYA_ver_0_8_8.c,137 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,138 :: 		}
L_FSM21:
;FIRMWARE_SYA_ver_0_8_8.c,139 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,140 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_FSM22:
;FIRMWARE_SYA_ver_0_8_8.c,141 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,142 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,143 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,144 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,145 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,146 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_8.c,147 :: 		if((0 == TEST1) && (1 == clock0)){
	BTFSC       PORTC+0, 3 
	GOTO        L_FSM25
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM25
L__FSM114:
;FIRMWARE_SYA_ver_0_8_8.c,148 :: 		M4 = 1;
	BSF         LATE+0, 2 
;FIRMWARE_SYA_ver_0_8_8.c,149 :: 		}
L_FSM25:
;FIRMWARE_SYA_ver_0_8_8.c,151 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM28
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM28
L__FSM113:
;FIRMWARE_SYA_ver_0_8_8.c,153 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,155 :: 		}
	GOTO        L_FSM29
L_FSM28:
;FIRMWARE_SYA_ver_0_8_8.c,157 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM32
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM32
L__FSM112:
;FIRMWARE_SYA_ver_0_8_8.c,159 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,160 :: 		}
	GOTO        L_FSM33
L_FSM32:
;FIRMWARE_SYA_ver_0_8_8.c,163 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,164 :: 		}
L_FSM33:
L_FSM29:
;FIRMWARE_SYA_ver_0_8_8.c,165 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,166 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_FSM34:
;FIRMWARE_SYA_ver_0_8_8.c,167 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,168 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,169 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,170 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,171 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,172 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_8.c,174 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM37
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM37
L__FSM111:
;FIRMWARE_SYA_ver_0_8_8.c,176 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,177 :: 		}
	GOTO        L_FSM38
L_FSM37:
;FIRMWARE_SYA_ver_0_8_8.c,179 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM41
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM41
L__FSM110:
;FIRMWARE_SYA_ver_0_8_8.c,181 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,182 :: 		}
	GOTO        L_FSM42
L_FSM41:
;FIRMWARE_SYA_ver_0_8_8.c,185 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,186 :: 		}
L_FSM42:
L_FSM38:
;FIRMWARE_SYA_ver_0_8_8.c,187 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,188 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_FSM43:
;FIRMWARE_SYA_ver_0_8_8.c,189 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,190 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,191 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,192 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,193 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,194 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_8.c,196 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM46
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM46
L__FSM109:
;FIRMWARE_SYA_ver_0_8_8.c,198 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,199 :: 		}
	GOTO        L_FSM47
L_FSM46:
;FIRMWARE_SYA_ver_0_8_8.c,201 :: 		else if((1 == sn_PosEdge_2) && (1 == clock0)){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM50
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM50
L__FSM108:
;FIRMWARE_SYA_ver_0_8_8.c,203 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,204 :: 		}
	GOTO        L_FSM51
L_FSM50:
;FIRMWARE_SYA_ver_0_8_8.c,207 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,208 :: 		}
L_FSM51:
L_FSM47:
;FIRMWARE_SYA_ver_0_8_8.c,209 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,210 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_FSM52:
;FIRMWARE_SYA_ver_0_8_8.c,211 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,212 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,213 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,215 :: 		if((1 == sn_NegEdge_1) && (1 == clock0)){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM55
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM55
L__FSM107:
;FIRMWARE_SYA_ver_0_8_8.c,216 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,217 :: 		}
	GOTO        L_FSM56
L_FSM55:
;FIRMWARE_SYA_ver_0_8_8.c,218 :: 		else if((1 == sn_NegEdge_2) && (1 == clock0)){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM59
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM59
L__FSM106:
;FIRMWARE_SYA_ver_0_8_8.c,220 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,221 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_8.c,222 :: 		}
	GOTO        L_FSM60
L_FSM59:
;FIRMWARE_SYA_ver_0_8_8.c,225 :: 		next_state = 4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,226 :: 		}
L_FSM60:
L_FSM56:
;FIRMWARE_SYA_ver_0_8_8.c,227 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,228 :: 		case 5: // S5 - Estado de transicion para flanco negativo 2
L_FSM61:
;FIRMWARE_SYA_ver_0_8_8.c,230 :: 		if((1 == sn_GoTo) && (1 == GT1) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM64
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM64
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM64
L__FSM105:
;FIRMWARE_SYA_ver_0_8_8.c,231 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,232 :: 		}
	GOTO        L_FSM65
L_FSM64:
;FIRMWARE_SYA_ver_0_8_8.c,233 :: 		else if((1 == sn_GoTo) && (1 == GT2) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM68
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM68
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM68
L__FSM104:
;FIRMWARE_SYA_ver_0_8_8.c,234 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,235 :: 		}
	GOTO        L_FSM69
L_FSM68:
;FIRMWARE_SYA_ver_0_8_8.c,236 :: 		else if((1 == sn_GoTo) && (1 == GT3) && (1 == clock0)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM72
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM72
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM72
L__FSM103:
;FIRMWARE_SYA_ver_0_8_8.c,237 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,238 :: 		}
	GOTO        L_FSM73
L_FSM72:
;FIRMWARE_SYA_ver_0_8_8.c,241 :: 		next_state = 5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,242 :: 		}
L_FSM73:
L_FSM69:
L_FSM65:
;FIRMWARE_SYA_ver_0_8_8.c,243 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,244 :: 		case 6: // S6 - Estado de transicion para flanco positivo
L_FSM74:
;FIRMWARE_SYA_ver_0_8_8.c,245 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM75
;FIRMWARE_SYA_ver_0_8_8.c,247 :: 		if((1 == GT1) && (1 == clock0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM78
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM78
L__FSM102:
;FIRMWARE_SYA_ver_0_8_8.c,249 :: 		next_state = 2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,250 :: 		GT2 = 0; // DO NOT
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,251 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_8.c,252 :: 		}
	GOTO        L_FSM79
L_FSM78:
;FIRMWARE_SYA_ver_0_8_8.c,254 :: 		else if((1 == GT2) && (1 == clock0)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM82
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM82
L__FSM101:
;FIRMWARE_SYA_ver_0_8_8.c,256 :: 		next_state = 3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,257 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,258 :: 		GT3 = 0; // DELETE !!!!
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_8.c,259 :: 		}
	GOTO        L_FSM83
L_FSM82:
;FIRMWARE_SYA_ver_0_8_8.c,261 :: 		else if((1 == GT3) && (1 == clock0)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM86
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM86
L__FSM100:
;FIRMWARE_SYA_ver_0_8_8.c,263 :: 		next_state = 1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,264 :: 		GT1 = 0; // DO NOT
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,265 :: 		GT2 = 0; // DELETE !!!!
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,266 :: 		}
	GOTO        L_FSM87
L_FSM86:
;FIRMWARE_SYA_ver_0_8_8.c,269 :: 		next_state = 6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,270 :: 		}
L_FSM87:
L_FSM83:
L_FSM79:
;FIRMWARE_SYA_ver_0_8_8.c,271 :: 		}
L_FSM75:
;FIRMWARE_SYA_ver_0_8_8.c,272 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,273 :: 		default:
L_FSM88:
;FIRMWARE_SYA_ver_0_8_8.c,274 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,275 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,276 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_8.c,277 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_8.c,278 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_8.c,279 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_8.c,280 :: 		current_state = 0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,281 :: 		next_state = 0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_0_8_8.c,282 :: 		break;
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_0_8_8.c,283 :: 		}
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
	GOTO        L_FSM34
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM43
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM52
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM61
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM74
	GOTO        L_FSM88
L_FSM16:
;FIRMWARE_SYA_ver_0_8_8.c,285 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_0_8_8.c,291 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_8.c,293 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events89
;FIRMWARE_SYA_ver_0_8_8.c,295 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events90
;FIRMWARE_SYA_ver_0_8_8.c,297 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,298 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,299 :: 		}
	GOTO        L_Events91
L_Events90:
;FIRMWARE_SYA_ver_0_8_8.c,303 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,304 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,305 :: 		}
L_Events91:
;FIRMWARE_SYA_ver_0_8_8.c,306 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_8.c,307 :: 		}
	GOTO        L_Events92
L_Events89:
;FIRMWARE_SYA_ver_0_8_8.c,309 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events93
;FIRMWARE_SYA_ver_0_8_8.c,311 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events94
;FIRMWARE_SYA_ver_0_8_8.c,313 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,314 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,315 :: 		}
	GOTO        L_Events95
L_Events94:
;FIRMWARE_SYA_ver_0_8_8.c,319 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,320 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_8.c,321 :: 		}
L_Events95:
;FIRMWARE_SYA_ver_0_8_8.c,322 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,323 :: 		}
	GOTO        L_Events96
L_Events93:
;FIRMWARE_SYA_ver_0_8_8.c,325 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_8.c,326 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_8.c,327 :: 		}
L_Events96:
L_Events92:
;FIRMWARE_SYA_ver_0_8_8.c,328 :: 		return;
;FIRMWARE_SYA_ver_0_8_8.c,330 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_8.c,336 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_8.c,338 :: 		PIE0 = 0x30;    // ~7, ~6, #5(TMR0IE), #4(IOCIE), ~3, !2, !1, !0
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_8.c,339 :: 		PIR0 = 0x00;    // ~7, ~6, RW#5(TMR0IF), R#4(IOCIF), ~3, RW[!2, #1(INT1IF), #0(INT0IF)]
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_8.c,341 :: 		T0CON0 = 0x90;  // #7(T0EN), ~6, !5, #4(T016BIT), ![3,2,1,0]
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_0_8_8.c,342 :: 		T0CON1 = 0x40;  // [!7, #6, !5] = 010 (Fosc/4), !4, ![3, 2, 1, 0]
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_0_8_8.c,343 :: 		TMR0H = 0xEC;   // Timer para
	MOVLW       236
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_0_8_8.c,344 :: 		TMR0L = 0x78;   // 1 ms
	MOVLW       120
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_0_8_8.c,346 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_8.c,347 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_8.c,348 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_8.c,350 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_8.c,352 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_8.c,358 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_8.c,361 :: 		OSCCON1 = 0x70;   // ~7, [#6, #5, #4] = EXTOSC, ![3, 2, 1, 0]
	MOVLW       112
	MOVWF       OSCCON1+0 
;FIRMWARE_SYA_ver_0_8_8.c,362 :: 		OSCEN = 0x80;     // #7(EXTOEN), !6, !5, !4, !3, !2, #1, #0
	MOVLW       128
	MOVWF       OSCEN+0 
;FIRMWARE_SYA_ver_0_8_8.c,364 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_8.c,365 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_8.c,366 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_8.c,367 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_0_8_8.c,369 :: 		TRISC = 0x0B;  // Ponemos en modo de entrada a C0, C1 y C3, los demas como salida
	MOVLW       11
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_8.c,370 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_8.c,371 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_8.c,372 :: 		TRISD = 0x03;  // Ponemos en modo entrada a D0, D1, y D2, los demas como salida
	MOVLW       3
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_0_8_8.c,374 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_8.c,375 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_8.c,376 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_8.c,377 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_0_8_8.c,379 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_8.c,380 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_8.c,381 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_8.c,382 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_0_8_8.c,384 :: 		WPUC = 0x0B;   // Activamos el pull-up interno de C0 y C1
	MOVLW       11
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_8.c,385 :: 		INLVLC = 0x0B; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       11
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_8.c,386 :: 		WPUD = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_0_8_8.c,387 :: 		INLVLD = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_0_8_8.c,388 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_8.c,389 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_8.c,391 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
