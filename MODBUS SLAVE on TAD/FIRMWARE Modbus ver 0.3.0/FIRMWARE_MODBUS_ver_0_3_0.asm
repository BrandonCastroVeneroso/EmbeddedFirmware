
_interrupt:

;FIRMWARE_MODBUS_ver_0_3_0.c,99 :: 		void interrupt(){
;FIRMWARE_MODBUS_ver_0_3_0.c,100 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_MODBUS_ver_0_3_0.c,101 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_MODBUS_ver_0_3_0.c,102 :: 		TMR0H = 0xB;
	MOVLW       11
	MOVWF       TMR0H+0 
;FIRMWARE_MODBUS_ver_0_3_0.c,103 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;FIRMWARE_MODBUS_ver_0_3_0.c,104 :: 		}
L_interrupt0:
;FIRMWARE_MODBUS_ver_0_3_0.c,105 :: 		if(PIR3.RC1IF){
	BTFSS       PIR3+0, 5 
	GOTO        L_interrupt1
;FIRMWARE_MODBUS_ver_0_3_0.c,106 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_MODBUS_ver_0_3_0.c,107 :: 		if(UART1_Data_Ready() == 1){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt2
;FIRMWARE_MODBUS_ver_0_3_0.c,108 :: 		rxfunction();
	CALL        _rxfunction+0, 0
;FIRMWARE_MODBUS_ver_0_3_0.c,109 :: 		}
L_interrupt2:
;FIRMWARE_MODBUS_ver_0_3_0.c,110 :: 		}
L_interrupt1:
;FIRMWARE_MODBUS_ver_0_3_0.c,111 :: 		}
L_end_interrupt:
L__interrupt15:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_MODBUS_ver_0_3_0.c,117 :: 		void main(){
;FIRMWARE_MODBUS_ver_0_3_0.c,119 :: 		InitSystem();
	CALL        _InitSystem+0, 0
;FIRMWARE_MODBUS_ver_0_3_0.c,120 :: 		EnableTimer0();
	CALL        _EnableTimer0+0, 0
;FIRMWARE_MODBUS_ver_0_3_0.c,121 :: 		in.rxIndex = 0;
	CLRF        _in+25 
;FIRMWARE_MODBUS_ver_0_3_0.c,123 :: 		while(1){
L_main3:
;FIRMWARE_MODBUS_ver_0_3_0.c,124 :: 		if(PIR4.TMR2IF){
	BTFSS       PIR4+0, 1 
	GOTO        L_main5
;FIRMWARE_MODBUS_ver_0_3_0.c,125 :: 		T2TMR = 0;
	CLRF        T2TMR+0 
;FIRMWARE_MODBUS_ver_0_3_0.c,126 :: 		if(in.TimeOutEnable){
	MOVF        _in+27, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
;FIRMWARE_MODBUS_ver_0_3_0.c,127 :: 		in.TimeOut++;
	MOVLW       1
	ADDWF       _in+28, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _in+29, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _in+28 
	MOVF        R1, 0 
	MOVWF       _in+29 
;FIRMWARE_MODBUS_ver_0_3_0.c,128 :: 		if(in.TimeOut >= 100){
	MOVLW       128
	XORWF       _in+29, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVLW       100
	SUBWF       _in+28, 0 
L__main17:
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;FIRMWARE_MODBUS_ver_0_3_0.c,129 :: 		in.TimeOut = 0;
	CLRF        _in+28 
	CLRF        _in+29 
;FIRMWARE_MODBUS_ver_0_3_0.c,130 :: 		in.rxIndex = 0;
	CLRF        _in+25 
;FIRMWARE_MODBUS_ver_0_3_0.c,131 :: 		}
L_main7:
;FIRMWARE_MODBUS_ver_0_3_0.c,132 :: 		}
L_main6:
;FIRMWARE_MODBUS_ver_0_3_0.c,133 :: 		}
L_main5:
;FIRMWARE_MODBUS_ver_0_3_0.c,134 :: 		if(in.rxFlag){
	MOVF        _in+26, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;FIRMWARE_MODBUS_ver_0_3_0.c,135 :: 		in.rxFlag = 0;
	CLRF        _in+26 
;FIRMWARE_MODBUS_ver_0_3_0.c,136 :: 		}
L_main8:
;FIRMWARE_MODBUS_ver_0_3_0.c,137 :: 		}
	GOTO        L_main3
;FIRMWARE_MODBUS_ver_0_3_0.c,139 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_rxfunction:

;FIRMWARE_MODBUS_ver_0_3_0.c,145 :: 		void rxfunction(){
;FIRMWARE_MODBUS_ver_0_3_0.c,146 :: 		in.in_string[in.rxIndex++] = UART1_Remappable_Read();
	MOVLW       _in+0
	MOVWF       FLOC__rxfunction+0 
	MOVLW       hi_addr(_in+0)
	MOVWF       FLOC__rxfunction+1 
	MOVF        _in+25, 0 
	ADDWF       FLOC__rxfunction+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FLOC__rxfunction+1, 1 
	CALL        _UART1_Remappable_Read+0, 0
	MOVFF       FLOC__rxfunction+0, FSR1L+0
	MOVFF       FLOC__rxfunction+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        _in+25, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _in+25 
;FIRMWARE_MODBUS_ver_0_3_0.c,147 :: 		in.TimeOutEnable = 1;
	MOVLW       1
	MOVWF       _in+27 
;FIRMWARE_MODBUS_ver_0_3_0.c,149 :: 		if(in.rxIndex >= 24){
	MOVLW       24
	SUBWF       _in+25, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_rxfunction9
;FIRMWARE_MODBUS_ver_0_3_0.c,150 :: 		in.rxIndex = 0;
	CLRF        _in+25 
;FIRMWARE_MODBUS_ver_0_3_0.c,151 :: 		in.rxFlag = 1;
	MOVLW       1
	MOVWF       _in+26 
;FIRMWARE_MODBUS_ver_0_3_0.c,152 :: 		in.TimeOutEnable = 0;
	CLRF        _in+27 
;FIRMWARE_MODBUS_ver_0_3_0.c,153 :: 		in.TimeOut = 0;
	CLRF        _in+28 
	CLRF        _in+29 
;FIRMWARE_MODBUS_ver_0_3_0.c,154 :: 		}
L_rxfunction9:
;FIRMWARE_MODBUS_ver_0_3_0.c,155 :: 		}
L_end_rxfunction:
	RETURN      0
; end of _rxfunction

_UART1_Write_Text1:

;FIRMWARE_MODBUS_ver_0_3_0.c,157 :: 		void UART1_Write_Text1(char *_cadena){
;FIRMWARE_MODBUS_ver_0_3_0.c,158 :: 		while(*_cadena){
L_UART1_Write_Text110:
	MOVFF       FARG_UART1_Write_Text1__cadena+0, FSR0L+0
	MOVFF       FARG_UART1_Write_Text1__cadena+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_UART1_Write_Text111
;FIRMWARE_MODBUS_ver_0_3_0.c,159 :: 		UART1_Write(*_cadena);
	MOVFF       FARG_UART1_Write_Text1__cadena+0, FSR0L+0
	MOVFF       FARG_UART1_Write_Text1__cadena+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FIRMWARE_MODBUS_ver_0_3_0.c,160 :: 		_cadena++;
	INFSNZ      FARG_UART1_Write_Text1__cadena+0, 1 
	INCF        FARG_UART1_Write_Text1__cadena+1, 1 
;FIRMWARE_MODBUS_ver_0_3_0.c,161 :: 		}
	GOTO        L_UART1_Write_Text110
L_UART1_Write_Text111:
;FIRMWARE_MODBUS_ver_0_3_0.c,162 :: 		}
L_end_UART1_Write_Text1:
	RETURN      0
; end of _UART1_Write_Text1

_UART1_Write_Text2:

;FIRMWARE_MODBUS_ver_0_3_0.c,164 :: 		void UART1_Write_Text2(char *_text, int _long){
;FIRMWARE_MODBUS_ver_0_3_0.c,165 :: 		while(_long--){
L_UART1_Write_Text212:
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
	GOTO        L_UART1_Write_Text213
;FIRMWARE_MODBUS_ver_0_3_0.c,166 :: 		UART1_Write(*_text++);
	MOVFF       FARG_UART1_Write_Text2__text+0, FSR0L+0
	MOVFF       FARG_UART1_Write_Text2__text+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
	INFSNZ      FARG_UART1_Write_Text2__text+0, 1 
	INCF        FARG_UART1_Write_Text2__text+1, 1 
;FIRMWARE_MODBUS_ver_0_3_0.c,167 :: 		}
	GOTO        L_UART1_Write_Text212
L_UART1_Write_Text213:
;FIRMWARE_MODBUS_ver_0_3_0.c,168 :: 		}
L_end_UART1_Write_Text2:
	RETURN      0
; end of _UART1_Write_Text2

_Read_SerialPort:

;FIRMWARE_MODBUS_ver_0_3_0.c,170 :: 		void Read_SerialPort(){
;FIRMWARE_MODBUS_ver_0_3_0.c,171 :: 		uart1_byte = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart1_byte+0 
;FIRMWARE_MODBUS_ver_0_3_0.c,172 :: 		uart1_array[i] = uart1_byte;
	MOVLW       _uart1_array+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_uart1_array+0)
	MOVWF       FSR1L+1 
	MOVF        _i+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        _uart1_byte+0, 0 
	MOVWF       POSTINC1+0 
;FIRMWARE_MODBUS_ver_0_3_0.c,173 :: 		i++;
	INCF        _i+0, 1 
;FIRMWARE_MODBUS_ver_0_3_0.c,174 :: 		}
L_end_Read_SerialPort:
	RETURN      0
; end of _Read_SerialPort
