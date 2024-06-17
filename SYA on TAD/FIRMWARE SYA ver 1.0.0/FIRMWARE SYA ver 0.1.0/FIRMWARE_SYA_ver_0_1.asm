
_main:

;FIRMWARE_SYA_ver_0_1.c,23 :: 		void main(){
;FIRMWARE_SYA_ver_0_1.c,24 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0_1.c,25 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0_1.c,26 :: 		ANSELE = 0;
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0_1.c,27 :: 		ANSELA = 0;
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0_1.c,29 :: 		TRISC = 0x03;
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0_1.c,30 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0_1.c,31 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0_1.c,33 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0_1.c,34 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0_1.c,35 :: 		PORTA = 0x10;
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0_1.c,37 :: 		LATC = 0x00;
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0_1.c,38 :: 		LATE = 0x00;
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0_1.c,39 :: 		LATA = 0x10;
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0_1.c,41 :: 		flag_switch = 0;
	BCF         _flag_switch+0, BitPos(_flag_switch+0) 
;FIRMWARE_SYA_ver_0_1.c,42 :: 		flag01 = 0;
	BCF         _flag01+0, BitPos(_flag01+0) 
;FIRMWARE_SYA_ver_0_1.c,43 :: 		flag02 = 0;
	BCF         _flag02+0, BitPos(_flag02+0) 
;FIRMWARE_SYA_ver_0_1.c,44 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_1.c,46 :: 		while(1){
L_main0:
;FIRMWARE_SYA_ver_0_1.c,47 :: 		if(1==SWITCH){
	BTFSS       PORTC+0, 0 
	GOTO        L_main2
;FIRMWARE_SYA_ver_0_1.c,48 :: 		flag_switch = 0;
	BCF         _flag_switch+0, BitPos(_flag_switch+0) 
;FIRMWARE_SYA_ver_0_1.c,49 :: 		reg = switch_count;
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0_1.c,50 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_1.c,51 :: 		}
L_main2:
;FIRMWARE_SYA_ver_0_1.c,52 :: 		if(0==SWITCH){
	BTFSC       PORTC+0, 0 
	GOTO        L_main3
;FIRMWARE_SYA_ver_0_1.c,53 :: 		flag_switch = 1;
	BSF         _flag_switch+0, BitPos(_flag_switch+0) 
;FIRMWARE_SYA_ver_0_1.c,54 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_main4
;FIRMWARE_SYA_ver_0_1.c,55 :: 		switch_count++;
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0_1.c,56 :: 		once = FALSE;
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0_1.c,57 :: 		if(switch_count > 3){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _switch_count+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVF        _switch_count+0, 0 
	SUBLW       3
L__main17:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;FIRMWARE_SYA_ver_0_1.c,58 :: 		switch_count = 0;
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0_1.c,59 :: 		}
L_main5:
;FIRMWARE_SYA_ver_0_1.c,60 :: 		}
L_main4:
;FIRMWARE_SYA_ver_0_1.c,61 :: 		}
L_main3:
;FIRMWARE_SYA_ver_0_1.c,63 :: 		while(flag_switch){
	BTFSS       _flag_switch+0, BitPos(_flag_switch+0) 
	GOTO        L_main7
;FIRMWARE_SYA_ver_0_1.c,64 :: 		reg = switch_count;
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0_1.c,66 :: 		}
L_main7:
;FIRMWARE_SYA_ver_0_1.c,69 :: 		if(flag_switch){
	BTFSS       _flag_switch+0, BitPos(_flag_switch+0) 
	GOTO        L_main8
;FIRMWARE_SYA_ver_0_1.c,70 :: 		switch(reg){
	GOTO        L_main9
;FIRMWARE_SYA_ver_0_1.c,71 :: 		case 0:
L_main11:
;FIRMWARE_SYA_ver_0_1.c,72 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_1.c,73 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_1.c,74 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_1.c,75 :: 		case 1:
L_main12:
;FIRMWARE_SYA_ver_0_1.c,76 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_1.c,77 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_1.c,78 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_1.c,79 :: 		break;
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_1.c,80 :: 		case 2:
L_main13:
;FIRMWARE_SYA_ver_0_1.c,81 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_1.c,82 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_1.c,83 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_1.c,84 :: 		break;
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_1.c,85 :: 		case 3:
L_main14:
;FIRMWARE_SYA_ver_0_1.c,86 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0_1.c,87 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0_1.c,88 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0_1.c,89 :: 		break;
	GOTO        L_main10
;FIRMWARE_SYA_ver_0_1.c,90 :: 		case 4:
L_main15:
;FIRMWARE_SYA_ver_0_1.c,91 :: 		reg = 0;
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0_1.c,93 :: 		}
	GOTO        L_main10
L_main9:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       0
	XORWF       _reg+0, 0 
L__main18:
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       1
	XORWF       _reg+0, 0 
L__main19:
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVLW       2
	XORWF       _reg+0, 0 
L__main20:
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main21
	MOVLW       3
	XORWF       _reg+0, 0 
L__main21:
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVLW       4
	XORWF       _reg+0, 0 
L__main22:
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
L_main10:
;FIRMWARE_SYA_ver_0_1.c,94 :: 		}
L_main8:
;FIRMWARE_SYA_ver_0_1.c,95 :: 		}
	GOTO        L_main0
;FIRMWARE_SYA_ver_0_1.c,96 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
