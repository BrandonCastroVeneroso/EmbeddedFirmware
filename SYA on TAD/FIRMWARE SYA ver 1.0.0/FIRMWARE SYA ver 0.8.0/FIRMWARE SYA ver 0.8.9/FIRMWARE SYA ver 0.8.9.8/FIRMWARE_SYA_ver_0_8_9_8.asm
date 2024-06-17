
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
	MOVLW       0
	SUBWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt68
	MOVLW       100
	SUBWF       _counter+0, 0 
L__interrupt68:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
	BSF         _clock0+0, BitPos(_clock0+0) 
	BCF         LATA+0, 4 
	CLRF        _counter+0 
	CLRF        _counter+1 
L_interrupt1:
L_interrupt0:
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt4
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt4
L__interrupt65:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt4:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt64:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt7:
L_end_interrupt:
L__interrupt67:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main8:
	CALL        _Events+0, 0
	MOVF        main_next_state_L1+0, 0 
	MOVWF       main_state_L1+0 
	GOTO        L_main10
L_main12:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main13
	GOTO        L_main14
L_main16:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BSF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       2
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main15
L_main17:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BSF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main15
L_main18:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main15
L_main19:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main15
L_main14:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
	GOTO        L_main19
L_main15:
L_main13:
	GOTO        L_main11
L_main20:
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_main21
L_main23:
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main24
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main25
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
L_main25:
	MOVLW       1
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main26
	CLRF        main_next_state_L1+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main27
L_main26:
	BSF         _INC1+0, BitPos(_INC1+0) 
L_main27:
L_main24:
	GOTO        L_main22
L_main28:
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main29
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main30
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
L_main30:
	MOVLW       2
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main31
	CLRF        main_next_state_L1+0 
	BCF         _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main32
L_main31:
	BSF         _INC2+0, BitPos(_INC2+0) 
L_main32:
L_main29:
	GOTO        L_main22
L_main33:
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main34
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
L_main35:
	MOVLW       3
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main36
	CLRF        main_next_state_L1+0 
	BCF         _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main37
L_main36:
	BSF         _INC3+0, BitPos(_INC3+0) 
L_main37:
L_main34:
	GOTO        L_main22
L_main21:
	MOVF        _INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
	MOVF        _INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
	MOVF        _INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
L_main22:
	GOTO        L_main11
L_main38:
	CLRF        main_next_state_L1+0 
	CLRF        main_state_L1+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	CLRF        _INC+0 
	MOVLW       2
	MOVWF       _last_INC+0 
	GOTO        L_main11
L_main10:
	MOVF        main_state_L1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        main_state_L1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
	GOTO        L_main38
L_main11:
	GOTO        L_main8
L_end_main:
	GOTO        $+0
; end of _main

_CodigoGray:

	MOVF        FARG_CodigoGray_INC+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	XORWF       FARG_CodigoGray_INC+0, 0 
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
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_8_9_8+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_8+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_8_9_8+0)
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
	GOTO        L_CodigoGray39
L_CodigoGray41:
	GOTO        L_CodigoGray42
L_CodigoGray44:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray45
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray45:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray42:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray44
	GOTO        L_CodigoGray40
L_CodigoGray47:
	GOTO        L_CodigoGray48
L_CodigoGray50:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray51
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray51:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray53:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray54
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray54:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray48:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray50
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray53
	GOTO        L_CodigoGray40
L_CodigoGray39:
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray41
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray47
L_CodigoGray40:
	CLRF        R0 
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events56
	BTFSS       PORTC+0, 0 
	GOTO        L_Events57
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events58
L_Events57:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events58:
	GOTO        L_Events59
L_Events56:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events60
	BTFSS       PORTC+0, 1 
	GOTO        L_Events61
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events62
L_Events61:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events62:
	GOTO        L_Events63
L_Events60:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events63:
L_Events59:
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
