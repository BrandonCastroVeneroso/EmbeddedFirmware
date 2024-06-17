
_M1On:

;FIRMWARE_SYA_ver_1_4_0.c,87 :: 		void M1On(){M1 = 1;}
	BSF         LATA+0, 5 
L_end_M1On:
	RETURN      0
; end of _M1On

_M1Off:

;FIRMWARE_SYA_ver_1_4_0.c,88 :: 		void M1Off(){M1 = 0;}
	BCF         LATA+0, 5 
L_end_M1Off:
	RETURN      0
; end of _M1Off

_M2On:

;FIRMWARE_SYA_ver_1_4_0.c,89 :: 		void M2On(){M2 = 1;}
	BSF         LATE+0, 0 
L_end_M2On:
	RETURN      0
; end of _M2On

_M2Off:

;FIRMWARE_SYA_ver_1_4_0.c,90 :: 		void M2Off(){M2 = 0;}
	BCF         LATE+0, 0 
L_end_M2Off:
	RETURN      0
; end of _M2Off

_M3On:

;FIRMWARE_SYA_ver_1_4_0.c,91 :: 		void M3On(){M3 = 1;}
	BSF         LATE+0, 1 
L_end_M3On:
	RETURN      0
; end of _M3On

_M3Off:

;FIRMWARE_SYA_ver_1_4_0.c,92 :: 		void M3Off(){M3 = 0;}
	BCF         LATE+0, 1 
L_end_M3Off:
	RETURN      0
; end of _M3Off

_interrupt:

;FIRMWARE_SYA_ver_1_4_0.c,98 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_4_0.c,100 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_1_4_0.c,101 :: 		TMR0H = 0x3C;      // Timer para cada segundo y medio?
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_4_0.c,102 :: 		TMR0L = 0xB0;      //
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_4_0.c,103 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,104 :: 		counter++;
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
;FIRMWARE_SYA_ver_1_4_0.c,105 :: 		if(counter >= 200){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt91
	MOVLW       200
	SUBWF       _counter+0, 0 
L__interrupt91:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_1_4_0.c,106 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_4_0.c,107 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_4_0.c,108 :: 		PIE0.TMR0IE = 0;
	BCF         PIE0+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,109 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_1_4_0.c,110 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_1_4_0.c,111 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_1_4_0.c,112 :: 		if(1 == IOCCF.B0){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
;FIRMWARE_SYA_ver_1_4_0.c,113 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,114 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC0+0 
	MOVLW       0
	MOVWF       _interruptC0+1 
;FIRMWARE_SYA_ver_1_4_0.c,128 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_4_0.c,130 :: 		if(1 == IOCCF.B1){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt3
;FIRMWARE_SYA_ver_1_4_0.c,131 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,132 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC1+0 
	MOVLW       0
	MOVWF       _interruptC1+1 
;FIRMWARE_SYA_ver_1_4_0.c,133 :: 		Delay_ms(200);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_interrupt4:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt4
	DECFSZ      R12, 1, 1
	BRA         L_interrupt4
	DECFSZ      R11, 1, 1
	BRA         L_interrupt4
	NOP
	NOP
;FIRMWARE_SYA_ver_1_4_0.c,134 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 1 
	GOTO        L_interrupt5
;FIRMWARE_SYA_ver_1_4_0.c,135 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,136 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,137 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_4_0.c,138 :: 		}
	GOTO        L_interrupt6
L_interrupt5:
;FIRMWARE_SYA_ver_1_4_0.c,140 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,141 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,142 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,143 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_4_0.c,144 :: 		}
L_interrupt6:
;FIRMWARE_SYA_ver_1_4_0.c,146 :: 		}
L_interrupt3:
;FIRMWARE_SYA_ver_1_4_0.c,148 :: 		if(1 == IOCCF.B2){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt7
;FIRMWARE_SYA_ver_1_4_0.c,149 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_4_0.c,150 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC2+0 
	MOVLW       0
	MOVWF       _interruptC2+1 
;FIRMWARE_SYA_ver_1_4_0.c,164 :: 		}
L_interrupt7:
;FIRMWARE_SYA_ver_1_4_0.c,166 :: 		}
L_end_interrupt:
L__interrupt90:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_4_0.c,172 :: 		void main(){
;FIRMWARE_SYA_ver_1_4_0.c,174 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_4_0.c,176 :: 		while(1){
L_main8:
;FIRMWARE_SYA_ver_1_4_0.c,178 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,179 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_4_0.c,180 :: 		}
	GOTO        L_main8
;FIRMWARE_SYA_ver_1_4_0.c,182 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_4_0.c,188 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_4_0.c,189 :: 		switch(current_state){
	GOTO        L_FSM10
;FIRMWARE_SYA_ver_1_4_0.c,190 :: 		case s0:
L_FSM12:
;FIRMWARE_SYA_ver_1_4_0.c,191 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,192 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,193 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,194 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM13
;FIRMWARE_SYA_ver_1_4_0.c,195 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,196 :: 		}
	GOTO        L_FSM14
L_FSM13:
;FIRMWARE_SYA_ver_1_4_0.c,198 :: 		}
L_FSM14:
;FIRMWARE_SYA_ver_1_4_0.c,199 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,200 :: 		case s1:
L_FSM15:
;FIRMWARE_SYA_ver_1_4_0.c,201 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,202 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,203 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,204 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,205 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,206 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,207 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM16
;FIRMWARE_SYA_ver_1_4_0.c,209 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,210 :: 		}
	GOTO        L_FSM17
L_FSM16:
;FIRMWARE_SYA_ver_1_4_0.c,215 :: 		}
L_FSM17:
;FIRMWARE_SYA_ver_1_4_0.c,216 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,217 :: 		case s2:
L_FSM18:
;FIRMWARE_SYA_ver_1_4_0.c,218 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,219 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,220 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,221 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,222 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,223 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,224 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM19
;FIRMWARE_SYA_ver_1_4_0.c,225 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,226 :: 		}
	GOTO        L_FSM20
L_FSM19:
;FIRMWARE_SYA_ver_1_4_0.c,231 :: 		}
L_FSM20:
;FIRMWARE_SYA_ver_1_4_0.c,232 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,233 :: 		case s3:
L_FSM21:
;FIRMWARE_SYA_ver_1_4_0.c,234 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,235 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,236 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,237 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,238 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,239 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,240 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM22
;FIRMWARE_SYA_ver_1_4_0.c,241 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,242 :: 		}
	GOTO        L_FSM23
L_FSM22:
;FIRMWARE_SYA_ver_1_4_0.c,247 :: 		}
L_FSM23:
;FIRMWARE_SYA_ver_1_4_0.c,248 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,249 :: 		case s4:
L_FSM24:
;FIRMWARE_SYA_ver_1_4_0.c,250 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM27
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM27
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM27
L__FSM82:
;FIRMWARE_SYA_ver_1_4_0.c,251 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,252 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,253 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,254 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,255 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,256 :: 		}
	GOTO        L_FSM28
L_FSM27:
;FIRMWARE_SYA_ver_1_4_0.c,257 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM31
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM31
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM31
L__FSM81:
;FIRMWARE_SYA_ver_1_4_0.c,258 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,259 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,260 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,261 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,262 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,263 :: 		}
	GOTO        L_FSM32
L_FSM31:
;FIRMWARE_SYA_ver_1_4_0.c,264 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM35
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM35
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM35
L__FSM80:
;FIRMWARE_SYA_ver_1_4_0.c,265 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,266 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,267 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,268 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,269 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,270 :: 		}
L_FSM35:
L_FSM32:
L_FSM28:
;FIRMWARE_SYA_ver_1_4_0.c,271 :: 		if(1 == sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM36
;FIRMWARE_SYA_ver_1_4_0.c,272 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,273 :: 		}
	GOTO        L_FSM37
L_FSM36:
;FIRMWARE_SYA_ver_1_4_0.c,274 :: 		else if(1 == sn_PosEdge_3){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM38
;FIRMWARE_SYA_ver_1_4_0.c,275 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,276 :: 		}
	GOTO        L_FSM39
L_FSM38:
;FIRMWARE_SYA_ver_1_4_0.c,278 :: 		}
L_FSM39:
L_FSM37:
;FIRMWARE_SYA_ver_1_4_0.c,279 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,280 :: 		case s5:
L_FSM40:
;FIRMWARE_SYA_ver_1_4_0.c,281 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,282 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_4_0.c,283 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_4_0.c,284 :: 		if(1 == sn_NegEdge_3){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM41
;FIRMWARE_SYA_ver_1_4_0.c,285 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,286 :: 		}
	GOTO        L_FSM42
L_FSM41:
;FIRMWARE_SYA_ver_1_4_0.c,288 :: 		}
L_FSM42:
;FIRMWARE_SYA_ver_1_4_0.c,289 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,290 :: 		case s6:
L_FSM43:
;FIRMWARE_SYA_ver_1_4_0.c,291 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM46
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM46
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM46
L__FSM79:
;FIRMWARE_SYA_ver_1_4_0.c,292 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,293 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,294 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,295 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,296 :: 		}
	GOTO        L_FSM47
L_FSM46:
;FIRMWARE_SYA_ver_1_4_0.c,297 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM50
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM50
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM50
L__FSM78:
;FIRMWARE_SYA_ver_1_4_0.c,298 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,299 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,300 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,301 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,302 :: 		}
	GOTO        L_FSM51
L_FSM50:
;FIRMWARE_SYA_ver_1_4_0.c,303 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM54
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM54
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM54
L__FSM77:
;FIRMWARE_SYA_ver_1_4_0.c,304 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,305 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,306 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,307 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,308 :: 		}
	GOTO        L_FSM55
L_FSM54:
;FIRMWARE_SYA_ver_1_4_0.c,310 :: 		}
L_FSM55:
L_FSM51:
L_FSM47:
;FIRMWARE_SYA_ver_1_4_0.c,311 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,312 :: 		case s7:
L_FSM56:
;FIRMWARE_SYA_ver_1_4_0.c,313 :: 		clock0 = 0;
	CLRF        _clock0+0 
	CLRF        _clock0+1 
;FIRMWARE_SYA_ver_1_4_0.c,314 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM59
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM59
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM59
L__FSM76:
;FIRMWARE_SYA_ver_1_4_0.c,315 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,316 :: 		}
	GOTO        L_FSM60
L_FSM59:
;FIRMWARE_SYA_ver_1_4_0.c,317 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM63
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM63
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM63
L__FSM75:
;FIRMWARE_SYA_ver_1_4_0.c,318 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,319 :: 		}
	GOTO        L_FSM64
L_FSM63:
;FIRMWARE_SYA_ver_1_4_0.c,320 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM67
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM67
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM67
L__FSM74:
;FIRMWARE_SYA_ver_1_4_0.c,321 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,322 :: 		}
L_FSM67:
L_FSM64:
L_FSM60:
;FIRMWARE_SYA_ver_1_4_0.c,323 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,324 :: 		default:
L_FSM68:
;FIRMWARE_SYA_ver_1_4_0.c,325 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,326 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,327 :: 		break;
	GOTO        L_FSM11
;FIRMWARE_SYA_ver_1_4_0.c,328 :: 		}
L_FSM10:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM12
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM15
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM18
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM21
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM24
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM40
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM43
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM56
	GOTO        L_FSM68
L_FSM11:
;FIRMWARE_SYA_ver_1_4_0.c,330 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_4_0.c,336 :: 		void Events(){
;FIRMWARE_SYA_ver_1_4_0.c,337 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,338 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,339 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,340 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,341 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,342 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,343 :: 		switch(SWITCH1){
	GOTO        L_Events69
;FIRMWARE_SYA_ver_1_4_0.c,344 :: 		case 0:
L_Events71:
;FIRMWARE_SYA_ver_1_4_0.c,345 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_4_0.c,346 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_Events72:
	DECFSZ      R13, 1, 1
	BRA         L_Events72
	DECFSZ      R12, 1, 1
	BRA         L_Events72
	DECFSZ      R11, 1, 1
	BRA         L_Events72
	NOP
;FIRMWARE_SYA_ver_1_4_0.c,347 :: 		break;
	GOTO        L_Events70
;FIRMWARE_SYA_ver_1_4_0.c,348 :: 		}
L_Events69:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events71
L_Events70:
;FIRMWARE_SYA_ver_1_4_0.c,355 :: 		return;
;FIRMWARE_SYA_ver_1_4_0.c,357 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_4_0.c,363 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_4_0.c,364 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems73:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems73
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems73
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems73
	NOP
;FIRMWARE_SYA_ver_1_4_0.c,365 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_4_0.c,366 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_4_0.c,367 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_4_0.c,373 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_4_0.c,375 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_4_0.c,376 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_4_0.c,378 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_1_4_0.c,379 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_1_4_0.c,380 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_4_0.c,381 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_4_0.c,383 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_4_0.c,384 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_4_0.c,385 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_4_0.c,386 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_4_0.c,388 :: 		PIE4 = 0x02;
	MOVLW       2
	MOVWF       PIE4+0 
;FIRMWARE_SYA_ver_1_4_0.c,389 :: 		PIR4 = 0x00;
	CLRF        PIR4+0 
;FIRMWARE_SYA_ver_1_4_0.c,390 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_4_0.c,392 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_4_0.c,398 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_4_0.c,400 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_4_0.c,401 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_4_0.c,402 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_4_0.c,403 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_4_0.c,404 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_4_0.c,406 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_4_0.c,407 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_4_0.c,408 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_4_0.c,409 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_4_0.c,411 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_4_0.c,412 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_4_0.c,413 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_4_0.c,414 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_4_0.c,416 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_4_0.c,417 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_4_0.c,418 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_4_0.c,419 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_4_0.c,423 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_4_0.c,424 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_4_0.c,425 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_4_0.c,426 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_4_0.c,427 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_4_0.c,428 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_4_0.c,429 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_4_0.c,431 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
