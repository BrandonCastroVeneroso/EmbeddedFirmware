
_interrupt:

	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
	MOVLW       177
	MOVWF       TMR0H+0 
	MOVLW       224
	MOVWF       TMR0L+0 
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
L__interrupt68:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt3:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt6
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt6
L__interrupt67:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt6:
L_end_interrupt:
L__interrupt70:
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
	MOVLW       4
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main16:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BSF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       4
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main17:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       4
	MOVWF       main_next_state_L1+0 
	GOTO        L_main14
L_main18:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       4
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
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
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
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main19
	GOTO        L_main31
L_main10:
	GOTO        L_main7
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

	CLRF        FSM_state_L0+0 
	CLRF        FSM_next_state_L0+0 
	MOVF        FSM_next_state_L0+0, 0 
	MOVWF       FSM_state_L0+0 
	GOTO        L_FSM32
L_FSM34:
	BSF         LATA+0, 5 
	BCF         LATE+0, 1 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM35
	MOVLW       1
	MOVWF       FSM_next_state_L0+0 
	MOVF        FSM_state_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM36
	BSF         LATE+0, 2 
L_FSM36:
	BTG         LATA+0, 4 
	GOTO        L_FSM37
L_FSM35:
	CLRF        FSM_next_state_L0+0 
L_FSM37:
	GOTO        L_FSM33
L_FSM38:
	BSF         LATE+0, 0 
	BCF         LATA+0, 5 
	MOVLW       2
	MOVWF       FSM_next_state_L0+0 
	GOTO        L_FSM33
L_FSM39:
	BTG         LATA+0, 4 
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
	BSF         LATE+0, 1 
	BCF         LATE+0, 0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM40
	CLRF        FSM_next_state_L0+0 
	GOTO        L_FSM41
L_FSM40:
	MOVLW       2
	MOVWF       FSM_next_state_L0+0 
L_FSM41:
	GOTO        L_FSM33
L_FSM32:
	MOVF        FSM_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM34
	MOVF        FSM_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM38
	MOVF        FSM_state_L0+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM39
L_FSM33:
L_end_FSM:
	RETURN      0
; end of _FSM

_CodigoGray:

	MOVF        _INC+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	XORWF       _INC+0, 0 
	MOVWF       CodigoGray_gray_L0+0 
	CLRF        CodigoGray_gray_L0+1 
	MOVLW       0
	XORWF       CodigoGray_gray_L0+1, 1 
	MOVLW       0
	MOVWF       CodigoGray_gray_L0+1 
	MOVLW       CodigoGray_result_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(CodigoGray_result_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_8_9_5+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_5+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_5+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        CodigoGray_gray_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        CodigoGray_gray_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	RRCF        FARG_sprintf_wh+6, 1 
	RRCF        FARG_sprintf_wh+5, 1 
	BCF         FARG_sprintf_wh+6, 7 
	BTFSC       FARG_sprintf_wh+6, 6 
	BSF         FARG_sprintf_wh+6, 7 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+5, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+6, 1 
	MOVF        CodigoGray_gray_L0+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        CodigoGray_gray_L0+1, 0 
	MOVWF       FARG_sprintf_wh+8 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+7, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+8, 1 
	CALL        _sprintf+0, 0
	GOTO        L_CodigoGray42
L_CodigoGray44:
	GOTO        L_CodigoGray45
L_CodigoGray47:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray48
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_CodigoGray49
L_CodigoGray48:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
L_CodigoGray49:
	GOTO        L_CodigoGray46
L_CodigoGray45:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray47
L_CodigoGray46:
	GOTO        L_CodigoGray43
L_CodigoGray50:
	GOTO        L_CodigoGray51
L_CodigoGray53:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray54
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	GOTO        L_CodigoGray55
L_CodigoGray54:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
L_CodigoGray55:
	GOTO        L_CodigoGray52
L_CodigoGray56:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray57
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	GOTO        L_CodigoGray58
L_CodigoGray57:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
L_CodigoGray58:
	GOTO        L_CodigoGray52
L_CodigoGray51:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray53
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray56
L_CodigoGray52:
	GOTO        L_CodigoGray43
L_CodigoGray42:
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray44
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray50
L_CodigoGray43:
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events59
	BTFSS       PORTC+0, 0 
	GOTO        L_Events60
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events61
L_Events60:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events61:
	GOTO        L_Events62
L_Events59:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events63
	BTFSS       PORTC+0, 1 
	GOTO        L_Events64
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events65
L_Events64:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events65:
	GOTO        L_Events66
L_Events63:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events66:
L_Events62:
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
	MOVLW       177
	MOVWF       TMR0H+0 
	MOVLW       224
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
