
_interrupt:

;FIRMWARE_MODBUS_ver_0_4_0.c,96 :: 		void interrupt(){
;FIRMWARE_MODBUS_ver_0_4_0.c,97 :: 		if(PIR0.TMR0IF){
	BTFSS       PIR0+0, 5 
	GOTO        L_interrupt0
;FIRMWARE_MODBUS_ver_0_4_0.c,98 :: 		PIR0.TMR0IF = 0;
	BCF         PIR0+0, 5 
;FIRMWARE_MODBUS_ver_0_4_0.c,99 :: 		TMR0H = 0xB;
	MOVLW       11
	MOVWF       TMR0H+0 
;FIRMWARE_MODBUS_ver_0_4_0.c,100 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;FIRMWARE_MODBUS_ver_0_4_0.c,101 :: 		}
L_interrupt0:
;FIRMWARE_MODBUS_ver_0_4_0.c,102 :: 		if(PIR3.RC1IF){
	BTFSS       PIR3+0, 5 
	GOTO        L_interrupt1
;FIRMWARE_MODBUS_ver_0_4_0.c,103 :: 		R1 = ~R1;
	BTG         LATA+0, 5 
;FIRMWARE_MODBUS_ver_0_4_0.c,104 :: 		rxfunction();
	CALL        _rxfunction+0, 0
;FIRMWARE_MODBUS_ver_0_4_0.c,105 :: 		}
L_interrupt1:
;FIRMWARE_MODBUS_ver_0_4_0.c,106 :: 		}
L_end_interrupt:
L__interrupt13:
	RETFIE      1
; end of _interrupt

_main:

;FIRMWARE_MODBUS_ver_0_4_0.c,112 :: 		void main(){
;FIRMWARE_MODBUS_ver_0_4_0.c,114 :: 		InitSystem();
	CALL        _InitSystem+0, 0
;FIRMWARE_MODBUS_ver_0_4_0.c,115 :: 		Delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;FIRMWARE_MODBUS_ver_0_4_0.c,117 :: 		ud_write_uart1('H');
	MOVLW       72
	MOVWF       FARG_ud_write_uart1__string+0 
	MOVLW       0
	MOVWF       FARG_ud_write_uart1__string+1 
	CALL        _ud_write_uart1+0, 0
;FIRMWARE_MODBUS_ver_0_4_0.c,119 :: 		in.rxIndex = 0;
	CLRF        _in+25 
;FIRMWARE_MODBUS_ver_0_4_0.c,121 :: 		while(1){
L_main3:
;FIRMWARE_MODBUS_ver_0_4_0.c,122 :: 		if(PIR4.TMR2IF){
	BTFSS       PIR4+0, 1 
	GOTO        L_main5
;FIRMWARE_MODBUS_ver_0_4_0.c,123 :: 		T2TMR = 0;
	CLRF        T2TMR+0 
;FIRMWARE_MODBUS_ver_0_4_0.c,124 :: 		if(in.TimeOutEnable){
	MOVF        _in+27, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
;FIRMWARE_MODBUS_ver_0_4_0.c,125 :: 		in.TimeOut++;
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
;FIRMWARE_MODBUS_ver_0_4_0.c,126 :: 		if(in.TimeOut >= 100){
	MOVLW       128
	XORWF       _in+29, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main15
	MOVLW       100
	SUBWF       _in+28, 0 
L__main15:
	BTFSS       STATUS+0, 0 
	GOTO        L_main7
;FIRMWARE_MODBUS_ver_0_4_0.c,127 :: 		in.TimeOut = 0;
	CLRF        _in+28 
	CLRF        _in+29 
;FIRMWARE_MODBUS_ver_0_4_0.c,128 :: 		in.rxIndex = 0;
	CLRF        _in+25 
;FIRMWARE_MODBUS_ver_0_4_0.c,129 :: 		}
L_main7:
;FIRMWARE_MODBUS_ver_0_4_0.c,130 :: 		}
L_main6:
;FIRMWARE_MODBUS_ver_0_4_0.c,131 :: 		}
L_main5:
;FIRMWARE_MODBUS_ver_0_4_0.c,132 :: 		if(in.rxFlag){
	MOVF        _in+26, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;FIRMWARE_MODBUS_ver_0_4_0.c,133 :: 		in.rxFlag = 0;
	CLRF        _in+26 
;FIRMWARE_MODBUS_ver_0_4_0.c,134 :: 		LED = ~LED;
	BTG         LATA+0, 4 
;FIRMWARE_MODBUS_ver_0_4_0.c,135 :: 		}
L_main8:
;FIRMWARE_MODBUS_ver_0_4_0.c,136 :: 		}
	GOTO        L_main3
;FIRMWARE_MODBUS_ver_0_4_0.c,138 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_rxfunction:

;FIRMWARE_MODBUS_ver_0_4_0.c,144 :: 		void rxfunction(){
;FIRMWARE_MODBUS_ver_0_4_0.c,145 :: 		in.in_string[in.rxIndex++] = RC1REG;
	MOVLW       _in+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_in+0)
	MOVWF       FSR1L+1 
	MOVF        _in+25, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        RC1REG+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        _in+25, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _in+25 
;FIRMWARE_MODBUS_ver_0_4_0.c,146 :: 		in.TimeOutEnable = 1;
	MOVLW       1
	MOVWF       _in+27 
;FIRMWARE_MODBUS_ver_0_4_0.c,148 :: 		if(in.rxIndex >= 24){
	MOVLW       24
	SUBWF       _in+25, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_rxfunction9
;FIRMWARE_MODBUS_ver_0_4_0.c,149 :: 		in.rxIndex = 0;
	CLRF        _in+25 
;FIRMWARE_MODBUS_ver_0_4_0.c,150 :: 		in.rxFlag = 1;
	MOVLW       1
	MOVWF       _in+26 
;FIRMWARE_MODBUS_ver_0_4_0.c,151 :: 		in.TimeOutEnable = 0;
	CLRF        _in+27 
;FIRMWARE_MODBUS_ver_0_4_0.c,152 :: 		in.TimeOut = 0;
	CLRF        _in+28 
	CLRF        _in+29 
;FIRMWARE_MODBUS_ver_0_4_0.c,153 :: 		}
L_rxfunction9:
;FIRMWARE_MODBUS_ver_0_4_0.c,154 :: 		}
L_end_rxfunction:
	RETURN      0
; end of _rxfunction

_ud_write_uart1:

;FIRMWARE_MODBUS_ver_0_4_0.c,156 :: 		void ud_write_uart1(char *_string){
;FIRMWARE_MODBUS_ver_0_4_0.c,157 :: 		while(*_string){
L_ud_write_uart110:
	MOVFF       FARG_ud_write_uart1__string+0, FSR0L+0
	MOVFF       FARG_ud_write_uart1__string+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ud_write_uart111
;FIRMWARE_MODBUS_ver_0_4_0.c,158 :: 		TX1REG = *_string;
	MOVFF       FARG_ud_write_uart1__string+0, FSR0L+0
	MOVFF       FARG_ud_write_uart1__string+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       TX1REG+0 
;FIRMWARE_MODBUS_ver_0_4_0.c,159 :: 		*_string++;
	INFSNZ      FARG_ud_write_uart1__string+0, 1 
	INCF        FARG_ud_write_uart1__string+1, 1 
;FIRMWARE_MODBUS_ver_0_4_0.c,160 :: 		}
	GOTO        L_ud_write_uart110
L_ud_write_uart111:
;FIRMWARE_MODBUS_ver_0_4_0.c,161 :: 		}
L_end_ud_write_uart1:
	RETURN      0
; end of _ud_write_uart1
