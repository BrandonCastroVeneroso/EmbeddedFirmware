
_interrupt:

	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt41:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt2:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt40:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt5:
L_end_interrupt:
L__interrupt44:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main6:
	CALL        _Events+0, 0
	BTFSC       IOCCF+0, 0 
	GOTO        L_main6
	BTFSC       IOCCF+0, 1 
	GOTO        L_main6
L__main42:
L_main11:
	GOTO        L_main13
L_main15:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main16
	MOVLW       1
	XORWF       _caso_anterior+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
	MOVLW       2
	MOVWF       _caso+0 
	GOTO        L_main18
L_main17:
	MOVLW       2
	XORWF       _caso_anterior+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
	MOVLW       3
	MOVWF       _caso+0 
	GOTO        L_main20
L_main19:
	MOVLW       3
	XORWF       _caso_anterior+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
	MOVLW       1
	MOVWF       _caso+0 
L_main21:
L_main20:
L_main18:
L_main16:
	GOTO        L_main14
L_main22:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	MOVLW       1
	MOVWF       _caso_anterior+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main23
	CLRF        _caso+0 
	GOTO        L_main24
L_main23:
L_main24:
	GOTO        L_main14
L_main25:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	MOVLW       2
	MOVWF       _caso_anterior+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main26
	CLRF        _caso+0 
	GOTO        L_main27
L_main26:
L_main27:
	GOTO        L_main14
L_main28:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	MOVLW       3
	MOVWF       _caso_anterior+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main29
	CLRF        _caso+0 
	GOTO        L_main30
L_main29:
L_main30:
	GOTO        L_main14
L_main31:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main14
L_main13:
	MOVF        _caso+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _caso+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	MOVF        _caso+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	MOVF        _caso+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
	GOTO        L_main31
L_main14:
	GOTO        L_main11
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
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
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
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
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
	MOVLW       3
	MOVWF       IOCCN+0 
	MOVLW       3
	MOVWF       IOCCP+0 
	CLRF        IOCCF+0 
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
