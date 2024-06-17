
_InitInterrupt:

	MOVLW       195
	MOVWF       INTCON+0 
	CLRF        PIR0+0 
	CLRF        PIR4+0 
	MOVLW       51
	MOVWF       PIE0+0 
	MOVLW       48
	MOVWF       PIE3+0 
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
	MOVLW       3
	MOVWF       IOCCN+0 
	MOVLW       3
	MOVWF       IOCCP+0 
	CLRF        IOCCF+0 
	BCF         PIR0+0, 5 
L_end_InitInterrupt:
	RETURN      0
; end of _InitInterrupt

_InitMCU:

	MOVLW       128
	MOVWF       ADCON0+0 
	MOVLW       15
	MOVWF       ANSELA+0 
	MOVLW       39
	MOVWF       ANSELB+0 
	CLRF        ANSELC+0 
	CLRF        ANSELD+0 
	CLRF        ANSELE+0 
	MOVLW       143
	MOVWF       TRISA+0 
	BCF         TRISB+0, 0 
	BCF         TRISB+0, 1 
	BCF         TRISB+0, 2 
	BCF         TRISB+0, 5 
	BSF         TRISB+0, 3 
	BCF         TRISB+0, 4 
	MOVLW       3
	MOVWF       TRISC+0 
	CLRF        TRISD+0 
	CLRF        TRISE+0 
	MOVLW       16
	MOVWF       PORTA+0 
	CLRF        PORTC+0 
	CLRF        PORTD+0 
	CLRF        PORTE+0 
	MOVLW       16
	MOVWF       LATA+0 
	CLRF        LATB+0 
	CLRF        LATC+0 
	CLRF        LATD+0 
	CLRF        LATE+0 
	MOVLW       11
	MOVWF       RX1PPS+0 
	MOVLW       9
	MOVWF       RB4PPS+0 
	MOVLW       3
	MOVWF       WPUC+0 
	MOVLW       3
	MOVWF       INLVLC+0 
	CLRF        CM1CON0+0 
	CLRF        CM2CON0+0 
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
L_InitMCU0:
	DECFSZ      R13, 1, 1
	BRA         L_InitMCU0
	DECFSZ      R12, 1, 1
	BRA         L_InitMCU0
	DECFSZ      R11, 1, 1
	BRA         L_InitMCU0
	NOP
	NOP
L_end_InitMCU:
	RETURN      0
; end of _InitMCU

_UART1_Write_Text1:

L_UART1_Write_Text11:
	MOVFF       FARG_UART1_Write_Text1__cadena+0, FSR0L
	MOVFF       FARG_UART1_Write_Text1__cadena+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_UART1_Write_Text12
	MOVFF       FARG_UART1_Write_Text1__cadena+0, FSR0L
	MOVFF       FARG_UART1_Write_Text1__cadena+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_UART1_Write_Text1__cadena+0, 1 
	INCF        FARG_UART1_Write_Text1__cadena+1, 1 
	GOTO        L_UART1_Write_Text11
L_UART1_Write_Text12:
L_end_UART1_Write_Text1:
	RETURN      0
; end of _UART1_Write_Text1

_UART1_Write_Text2:

L_UART1_Write_Text23:
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
	GOTO        L_UART1_Write_Text24
	MOVFF       FARG_UART1_Write_Text2__text+0, FSR0L
	MOVFF       FARG_UART1_Write_Text2__text+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_UART1_Write_Text2__text+0, 1 
	INCF        FARG_UART1_Write_Text2__text+1, 1 
	GOTO        L_UART1_Write_Text23
L_UART1_Write_Text24:
L_end_UART1_Write_Text2:
	RETURN      0
; end of _UART1_Write_Text2
