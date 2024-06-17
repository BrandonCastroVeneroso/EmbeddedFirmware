
_main:

;FIRMWARE_SYA_ver_0_3.c,28 :: 		void main(){
;FIRMWARE_SYA_ver_0_3.c,30 :: 		InitMCU();
	CALL        _InitMCU+0, 0
;FIRMWARE_SYA_ver_0_3.c,32 :: 		while(1){
L_main0:
;FIRMWARE_SYA_ver_0_3.c,33 :: 		watcher();
	CALL        _watcher+0, 0
;FIRMWARE_SYA_ver_0_3.c,35 :: 		if(flag_switch2){
	BTFSS       _flag_switch2+0, BitPos(_flag_switch2+0) 
	GOTO        L_main2
;FIRMWARE_SYA_ver_0_3.c,36 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_3.c,37 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_3.c,38 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_3.c,39 :: 		}
	GOTO        L_main3
L_main2:
;FIRMWARE_SYA_ver_0_3.c,41 :: 		if(flag_switch1){
	BTFSS       _flag_switch1+0, BitPos(_flag_switch1+0) 
	GOTO        L_main4
;FIRMWARE_SYA_ver_0_3.c,42 :: 		switch(reg){
	GOTO        L_main5
;FIRMWARE_SYA_ver_0_3.c,43 :: 		case 0:
L_main7:
;FIRMWARE_SYA_ver_0_3.c,44 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_3.c,45 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_3.c,46 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_3.c,47 :: 		case 1:
L_main8:
;FIRMWARE_SYA_ver_0_3.c,48 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_3.c,49 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_3.c,50 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_3.c,51 :: 		break;
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_3.c,52 :: 		case 2:
L_main9:
;FIRMWARE_SYA_ver_0_3.c,53 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_3.c,54 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_3.c,55 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_3.c,56 :: 		break;
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_3.c,57 :: 		case 3:
L_main10:
;FIRMWARE_SYA_ver_0_3.c,58 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_3.c,59 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_3.c,60 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_3.c,61 :: 		break;
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_3.c,62 :: 		case 4:
L_main11:
;FIRMWARE_SYA_ver_0_3.c,63 :: 		reg = 0;
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0_3.c,64 :: 		break;
	GOTO        L_main6
;FIRMWARE_SYA_ver_0_3.c,65 :: 		}
L_main5:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main26
	MOVLW       0
	XORWF       _reg+0, 0 
L__main26:
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main27
	MOVLW       1
	XORWF       _reg+0, 0 
L__main27:
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       2
	XORWF       _reg+0, 0 
L__main28:
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       3
	XORWF       _reg+0, 0 
L__main29:
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVLW       4
	XORWF       _reg+0, 0 
L__main30:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
L_main6:
;FIRMWARE_SYA_ver_0_3.c,66 :: 		}
L_main4:
;FIRMWARE_SYA_ver_0_3.c,67 :: 		}
L_main3:
;FIRMWARE_SYA_ver_0_3.c,68 :: 		}
	GOTO        L_main0
;FIRMWARE_SYA_ver_0_3.c,69 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_watcher:

;FIRMWARE_SYA_ver_0_3.c,71 :: 		void watcher(){
;FIRMWARE_SYA_ver_0_3.c,73 :: 		if(SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher12
;FIRMWARE_SYA_ver_0_3.c,74 :: 		while(SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher14
;FIRMWARE_SYA_ver_0_3.c,75 :: 		flag_switch1 = 0;
	BCF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;FIRMWARE_SYA_ver_0_3.c,76 :: 		reg = switch_count;
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0_3.c,77 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_3.c,79 :: 		}
L_watcher14:
;FIRMWARE_SYA_ver_0_3.c,80 :: 		}
L_watcher12:
;FIRMWARE_SYA_ver_0_3.c,81 :: 		while(0 == SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher16
;FIRMWARE_SYA_ver_0_3.c,82 :: 		flag_switch1 = 1;
	BSF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;FIRMWARE_SYA_ver_0_3.c,83 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_watcher17
;FIRMWARE_SYA_ver_0_3.c,84 :: 		switch_count++;
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0_3.c,85 :: 		once = FALSE;
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_3.c,86 :: 		if(switch_count > 3){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _switch_count+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__watcher32
	MOVF        _switch_count+0, 0 
	SUBLW       3
L__watcher32:
	BTFSC       STATUS+0, 0 
	GOTO        L_watcher18
;FIRMWARE_SYA_ver_0_3.c,87 :: 		switch_count = 0;
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0_3.c,88 :: 		}
L_watcher18:
;FIRMWARE_SYA_ver_0_3.c,89 :: 		}
L_watcher17:
;FIRMWARE_SYA_ver_0_3.c,91 :: 		}
L_watcher16:
;FIRMWARE_SYA_ver_0_3.c,92 :: 		if(SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher19
;FIRMWARE_SYA_ver_0_3.c,93 :: 		while(SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher21
;FIRMWARE_SYA_ver_0_3.c,94 :: 		flag_switch2 = 0;
	BCF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;FIRMWARE_SYA_ver_0_3.c,96 :: 		}
L_watcher21:
;FIRMWARE_SYA_ver_0_3.c,97 :: 		}
L_watcher19:
;FIRMWARE_SYA_ver_0_3.c,98 :: 		while(0 == SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_watcher23
;FIRMWARE_SYA_ver_0_3.c,99 :: 		flag_switch2 = 1;
	BSF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;FIRMWARE_SYA_ver_0_3.c,100 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_watcher24
;FIRMWARE_SYA_ver_0_3.c,101 :: 		switch_count++;
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0_3.c,102 :: 		once = FALSE;
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_3.c,103 :: 		}
L_watcher24:
;FIRMWARE_SYA_ver_0_3.c,105 :: 		}
L_watcher23:
;FIRMWARE_SYA_ver_0_3.c,107 :: 		}
L_end_watcher:
	RETURN      0
; end of _watcher

_InitMCU:

;FIRMWARE_SYA_ver_0_3.c,109 :: 		void InitMCU(){
;FIRMWARE_SYA_ver_0_3.c,111 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_3.c,112 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_3.c,113 :: 		ANSELE = 0;
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_3.c,114 :: 		ANSELA = 0;
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_3.c,116 :: 		TRISC = 0x03;
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_3.c,117 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_3.c,118 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0_3.c,120 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_3.c,121 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_3.c,122 :: 		PORTA = 0x10;
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_3.c,124 :: 		LATC = 0x00;
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_3.c,125 :: 		LATE = 0x00;
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_3.c,126 :: 		LATA = 0x10;
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_3.c,128 :: 		WPUC = 0x03;
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0_3.c,129 :: 		INLVLC = 0x03;
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0_3.c,131 :: 		flag_switch1 = 0;
	BCF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;FIRMWARE_SYA_ver_0_3.c,132 :: 		flag_switch2 = 0;
	BCF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;FIRMWARE_SYA_ver_0_3.c,133 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_3.c,135 :: 		}
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
