
_interrupt:

;FIRMWARE_SYA_ver_0_8_3.c,64 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_3.c,65 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_8_3.c,66 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt67:
	BZ          L__interrupt68
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt67
L__interrupt68:
;FIRMWARE_SYA_ver_0_8_3.c,77 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt61:
;FIRMWARE_SYA_ver_0_8_3.c,78 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_3.c,79 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_3.c,80 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8_3.c,82 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt60:
;FIRMWARE_SYA_ver_0_8_3.c,83 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_3.c,84 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,85 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8_3.c,87 :: 		}
L_end_interrupt:
L__interrupt66:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_3.c,93 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_3.c,95 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_3.c,96 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_3.c,97 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_3.c,98 :: 		flag_init = 1;
	BSF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8_3.c,101 :: 		do{
L_main6:
;FIRMWARE_SYA_ver_0_8_3.c,102 :: 		Events(); // Iniciamos las
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_3.c,103 :: 		State();  // funciones
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8_3.c,104 :: 		}while(1);
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8_3.c,105 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_State:

;FIRMWARE_SYA_ver_0_8_3.c,111 :: 		void State(){
;FIRMWARE_SYA_ver_0_8_3.c,113 :: 		switch(state){
	GOTO        L_State9
;FIRMWARE_SYA_ver_0_8_3.c,114 :: 		case 0: // S0 - Todo apagado
L_State11:
;FIRMWARE_SYA_ver_0_8_3.c,115 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_3.c,116 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_3.c,117 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_3.c,118 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_3.c,124 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State12
;FIRMWARE_SYA_ver_0_8_3.c,125 :: 		state = 7; // Si, pasamos a estado 7
	MOVLW       7
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,126 :: 		}
	GOTO        L_State13
L_State12:
;FIRMWARE_SYA_ver_0_8_3.c,128 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,129 :: 		}
L_State13:
;FIRMWARE_SYA_ver_0_8_3.c,130 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,131 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_State14:
;FIRMWARE_SYA_ver_0_8_3.c,132 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_3.c,133 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_3.c,134 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_3.c,135 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,136 :: 		GT2 = 0; // Trouble
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,137 :: 		GT3 = 0; //
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_3.c,139 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State15
;FIRMWARE_SYA_ver_0_8_3.c,141 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,143 :: 		}
	GOTO        L_State16
L_State15:
;FIRMWARE_SYA_ver_0_8_3.c,145 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State17
;FIRMWARE_SYA_ver_0_8_3.c,147 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,148 :: 		}
	GOTO        L_State18
L_State17:
;FIRMWARE_SYA_ver_0_8_3.c,152 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,153 :: 		}
L_State18:
L_State16:
;FIRMWARE_SYA_ver_0_8_3.c,154 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,155 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_State19:
;FIRMWARE_SYA_ver_0_8_3.c,156 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_3.c,157 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_3.c,158 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_3.c,159 :: 		GT1 = 0; // Ponemos en 0 todos los
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,160 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,161 :: 		GT3 = 0; // demas GT's para alternar en estado 7
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_3.c,163 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State20
;FIRMWARE_SYA_ver_0_8_3.c,165 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,166 :: 		}
	GOTO        L_State21
L_State20:
;FIRMWARE_SYA_ver_0_8_3.c,168 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State22
;FIRMWARE_SYA_ver_0_8_3.c,170 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,171 :: 		}
	GOTO        L_State23
L_State22:
;FIRMWARE_SYA_ver_0_8_3.c,175 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,176 :: 		}
L_State23:
L_State21:
;FIRMWARE_SYA_ver_0_8_3.c,177 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,178 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_State24:
;FIRMWARE_SYA_ver_0_8_3.c,179 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_3.c,180 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_3.c,181 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_3.c,182 :: 		GT1 = 0; // Ponemos en 0 todos los demas GT's
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,183 :: 		GT2 = 0; // para alternar en estado 7
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,184 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_3.c,186 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State25
;FIRMWARE_SYA_ver_0_8_3.c,188 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,189 :: 		}
	GOTO        L_State26
L_State25:
;FIRMWARE_SYA_ver_0_8_3.c,191 :: 		else if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State27
;FIRMWARE_SYA_ver_0_8_3.c,193 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,194 :: 		}
	GOTO        L_State28
L_State27:
;FIRMWARE_SYA_ver_0_8_3.c,198 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,199 :: 		}
L_State28:
L_State26:
;FIRMWARE_SYA_ver_0_8_3.c,200 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,201 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_State29:
;FIRMWARE_SYA_ver_0_8_3.c,202 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_3.c,203 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_3.c,204 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_3.c,206 :: 		if(sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_State30
;FIRMWARE_SYA_ver_0_8_3.c,208 :: 		state = 6;
	MOVLW       6
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,209 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_3.c,210 :: 		}
	GOTO        L_State31
L_State30:
;FIRMWARE_SYA_ver_0_8_3.c,214 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,215 :: 		}
L_State31:
;FIRMWARE_SYA_ver_0_8_3.c,216 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,217 :: 		case 6: // S6 - Estado de transicion para flanco negativo 2
L_State32:
;FIRMWARE_SYA_ver_0_8_3.c,219 :: 		if((sn_GoTo == 1) && (GT1 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State35
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State35
L__State64:
;FIRMWARE_SYA_ver_0_8_3.c,220 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,221 :: 		}
	GOTO        L_State36
L_State35:
;FIRMWARE_SYA_ver_0_8_3.c,222 :: 		else if((sn_GoTo == 1) && (GT2 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State39
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State39
L__State63:
;FIRMWARE_SYA_ver_0_8_3.c,223 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,224 :: 		}
	GOTO        L_State40
L_State39:
;FIRMWARE_SYA_ver_0_8_3.c,225 :: 		else if((sn_GoTo == 1) && (GT3 == 1)){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State43
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State43
L__State62:
;FIRMWARE_SYA_ver_0_8_3.c,226 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,227 :: 		}
	GOTO        L_State44
L_State43:
;FIRMWARE_SYA_ver_0_8_3.c,231 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,232 :: 		}
L_State44:
L_State40:
L_State36:
;FIRMWARE_SYA_ver_0_8_3.c,233 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,234 :: 		case 7: // S7 - Estado de transicion para flanco positivo
L_State45:
;FIRMWARE_SYA_ver_0_8_3.c,236 :: 		if(GT1){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State46
;FIRMWARE_SYA_ver_0_8_3.c,238 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,239 :: 		GT2 = 0; // Apaga la señal de GT1 (pq lo puse?)
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,240 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_3.c,241 :: 		}
	GOTO        L_State47
L_State46:
;FIRMWARE_SYA_ver_0_8_3.c,243 :: 		else if(GT2){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State48
;FIRMWARE_SYA_ver_0_8_3.c,245 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,246 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,247 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_3.c,248 :: 		}
	GOTO        L_State49
L_State48:
;FIRMWARE_SYA_ver_0_8_3.c,250 :: 		else if(GT3){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State50
;FIRMWARE_SYA_ver_0_8_3.c,252 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,253 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,254 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,255 :: 		}
	GOTO        L_State51
L_State50:
;FIRMWARE_SYA_ver_0_8_3.c,259 :: 		state = 7;
	MOVLW       7
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_3.c,260 :: 		}
L_State51:
L_State49:
L_State47:
;FIRMWARE_SYA_ver_0_8_3.c,261 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_3.c,262 :: 		}
L_State9:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State11
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State14
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State19
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State24
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State29
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_State32
	MOVF        _state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_State45
L_State10:
;FIRMWARE_SYA_ver_0_8_3.c,264 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8_3.c,270 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_3.c,272 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events52
;FIRMWARE_SYA_ver_0_8_3.c,274 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events53
;FIRMWARE_SYA_ver_0_8_3.c,276 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,277 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,278 :: 		}
	GOTO        L_Events54
L_Events53:
;FIRMWARE_SYA_ver_0_8_3.c,282 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,283 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,284 :: 		}
L_Events54:
;FIRMWARE_SYA_ver_0_8_3.c,285 :: 		interruptC0 = 0; // Limpiamos la bandera de interrupcion en C0
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_3.c,286 :: 		}
	GOTO        L_Events55
L_Events52:
;FIRMWARE_SYA_ver_0_8_3.c,288 :: 		else if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events56
;FIRMWARE_SYA_ver_0_8_3.c,290 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events57
;FIRMWARE_SYA_ver_0_8_3.c,292 :: 		sn_PosEdge_2 = 0;
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,293 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,294 :: 		}
	GOTO        L_Events58
L_Events57:
;FIRMWARE_SYA_ver_0_8_3.c,298 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,299 :: 		sn_NegEdge_2 = 0;
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_3.c,300 :: 		}
L_Events58:
;FIRMWARE_SYA_ver_0_8_3.c,301 :: 		interruptC1 = 0; // Limpiamos la bandera de interrupcion en C1
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_3.c,302 :: 		}
	GOTO        L_Events59
L_Events56:
;FIRMWARE_SYA_ver_0_8_3.c,305 :: 		}
L_Events59:
L_Events55:
;FIRMWARE_SYA_ver_0_8_3.c,307 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_3.c,313 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_3.c,315 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_3.c,316 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_3.c,321 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_3.c,322 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_3.c,323 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_3.c,325 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_3.c,327 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_3.c,333 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_3.c,335 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_3.c,336 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_3.c,337 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_3.c,338 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_3.c,340 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_3.c,341 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_3.c,342 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_3.c,344 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_3.c,345 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_3.c,346 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_3.c,348 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_3.c,349 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_3.c,350 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_3.c,352 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_3.c,353 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_3.c,354 :: 		CM1CON0 = 0x00; // Desactivamos el comparador 1
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_3.c,355 :: 		CM2CON0 = 0x00; // Desactivamos el comparador 2
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_3.c,357 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_3.c,359 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
