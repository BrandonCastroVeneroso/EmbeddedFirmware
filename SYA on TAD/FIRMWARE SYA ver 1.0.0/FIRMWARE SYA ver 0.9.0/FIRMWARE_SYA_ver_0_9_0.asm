
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

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events7
	BTFSS       PORTC+0, 0 
	GOTO        L_Events8
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events9
L_Events8:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events9:
	GOTO        L_Events10
L_Events7:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events11
	BTFSS       PORTC+0, 1 
	GOTO        L_Events12
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events13
L_Events12:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events13:
	GOTO        L_Events14
L_Events11:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events14:
L_Events10:
L_end_Events:
	RETURN      0
; end of _Events

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
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_9_0+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_9_0+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_9_0+0)
	MOVWF       FARG_sprintf_f+2 
	MOVLW       3
	MOVWF       R0 
	MOVF        CodigoGray_gray_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        CodigoGray_gray_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        R0, 0 
L__CodigoGray69:
	BZ          L__CodigoGray70
	RRCF        FARG_sprintf_wh+6, 1 
	RRCF        FARG_sprintf_wh+5, 1 
	BCF         FARG_sprintf_wh+6, 7 
	BTFSC       FARG_sprintf_wh+6, 6 
	BSF         FARG_sprintf_wh+6, 7 
	ADDLW       255
	GOTO        L__CodigoGray69
L__CodigoGray70:
	MOVLW       1
	ANDWF       FARG_sprintf_wh+5, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+6, 1 
	MOVF        CodigoGray_gray_L0+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        CodigoGray_gray_L0+1, 0 
	MOVWF       FARG_sprintf_wh+8 
	RRCF        FARG_sprintf_wh+8, 1 
	RRCF        FARG_sprintf_wh+7, 1 
	BCF         FARG_sprintf_wh+8, 7 
	BTFSC       FARG_sprintf_wh+8, 6 
	BSF         FARG_sprintf_wh+8, 7 
	RRCF        FARG_sprintf_wh+8, 1 
	RRCF        FARG_sprintf_wh+7, 1 
	BCF         FARG_sprintf_wh+8, 7 
	BTFSC       FARG_sprintf_wh+8, 6 
	BSF         FARG_sprintf_wh+8, 7 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+7, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+8, 1 
	MOVF        CodigoGray_gray_L0+0, 0 
	MOVWF       FARG_sprintf_wh+9 
	MOVF        CodigoGray_gray_L0+1, 0 
	MOVWF       FARG_sprintf_wh+10 
	RRCF        FARG_sprintf_wh+10, 1 
	RRCF        FARG_sprintf_wh+9, 1 
	BCF         FARG_sprintf_wh+10, 7 
	BTFSC       FARG_sprintf_wh+10, 6 
	BSF         FARG_sprintf_wh+10, 7 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+9, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+10, 1 
	MOVF        CodigoGray_gray_L0+0, 0 
	MOVWF       FARG_sprintf_wh+11 
	MOVF        CodigoGray_gray_L0+1, 0 
	MOVWF       FARG_sprintf_wh+12 
	MOVLW       1
	ANDWF       FARG_sprintf_wh+11, 1 
	MOVLW       0
	ANDWF       FARG_sprintf_wh+12, 1 
	CALL        _sprintf+0, 0
	GOTO        L_CodigoGray15
L_CodigoGray17:
	GOTO        L_CodigoGray18
L_CodigoGray20:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray21
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray21:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray18:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray20
	GOTO        L_CodigoGray16
L_CodigoGray23:
	GOTO        L_CodigoGray24
L_CodigoGray26:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray27
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray27:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray29:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray30
	MOVLW       3
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray30:
	MOVLW       99
	MOVWF       R0 
	GOTO        L_end_CodigoGray
L_CodigoGray24:
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray26
	MOVF        CodigoGray_result_L0+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray29
	GOTO        L_CodigoGray16
L_CodigoGray15:
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray17
	MOVF        CodigoGray_result_L0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray23
L_CodigoGray16:
	CLRF        R0 
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main32:
	CALL        _Events+0, 0
	MOVF        main_next_state_L1+0, 0 
	MOVWF       main_state_L1+0 
	GOTO        L_main34
L_main36:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main37
	GOTO        L_main38
L_main40:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BSF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       2
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main39
L_main41:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BSF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main39
L_main42:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main39
L_main43:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       1
	MOVWF       main_next_state_L1+0 
	GOTO        L_main39
L_main38:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main41
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main42
	GOTO        L_main43
L_main39:
L_main37:
	GOTO        L_main35
L_main44:
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_main45
L_main47:
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main48
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVLW       0
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
L_main49:
	MOVLW       1
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main50
	CLRF        main_next_state_L1+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main51
L_main50:
	BSF         _INC1+0, BitPos(_INC1+0) 
L_main51:
L_main48:
	GOTO        L_main46
L_main52:
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main53
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVLW       0
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main54
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
L_main54:
	MOVLW       2
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main55
	CLRF        main_next_state_L1+0 
	BCF         _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main56
L_main55:
	BSF         _INC2+0, BitPos(_INC2+0) 
L_main56:
L_main53:
	GOTO        L_main46
L_main57:
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main58
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray__INC+0 
	MOVLW       0
	MOVWF       FARG_CodigoGray__INC+1 
	CALL        _CodigoGray+0, 0
	MOVF        R0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main59
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
L_main59:
	MOVLW       3
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main60
	CLRF        main_next_state_L1+0 
	BCF         _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main61
L_main60:
	BSF         _INC3+0, BitPos(_INC3+0) 
L_main61:
L_main58:
	GOTO        L_main46
L_main45:
	MOVF        _INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVF        _INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main52
	MOVF        _INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
L_main46:
	GOTO        L_main35
L_main62:
	CLRF        main_next_state_L1+0 
	CLRF        main_state_L1+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	CLRF        _INC+0 
	MOVLW       2
	MOVWF       _last_INC+0 
	GOTO        L_main35
L_main34:
	MOVF        main_state_L1+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main36
	MOVF        main_state_L1+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main44
	GOTO        L_main62
L_main35:
	GOTO        L_main32
L_end_main:
	GOTO        $+0
; end of _main

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
