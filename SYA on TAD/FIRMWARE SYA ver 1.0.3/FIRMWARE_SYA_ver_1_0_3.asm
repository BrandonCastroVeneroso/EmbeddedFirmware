
_interrupt:

	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt101:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt2:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt100:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt5:
L_end_interrupt:
L__interrupt119:
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
L__main110:
L_main11:
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
	CALL        _FSM+0, 0
	BTFSS       _ONE+0, BitPos(_ONE+0) 
	GOTO        L_main13
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main16
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main16
L__main109:
	CLRF        _next_state+0 
	GOTO        L_main17
L_main16:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_main20
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main20
L__main108:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_main21
L_main20:
L_main21:
L_main17:
	GOTO        L_main22
L_main13:
	BTFSS       _TWO+0, BitPos(_TWO+0) 
	GOTO        L_main23
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main26
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main26
L__main107:
	CLRF        _next_state+0 
	GOTO        L_main27
L_main26:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_main30
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main30
L__main106:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_main31
L_main30:
L_main31:
L_main27:
	GOTO        L_main32
L_main23:
	BTFSS       _THREE+0, BitPos(_THREE+0) 
	GOTO        L_main33
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main36
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main36
L__main105:
	CLRF        _next_state+0 
	GOTO        L_main37
L_main36:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_main40
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main40
L__main104:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_main41
L_main40:
L_main41:
L_main37:
	GOTO        L_main42
L_main33:
	BTFSS       _FOUR+0, BitPos(_FOUR+0) 
	GOTO        L_main43
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main46
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main46
L__main103:
	CLRF        _next_state+0 
	GOTO        L_main47
L_main46:
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_main50
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_main50
L__main102:
	MOVLW       5
	MOVWF       _next_state+0 
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_main51
L_main50:
L_main51:
L_main47:
	GOTO        L_main52
L_main43:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
L_main52:
L_main42:
L_main32:
L_main22:
	GOTO        L_main11
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

	GOTO        L_FSM53
L_FSM55:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM58
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM58
L__FSM117:
	MOVLW       6
	MOVWF       _next_state+0 
	GOTO        L_FSM59
L_FSM58:
L_FSM59:
	GOTO        L_FSM54
L_FSM60:
	BSF         _ONE+0, BitPos(_ONE+0) 
	BSF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_end_FSM
L_FSM61:
	BSF         _TWO+0, BitPos(_TWO+0) 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BSF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_end_FSM
L_FSM62:
	BSF         _THREE+0, BitPos(_THREE+0) 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BSF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_end_FSM
L_FSM63:
	BSF         _FOUR+0, BitPos(_FOUR+0) 
	GOTO        L_end_FSM
L_FSM64:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM67
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM67
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM67
L__FSM116:
	MOVLW       2
	MOVWF       _next_state+0 
	GOTO        L_FSM68
L_FSM67:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM71
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM71
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM71
L__FSM115:
	MOVLW       3
	MOVWF       _next_state+0 
	GOTO        L_FSM72
L_FSM71:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM75
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM75
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM75
L__FSM114:
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_FSM76
L_FSM75:
L_FSM76:
L_FSM72:
L_FSM68:
	GOTO        L_FSM54
L_FSM77:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM78
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM81
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM81
L__FSM113:
	MOVLW       2
	MOVWF       _next_state+0 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM82
L_FSM81:
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM85
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM85
L__FSM112:
	MOVLW       3
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM86
L_FSM85:
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM89
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM89
L__FSM111:
	MOVLW       1
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM90
L_FSM89:
L_FSM90:
L_FSM86:
L_FSM82:
L_FSM78:
	GOTO        L_FSM54
L_FSM91:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BSF         _GT3+0, BitPos(_GT3+0) 
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	CLRF        _current_state+0 
	CLRF        _next_state+0 
	GOTO        L_FSM54
L_FSM53:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM55
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM60
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM61
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM62
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM63
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM64
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM77
	GOTO        L_FSM91
L_FSM54:
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events92
	BTFSS       PORTC+0, 0 
	GOTO        L_Events93
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events94
L_Events93:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events94:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events95
L_Events92:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events96
	BTFSS       PORTC+0, 1 
	GOTO        L_Events97
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events98
L_Events97:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events98:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events99
L_Events96:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events99:
L_Events95:
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
