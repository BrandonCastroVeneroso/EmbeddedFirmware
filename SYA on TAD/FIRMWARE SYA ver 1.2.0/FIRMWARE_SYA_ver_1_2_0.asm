
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
	MOVLW       128
	XORWF       _counter+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt311
	MOVLW       100
	SUBWF       _counter+0, 0 
L__interrupt311:
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
L__interrupt264:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt4:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt263:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt7:
L_end_interrupt:
L__interrupt310:
	RETFIE      1
; end of _interrupt

_main:

	CALL        _InitInterrupt+0, 0
	CALL        _InitMCU+0, 0
L_main8:
	CALL        _Events+0, 0
	BTFSC       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_main8
	BTFSC       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_main8
L__main265:
L_main13:
	MOVF        _next_state+0, 0 
	MOVWF       _current_state+0 
	CALL        _FSM+0, 0
	GOTO        L_main13
L_end_main:
	GOTO        $+0
; end of _main

_FSM:

	GOTO        L_FSM15
L_FSM17:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM20
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM20
L__FSM308:
	MOVLW       13
	MOVWF       _next_state+0 
	GOTO        L_FSM21
L_FSM20:
	CLRF        _next_state+0 
L_FSM21:
	GOTO        L_FSM16
L_FSM22:
	GOTO        L_FSM23
L_FSM25:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM24
L_FSM26:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM24
L_FSM27:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM24
L_FSM23:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM314
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM314:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM25
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM315
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM315:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM26
	GOTO        L_FSM27
L_FSM24:
	BSF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM30
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM30
L__FSM307:
	CLRF        _next_state+0 
	GOTO        L_FSM31
L_FSM30:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM34
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM34
L__FSM306:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM35
L_FSM34:
	MOVLW       1
	MOVWF       _next_state+0 
L_FSM35:
L_FSM31:
	GOTO        L_FSM16
L_FSM36:
	GOTO        L_FSM37
L_FSM39:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM38
L_FSM40:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM38
L_FSM41:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM38
L_FSM37:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM316
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM316:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM39
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM317
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM317:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM40
	GOTO        L_FSM41
L_FSM38:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BSF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM44
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM44
L__FSM305:
	CLRF        _next_state+0 
	GOTO        L_FSM45
L_FSM44:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM48
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM48
L__FSM304:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM49
L_FSM48:
	MOVLW       2
	MOVWF       _next_state+0 
L_FSM49:
L_FSM45:
	GOTO        L_FSM16
L_FSM50:
	GOTO        L_FSM51
L_FSM53:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM52
L_FSM54:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM52
L_FSM55:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM52
L_FSM51:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM318
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM318:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM53
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM319
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM319:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM54
	GOTO        L_FSM55
L_FSM52:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BSF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM58
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM58
L__FSM303:
	CLRF        _next_state+0 
	GOTO        L_FSM59
L_FSM58:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM62
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM62
L__FSM302:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM63
L_FSM62:
	MOVLW       3
	MOVWF       _next_state+0 
L_FSM63:
L_FSM59:
	GOTO        L_FSM16
L_FSM64:
	GOTO        L_FSM65
L_FSM67:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM66
L_FSM68:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM66
L_FSM69:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM66
L_FSM65:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM320
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM320:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM67
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM321
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM321:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM68
	GOTO        L_FSM69
L_FSM66:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BSF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM72
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM72
L__FSM301:
	CLRF        _next_state+0 
	GOTO        L_FSM73
L_FSM72:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM76
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM76
L__FSM300:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM77
L_FSM76:
	MOVLW       4
	MOVWF       _next_state+0 
L_FSM77:
L_FSM73:
	GOTO        L_FSM16
L_FSM78:
	GOTO        L_FSM79
L_FSM81:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM80
L_FSM82:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM80
L_FSM83:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM80
L_FSM79:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM322
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM322:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM81
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM323
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM323:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM82
	GOTO        L_FSM83
L_FSM80:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BSF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM86
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM86
L__FSM299:
	CLRF        _next_state+0 
	GOTO        L_FSM87
L_FSM86:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM90
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM90
L__FSM298:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM91
L_FSM90:
	MOVLW       5
	MOVWF       _next_state+0 
L_FSM91:
L_FSM87:
	GOTO        L_FSM16
L_FSM92:
	GOTO        L_FSM93
L_FSM95:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM94
L_FSM96:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM94
L_FSM97:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM94
L_FSM93:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM324
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM324:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM95
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM325
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM325:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM96
	GOTO        L_FSM97
L_FSM94:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BSF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM100
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM100
L__FSM297:
	CLRF        _next_state+0 
	GOTO        L_FSM101
L_FSM100:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM104
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM104
L__FSM296:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM105
L_FSM104:
	MOVLW       6
	MOVWF       _next_state+0 
L_FSM105:
L_FSM101:
	GOTO        L_FSM16
L_FSM106:
	GOTO        L_FSM107
L_FSM109:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM108
L_FSM110:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM108
L_FSM111:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM108
L_FSM107:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM326
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM326:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM109
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM327
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM327:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM110
	GOTO        L_FSM111
L_FSM108:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BSF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM114
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM114
L__FSM295:
	CLRF        _next_state+0 
	GOTO        L_FSM115
L_FSM114:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM118
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM118
L__FSM294:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM119
L_FSM118:
	MOVLW       7
	MOVWF       _next_state+0 
L_FSM119:
L_FSM115:
	GOTO        L_FSM16
L_FSM120:
	GOTO        L_FSM121
L_FSM123:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM122
L_FSM124:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM122
L_FSM125:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM122
L_FSM121:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM328
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM328:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM123
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM329
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM329:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM124
	GOTO        L_FSM125
L_FSM122:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BSF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM128
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM128
L__FSM293:
	CLRF        _next_state+0 
	GOTO        L_FSM129
L_FSM128:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM132
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM132
L__FSM292:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM133
L_FSM132:
	MOVLW       8
	MOVWF       _next_state+0 
L_FSM133:
L_FSM129:
	GOTO        L_FSM16
L_FSM134:
	GOTO        L_FSM135
L_FSM137:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM136
L_FSM138:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM136
L_FSM139:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM136
L_FSM135:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM330
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM330:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM137
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM331
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM331:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM138
	GOTO        L_FSM139
L_FSM136:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BSF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM142
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM142
L__FSM291:
	CLRF        _next_state+0 
	GOTO        L_FSM143
L_FSM142:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM146
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM146
L__FSM290:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM147
L_FSM146:
	MOVLW       9
	MOVWF       _next_state+0 
L_FSM147:
L_FSM143:
	GOTO        L_FSM16
L_FSM148:
	GOTO        L_FSM149
L_FSM151:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM150
L_FSM152:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	GOTO        L_FSM150
L_FSM153:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         LATB+0, 0 
	GOTO        L_FSM150
L_FSM149:
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM332
	MOVLW       2
	XORWF       _num+0, 0 
L__FSM332:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM151
	MOVLW       0
	XORWF       _num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__FSM333
	MOVLW       3
	XORWF       _num+0, 0 
L__FSM333:
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM152
	GOTO        L_FSM153
L_FSM150:
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BSF         _GT10+0, BitPos(_GT10+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM156
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM156
L__FSM289:
	CLRF        _next_state+0 
	GOTO        L_FSM157
L_FSM156:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM160
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM160
L__FSM288:
	MOVLW       11
	MOVWF       _next_state+0 
	GOTO        L_FSM161
L_FSM160:
	MOVLW       10
	MOVWF       _next_state+0 
L_FSM161:
L_FSM157:
	GOTO        L_FSM16
L_FSM162:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         LATB+0, 0 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM165
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM165
L__FSM287:
	CLRF        _next_state+0 
	GOTO        L_FSM166
L_FSM165:
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM169
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM169
L__FSM286:
	MOVLW       12
	MOVWF       _next_state+0 
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM170
L_FSM169:
	MOVLW       11
	MOVWF       _next_state+0 
L_FSM170:
L_FSM166:
	GOTO        L_FSM16
L_FSM171:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM174
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM174
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM174
L__FSM285:
	MOVLW       2
	MOVWF       _next_state+0 
	GOTO        L_FSM175
L_FSM174:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM178
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM178
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM178
L__FSM284:
	MOVLW       3
	MOVWF       _next_state+0 
	GOTO        L_FSM179
L_FSM178:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM182
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM182
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM182
L__FSM283:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_FSM183
L_FSM182:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM186
	BTFSS       _GT4+0, BitPos(_GT4+0) 
	GOTO        L_FSM186
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM186
L__FSM282:
	MOVLW       5
	MOVWF       _next_state+0 
	GOTO        L_FSM187
L_FSM186:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM190
	BTFSS       _GT5+0, BitPos(_GT5+0) 
	GOTO        L_FSM190
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM190
L__FSM281:
	MOVLW       6
	MOVWF       _next_state+0 
	GOTO        L_FSM191
L_FSM190:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM194
	BTFSS       _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM194
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM194
L__FSM280:
	MOVLW       7
	MOVWF       _next_state+0 
	GOTO        L_FSM195
L_FSM194:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM198
	BTFSS       _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM198
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM198
L__FSM279:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM199
L_FSM198:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM202
	BTFSS       _GT8+0, BitPos(_GT8+0) 
	GOTO        L_FSM202
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM202
L__FSM278:
	MOVLW       9
	MOVWF       _next_state+0 
	GOTO        L_FSM203
L_FSM202:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM206
	BTFSS       _GT9+0, BitPos(_GT9+0) 
	GOTO        L_FSM206
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM206
L__FSM277:
	MOVLW       10
	MOVWF       _next_state+0 
	GOTO        L_FSM207
L_FSM206:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM210
	BTFSS       _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM210
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM210
L__FSM276:
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_FSM211
L_FSM210:
	MOVLW       11
	MOVWF       _next_state+0 
L_FSM211:
L_FSM207:
L_FSM203:
L_FSM199:
L_FSM195:
L_FSM191:
L_FSM187:
L_FSM183:
L_FSM179:
L_FSM175:
	GOTO        L_FSM16
L_FSM212:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM213
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM216
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM216
L__FSM275:
	MOVLW       2
	MOVWF       _next_state+0 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM217
L_FSM216:
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM220
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM220
L__FSM274:
	MOVLW       3
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM221
L_FSM220:
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM224
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM224
L__FSM273:
	MOVLW       4
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM225
L_FSM224:
	BTFSS       _GT4+0, BitPos(_GT4+0) 
	GOTO        L_FSM228
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM228
L__FSM272:
	MOVLW       5
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM229
L_FSM228:
	BTFSS       _GT5+0, BitPos(_GT5+0) 
	GOTO        L_FSM232
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM232
L__FSM271:
	MOVLW       6
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM233
L_FSM232:
	BTFSS       _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM236
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM236
L__FSM270:
	MOVLW       7
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM237
L_FSM236:
	BTFSS       _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM240
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM240
L__FSM269:
	MOVLW       8
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM241
L_FSM240:
	BTFSS       _GT8+0, BitPos(_GT8+0) 
	GOTO        L_FSM244
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM244
L__FSM268:
	MOVLW       9
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM245
L_FSM244:
	BTFSS       _GT9+0, BitPos(_GT9+0) 
	GOTO        L_FSM248
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM248
L__FSM267:
	MOVLW       10
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	GOTO        L_FSM249
L_FSM248:
	BTFSS       _GT10+0, BitPos(_GT10+0) 
	GOTO        L_FSM252
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM252
L__FSM266:
	MOVLW       1
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	GOTO        L_FSM253
L_FSM252:
	MOVLW       10
	MOVWF       _next_state+0 
L_FSM253:
L_FSM249:
L_FSM245:
L_FSM241:
L_FSM237:
L_FSM233:
L_FSM229:
L_FSM225:
L_FSM221:
L_FSM217:
L_FSM213:
	GOTO        L_FSM16
L_FSM254:
	BSF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BCF         _GT8+0, BitPos(_GT8+0) 
	BCF         _GT9+0, BitPos(_GT9+0) 
	BCF         _GT10+0, BitPos(_GT10+0) 
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	CLRF        _current_state+0 
	CLRF        _next_state+0 
	GOTO        L_FSM16
L_FSM15:
	MOVF        _current_state+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM17
	MOVF        _current_state+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM22
	MOVF        _current_state+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM36
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM50
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM64
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM78
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM92
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM106
	MOVF        _current_state+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM120
	MOVF        _current_state+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM134
	MOVF        _current_state+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM148
	MOVF        _current_state+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM162
	MOVF        _current_state+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM171
	MOVF        _current_state+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM212
	GOTO        L_FSM254
L_FSM16:
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events255
	BTFSS       PORTC+0, 0 
	GOTO        L_Events256
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events257
L_Events256:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events257:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events258
L_Events255:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events259
	BTFSS       PORTC+0, 1 
	GOTO        L_Events260
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events261
L_Events260:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events261:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events262
L_Events259:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events262:
L_Events258:
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
