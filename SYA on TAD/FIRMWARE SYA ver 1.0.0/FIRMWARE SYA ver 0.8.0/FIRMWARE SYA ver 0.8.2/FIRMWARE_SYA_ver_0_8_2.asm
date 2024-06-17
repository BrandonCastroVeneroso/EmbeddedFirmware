
_interrupt:

;FIRMWARE_SYA_ver_0_8_2.c,63 :: 		void interrupt(){
;FIRMWARE_SYA_ver_0_8_2.c,64 :: 		temp = PORTC;
	MOVF        PORTC+0, 0 
	MOVWF       _temp+0 
	MOVLW       0
	MOVWF       _temp+1 
;FIRMWARE_SYA_ver_0_8_2.c,65 :: 		temp = temp << 6;
	MOVLW       6
	MOVWF       R0 
	MOVF        R0, 0 
L__interrupt58:
	BZ          L__interrupt59
	RLCF        _temp+0, 1 
	BCF         _temp+0, 0 
	RLCF        _temp+1, 1 
	ADDLW       255
	GOTO        L__interrupt58
L__interrupt59:
;FIRMWARE_SYA_ver_0_8_2.c,67 :: 		if((IOCCF.B0 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt51:
;FIRMWARE_SYA_ver_0_8_2.c,68 :: 		IOCCF.B0 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 0 
;FIRMWARE_SYA_ver_0_8_2.c,69 :: 		interruptC0 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_2.c,70 :: 		}
L_interrupt2:
;FIRMWARE_SYA_ver_0_8_2.c,72 :: 		if((IOCCF.B1 == 1) && (IOCIE_bit == 1)){
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt50:
;FIRMWARE_SYA_ver_0_8_2.c,73 :: 		IOCCF.B1 = 0; // Limpiamos la bandera de IOC
	BCF         IOCCF+0, 1 
;FIRMWARE_SYA_ver_0_8_2.c,74 :: 		interruptC1 = 1; // Ponemos en 1 la bandera de interrupcion en C0
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,75 :: 		}
L_interrupt5:
;FIRMWARE_SYA_ver_0_8_2.c,77 :: 		}
L_end_interrupt:
L__interrupt57:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_SYA_ver_0_8_2.c,83 :: 		void main(){
;FIRMWARE_SYA_ver_0_8_2.c,85 :: 		InitMCU();       // Configuraciones iniciales del MCU
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_8_2.c,86 :: 		InitInterrupt(); //       ''        de interrupciones del MCU
	CALL        _InitInterrupt+0, 0
;FIRMWARE_SYA_ver_0_8_2.c,87 :: 		once = TRUE;     // Seteo de la condicion del lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_2.c,88 :: 		flag_init = 1;
	BSF         _flag_init+0, BitPos(_flag_init+0) 
;FIRMWARE_SYA_ver_0_8_2.c,91 :: 		do{
L_main6:
;FIRMWARE_SYA_ver_0_8_2.c,92 :: 		Events(); // Iniciamos las
	CALL        _Events+0, 0
;FIRMWARE_SYA_ver_0_8_2.c,93 :: 		State();  // funciones
	CALL        _State+0, 0
;FIRMWARE_SYA_ver_0_8_2.c,94 :: 		}while(1);
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_8_2.c,95 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_State:

;FIRMWARE_SYA_ver_0_8_2.c,97 :: 		void State(){
;FIRMWARE_SYA_ver_0_8_2.c,99 :: 		switch(state){
	GOTO        L_State9
;FIRMWARE_SYA_ver_0_8_2.c,100 :: 		case 0: // S0 - Todo apagado
L_State11:
;FIRMWARE_SYA_ver_0_8_2.c,101 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_2.c,102 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_2.c,103 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_2.c,104 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,106 :: 		if((GT1 == 0) && (GT2 == 0) && (GT3 == 0)){
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State14
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State14
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State14
L__State55:
;FIRMWARE_SYA_ver_0_8_2.c,107 :: 		GT3 = 1; // Si, iniciamos en GT3 (para pasar a GT1)
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_2.c,108 :: 		}
L_State14:
;FIRMWARE_SYA_ver_0_8_2.c,110 :: 		if(sn_PosEdge_1){
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_State15
;FIRMWARE_SYA_ver_0_8_2.c,111 :: 		state = 7; // Si, pasamos a estado 7
	MOVLW       7
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,112 :: 		}
L_State15:
;FIRMWARE_SYA_ver_0_8_2.c,113 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,114 :: 		case 1: // S1 - Grupo de trabajo 1 110
L_State16:
;FIRMWARE_SYA_ver_0_8_2.c,115 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_2.c,116 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_2.c,117 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_2.c,118 :: 		GT1 = 1;
	BSF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,119 :: 		GT2 = 0; // Ponemos en 0 todos los demas GT's
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,120 :: 		GT3 = 0; // para alternar en estado 7
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_2.c,121 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,123 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State17
;FIRMWARE_SYA_ver_0_8_2.c,125 :: 		state = 5;
	MOVLW       5
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,126 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,127 :: 		}
L_State17:
;FIRMWARE_SYA_ver_0_8_2.c,129 :: 		if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State18
;FIRMWARE_SYA_ver_0_8_2.c,131 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,132 :: 		}
L_State18:
;FIRMWARE_SYA_ver_0_8_2.c,133 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,134 :: 		case 2: // S2 - Grupo de trabajo 2 011
L_State19:
;FIRMWARE_SYA_ver_0_8_2.c,135 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_2.c,136 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_2.c,137 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_2.c,138 :: 		GT1 = 0; // Ponemos en 0 todos los
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,139 :: 		GT2 = 1;
	BSF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,140 :: 		GT3 = 0; // demas GT's para alternar en estado 7
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_2.c,141 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,143 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State20
;FIRMWARE_SYA_ver_0_8_2.c,145 :: 		state = 5;
	MOVLW       5
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,146 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,147 :: 		}
L_State20:
;FIRMWARE_SYA_ver_0_8_2.c,149 :: 		if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State21
;FIRMWARE_SYA_ver_0_8_2.c,151 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,152 :: 		}
L_State21:
;FIRMWARE_SYA_ver_0_8_2.c,153 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,154 :: 		case 3: // S3 - Grupo de trabajo 3 101
L_State22:
;FIRMWARE_SYA_ver_0_8_2.c,155 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_2.c,156 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_2.c,157 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_2.c,158 :: 		GT1 = 0; // Ponemos en 0 todos los demas GT's
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,159 :: 		GT2 = 0; // para alternar en estado 7
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,160 :: 		GT3 = 1;
	BSF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_2.c,161 :: 		sn_GoTo = 0;
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,163 :: 		if(sn_NegEdge_1){
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_State23
;FIRMWARE_SYA_ver_0_8_2.c,165 :: 		state = 5;
	MOVLW       5
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,166 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,167 :: 		}
L_State23:
;FIRMWARE_SYA_ver_0_8_2.c,169 :: 		if(sn_PosEdge_2){
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_State24
;FIRMWARE_SYA_ver_0_8_2.c,171 :: 		state = 4;
	MOVLW       4
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,172 :: 		}
L_State24:
;FIRMWARE_SYA_ver_0_8_2.c,173 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,174 :: 		case 4: // S4 - Grupo de trabajo 4 111
L_State25:
;FIRMWARE_SYA_ver_0_8_2.c,175 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_8_2.c,176 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_8_2.c,177 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_8_2.c,179 :: 		if(sn_NegEdge_2){
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_State26
;FIRMWARE_SYA_ver_0_8_2.c,181 :: 		state = 6;
	MOVLW       6
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,182 :: 		sn_GoTo = 1; // Ponemos en 1 la señal de transicion
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
;FIRMWARE_SYA_ver_0_8_2.c,183 :: 		}
L_State26:
;FIRMWARE_SYA_ver_0_8_2.c,184 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,185 :: 		case 5: // S5 - Estado de transicion para flanco negativo 1
L_State27:
;FIRMWARE_SYA_ver_0_8_2.c,187 :: 		if(sn_GoTo){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State28
;FIRMWARE_SYA_ver_0_8_2.c,189 :: 		state = 0;
	CLRF        _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,190 :: 		}
L_State28:
;FIRMWARE_SYA_ver_0_8_2.c,191 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,192 :: 		case 6: // S6 - Estado de transicion para flanco negativo 2
L_State29:
;FIRMWARE_SYA_ver_0_8_2.c,194 :: 		if(sn_GoTo){
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_State30
;FIRMWARE_SYA_ver_0_8_2.c,196 :: 		if(GT1){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State31
;FIRMWARE_SYA_ver_0_8_2.c,198 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,199 :: 		}
L_State31:
;FIRMWARE_SYA_ver_0_8_2.c,201 :: 		if(GT2){
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State32
;FIRMWARE_SYA_ver_0_8_2.c,203 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,204 :: 		}
L_State32:
;FIRMWARE_SYA_ver_0_8_2.c,206 :: 		if(GT3){
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State33
;FIRMWARE_SYA_ver_0_8_2.c,208 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,209 :: 		}
L_State33:
;FIRMWARE_SYA_ver_0_8_2.c,210 :: 		}
L_State30:
;FIRMWARE_SYA_ver_0_8_2.c,211 :: 		break;
	GOTO        L_State10
;FIRMWARE_SYA_ver_0_8_2.c,212 :: 		case 7: // S7 - Estado de transicion para flanco positivo
L_State34:
;FIRMWARE_SYA_ver_0_8_2.c,214 :: 		if((GT1 == 1) && (GT2 == 0) && (GT3 == 0)){
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State37
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State37
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State37
L__State54:
;FIRMWARE_SYA_ver_0_8_2.c,216 :: 		state = 2;
	MOVLW       2
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,217 :: 		GT2 = 0; // Apaga la señal de GT1 (pq lo puse?)
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,218 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_2.c,219 :: 		}
L_State37:
;FIRMWARE_SYA_ver_0_8_2.c,221 :: 		if((GT1 == 0) && (GT2 == 1) && (GT3 == 0)){
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State40
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State40
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State40
L__State53:
;FIRMWARE_SYA_ver_0_8_2.c,223 :: 		state = 3;
	MOVLW       3
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,224 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,225 :: 		GT3 = 0;
	BCF         _GT3+0, BitPos(_GT3+0) 
;FIRMWARE_SYA_ver_0_8_2.c,226 :: 		}
L_State40:
;FIRMWARE_SYA_ver_0_8_2.c,228 :: 		if((GT1 == 0) && (GT2 == 0) && (GT3 == 1)){
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_State43
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_State43
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_State43
L__State52:
;FIRMWARE_SYA_ver_0_8_2.c,230 :: 		state = 1;
	MOVLW       1
	MOVWF       _state+0 
;FIRMWARE_SYA_ver_0_8_2.c,231 :: 		GT1 = 0;
	BCF         _GT1+0, BitPos(_GT1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,232 :: 		GT2 = 0;
	BCF         _GT2+0, BitPos(_GT2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,233 :: 		}
L_State43:
;FIRMWARE_SYA_ver_0_8_2.c,234 :: 		}
	GOTO        L_State10
L_State9:
	MOVF        _state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State11
	MOVF        _state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_State16
	MOVF        _state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_State19
	MOVF        _state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_State22
	MOVF        _state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_State25
	MOVF        _state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_State27
	MOVF        _state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_State29
	MOVF        _state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_State34
L_State10:
;FIRMWARE_SYA_ver_0_8_2.c,236 :: 		}
L_end_State:
	RETURN      0
; end of _State

_Events:

;FIRMWARE_SYA_ver_0_8_2.c,238 :: 		void Events(){
;FIRMWARE_SYA_ver_0_8_2.c,240 :: 		if(interruptC0){
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events44
;FIRMWARE_SYA_ver_0_8_2.c,241 :: 		if(SWITCH1 == 1){
	BTFSS       PORTC+0, 0 
	GOTO        L_Events45
;FIRMWARE_SYA_ver_0_8_2.c,242 :: 		sn_PosEdge_1 = 0;
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,243 :: 		sn_NegEdge_1 = 1;
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,244 :: 		}
L_Events45:
;FIRMWARE_SYA_ver_0_8_2.c,245 :: 		if(SWITCH1 == 0){
	BTFSC       PORTC+0, 0 
	GOTO        L_Events46
;FIRMWARE_SYA_ver_0_8_2.c,246 :: 		sn_PosEdge_1 = 1;
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,247 :: 		sn_NegEdge_1 = 0;
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,248 :: 		}
L_Events46:
;FIRMWARE_SYA_ver_0_8_2.c,249 :: 		interruptC0 = 0;
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
;FIRMWARE_SYA_ver_0_8_2.c,250 :: 		}
L_Events44:
;FIRMWARE_SYA_ver_0_8_2.c,251 :: 		if(interruptC1){
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events47
;FIRMWARE_SYA_ver_0_8_2.c,252 :: 		if(SWITCH2 == 1){
	BTFSS       PORTC+0, 1 
	GOTO        L_Events48
;FIRMWARE_SYA_ver_0_8_2.c,253 :: 		sn_PosEdge_2 = 0; // Ponemos en 1 la bandera de transicion positiva en SWITCH2
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,254 :: 		sn_NegEdge_2 = 1;
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,255 :: 		}
L_Events48:
;FIRMWARE_SYA_ver_0_8_2.c,256 :: 		if(SWITCH2 == 0){
	BTFSC       PORTC+0, 1 
	GOTO        L_Events49
;FIRMWARE_SYA_ver_0_8_2.c,257 :: 		sn_PosEdge_2 = 1;
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,258 :: 		sn_NegEdge_2 = 0; // Ponemos en 1 la bandera de transicion negativa en SWITCH2
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
;FIRMWARE_SYA_ver_0_8_2.c,259 :: 		}
L_Events49:
;FIRMWARE_SYA_ver_0_8_2.c,260 :: 		interruptC1 = 0;
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
;FIRMWARE_SYA_ver_0_8_2.c,261 :: 		}
L_Events47:
;FIRMWARE_SYA_ver_0_8_2.c,263 :: 		}
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

;FIRMWARE_SYA_ver_0_8_2.c,269 :: 		void InitInterrupt(){
;FIRMWARE_SYA_ver_0_8_2.c,271 :: 		PIE0 = 0x30;    // Enable bit de IOC (Interrupt on Change)
	MOVLW       48
	MOVWF       PIE0+0 
;FIRMWARE_SYA_ver_0_8_2.c,272 :: 		PIR0 = 0x00;    // Limpiamos la bandera de IOC
	CLRF        PIR0+0 
;FIRMWARE_SYA_ver_0_8_2.c,277 :: 		IOCCN = 0x03;   // Activamos las banderas de IOC en Transicion negativa para C0 y C1
	MOVLW       3
	MOVWF       IOCCN+0 
;FIRMWARE_SYA_ver_0_8_2.c,278 :: 		IOCCP = 0x03;   // Activamos las banderas de IOC en Transicion positiva para C0 y C1
	MOVLW       3
	MOVWF       IOCCP+0 
;FIRMWARE_SYA_ver_0_8_2.c,279 :: 		IOCCF = 0x00;   // Limpiamos la bandera de IOC
	CLRF        IOCCF+0 
;FIRMWARE_SYA_ver_0_8_2.c,280 :: 		INTCON = 0xC0;  // Activamos bits de interrupt globales (GIE) y por perifericos (PIE)
	MOVLW       192
	MOVWF       INTCON+0 
;FIRMWARE_SYA_ver_0_8_2.c,282 :: 		}
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

;FIRMWARE_SYA_ver_0_8_2.c,288 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_8_2.c,290 :: 		ADCON1 = 0x0F; // Desactivamos ADC
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_8_2.c,291 :: 		ANSELC = 0;    // Ponemos en modo digital al puerto C
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_8_2.c,292 :: 		ANSELE = 0;    //                ''                 E
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_8_2.c,293 :: 		ANSELA = 0;    //                ''                 A
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_8_2.c,295 :: 		TRISC = 0x03;  // Ponemos en modo de entrada a C0 y C1, los demas como salida
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_8_2.c,296 :: 		TRISE = 0x00;  // Ponemos en modo salida al puerto E
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_8_2.c,297 :: 		TRISA = 0x80;  //                ''                A
	MOVLW       128
	MOVWF       TRISA+0 
;FIRMWARE_SYA_ver_0_8_2.c,299 :: 		PORTC = 0x00;  // Ponemos en linea baja en puerto C
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_8_2.c,300 :: 		PORTE = 0x00;  //                ''             E
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_8_2.c,301 :: 		PORTA = 0x10;  // Ponemos en linea alta en A4
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_8_2.c,303 :: 		LATC = 0x00;   // Dejamos en cero el registro del puerto C
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_8_2.c,304 :: 		LATE = 0x00;   //                ''                      E
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_8_2.c,305 :: 		LATA = 0x10;   // Dejamos en 1 al pin A4
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_8_2.c,307 :: 		WPUC = 0x03;   // Activamos el pull-up interno de C0 y C1
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_8_2.c,308 :: 		INLVLC = 0x03; // Desactivamos valores TTL para C0 y C1 asumiento valores CMOS
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_8_2.c,309 :: 		CM1CON0 = 0x00;
	CLRF        CM1CON0+0 
;FIRMWARE_SYA_ver_0_8_2.c,310 :: 		CM2CON0 = 0x00;
	CLRF        CM2CON0+0 
;FIRMWARE_SYA_ver_0_8_2.c,312 :: 		once = TRUE;   // Seteo de la condicion para lazo
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_8_2.c,314 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
