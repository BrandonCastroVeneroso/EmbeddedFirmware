
_M1On:

;FIRMWARE_SYA_ver_1_3_0.c,90 :: 		void M1On(){M1 = 1;}
	BSF         LATA+0, 5 
L_end_M1On:
	RETURN      0
; end of _M1On

_M1Off:

;FIRMWARE_SYA_ver_1_3_0.c,91 :: 		void M1Off(){M1 = 0;}
	BCF         LATA+0, 5 
L_end_M1Off:
	RETURN      0
; end of _M1Off

_M2On:

;FIRMWARE_SYA_ver_1_3_0.c,92 :: 		void M2On(){M2 = 1;}
	BSF         LATE+0, 0 
L_end_M2On:
	RETURN      0
; end of _M2On

_M2Off:

;FIRMWARE_SYA_ver_1_3_0.c,93 :: 		void M2Off(){M2 = 0;}
	BCF         LATE+0, 0 
L_end_M2Off:
	RETURN      0
; end of _M2Off

_M3On:

;FIRMWARE_SYA_ver_1_3_0.c,94 :: 		void M3On(){M3 = 1;}
	BSF         LATE+0, 1 
L_end_M3On:
	RETURN      0
; end of _M3On

_M3Off:

;FIRMWARE_SYA_ver_1_3_0.c,95 :: 		void M3Off(){M3 = 0;}
	BCF         LATE+0, 1 
L_end_M3Off:
	RETURN      0
; end of _M3Off

_interrupt:

;FIRMWARE_SYA_ver_1_3_0.c,101 :: 		void interrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,103 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_SYA_ver_1_3_0.c,104 :: 		TMR0H = 0x3C;      // Timer para cada segundo y medio?
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,105 :: 		TMR0L = 0xB0;      //
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,106 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,107 :: 		counter++;
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
;FIRMWARE_SYA_ver_1_3_0.c,108 :: 		if(counter >= 200){
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt148
	MOVLW       200
	SUBWF       _counter+0, 0 
L__interrupt148:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
;FIRMWARE_SYA_ver_1_3_0.c,109 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_SYA_ver_1_3_0.c,110 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,111 :: 		PIE0.TMR0IE = 0;
	BCF         PIE0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,112 :: 		counter = 0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;FIRMWARE_SYA_ver_1_3_0.c,113 :: 		}
L_interrupt1:
;FIRMWARE_SYA_ver_1_3_0.c,114 :: 		}
L_interrupt0:
;FIRMWARE_SYA_ver_1_3_0.c,115 :: 		if(1 == IOCCF.B0){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
;FIRMWARE_SYA_ver_1_3_0.c,116 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,117 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC0+0 
	MOVLW       0
	MOVWF       _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,118 :: 		Delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       69
	MOVWF       R12, 0
	MOVLW       169
	MOVWF       R13, 0
L_interrupt3:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt3
	DECFSZ      R12, 1, 1
	BRA         L_interrupt3
	DECFSZ      R11, 1, 1
	BRA         L_interrupt3
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,119 :: 		if(1 == SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_interrupt4
;FIRMWARE_SYA_ver_1_3_0.c,120 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,121 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,122 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,123 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt5
;FIRMWARE_SYA_ver_1_3_0.c,124 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,125 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_1_3_0.c,126 :: 		}
	GOTO        L_interrupt6
L_interrupt4:
;FIRMWARE_SYA_ver_1_3_0.c,128 :: 		sn_GoToGT = 1;
	MOVLW       1
	MOVWF       _sn_GoToGT+0 
	MOVLW       0
	MOVWF       _sn_GoToGT+1 
;FIRMWARE_SYA_ver_1_3_0.c,129 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,130 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,131 :: 		interruptC0 = 0;
	CLRF        _interruptC0+0 
	CLRF        _interruptC0+1 
;FIRMWARE_SYA_ver_1_3_0.c,132 :: 		if(!SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_interrupt7
;FIRMWARE_SYA_ver_1_3_0.c,133 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,134 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt8
;FIRMWARE_SYA_ver_1_3_0.c,135 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,136 :: 		}
	GOTO        L_interrupt9
L_interrupt8:
;FIRMWARE_SYA_ver_1_3_0.c,138 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,139 :: 		}
L_interrupt9:
;FIRMWARE_SYA_ver_1_3_0.c,140 :: 		}
	GOTO        L_interrupt10
L_interrupt7:
;FIRMWARE_SYA_ver_1_3_0.c,142 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,143 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt11
;FIRMWARE_SYA_ver_1_3_0.c,144 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,145 :: 		}
L_interrupt11:
;FIRMWARE_SYA_ver_1_3_0.c,146 :: 		}
L_interrupt10:
;FIRMWARE_SYA_ver_1_3_0.c,147 :: 		}
L_interrupt6:
;FIRMWARE_SYA_ver_1_3_0.c,148 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_1_3_0.c,150 :: 		if(1 == IOCCF.B1){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt12
;FIRMWARE_SYA_ver_1_3_0.c,151 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,152 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC1+0 
	MOVLW       0
	MOVWF       _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,153 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt13:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt13
	DECFSZ      R12, 1, 1
	BRA         L_interrupt13
	DECFSZ      R11, 1, 1
	BRA         L_interrupt13
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,154 :: 		if(1 == SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_interrupt14
;FIRMWARE_SYA_ver_1_3_0.c,155 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,156 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,157 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,158 :: 		if(!SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_interrupt15
;FIRMWARE_SYA_ver_1_3_0.c,159 :: 		sn_GoToGT = 1;
	MOVLW       1
	MOVWF       _sn_GoToGT+0 
	MOVLW       0
	MOVWF       _sn_GoToGT+1 
;FIRMWARE_SYA_ver_1_3_0.c,160 :: 		}
L_interrupt15:
;FIRMWARE_SYA_ver_1_3_0.c,161 :: 		}
	GOTO        L_interrupt16
L_interrupt14:
;FIRMWARE_SYA_ver_1_3_0.c,163 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,164 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,165 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,166 :: 		interruptC1 = 0;
	CLRF        _interruptC1+0 
	CLRF        _interruptC1+1 
;FIRMWARE_SYA_ver_1_3_0.c,167 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_interrupt17
;FIRMWARE_SYA_ver_1_3_0.c,168 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,169 :: 		}
	GOTO        L_interrupt18
L_interrupt17:
;FIRMWARE_SYA_ver_1_3_0.c,171 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,172 :: 		}
L_interrupt18:
;FIRMWARE_SYA_ver_1_3_0.c,173 :: 		}
L_interrupt16:
;FIRMWARE_SYA_ver_1_3_0.c,174 :: 		}
L_interrupt12:
;FIRMWARE_SYA_ver_1_3_0.c,176 :: 		if(1 == IOCCF.B2){
	BTFSS       IOCCF+0, 2 
	GOTO        L_interrupt19
;FIRMWARE_SYA_ver_1_3_0.c,177 :: 		IOCCF.B2 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 2 
;FIRMWARE_SYA_ver_1_3_0.c,178 :: 		interruptC2 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	MOVLW       1
	MOVWF       _interruptC2+0 
	MOVLW       0
	MOVWF       _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,179 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_interrupt20:
	DECFSZ      R13, 1, 1
	BRA         L_interrupt20
	DECFSZ      R12, 1, 1
	BRA         L_interrupt20
	DECFSZ      R11, 1, 1
	BRA         L_interrupt20
	NOP
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,180 :: 		if(1 == SWITCH3){
	BTFSS       PORTC+0, 2 
	GOTO        L_interrupt21
;FIRMWARE_SYA_ver_1_3_0.c,181 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,182 :: 		sn_NegEdge_3 = 1;
	BSF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,183 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,184 :: 		if(!SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_interrupt22
;FIRMWARE_SYA_ver_1_3_0.c,185 :: 		sn_GoToGT = 1;
	MOVLW       1
	MOVWF       _sn_GoToGT+0 
	MOVLW       0
	MOVWF       _sn_GoToGT+1 
;FIRMWARE_SYA_ver_1_3_0.c,186 :: 		sn_error = 1;
	MOVLW       1
	MOVWF       _sn_error+0 
	MOVLW       0
	MOVWF       _sn_error+1 
;FIRMWARE_SYA_ver_1_3_0.c,187 :: 		}
L_interrupt22:
;FIRMWARE_SYA_ver_1_3_0.c,188 :: 		if(!SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_interrupt23
;FIRMWARE_SYA_ver_1_3_0.c,189 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,190 :: 		}
L_interrupt23:
;FIRMWARE_SYA_ver_1_3_0.c,191 :: 		}
	GOTO        L_interrupt24
L_interrupt21:
;FIRMWARE_SYA_ver_1_3_0.c,193 :: 		sn_PosEdge_3 = 1;
	BSF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,194 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,195 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,196 :: 		interruptC2 = 0;
	CLRF        _interruptC2+0 
	CLRF        _interruptC2+1 
;FIRMWARE_SYA_ver_1_3_0.c,197 :: 		if(!SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_interrupt25
;FIRMWARE_SYA_ver_1_3_0.c,198 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,199 :: 		}
L_interrupt25:
;FIRMWARE_SYA_ver_1_3_0.c,200 :: 		}
L_interrupt24:
;FIRMWARE_SYA_ver_1_3_0.c,201 :: 		}
L_interrupt19:
;FIRMWARE_SYA_ver_1_3_0.c,203 :: 		}
L_end_interrupt:
L__interrupt147:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_1_3_0.c,209 :: 		void main(){
;FIRMWARE_SYA_ver_1_3_0.c,211 :: 		InitSystems();
	CALL        _InitSystems+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,213 :: 		while(1){
L_main26:
;FIRMWARE_SYA_ver_1_3_0.c,214 :: 		current_state = next_state; // Maybe move this with Events
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,215 :: 		FSM();
	CALL        _FSM+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,216 :: 		}
	GOTO        L_main26
;FIRMWARE_SYA_ver_1_3_0.c,218 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

;FIRMWARE_SYA_ver_1_3_0.c,224 :: 		void FSM(){
;FIRMWARE_SYA_ver_1_3_0.c,225 :: 		switch(current_state){
	GOTO        L_FSM28
;FIRMWARE_SYA_ver_1_3_0.c,226 :: 		case s0:
L_FSM30:
;FIRMWARE_SYA_ver_1_3_0.c,227 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,228 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,229 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,231 :: 		if(1 == sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM31
;FIRMWARE_SYA_ver_1_3_0.c,232 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,233 :: 		}
	GOTO        L_FSM32
L_FSM31:
;FIRMWARE_SYA_ver_1_3_0.c,235 :: 		}
L_FSM32:
;FIRMWARE_SYA_ver_1_3_0.c,236 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,237 :: 		case s1:
L_FSM33:
;FIRMWARE_SYA_ver_1_3_0.c,238 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,239 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,240 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,241 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,242 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,243 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,244 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM34
;FIRMWARE_SYA_ver_1_3_0.c,246 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,247 :: 		}
	GOTO        L_FSM35
L_FSM34:
;FIRMWARE_SYA_ver_1_3_0.c,248 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM36
;FIRMWARE_SYA_ver_1_3_0.c,249 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,250 :: 		}
	GOTO        L_FSM37
L_FSM36:
;FIRMWARE_SYA_ver_1_3_0.c,252 :: 		}
L_FSM37:
L_FSM35:
;FIRMWARE_SYA_ver_1_3_0.c,253 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,254 :: 		case s2:
L_FSM38:
;FIRMWARE_SYA_ver_1_3_0.c,255 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,256 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,257 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,258 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,259 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,260 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,261 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM39
;FIRMWARE_SYA_ver_1_3_0.c,262 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,263 :: 		}
	GOTO        L_FSM40
L_FSM39:
;FIRMWARE_SYA_ver_1_3_0.c,264 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM41
;FIRMWARE_SYA_ver_1_3_0.c,265 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,266 :: 		}
	GOTO        L_FSM42
L_FSM41:
;FIRMWARE_SYA_ver_1_3_0.c,268 :: 		}
L_FSM42:
L_FSM40:
;FIRMWARE_SYA_ver_1_3_0.c,269 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,270 :: 		case s3:
L_FSM43:
;FIRMWARE_SYA_ver_1_3_0.c,271 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,272 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,273 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,274 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,275 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,276 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,277 :: 		if(1 == sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM44
;FIRMWARE_SYA_ver_1_3_0.c,278 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,279 :: 		}
	GOTO        L_FSM45
L_FSM44:
;FIRMWARE_SYA_ver_1_3_0.c,280 :: 		else if(1 == sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM46
;FIRMWARE_SYA_ver_1_3_0.c,281 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,282 :: 		}
	GOTO        L_FSM47
L_FSM46:
;FIRMWARE_SYA_ver_1_3_0.c,284 :: 		}
L_FSM47:
L_FSM45:
;FIRMWARE_SYA_ver_1_3_0.c,285 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,286 :: 		case s4:
L_FSM48:
;FIRMWARE_SYA_ver_1_3_0.c,287 :: 		sn_GoTo = 1;
	MOVLW       1
	MOVWF       _sn_GoTo+0 
	MOVLW       0
	MOVWF       _sn_GoTo+1 
;FIRMWARE_SYA_ver_1_3_0.c,288 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM51
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM51
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM51
L__FSM139:
;FIRMWARE_SYA_ver_1_3_0.c,289 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,290 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,291 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,292 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,293 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,294 :: 		}
	GOTO        L_FSM52
L_FSM51:
;FIRMWARE_SYA_ver_1_3_0.c,295 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM55
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM55
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM55
L__FSM138:
;FIRMWARE_SYA_ver_1_3_0.c,296 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,297 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,298 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,299 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,300 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,301 :: 		}
	GOTO        L_FSM56
L_FSM55:
;FIRMWARE_SYA_ver_1_3_0.c,302 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM59
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM59
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM59
L__FSM137:
;FIRMWARE_SYA_ver_1_3_0.c,303 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,304 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,305 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,306 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,307 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,308 :: 		}
L_FSM59:
L_FSM56:
L_FSM52:
;FIRMWARE_SYA_ver_1_3_0.c,309 :: 		if(1 == sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM60
;FIRMWARE_SYA_ver_1_3_0.c,310 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,311 :: 		}
	GOTO        L_FSM61
L_FSM60:
;FIRMWARE_SYA_ver_1_3_0.c,312 :: 		else if(1 == sn_PosEdge_3){
	BTFSS       _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
	GOTO        L_FSM62
;FIRMWARE_SYA_ver_1_3_0.c,313 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,314 :: 		}
	GOTO        L_FSM63
L_FSM62:
;FIRMWARE_SYA_ver_1_3_0.c,316 :: 		}
L_FSM63:
L_FSM61:
;FIRMWARE_SYA_ver_1_3_0.c,317 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,318 :: 		case s5:
L_FSM64:
;FIRMWARE_SYA_ver_1_3_0.c,319 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,320 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_1_3_0.c,321 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_1_3_0.c,322 :: 		if(1 == sn_NegEdge_3){
	BTFSS       _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
	GOTO        L_FSM65
;FIRMWARE_SYA_ver_1_3_0.c,323 :: 		next_state = s6;
	MOVLW       6
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,324 :: 		}
	GOTO        L_FSM66
L_FSM65:
;FIRMWARE_SYA_ver_1_3_0.c,326 :: 		}
L_FSM66:
;FIRMWARE_SYA_ver_1_3_0.c,327 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,328 :: 		case s6:
L_FSM67:
;FIRMWARE_SYA_ver_1_3_0.c,329 :: 		if(sn_GoTo){
	MOVF        _sn_GoTo+0, 0 
	IORWF       _sn_GoTo+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM68
;FIRMWARE_SYA_ver_1_3_0.c,330 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM71
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM71
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM71
L__FSM136:
;FIRMWARE_SYA_ver_1_3_0.c,331 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,332 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,333 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,334 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,335 :: 		}
	GOTO        L_FSM72
L_FSM71:
;FIRMWARE_SYA_ver_1_3_0.c,336 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM75
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM75
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM75
L__FSM135:
;FIRMWARE_SYA_ver_1_3_0.c,337 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,338 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,339 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,340 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,341 :: 		}
	GOTO        L_FSM76
L_FSM75:
;FIRMWARE_SYA_ver_1_3_0.c,342 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM79
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM79
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM79
L__FSM134:
;FIRMWARE_SYA_ver_1_3_0.c,343 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,344 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,345 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,346 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,347 :: 		}
	GOTO        L_FSM80
L_FSM79:
;FIRMWARE_SYA_ver_1_3_0.c,349 :: 		}
L_FSM80:
L_FSM76:
L_FSM72:
;FIRMWARE_SYA_ver_1_3_0.c,350 :: 		}
	GOTO        L_FSM81
L_FSM68:
;FIRMWARE_SYA_ver_1_3_0.c,351 :: 		else if(sn_error){
	MOVF        _sn_error+0, 0 
	IORWF       _sn_error+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM82
;FIRMWARE_SYA_ver_1_3_0.c,352 :: 		next_state = s7;
	MOVLW       7
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,353 :: 		}
	GOTO        L_FSM83
L_FSM82:
;FIRMWARE_SYA_ver_1_3_0.c,355 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,356 :: 		}
L_FSM83:
L_FSM81:
;FIRMWARE_SYA_ver_1_3_0.c,357 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,358 :: 		case s7:
L_FSM84:
;FIRMWARE_SYA_ver_1_3_0.c,359 :: 		clock0 = 0;
	CLRF        _clock0+0 
	CLRF        _clock0+1 
;FIRMWARE_SYA_ver_1_3_0.c,360 :: 		if(!SWITCH3){
	BTFSC       PORTC+0, 2 
	GOTO        L_FSM85
;FIRMWARE_SYA_ver_1_3_0.c,361 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,362 :: 		}
	GOTO        L_FSM86
L_FSM85:
;FIRMWARE_SYA_ver_1_3_0.c,363 :: 		else if(sn_GoToGT){
	MOVF        _sn_GoToGT+0, 0 
	IORWF       _sn_GoToGT+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM87
;FIRMWARE_SYA_ver_1_3_0.c,364 :: 		if((1 == GT1) && (0 == GT2) && (0 == GT3)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM90
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM90
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM90
L__FSM133:
;FIRMWARE_SYA_ver_1_3_0.c,365 :: 		next_state = s2;
	MOVLW       2
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,366 :: 		}
	GOTO        L_FSM91
L_FSM90:
;FIRMWARE_SYA_ver_1_3_0.c,367 :: 		else if((1 == GT2) && (0 == GT1) && (0 == GT3)){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM94
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM94
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM94
L__FSM132:
;FIRMWARE_SYA_ver_1_3_0.c,368 :: 		next_state = s3;
	MOVLW       3
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,369 :: 		}
	GOTO        L_FSM95
L_FSM94:
;FIRMWARE_SYA_ver_1_3_0.c,370 :: 		else if((1 == GT3) && (0 == GT1) && (0 == GT2)){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM98
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM98
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM98
L__FSM131:
;FIRMWARE_SYA_ver_1_3_0.c,371 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,372 :: 		}
L_FSM98:
L_FSM95:
L_FSM91:
;FIRMWARE_SYA_ver_1_3_0.c,373 :: 		}
	GOTO        L_FSM99
L_FSM87:
;FIRMWARE_SYA_ver_1_3_0.c,375 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,376 :: 		}
L_FSM99:
L_FSM86:
;FIRMWARE_SYA_ver_1_3_0.c,377 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,378 :: 		default:
L_FSM100:
;FIRMWARE_SYA_ver_1_3_0.c,379 :: 		current_state = s0;
	CLRF        _current_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,380 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,381 :: 		break;
	GOTO        L_FSM29
;FIRMWARE_SYA_ver_1_3_0.c,382 :: 		}
L_FSM28:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM30
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM33
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM38
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM43
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM48
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM64
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM67
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM84
	GOTO        L_FSM100
L_FSM29:
;FIRMWARE_SYA_ver_1_3_0.c,384 :: 		}
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

;FIRMWARE_SYA_ver_1_3_0.c,390 :: 		void Events(){
;FIRMWARE_SYA_ver_1_3_0.c,391 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,392 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,393 :: 		sn_NegEdge_3 = 0;
	BCF         _sn_NegEdge_3+0, BitPos(_sn_NegEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,394 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,395 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,396 :: 		sn_PosEdge_3 = 0;
	BCF         _sn_PosEdge_3+0, BitPos(_sn_PosEdge_3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,397 :: 		switch(SWITCH1){
	GOTO        L_Events101
;FIRMWARE_SYA_ver_1_3_0.c,398 :: 		case 0:
L_Events103:
;FIRMWARE_SYA_ver_1_3_0.c,399 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,400 :: 		switch(SWITCH2){
	GOTO        L_Events104
;FIRMWARE_SYA_ver_1_3_0.c,401 :: 		case 0:
L_Events106:
;FIRMWARE_SYA_ver_1_3_0.c,402 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,403 :: 		switch(SWITCH3){
	GOTO        L_Events107
;FIRMWARE_SYA_ver_1_3_0.c,404 :: 		case 0:
L_Events109:
;FIRMWARE_SYA_ver_1_3_0.c,405 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,406 :: 		break;
	GOTO        L_Events108
;FIRMWARE_SYA_ver_1_3_0.c,407 :: 		case 1:
L_Events110:
;FIRMWARE_SYA_ver_1_3_0.c,408 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,409 :: 		break;
	GOTO        L_Events108
;FIRMWARE_SYA_ver_1_3_0.c,410 :: 		}
L_Events107:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events109
	BTFSC       PORTC+0, 2 
	GOTO        L_Events110
L_Events108:
;FIRMWARE_SYA_ver_1_3_0.c,411 :: 		break;
	GOTO        L_Events105
;FIRMWARE_SYA_ver_1_3_0.c,412 :: 		case 1:
L_Events111:
;FIRMWARE_SYA_ver_1_3_0.c,413 :: 		switch(SWITCH3){
	GOTO        L_Events112
;FIRMWARE_SYA_ver_1_3_0.c,414 :: 		case 0:
L_Events114:
;FIRMWARE_SYA_ver_1_3_0.c,415 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,416 :: 		break;
	GOTO        L_Events113
;FIRMWARE_SYA_ver_1_3_0.c,417 :: 		case 1:
L_Events115:
;FIRMWARE_SYA_ver_1_3_0.c,418 :: 		next_state = s1;
	MOVLW       1
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,419 :: 		break;
	GOTO        L_Events113
;FIRMWARE_SYA_ver_1_3_0.c,420 :: 		}
L_Events112:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events114
	BTFSC       PORTC+0, 2 
	GOTO        L_Events115
L_Events113:
;FIRMWARE_SYA_ver_1_3_0.c,421 :: 		break;
	GOTO        L_Events105
;FIRMWARE_SYA_ver_1_3_0.c,422 :: 		}
L_Events104:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events106
	BTFSC       PORTC+0, 1 
	GOTO        L_Events111
L_Events105:
;FIRMWARE_SYA_ver_1_3_0.c,423 :: 		break;
	GOTO        L_Events102
;FIRMWARE_SYA_ver_1_3_0.c,424 :: 		case 1:
L_Events116:
;FIRMWARE_SYA_ver_1_3_0.c,425 :: 		switch(SWITCH2){
	GOTO        L_Events117
;FIRMWARE_SYA_ver_1_3_0.c,426 :: 		case 0:
L_Events119:
;FIRMWARE_SYA_ver_1_3_0.c,427 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,428 :: 		switch(SWITCH3){
	GOTO        L_Events120
;FIRMWARE_SYA_ver_1_3_0.c,429 :: 		case 0:
L_Events122:
;FIRMWARE_SYA_ver_1_3_0.c,430 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,431 :: 		break;
	GOTO        L_Events121
;FIRMWARE_SYA_ver_1_3_0.c,432 :: 		case 1:
L_Events123:
;FIRMWARE_SYA_ver_1_3_0.c,433 :: 		next_state = s4;
	MOVLW       4
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,434 :: 		break;
	GOTO        L_Events121
;FIRMWARE_SYA_ver_1_3_0.c,435 :: 		}
L_Events120:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events122
	BTFSC       PORTC+0, 2 
	GOTO        L_Events123
L_Events121:
;FIRMWARE_SYA_ver_1_3_0.c,436 :: 		break;
	GOTO        L_Events118
;FIRMWARE_SYA_ver_1_3_0.c,437 :: 		case 1:
L_Events124:
;FIRMWARE_SYA_ver_1_3_0.c,438 :: 		switch(SWITCH3){
	GOTO        L_Events125
;FIRMWARE_SYA_ver_1_3_0.c,439 :: 		case 0:
L_Events127:
;FIRMWARE_SYA_ver_1_3_0.c,440 :: 		next_state = s5;
	MOVLW       5
	MOVWF       _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,441 :: 		break;
	GOTO        L_Events126
;FIRMWARE_SYA_ver_1_3_0.c,442 :: 		case 1:
L_Events128:
;FIRMWARE_SYA_ver_1_3_0.c,443 :: 		next_state = s0;
	CLRF        _next_state+0 
;FIRMWARE_SYA_ver_1_3_0.c,444 :: 		break;
	GOTO        L_Events126
;FIRMWARE_SYA_ver_1_3_0.c,445 :: 		}
L_Events125:
	BTFSS       PORTC+0, 2 
	GOTO        L_Events127
	BTFSC       PORTC+0, 2 
	GOTO        L_Events128
L_Events126:
;FIRMWARE_SYA_ver_1_3_0.c,446 :: 		break;
	GOTO        L_Events118
;FIRMWARE_SYA_ver_1_3_0.c,447 :: 		}
L_Events117:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events119
	BTFSC       PORTC+0, 1 
	GOTO        L_Events124
L_Events118:
;FIRMWARE_SYA_ver_1_3_0.c,448 :: 		break;
	GOTO        L_Events102
;FIRMWARE_SYA_ver_1_3_0.c,449 :: 		}
L_Events101:
	BTFSS       PORTC+0, 0 
	GOTO        L_Events103
	BTFSC       PORTC+0, 0 
	GOTO        L_Events116
L_Events102:
;FIRMWARE_SYA_ver_1_3_0.c,450 :: 		return;
;FIRMWARE_SYA_ver_1_3_0.c,452 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitSystems:

;FIRMWARE_SYA_ver_1_3_0.c,458 :: 		void InitSystems(){
;FIRMWARE_SYA_ver_1_3_0.c,459 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems129:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems129
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems129
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems129
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,460 :: 		InitInterrupt();
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,461 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,462 :: 		Delay_ms(1000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_InitSystems130:
	DECFSZ      R13, 1, 1
	BRA         L_InitSystems130
	DECFSZ      R12, 1, 1
	BRA         L_InitSystems130
	DECFSZ      R11, 1, 1
	BRA         L_InitSystems130
	NOP
;FIRMWARE_SYA_ver_1_3_0.c,463 :: 		Events();
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_1_3_0.c,464 :: 		}
L_end_InitSystems:
	RETURN      0
; end of _InitSystems

_InitInterrupt:

;FIRMWARE_SYA_ver_1_3_0.c,470 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_1_3_0.c,472 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_1_3_0.c,473 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_1_3_0.c,475 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,476 :: 		T0CON1 = 0x40;
	MOVLW       64
	MOVWF       T0CON1+0 
;FIRMWARE_SYA_ver_1_3_0.c,477 :: 		TMR0H = 0x3C;
	MOVLW       60
	MOVWF       TMR0H+0 
;FIRMWARE_SYA_ver_1_3_0.c,478 :: 		TMR0L = 0xB0;
	MOVLW       176
	MOVWF       TMR0L+0 
;FIRMWARE_SYA_ver_1_3_0.c,480 :: 		IOCCN = 0x07;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       7
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_1_3_0.c,481 :: 		IOCCP = 0x07;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       7
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_1_3_0.c,482 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_1_3_0.c,483 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_SYA_ver_1_3_0.c,485 :: 		PIE4 = 0x02;
	MOVLW       2
	MOVWF       PIE4+0 
;FIRMWARE_SYA_ver_1_3_0.c,486 :: 		PIR4 = 0x00;
	CLRF        PIR4+0 
;FIRMWARE_SYA_ver_1_3_0.c,488 :: 		T1CON = 0x03;   // ~7, ~6, ![5, 4], ~3, ~2, #1(RD16), #0(ON)
	MOVLW       3
	MOVWF       T1CON+0 
;FIRMWARE_SYA_ver_1_3_0.c,489 :: 		T1GCON = 0x00;  // !7, !6, !5, !4, !3, !2, ~1, ~0
	CLRF        T1GCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,490 :: 		TMR1CLK = 0x01; // ~7, ~6, ~5, ~4, [!3, !2, !1, #0] = Fosc/4
	MOVLW       1
	MOVWF       TMR1CLK+0 
;FIRMWARE_SYA_ver_1_3_0.c,491 :: 		TMR1 = 0xEC78;   // Timer para
	MOVLW       120
	MOVWF       TMR1+0 
	MOVLW       236
	MOVWF       TMR1+1 
;FIRMWARE_SYA_ver_1_3_0.c,492 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_1_3_0.c,494 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_1_3_0.c,500 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_1_3_0.c,502 :: 		ADCON0 = 0x08; // Desactivamos ADC
	MOVLW       8
	MOVWF       ADCON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,503 :: 		ANSELC = 0x00;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_1_3_0.c,504 :: 		ANSELE = 0x00;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_1_3_0.c,505 :: 		ANSELA = 0x00;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_1_3_0.c,506 :: 		ANSELD = 0x00;
	CLRF        ANSELD+0 
;FIRMWARE_SYA_ver_1_3_0.c,508 :: 		TRISC = 0x0F;  // Ponemos en modo de entrada a C0, C1, c2 Y c3, los demas como salida
	MOVLW       15
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_1_3_0.c,509 :: 		TRISD = 0x07;  // Ponemos en modo de entrada a D0 y D1
	MOVLW       7
	MOVWF       TRISD+0 
;FIRMWARE_SYA_ver_1_3_0.c,510 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_1_3_0.c,511 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_1_3_0.c,513 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_1_3_0.c,514 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;FIRMWARE_SYA_ver_1_3_0.c,515 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_1_3_0.c,516 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_1_3_0.c,518 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_1_3_0.c,519 :: 		LATD = 0x00;
	CLRF        LATD+0 
;FIRMWARE_SYA_ver_1_3_0.c,520 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_1_3_0.c,521 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_1_3_0.c,523 :: 		WPUD = 0x07;   // Activamos el pull-up interno de C0 y C1
	MOVLW       7
	MOVWF       WPUD+0 
;FIRMWARE_SYA_ver_1_3_0.c,524 :: 		INLVLD = 0x07; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       7
	MOVWF       INLVLD+0 
;FIRMWARE_SYA_ver_1_3_0.c,525 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,526 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_1_3_0.c,527 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_1_3_0.c,528 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_1_3_0.c,529 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_1_3_0.c,531 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
