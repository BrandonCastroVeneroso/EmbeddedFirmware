
_interrupt:

	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
	MOVLW       6
	MOVWF       TMR0H+0 
	CLRF        TMR0L+0 
	BCF         PIR0+0, 5 
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
L_interrupt0:
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt3
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt3
L__interrupt41:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt3:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt6
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt6
L__interrupt40:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt6:
L_end_interrupt:
L__interrupt43:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitMCU+0, 0
	CALL        _InitInterrupt+0, 0
L_main7:
	CALL        _Events+0, 0
	MOVF        main_next_state_L1+0, 0 
	MOVWF       main_state_L1+0 
	GOTO        L_main9
L_main11:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main12
	GOTO        L_main13
L_main15:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BSF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       2
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main16:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BSF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main17:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main18:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main13:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	GOTO        L_main18
L_main14:
L_main12:
	GOTO        L_main10
L_main19:
	GOTO        L_main20
L_main22:
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main23
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main24
	CLRF        main_next_state_L1+0 
L_main24:
L_main23:
	GOTO        L_main21
L_main25:
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main26
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       2
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main27
	CLRF        main_next_state_L1+0 
L_main27:
L_main26:
	GOTO        L_main21
L_main28:
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main29
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	MOVLW       3
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main30
	CLRF        main_next_state_L1+0 
L_main30:
L_main29:
	GOTO        L_main21
L_main20:
	MOVF        _INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	MOVF        _INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	MOVF        _INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
L_main21:
	GOTO        L_main10
L_main31:
	CLRF        main_next_state_L1+0 
	CLRF        main_state_L1+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	CLRF        _INC+0 
	MOVLW       2
	MOVWF       _last_INC+0 
	GOTO        L_main10
L_main9:
	MOVF        main_state_L1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        main_state_L1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
	GOTO        L_main31
L_main10:
	GOTO        L_main7
L_end_main:
	GOTO        $+0
; end of _main

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events32
	BTFSS       PORTC+0, 0 
	GOTO        L_Events33
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events34
L_Events33:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events34:
	GOTO        L_Events35
L_Events32:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events36
	BTFSS       PORTC+0, 1 
	GOTO        L_Events37
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events38
L_Events37:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events38:
	GOTO        L_Events39
L_Events36:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events39:
L_Events35:
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

	MOVLW       48
	MOVWF       PIE0+0 
	CLRF        PIR0+0 
	MOVLW       144
	MOVWF       T0CON0+0 
	MOVLW       64
	MOVWF       T0CON1+0 
	MOVLW       6
	MOVWF       TMR0H+0 
	CLRF        TMR0L+0 
	MOVLW       3
	MOVWF       IOCCN+0 
	MOVLW       3
	MOVWF       IOCCP+0 
	CLRF        IOCCF+0 
	BCF         PIR0+0, 5 
	MOVLW       192
	MOVWF       INTCON+0 
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

	MOVLW       15
	MOVWF       ADCON1+0 
	CLRF        ANSELC+0 
	CLRF        ANSELE+0 
	CLRF        ANSELA+0 
	MOVLW       3
	MOVWF       TRISC+0 
	CLRF        TRISE+0 
	MOVLW       128
	MOVWF       TRISA+0 
	CLRF        PORTC+0 
	CLRF        PORTE+0 
	MOVLW       16
	MOVWF       PORTA+0 
	CLRF        LATC+0 
	CLRF        LATE+0 
	MOVLW       16
	MOVWF       LATA+0 
	MOVLW       3
	MOVWF       WPUC+0 
	MOVLW       3
	MOVWF       INLVLC+0 
	CLRF        CM1CON0+0 
	CLRF        CM2CON0+0 
L_end_InitMCU:
	RETURN      0
; end of _InitMCU
