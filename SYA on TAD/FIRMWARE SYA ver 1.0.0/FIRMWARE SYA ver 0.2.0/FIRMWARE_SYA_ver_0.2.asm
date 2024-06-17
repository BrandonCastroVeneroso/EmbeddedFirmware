
_main:

;FIRMWARE_SYA_ver_0.2.c,25 :: 		void main(){
;FIRMWARE_SYA_ver_0.2.c,26 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;FIRMWARE_SYA_ver_0.2.c,27 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;FIRMWARE_SYA_ver_0.2.c,28 :: 		ANSELE = 0;
	CLRF        ANSELE+0 
;FIRMWARE_SYA_ver_0.2.c,29 :: 		ANSELA = 0;
	CLRF        ANSELA+0 
;FIRMWARE_SYA_ver_0.2.c,31 :: 		TRISC = 0x03;
	MOVLW       3
	MOVWF       TRISC+0 
;FIRMWARE_SYA_ver_0.2.c,32 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;FIRMWARE_SYA_ver_0.2.c,33 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;FIRMWARE_SYA_ver_0.2.c,35 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;FIRMWARE_SYA_ver_0.2.c,36 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;FIRMWARE_SYA_ver_0.2.c,37 :: 		PORTA = 0x10;
	MOVLW       16
	MOVWF       PORTA+0 
;FIRMWARE_SYA_ver_0.2.c,39 :: 		LATC = 0x00;
	CLRF        LATC+0 
;FIRMWARE_SYA_ver_0.2.c,40 :: 		LATE = 0x00;
	CLRF        LATE+0 
;FIRMWARE_SYA_ver_0.2.c,41 :: 		LATA = 0x10;
	MOVLW       16
	MOVWF       LATA+0 
;FIRMWARE_SYA_ver_0.2.c,43 :: 		WPUC = 0x03;
	MOVLW       3
	MOVWF       WPUC+0 
;FIRMWARE_SYA_ver_0.2.c,44 :: 		INLVLC = 0x03;
	MOVLW       3
	MOVWF       INLVLC+0 
;FIRMWARE_SYA_ver_0.2.c,46 :: 		flag_switch1 = 0;
	BCF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;FIRMWARE_SYA_ver_0.2.c,47 :: 		flag_switch2 = 0;
	BCF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;FIRMWARE_SYA_ver_0.2.c,48 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.2.c,50 :: 		while(1){
L_main0:
;FIRMWARE_SYA_ver_0.2.c,51 :: 		if(SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_main2
;FIRMWARE_SYA_ver_0.2.c,52 :: 		flag_switch1 = 0;
	BCF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;FIRMWARE_SYA_ver_0.2.c,53 :: 		reg = switch_count;
	MOVF        _switch_count+0, 0 
	MOVWF       _reg+0 
	MOVF        _switch_count+1, 0 
	MOVWF       _reg+1 
;FIRMWARE_SYA_ver_0.2.c,54 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.2.c,55 :: 		}
	GOTO        L_main3
L_main2:
;FIRMWARE_SYA_ver_0.2.c,57 :: 		flag_switch1 = 1;
	BSF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;FIRMWARE_SYA_ver_0.2.c,58 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_main4
;FIRMWARE_SYA_ver_0.2.c,59 :: 		switch_count++;
	INFSNZ      _switch_count+0, 1 
	INCF        _switch_count+1, 1 
;FIRMWARE_SYA_ver_0.2.c,60 :: 		once = FALSE;
	BCF         _once+0, BitPos(_once+0) 
;FIRMWARE_SYA_ver_0.2.c,61 :: 		if(switch_count > 3){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _switch_count+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVF        _switch_count+0, 0 
	SUBLW       3
L__main19:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;FIRMWARE_SYA_ver_0.2.c,62 :: 		switch_count = 0;
	CLRF        _switch_count+0 
	CLRF        _switch_count+1 
;FIRMWARE_SYA_ver_0.2.c,63 :: 		}
L_main5:
;FIRMWARE_SYA_ver_0.2.c,64 :: 		}
L_main4:
;FIRMWARE_SYA_ver_0.2.c,65 :: 		}
L_main3:
;FIRMWARE_SYA_ver_0.2.c,66 :: 		if(SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_main6
;FIRMWARE_SYA_ver_0.2.c,67 :: 		flag_switch2 = 0;
	BCF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;FIRMWARE_SYA_ver_0.2.c,68 :: 		}
	GOTO        L_main7
L_main6:
;FIRMWARE_SYA_ver_0.2.c,70 :: 		flag_switch2 = 1;
	BSF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;FIRMWARE_SYA_ver_0.2.c,71 :: 		}
L_main7:
;FIRMWARE_SYA_ver_0.2.c,78 :: 		if(flag_switch2){
	BTFSS       _flag_switch2+0, BitPos(_flag_switch2+0) 
	GOTO        L_main8
;FIRMWARE_SYA_ver_0.2.c,79 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.2.c,80 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.2.c,81 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.2.c,82 :: 		}
	GOTO        L_main9
L_main8:
;FIRMWARE_SYA_ver_0.2.c,84 :: 		if(flag_switch1){
	BTFSS       _flag_switch1+0, BitPos(_flag_switch1+0) 
	GOTO        L_main10
;FIRMWARE_SYA_ver_0.2.c,85 :: 		switch(reg){
	GOTO        L_main11
;FIRMWARE_SYA_ver_0.2.c,86 :: 		case 0:
L_main13:
;FIRMWARE_SYA_ver_0.2.c,87 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.2.c,88 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.2.c,89 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.2.c,90 :: 		case 1:
L_main14:
;FIRMWARE_SYA_ver_0.2.c,91 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.2.c,92 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.2.c,93 :: 		M3 = 0;
	BCF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.2.c,94 :: 		break;
	GOTO        L_main12
;FIRMWARE_SYA_ver_0.2.c,95 :: 		case 2:
L_main15:
;FIRMWARE_SYA_ver_0.2.c,96 :: 		M1 = 0;
	BCF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.2.c,97 :: 		M2 = 1;
	BSF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.2.c,98 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.2.c,99 :: 		break;
	GOTO        L_main12
;FIRMWARE_SYA_ver_0.2.c,100 :: 		case 3:
L_main16:
;FIRMWARE_SYA_ver_0.2.c,101 :: 		M1 = 1;
	BSF         LATA+0, 5 
;FIRMWARE_SYA_ver_0.2.c,102 :: 		M2 = 0;
	BCF         LATE+0, 0 
;FIRMWARE_SYA_ver_0.2.c,103 :: 		M3 = 1;
	BSF         LATE+0, 1 
;FIRMWARE_SYA_ver_0.2.c,104 :: 		break;
	GOTO        L_main12
;FIRMWARE_SYA_ver_0.2.c,105 :: 		case 4:
L_main17:
;FIRMWARE_SYA_ver_0.2.c,106 :: 		reg = 0;
	CLRF        _reg+0 
	CLRF        _reg+1 
;FIRMWARE_SYA_ver_0.2.c,108 :: 		}
	GOTO        L_main12
L_main11:
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVLW       0
	XORWF       _reg+0, 0 
L__main20:
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main21
	MOVLW       1
	XORWF       _reg+0, 0 
L__main21:
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVLW       2
	XORWF       _reg+0, 0 
L__main22:
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVLW       3
	XORWF       _reg+0, 0 
L__main23:
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVLW       0
	XORWF       _reg+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main24
	MOVLW       4
	XORWF       _reg+0, 0 
L__main24:
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
L_main12:
;FIRMWARE_SYA_ver_0.2.c,109 :: 		}
L_main10:
;FIRMWARE_SYA_ver_0.2.c,110 :: 		}
L_main9:
;FIRMWARE_SYA_ver_0.2.c,111 :: 		}
	GOTO        L_main0
;FIRMWARE_SYA_ver_0.2.c,112 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
