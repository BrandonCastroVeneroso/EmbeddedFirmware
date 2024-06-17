
_interrupt:

	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt2
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt2
L__interrupt75:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt2:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt5
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt5
L__interrupt74:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt5:
L_end_interrupt:
L__interrupt77:
	RETFIE      1
; end of _interrupt

_CodigoGray:

	MOVF        FARG_CodigoGray_INC+0, 0 
	MOVWF       R0 
	MOVF        FARG_CodigoGray_INC+1, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	MOVF        R0, 0 
	XORWF       FARG_CodigoGray_INC+0, 0 
	MOVWF       _gray+0 
	MOVF        FARG_CodigoGray_INC+1, 0 
	XORWF       R1, 0 
	MOVWF       _gray+1 
	MOVF        _gray+0, 0 
	MOVWF       _bit0+0 
	MOVF        _gray+1, 0 
	MOVWF       _bit0+1 
	MOVLW       1
	ANDWF       _bit0+0, 1 
	MOVLW       0
	ANDWF       _bit0+1, 1 
	MOVF        _gray+0, 0 
	MOVWF       _bit1+0 
	MOVF        _gray+1, 0 
	MOVWF       _bit1+1 
	RRCF        _bit1+1, 1 
	RRCF        _bit1+0, 1 
	BCF         _bit1+1, 7 
	BTFSC       _bit1+1, 6 
	BSF         _bit1+1, 7 
	MOVLW       1
	ANDWF       _bit1+0, 1 
	MOVLW       0
	ANDWF       _bit1+1, 1 
	MOVLW       _result+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_result+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_FIRMWARE_SYA_ver_0_9_3+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_FIRMWARE_SYA_ver_0_9_3+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_FIRMWARE_SYA_ver_0_9_3+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _bit1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _bit1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _bit0+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _bit0+1, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
	GOTO        L_CodigoGray6
L_CodigoGray8:
	GOTO        L_CodigoGray9
L_CodigoGray11:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray12
	BSF         _GT1+0, BitPos(_GT1+0) 
	GOTO        L_end_CodigoGray
L_CodigoGray12:
	GOTO        L_end_CodigoGray
L_CodigoGray9:
	MOVF        _result+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray11
	GOTO        L_CodigoGray7
L_CodigoGray14:
	GOTO        L_CodigoGray15
L_CodigoGray17:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray18
	BSF         _GT2+0, BitPos(_GT2+0) 
	GOTO        L_end_CodigoGray
L_CodigoGray18:
	GOTO        L_end_CodigoGray
L_CodigoGray20:
	BTFSS       _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_CodigoGray21
	BSF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_end_CodigoGray
L_CodigoGray21:
	GOTO        L_end_CodigoGray
L_CodigoGray15:
	MOVF        _result+1, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray17
	MOVF        _result+1, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray20
	GOTO        L_CodigoGray7
L_CodigoGray6:
	MOVF        _result+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray8
	MOVF        _result+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_CodigoGray14
L_CodigoGray7:
L_end_CodigoGray:
	RETURN      0
; end of _CodigoGray

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events23
	BTFSS       PORTC+0, 0 
	GOTO        L_Events24
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events25
L_Events24:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events25:
	GOTO        L_Events26
L_Events23:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events27
	BTFSS       PORTC+0, 1 
	GOTO        L_Events28
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events29
L_Events28:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events29:
	GOTO        L_Events30
L_Events27:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events30:
L_Events26:
L_end_Events:
	RETURN      0
; end of _Events

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main31:
	CALL        _Events+0, 0
	MOVF        _next_state+0, 0 
	MOVWF       _fsm_state+0 
	GOTO        L_main33
L_main35:
	BCF         LATA+0, 4 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main36
	GOTO        L_main37
L_main39:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BSF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       2
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_main38
L_main40:
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BSF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       3
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_main38
L_main41:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_main38
L_main42:
	BSF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	MOVLW       1
	MOVWF       _INC+0 
	MOVLW       0
	MOVWF       _INC+1 
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_main38
L_main37:
	MOVF        _last_INC+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
	MOVF        _last_INC+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
	MOVF        _last_INC+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main41
	GOTO        L_main42
L_main38:
L_main36:
	GOTO        L_main34
L_main43:
	BSF         _AND_signal+0, BitPos(_AND_signal+0) 
	GOTO        L_main44
L_main46:
	BTFSS       _INC1+0, BitPos(_INC1+0) 
	GOTO        L_main47
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	MOVF        _INC+1, 0 
	MOVWF       FARG_CodigoGray_INC+1 
	CALL        _CodigoGray+0, 0
	GOTO        L_main48
L_main50:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main49
L_main51:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main49
L_main52:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main49
L_main48:
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_main50
	BTFSC       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_main51
	GOTO        L_main52
L_main49:
	MOVLW       1
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main53
	CLRF        _next_state+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _GT1+0, BitPos(_GT1+0) 
	GOTO        L_main54
L_main53:
	BSF         _INC1+0, BitPos(_INC1+0) 
L_main54:
L_main47:
	GOTO        L_main45
L_main55:
	BTFSS       _INC2+0, BitPos(_INC2+0) 
	GOTO        L_main56
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	MOVF        _INC+1, 0 
	MOVWF       FARG_CodigoGray_INC+1 
	CALL        _CodigoGray+0, 0
	GOTO        L_main57
L_main59:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main58
L_main60:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	GOTO        L_main58
L_main61:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main58
L_main57:
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_main59
	BTFSC       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_main60
	GOTO        L_main61
L_main58:
	MOVLW       2
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main62
	CLRF        _next_state+0 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	GOTO        L_main63
L_main62:
	BSF         _INC2+0, BitPos(_INC2+0) 
L_main63:
L_main56:
	GOTO        L_main45
L_main64:
	BTFSS       _INC3+0, BitPos(_INC3+0) 
	GOTO        L_main65
	MOVF        _INC+0, 0 
	MOVWF       FARG_CodigoGray_INC+0 
	MOVF        _INC+1, 0 
	MOVWF       FARG_CodigoGray_INC+1 
	CALL        _CodigoGray+0, 0
	GOTO        L_main66
L_main68:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main67
L_main69:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	GOTO        L_main67
L_main70:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	GOTO        L_main67
L_main66:
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_main68
	BTFSC       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_main69
	GOTO        L_main70
L_main67:
	MOVLW       3
	MOVWF       _last_INC+0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_main71
	CLRF        _next_state+0 
	BCF         _INC3+0, BitPos(_INC3+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_main72
L_main71:
	BSF         _INC3+0, BitPos(_INC3+0) 
L_main72:
L_main65:
	GOTO        L_main45
L_main44:
	MOVLW       0
	XORWF       _INC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main81
	MOVLW       1
	XORWF       _INC+0, 0 
L__main81:
	BTFSC       STATUS+0, 2 
	GOTO        L_main46
	MOVLW       0
	XORWF       _INC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main82
	MOVLW       2
	XORWF       _INC+0, 0 
L__main82:
	BTFSC       STATUS+0, 2 
	GOTO        L_main55
	MOVLW       0
	XORWF       _INC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main83
	MOVLW       3
	XORWF       _INC+0, 0 
L__main83:
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
L_main45:
	GOTO        L_main34
L_main73:
	CLRF        _next_state+0 
	CLRF        _fsm_state+0 
	BCF         _INC1+0, BitPos(_INC1+0) 
	BCF         _INC2+0, BitPos(_INC2+0) 
	BCF         _INC3+0, BitPos(_INC3+0) 
	CLRF        _INC+0 
	CLRF        _INC+1 
	MOVLW       2
	MOVWF       _last_INC+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	GOTO        L_main34
L_main33:
	MOVF        _fsm_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
	MOVF        _fsm_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
	GOTO        L_main73
L_main34:
	GOTO        L_main31
L_end_main:
	GOTO        $+0
; end of _main

_InitInterrupt:

	MOVLW       48
	MOVWF       PIE0+0 
	CLRF        PIR0+0 
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
