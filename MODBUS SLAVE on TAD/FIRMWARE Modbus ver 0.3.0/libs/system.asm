
_DeviceConfig:

;system.c,28 :: 		void DeviceConfig(){
;system.c,29 :: 		LATA = 0x10; // #7 (LED), !6, !5, !4, !3, !2, !1, !0
	MOVLW       16
	MOVWF       LATA+0 
;system.c,30 :: 		LATB = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
	CLRF        LATB+0 
;system.c,31 :: 		LATC = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
	CLRF        LATC+0 
;system.c,32 :: 		LATD = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
	CLRF        LATD+0 
;system.c,33 :: 		LATE = 0x00; // !7, !6, !5, !4, !3, !2, !1, !0
	CLRF        LATE+0 
;system.c,35 :: 		TRISA = 0xCF; // #7 (OSC1), #6 (OSC2), !5 (RELE 1), !4 (LED), #3 (ANA_INPUT 4), #2 (ANA_INPUT 3), #1 (ANA_INPUT 2), #0 (ANA_INPUT 1)
	MOVLW       207
	MOVWF       TRISA+0 
;system.c,36 :: 		TRISB = 0xC8; // #7 (ICSPD), #6 (ICSPC), !5 (ANA_OUTPUT 4), !4 (TX), #3 (RX), !2 (ANA_OUTPUT 3), !1 (ANA_OUTPUT 2), !0 (ANA_OUTPUT 1)
	MOVLW       200
	MOVWF       TRISB+0 
;system.c,37 :: 		TRISC = 0xFF; // DIG 1 - 16
	MOVLW       255
	MOVWF       TRISC+0 
;system.c,38 :: 		TRISD = 0xFF; // Input
	MOVLW       255
	MOVWF       TRISD+0 
;system.c,39 :: 		TRISE = 0x00; // ~[7,6,5,4,3], !2 (RELE 4), !1 (RELE 3), !0 (RELE 2)
	CLRF        TRISE+0 
;system.c,41 :: 		ANSELA = 0xCF; // #7 (OSC1), #6 (OSC2), !5 (RELE 1), !4 (LED), #3 (ANA_INPUT 4), #2 (ANA_INPUT 3), #1 (ANA_INPUT 2), #0 (ANA_INPUT 1)
	MOVLW       207
	MOVWF       ANSELA+0 
;system.c,42 :: 		ANSELB = 0xC0; // #7 (ICSPD), #6 (ICSPC), !5 (ANA_OUTPUT 4), !4 (TX), !3 (RX), !2 (ANA_OUTPUT 3), !1 (ANA_OUTPUT 2), !0 (ANA_OUTPUT 1)
	MOVLW       192
	MOVWF       ANSELB+0 
;system.c,43 :: 		ANSELC = 0x00; // DIG 1 - 16
	CLRF        ANSELC+0 
;system.c,44 :: 		ANSELD = 0x00; // Digital
	CLRF        ANSELD+0 
;system.c,45 :: 		ANSELE = 0x00; // RELE 4 - 2
	CLRF        ANSELE+0 
;system.c,47 :: 		WPUA = 0x00; //
	CLRF        WPUA+0 
;system.c,48 :: 		WPUB = 0x00; //
	CLRF        WPUB+0 
;system.c,49 :: 		WPUC = 0x00; // Desactivamos los Weak-PullUps
	CLRF        WPUC+0 
;system.c,50 :: 		WPUD = 0x00; //
	CLRF        WPUD+0 
;system.c,51 :: 		WPUE = 0x00; //
	CLRF        WPUE+0 
;system.c,53 :: 		SLRCONA = 0xFF; //
	MOVLW       255
	MOVWF       SLRCONA+0 
;system.c,54 :: 		SLRCONB = 0xFF; //
	MOVLW       255
	MOVWF       SLRCONB+0 
;system.c,55 :: 		SLRCONC = 0xFF; // Dejamos el limite de SlewRate
	MOVLW       255
	MOVWF       SLRCONC+0 
;system.c,56 :: 		SLRCOND = 0xFF; //
	MOVLW       255
	MOVWF       SLRCOND+0 
;system.c,57 :: 		SLRCONE = 0x07; //
	MOVLW       7
	MOVWF       SLRCONE+0 
;system.c,59 :: 		INLVLA = 0xFF; //
	MOVLW       255
	MOVWF       INLVLA+0 
;system.c,60 :: 		INLVLB = 0xFF; //
	MOVLW       255
	MOVWF       INLVLB+0 
;system.c,61 :: 		INLVLC = 0xFF; // Dejamos los niveles TTL
	MOVLW       255
	MOVWF       INLVLC+0 
;system.c,62 :: 		INLVLD = 0xFF; //
	MOVLW       255
	MOVWF       INLVLD+0 
;system.c,63 :: 		INLVLE = 0x07; //
	MOVLW       7
	MOVWF       INLVLE+0 
;system.c,65 :: 		RB4PPS = 0x09; // TX1 --> RB4
	MOVLW       9
	MOVWF       RB4PPS+0 
;system.c,66 :: 		RX1PPS = 0x0B; // RX1 --> RB3
	MOVLW       11
	MOVWF       RX1PPS+0 
;system.c,67 :: 		}
L_end_DeviceConfig:
	RETURN      0
; end of _DeviceConfig

_ClockConfig:

;system.c,69 :: 		void ClockConfig(){
;system.c,70 :: 		OSCCON1 = 0x70;   // ~7, [#6, #5, #4] = EXTOSC, ![3, 2, 1, 0]
	MOVLW       112
	MOVWF       OSCCON1+0 
;system.c,71 :: 		OSCEN = 0x80;     // #7(EXTOEN), !6, !5, !4, !3, !2, #1, #0
	MOVLW       128
	MOVWF       OSCEN+0 
;system.c,72 :: 		}
L_end_ClockConfig:
	RETURN      0
; end of _ClockConfig

_InitEUSART:

;system.c,74 :: 		void InitEUSART(){
;system.c,75 :: 		UART1_Remappable_Init(19200); // EUSART 1 con 19200 baud
	BSF         BAUDCON+0, 3, 0
	MOVLW       3
	MOVWF       SPBRG+0 
	MOVLW       1
	MOVWF       SPBRG+1 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Remappable_Init+0, 0
;system.c,76 :: 		}
L_end_InitEUSART:
	RETURN      0
; end of _InitEUSART

_InterruptConfig:

;system.c,78 :: 		void InterruptConfig(){
;system.c,79 :: 		INTCON = 0xC0; // GIE = 1, PIE = 1
	MOVLW       192
	MOVWF       INTCON+0 
;system.c,81 :: 		T0CON0 = 0x90;
	MOVLW       144
	MOVWF       T0CON0+0 
;system.c,82 :: 		T0CON1 = 0x43;
	MOVLW       67
	MOVWF       T0CON1+0 
;system.c,83 :: 		TMR0H = 0xB;
	MOVLW       11
	MOVWF       TMR0H+0 
;system.c,84 :: 		TMR0L = 0xDC;
	MOVLW       220
	MOVWF       TMR0L+0 
;system.c,86 :: 		T2CLKCON = 0x01;
	MOVLW       1
	MOVWF       T2CLKCON+0 
;system.c,87 :: 		T2HLT = 0x00;
	CLRF        T2HLT+0 
;system.c,88 :: 		T2RST = 0x00;
	CLRF        T2RST+0 
;system.c,89 :: 		T2PR = 0x4D;
	MOVLW       77
	MOVWF       T2PR+0 
;system.c,90 :: 		T2TMR = 0x00;
	CLRF        T2TMR+0 
;system.c,91 :: 		T2CON = 0xE0;
	MOVLW       224
	MOVWF       T2CON+0 
;system.c,93 :: 		PIR0 = 0x00;
	CLRF        PIR0+0 
;system.c,94 :: 		PIE3 = 0x20; // RC1IE = 1 (EUSART 1 RX)
	MOVLW       32
	MOVWF       PIE3+0 
;system.c,95 :: 		PIR3 = 0x00;
	CLRF        PIR3+0 
;system.c,96 :: 		PIR4 = 0x00;
	CLRF        PIR4+0 
;system.c,97 :: 		}
L_end_InterruptConfig:
	RETURN      0
; end of _InterruptConfig

_InitSystem:

;system.c,99 :: 		void InitSystem(){
;system.c,100 :: 		InterruptConfig();
	CALL        _InterruptConfig+0, 0
;system.c,101 :: 		DeviceConfig();
	CALL        _DeviceConfig+0, 0
;system.c,102 :: 		ClockConfig();
	CALL        _ClockConfig+0, 0
;system.c,103 :: 		InitEUSART();
	CALL        _InitEUSART+0, 0
;system.c,104 :: 		}
L_end_InitSystem:
	RETURN      0
; end of _InitSystem

_EnableTimer0:

;system.c,106 :: 		void EnableTimer0(){
;system.c,107 :: 		PIE0.TMR0IE = 1;
	BSF         PIE0+0, 5 
;system.c,108 :: 		}
L_end_EnableTimer0:
	RETURN      0
; end of _EnableTimer0
