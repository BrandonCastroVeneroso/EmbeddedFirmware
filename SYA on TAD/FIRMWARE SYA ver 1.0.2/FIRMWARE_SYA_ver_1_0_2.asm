
_interrupt:

	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt93:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt2:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt92:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt5:
L_end_interrupt:
L__interrupt111:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main6:
	CALL        _Events+0, 0
	BTFSC       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_main6
	BTFSC       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_main6
L__main94:
L_main11:
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
	CALL        _FSM+0, 0
	GOTO        L_main11
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

	GOTO        L_FSM13
L_FSM15:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM18
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM18
L__FSM109:
	MOVLW       6
	MOVWF       _next_state+0 
	GOTO        L_FSM19
L_FSM18:
L_FSM19:
	GOTO        L_FSM14
L_FSM20:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM23
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM23
L__FSM108:
	CLRF        _next_state+0 
	GOTO        L_FSM24
L_FSM23:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM27
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM27
L__FSM107:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_FSM28
L_FSM27:
L_FSM28:
L_FSM24:
	GOTO        L_FSM14
L_FSM29:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BSF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM32
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM32
L__FSM106:
	CLRF        _next_state+0 
	GOTO        L_FSM33
L_FSM32:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM36
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM36
L__FSM105:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_FSM37
L_FSM36:
L_FSM37:
L_FSM33:
	GOTO        L_FSM14
L_FSM38:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BSF         _GT3+0, BitPos(_GT3+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM41
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM41
L__FSM104:
	CLRF        _next_state+0 
	GOTO        L_FSM42
L_FSM41:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM45
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM45
L__FSM103:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_FSM46
L_FSM45:
L_FSM46:
L_FSM42:
	GOTO        L_FSM14
L_FSM47:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM50
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM50
L__FSM102:
	CLRF        _next_state+0 
	GOTO        L_FSM51
L_FSM50:
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM54
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM54
L__FSM101:
	MOVLW       5
	MOVWF       _next_state+0 
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM55
L_FSM54:
L_FSM55:
L_FSM51:
	GOTO        L_FSM14
L_FSM56:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM59
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM59
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM59
L__FSM100:
	MOVLW       2
	MOVWF       _next_state+0 
	GOTO        L_FSM60
L_FSM59:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM63
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM63
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM63
L__FSM99:
	MOVLW       3
	MOVWF       _next_state+0 
	GOTO        L_FSM64
L_FSM63:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM67
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM67
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM67
L__FSM98:
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_FSM68
L_FSM67:
L_FSM68:
L_FSM64:
L_FSM60:
	GOTO        L_FSM14
L_FSM69:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM70
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM73
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM73
L__FSM97:
	MOVLW       2
	MOVWF       _next_state+0 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM74
L_FSM73:
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM77
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM77
L__FSM96:
	MOVLW       3
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM78
L_FSM77:
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM81
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM81
L__FSM95:
	MOVLW       1
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM82
L_FSM81:
L_FSM82:
L_FSM78:
L_FSM74:
L_FSM70:
	GOTO        L_FSM14
L_FSM83:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BSF         _GT3+0, BitPos(_GT3+0) 
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	CLRF        _current_state+0 
	CLRF        _next_state+0 
	GOTO        L_FSM14
L_FSM13:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM15
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM20
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM29
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM38
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM47
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM56
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM69
	GOTO        L_FSM83
L_FSM14:
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events84
	BTFSS       PORTC+0, 0 
	GOTO        L_Events85
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events86
L_Events85:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events86:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events87
L_Events84:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events88
	BTFSS       PORTC+0, 1 
	GOTO        L_Events89
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events90
L_Events89:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events90:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events91
L_Events88:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events91:
L_Events87:
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
	MOVLW       60
	MOVWF       TMR0H+0 
	MOVLW       176
	MOVWF       TMR0L+0 
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
