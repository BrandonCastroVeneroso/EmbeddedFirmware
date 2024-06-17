
_main:

;Validacion.c,19 :: 		void main(){
;Validacion.c,20 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Validacion.c,22 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;Validacion.c,23 :: 		ANSELE = 0;
	CLRF        ANSELE+0 
;Validacion.c,24 :: 		ANSELA = 0;
	CLRF        ANSELA+0 
;Validacion.c,26 :: 		TRISC = 0x03;
	MOVLW       3
	MOVWF       TRISC+0 
;Validacion.c,27 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;Validacion.c,28 :: 		TRISA = 0x00;
	CLRF        TRISA+0 
;Validacion.c,30 :: 		PORTC = 0x00;
	CLRF        PORTC+0 
;Validacion.c,31 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;Validacion.c,32 :: 		PORTA = 0x10;
	MOVLW       16
	MOVWF       PORTA+0 
;Validacion.c,34 :: 		LATC = 0x00;
	CLRF        LATC+0 
;Validacion.c,35 :: 		LATE = 0x00;
	CLRF        LATE+0 
;Validacion.c,36 :: 		LATA = 0x10;
	MOVLW       16
	MOVWF       LATA+0 
;Validacion.c,38 :: 		WPUC = 0x03;
	MOVLW       3
	MOVWF       WPUC+0 
;Validacion.c,39 :: 		INLVLC = 0x03;
	MOVLW       3
	MOVWF       INLVLC+0 
;Validacion.c,41 :: 		flag_switch1 = 0;
	BCF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;Validacion.c,42 :: 		flag_switch2 = 0;
	BCF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;Validacion.c,43 :: 		conteo = 0;
	CLRF        _conteo+0 
	CLRF        _conteo+1 
;Validacion.c,44 :: 		once = TRUE;
	BSF         _once+0, BitPos(_once+0) 
;Validacion.c,46 :: 		watcher();
	CALL        _watcher+0, 0
;Validacion.c,48 :: 		while(1){
L_main0:
;Validacion.c,49 :: 		reg = conteo;
	MOVF        _conteo+0, 0 
	MOVWF       _reg+0 
	MOVF        _conteo+1, 0 
	MOVWF       _reg+1 
;Validacion.c,50 :: 		if(conteo > 3){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _conteo+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVF        _conteo+0, 0 
	SUBLW       3
L__main17:
	BTFSC       STATUS+0, 0 
	GOTO        L_main2
;Validacion.c,51 :: 		LED = 0;
	BCF         LATA+0, 4 
;Validacion.c,52 :: 		conteo = 0;
	CLRF        _conteo+0 
	CLRF        _conteo+1 
;Validacion.c,53 :: 		}
L_main2:
;Validacion.c,54 :: 		if(flag_switch1){
	BTFSS       _flag_switch1+0, BitPos(_flag_switch1+0) 
	GOTO        L_main3
;Validacion.c,55 :: 		if(once){
	BTFSS       _once+0, BitPos(_once+0) 
	GOTO        L_main4
;Validacion.c,56 :: 		conteo++;
	INFSNZ      _conteo+0, 1 
	INCF        _conteo+1, 1 
;Validacion.c,57 :: 		once = FALSE;
	BCF         _once+0, BitPos(_once+0) 
;Validacion.c,58 :: 		}
L_main4:
;Validacion.c,59 :: 		M1 = 1;
	BSF         LATA+0, 5 
;Validacion.c,60 :: 		M2 = 1;
	BSF         LATE+0, 0 
;Validacion.c,61 :: 		}
L_main3:
;Validacion.c,62 :: 		if(flag_switch2){
	BTFSS       _flag_switch2+0, BitPos(_flag_switch2+0) 
	GOTO        L_main5
;Validacion.c,63 :: 		M1 = 1;
	BSF         LATA+0, 5 
;Validacion.c,64 :: 		M2 = 1;
	BSF         LATE+0, 0 
;Validacion.c,65 :: 		M3 = 1;
	BSF         LATE+0, 1 
;Validacion.c,66 :: 		M4 = 1;
	BSF         LATE+0, 2 
;Validacion.c,67 :: 		}
L_main5:
;Validacion.c,68 :: 		}
	GOTO        L_main0
;Validacion.c,69 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_watcher:

;Validacion.c,71 :: 		void watcher(){
;Validacion.c,73 :: 		if(SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher6
;Validacion.c,74 :: 		while(SWITCH1){
	BTFSS       PORTC+0, 0 
	GOTO        L_watcher8
;Validacion.c,75 :: 		flag_switch1 = 1;
	BSF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;Validacion.c,77 :: 		}
L_watcher8:
;Validacion.c,78 :: 		}
L_watcher6:
;Validacion.c,79 :: 		while(0 == SWITCH1){
	BTFSC       PORTC+0, 0 
	GOTO        L_watcher10
;Validacion.c,80 :: 		flag_switch1 = 0;
	BCF         _flag_switch1+0, BitPos(_flag_switch1+0) 
;Validacion.c,82 :: 		}
L_watcher10:
;Validacion.c,83 :: 		if(SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher11
;Validacion.c,84 :: 		while(SWITCH2){
	BTFSS       PORTC+0, 1 
	GOTO        L_watcher13
;Validacion.c,85 :: 		flag_switch2 = 1;
	BSF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;Validacion.c,87 :: 		}
L_watcher13:
;Validacion.c,88 :: 		}
L_watcher11:
;Validacion.c,89 :: 		while(0 == SWITCH2){
	BTFSC       PORTC+0, 1 
	GOTO        L_watcher15
;Validacion.c,90 :: 		flag_switch2 = 0;
	BCF         _flag_switch2+0, BitPos(_flag_switch2+0) 
;Validacion.c,92 :: 		}
L_watcher15:
;Validacion.c,94 :: 		}
L_end_watcher:
	RETURN      0
; end of _watcher
