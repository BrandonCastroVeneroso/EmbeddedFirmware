
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
L__interrupt64:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt3:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt6
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt6
L__interrupt63:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt6:
L_end_interrupt:
L__interrupt66:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitMCU+0, 0
	CALL        _InitInterrupt+0, 0
L_main7:
	CALL        _Events+0, 0
	CALL        _FSM+0, 0
	GOTO        L_main7
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

	MOVF        FSM_next_state_L0+0, 0 
	MOVWF       FSM_state_L0+0 
	GOTO        L_FSM9
L_FSM11:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM12
	GOTO        L_FSM13
L_FSM15:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BSF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       2
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       FSM_next_state_L0+0 
	GOTO        L_FSM14
L_FSM16:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BSF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       FSM_next_state_L0+0 
	GOTO        L_FSM14
L_FSM17:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       FSM_next_state_L0+0 
	GOTO        L_FSM14
L_FSM18:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       FSM_next_state_L0+0 
	GOTO        L_FSM14
L_FSM13:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM15
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM16
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM17
	GOTO        L_FSM18
L_FSM14:
L_FSM12:
	GOTO        L_FSM10
L_FSM19:
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_FSM20
L_FSM22:
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_FSM23
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVLW       0
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM24
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
L_FSM24:
	MOVLW       1
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM25
	CLRF        FSM_next_state_L0+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	GOTO        L_FSM26
L_FSM25:
	BSF         _INC1+0, BitPos(_INC1+0) 
L_FSM26:
L_FSM23:
	GOTO        L_FSM21
L_FSM27:
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_FSM28
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVLW       0
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM29
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
L_FSM29:
	MOVLW       2
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM30
	CLRF        FSM_next_state_L0+0 
	BCF         _INC2+0, BitPos(_INC2+0) 
	GOTO        L_FSM31
L_FSM30:
	BSF         _INC2+0, BitPos(_INC2+0) 
L_FSM31:
L_FSM28:
	GOTO        L_FSM21
L_FSM32:
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_FSM33
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVLW       0
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_FSM34
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
L_FSM34:
	MOVLW       3
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM35
	CLRF        FSM_next_state_L0+0 
	BCF         _INC3+0, BitPos(_INC3+0) 
	GOTO        L_FSM36
L_FSM35:
	BSF         _INC3+0, BitPos(_INC3+0) 
L_FSM36:
L_FSM33:
	GOTO        L_FSM21
L_FSM20:
	MOVF        _INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM22
	MOVF        _INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM27
	MOVF        _INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM32
L_FSM21:
	GOTO        L_FSM10
L_FSM37:
	CLRF        FSM_next_state_L0+0 
	CLRF        FSM_state_L0+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	CLRF        _INC+0 
	MOVLW       2
	MOVWF       _last_INC+0 
	GOTO        L_FSM10
L_FSM9:
	MOVF        FSM_state_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM11
	MOVF        FSM_state_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM19
	GOTO        L_FSM37
L_FSM10:
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
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_8_9_7+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_7+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_7+0)
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
	GOTO        L_CodigoGray38
L_CodigoGray40:
	GOTO        L_CodigoGray41
L_CodigoGray43:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray44
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray44:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray41:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray43
	GOTO        L_CodigoGray39
L_CodigoGray46:
	GOTO        L_CodigoGray47
L_CodigoGray49:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray50
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray50:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray52:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray53
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray53:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray47:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray49
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray52
	GOTO        L_CodigoGray39
L_CodigoGray38:
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray40
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray46
L_CodigoGray39:
	CLRF        R0 
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events55
	BTFSS       PORTC+0, 0 
	GOTO        L_Events56
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events57
L_Events56:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events57:
	GOTO        L_Events58
L_Events55:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events59
	BTFSS       PORTC+0, 1 
	GOTO        L_Events60
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events61
L_Events60:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events61:
	GOTO        L_Events62
L_Events59:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events62:
L_Events58:
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
