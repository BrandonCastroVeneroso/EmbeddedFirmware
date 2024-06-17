
_interrupt:

	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
	MOVLW       236
	MOVWF       TMR0H+0 
	MOVLW       120
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
	BTG         _timer0+0, BitPos(_timer0+0) 
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       1
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt50
	MOVLW       244
	SUBWF       _counter+0, 0 
L__interrupt50:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt1
	BTG         LATA+0, 4 
	CLRF        _counter+0 
	CLRF        _counter+1 
L_interrupt1:
L_interrupt0:
	BTFSS       PIR4+0, 0 
	GOTO        L_interrupt2
	MOVLW       60
	MOVWF       TMR1H+0 
	MOVLW       176
	MOVWF       TMR1L+0 
	BCF         PIR4+0, 0 
	MOVLW       1
	ADDWF       _counter1+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _counter1+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _counter1+0 
	MOVF        R1, 0 
	MOVWF       _counter1+1 
	BTG         _timer1+0, BitPos(_timer1+0) 
	MOVLW       128
	XORWF       _counter1+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt51
	MOVLW       50
	SUBWF       _counter1+0, 0 
L__interrupt51:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt3
	BTG         LATA+0, 5 
	CLRF        _counter1+0 
	CLRF        _counter1+1 
L_interrupt3:
L_interrupt2:
	BTFSS       PIR4+0, 2 
	GOTO        L_interrupt4
	MOVLW       11
	MOVWF       TMR3H+0 
	MOVLW       220
	MOVWF       TMR3L+0 
	BCF         PIR4+0, 2 
	MOVLW       1
	ADDWF       _counter2+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _counter2+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _counter2+0 
	MOVF        R1, 0 
	MOVWF       _counter2+1 
	MOVLW       128
	XORWF       _counter2+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt52
	MOVLW       10
	SUBWF       _counter2+0, 0 
L__interrupt52:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
	BTG         LATE+0, 0 
	BTG         _timer3+0, BitPos(_timer3+0) 
	CLRF        _counter2+0 
	CLRF        _counter2+1 
L_interrupt5:
L_interrupt4:
	BTFSS       PIR3+0, 5 
	GOTO        L_interrupt6
	BCF         PIR3+0, 5 
L_interrupt6:
	BTFSS       IOCCF+0, 0 
	GOTO        L_interrupt9
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt9
L__interrupt47:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt9:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt12
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt12
L__interrupt46:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt12:
L_end_interrupt:
L__interrupt49:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main13:
	BTG         LATE+0, 2 
	MOVLW       101
	MOVWF       FARG_UART1_Remappable_Write_data_+0 
	CALL        _UART1_Remappable_Write+0, 0
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	DECFSZ      R11, 1, 1
	BRA         L_main15
	NOP
	NOP
	CALL        _Events+0, 0
	GOTO        L_main16
L_main18:
	BCF         LATE+0, 1 
	GOTO        L_main17
L_main19:
	BSF         LATE+0, 1 
	GOTO        L_main17
L_main20:
	BCF         LATE+0, 1 
	GOTO        L_main17
L_main16:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main18
	BTFSC       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_main19
	GOTO        L_main20
L_main17:
	GOTO        L_main13
L_end_main:
	GOTO        $+0
; end of _main

_Events:

	GOTO        L_Events21
L_Events23:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events22
L_Events24:
	GOTO        L_Events25
L_Events27:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events26
L_Events28:
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events26
L_Events29:
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events26
L_Events25:
	BTFSS       PORTC+0, 0 
	GOTO        L_Events27
	BTFSC       PORTC+0, 0 
	GOTO        L_Events28
	GOTO        L_Events29
L_Events26:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events22
L_Events30:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events22
L_Events21:
	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events23
	BTFSC       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events24
	GOTO        L_Events30
L_Events22:
	GOTO        L_Events31
L_Events33:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events32
L_Events34:
	GOTO        L_Events35
L_Events37:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events36
L_Events38:
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events36
L_Events39:
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events36
L_Events35:
	BTFSS       PORTC+0, 1 
	GOTO        L_Events37
	BTFSC       PORTC+0, 1 
	GOTO        L_Events38
	GOTO        L_Events39
L_Events36:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events32
L_Events40:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events32
L_Events31:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events33
	BTFSC       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events34
	GOTO        L_Events40
L_Events32:
L_end_Events:
	RETURN      0
; end of _Events

_InitInterrupt:

	MOVLW       51
	MOVWF       PIE0+0 
	CLRF        PIR0+0 
	MOVLW       32
	MOVWF       PIE3+0 
	MOVLW       5
	MOVWF       PIE4+0 
	CLRF        PIR4+0 
	MOVLW       144
	MOVWF       T0CON0+0 
	MOVLW       64
	MOVWF       T0CON1+0 
	MOVLW       236
	MOVWF       TMR0H+0 
	MOVLW       120
	MOVWF       TMR0L+0 
	MOVLW       3
	MOVWF       T1CON+0 
	CLRF        T1GCON+0 
	MOVLW       1
	MOVWF       TMR1CLK+0 
	MOVLW       60
	MOVWF       TMR1H+0 
	MOVLW       176
	MOVWF       TMR1L+0 
	MOVLW       51
	MOVWF       T3CON+0 
	CLRF        T3GCON+0 
	MOVLW       1
	MOVWF       TMR3CLK+0 
	MOVLW       11
	MOVWF       TMR3H+0 
	MOVLW       220
	MOVWF       TMR3L+0 
	MOVLW       3
	MOVWF       IOCCN+0 
	MOVLW       3
	MOVWF       IOCCP+0 
	CLRF        IOCCF+0 
	BCF         PIR0+0, 5 
	MOVLW       195
	MOVWF       INTCON+0 
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

	MOVLW       112
	MOVWF       OSCCON1+0 
	MOVLW       128
	MOVWF       OSCEN+0 
	CLRF        ADCON0+0 
	CLRF        ANSELC+0 
	CLRF        ANSELE+0 
	CLRF        ANSELA+0 
	CLRF        ANSELB+0 
	MOVLW       3
	MOVWF       TRISC+0 
	CLRF        TRISE+0 
	MOVLW       128
	MOVWF       TRISA+0 
	BSF         TRISB+0, 3 
	BCF         TRISB+0, 4 
	CLRF        PORTC+0 
	CLRF        PORTE+0 
	MOVLW       16
	MOVWF       PORTA+0 
	CLRF        LATC+0 
	CLRF        LATE+0 
	MOVLW       16
	MOVWF       LATA+0 
	CLRF        LATB+0 
	MOVLW       3
	MOVWF       WPUC+0 
	MOVLW       3
	MOVWF       INLVLC+0 
	CLRF        CM1CON0+0 
	CLRF        CM2CON0+0 
	CALL        _Unlock_IOLOCK+0, 0
	MOVLW       36
	MOVWF       FARG_PPS_Mapping_NoLock_rp_num+0 
	MOVLW       1
	MOVWF       FARG_PPS_Mapping_NoLock_input_output+0 
	MOVLW       26
	MOVWF       FARG_PPS_Mapping_NoLock_funct_name+0 
	CALL        _PPS_Mapping_NoLock+0, 0
	MOVLW       37
	MOVWF       FARG_PPS_Mapping_NoLock_rp_num+0 
	CLRF        FARG_PPS_Mapping_NoLock_input_output+0 
	MOVLW       27
	MOVWF       FARG_PPS_Mapping_NoLock_funct_name+0 
	CALL        _PPS_Mapping_NoLock+0, 0
	CALL        _Lock_IOLOCK+0, 0
	BSF         BAUDCON+0, 3, 0
	MOVLW       8
	MOVWF       SPBRG+0 
	MOVLW       2
	MOVWF       SPBRG+1 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Remappable_Init+0, 0
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_InitMCU41:
	DECFSZ      R13, 1, 1
	BRA         L_InitMCU41
	DECFSZ      R12, 1, 1
	BRA         L_InitMCU41
	DECFSZ      R11, 1, 1
	BRA         L_InitMCU41
	NOP
	NOP
L_end_InitMCU:
	RETURN      0
; end of _InitMCU

_UART1_Write_Text1:

L_UART1_Write_Text142:
	MOVFF       FARG_UART1_Write_Text1__cadena+0, FSR0L
	MOVFF       FARG_UART1_Write_Text1__cadena+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_UART1_Write_Text143
	MOVFF       FARG_UART1_Write_Text1__cadena+0, FSR0L
	MOVFF       FARG_UART1_Write_Text1__cadena+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_UART1_Write_Text1__cadena+0, 1 
	INCF        FARG_UART1_Write_Text1__cadena+1, 1 
	GOTO        L_UART1_Write_Text142
L_UART1_Write_Text143:
L_end_UART1_Write_Text1:
	RETURN      0
; end of _UART1_Write_Text1

_UART1_Write_Text2:

L_UART1_Write_Text244:
	MOVF        FARG_UART1_Write_Text2__long+0, 0 
	MOVWF       R0 
	MOVF        FARG_UART1_Write_Text2__long+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_UART1_Write_Text2__long+0, 1 
	MOVLW       0
	SUBWFB      FARG_UART1_Write_Text2__long+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_UART1_Write_Text245
	MOVFF       FARG_UART1_Write_Text2__text+0, FSR0L
	MOVFF       FARG_UART1_Write_Text2__text+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_UART1_Write_Text2__text+0, 1 
	INCF        FARG_UART1_Write_Text2__text+1, 1 
	GOTO        L_UART1_Write_Text244
L_UART1_Write_Text245:
L_end_UART1_Write_Text2:
	RETURN      0
; end of _UART1_Write_Text2

_Read_SerialPort:

	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart1_byte+0 
	MOVLW       _uart1_array+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_uart1_array+0)
	MOVWF       FSR1H 
	MOVF        _i+0, 0 
	ADDWF       FSR1L, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _uart1_byte+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _i+0, 1 
L_end_Read_SerialPort:
	RETURN      0
; end of _Read_SerialPort
