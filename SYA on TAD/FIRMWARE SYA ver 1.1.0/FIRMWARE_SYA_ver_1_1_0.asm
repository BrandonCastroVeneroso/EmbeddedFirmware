
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
	GOTO        L__interrupt193
	MOVLW       50
	SUBWF       _counter+0, 0 
L__interrupt193:
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
L__interrupt159:
	BCF         IOCCF+0, 0 
	BSF         _interruptC0+0, BitPos(_interruptC0+0) 
L_interrupt4:
	BTFSS       IOCCF+0, 1 
	GOTO        L_interrupt7
	BTFSS       IOCIE_bit+0, BitPos(IOCIE_bit+0) 
	GOTO        L_interrupt7
L__interrupt158:
	BCF         IOCCF+0, 1 
	BSF         _interruptC1+0, BitPos(_interruptC1+0) 
L_interrupt7:
L_end_interrupt:
L__interrupt192:
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
L__main160:
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
	BCF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM20
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM20
L__FSM190:
	MOVLW       10
	MOVWF       _next_state+0 
	GOTO        L_FSM21
L_FSM20:
	CLRF        _next_state+0 
L_FSM21:
	GOTO        L_FSM16
L_FSM22:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BCF         LATE+0, 2 
	BSF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM25
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM25
L__FSM189:
	CLRF        _next_state+0 
	GOTO        L_FSM26
L_FSM25:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM29
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM29
L__FSM188:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM30
L_FSM29:
	MOVLW       1
	MOVWF       _next_state+0 
L_FSM30:
L_FSM26:
	GOTO        L_FSM16
L_FSM31:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BSF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM34
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM34
L__FSM187:
	CLRF        _next_state+0 
	GOTO        L_FSM35
L_FSM34:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM38
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM38
L__FSM186:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM39
L_FSM38:
	MOVLW       2
	MOVWF       _next_state+0 
L_FSM39:
L_FSM35:
	GOTO        L_FSM16
L_FSM40:
	BCF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BSF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM43
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM43
L__FSM185:
	CLRF        _next_state+0 
	GOTO        L_FSM44
L_FSM43:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM47
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM47
L__FSM184:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM48
L_FSM47:
	MOVLW       3
	MOVWF       _next_state+0 
L_FSM48:
L_FSM44:
	GOTO        L_FSM16
L_FSM49:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BSF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM52
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM52
L__FSM183:
	CLRF        _next_state+0 
	GOTO        L_FSM53
L_FSM52:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM56
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM56
L__FSM182:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM57
L_FSM56:
	MOVLW       4
	MOVWF       _next_state+0 
L_FSM57:
L_FSM53:
	GOTO        L_FSM16
L_FSM58:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BSF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM61
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM61
L__FSM181:
	CLRF        _next_state+0 
	GOTO        L_FSM62
L_FSM61:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM65
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM65
L__FSM180:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM66
L_FSM65:
	MOVLW       5
	MOVWF       _next_state+0 
L_FSM66:
L_FSM62:
	GOTO        L_FSM16
L_FSM67:
	BSF         LATA+0, 5 
	BCF         LATE+0, 0 
	BSF         LATE+0, 1 
	BCF         LATE+0, 2 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BSF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM70
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM70
L__FSM179:
	CLRF        _next_state+0 
	GOTO        L_FSM71
L_FSM70:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM74
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM74
L__FSM178:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM75
L_FSM74:
	MOVLW       6
	MOVWF       _next_state+0 
L_FSM75:
L_FSM71:
	GOTO        L_FSM16
L_FSM76:
	BCF         LATA+0, 5 
	BSF         LATE+0, 0 
	BCF         LATE+0, 1 
	BSF         LATE+0, 2 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM79
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM79
L__FSM177:
	CLRF        _next_state+0 
	GOTO        L_FSM80
L_FSM79:
	BTFSS       _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	GOTO        L_FSM83
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM83
L__FSM176:
	MOVLW       8
	MOVWF       _next_state+0 
	GOTO        L_FSM84
L_FSM83:
	MOVLW       7
	MOVWF       _next_state+0 
L_FSM84:
L_FSM80:
	GOTO        L_FSM16
L_FSM85:
	BSF         LATA+0, 5 
	BSF         LATE+0, 0 
	BSF         LATE+0, 1 
	BSF         LATE+0, 2 
	BTFSS       _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_FSM88
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM88
L__FSM175:
	CLRF        _next_state+0 
	GOTO        L_FSM89
L_FSM88:
	BTFSS       _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_FSM92
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM92
L__FSM174:
	MOVLW       5
	MOVWF       _next_state+0 
	BSF         _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM93
L_FSM92:
	MOVLW       8
	MOVWF       _next_state+0 
L_FSM93:
L_FSM89:
	GOTO        L_FSM16
L_FSM94:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM97
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM97
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM97
L__FSM173:
	MOVLW       2
	MOVWF       _next_state+0 
	GOTO        L_FSM98
L_FSM97:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM101
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM101
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM101
L__FSM172:
	MOVLW       3
	MOVWF       _next_state+0 
	GOTO        L_FSM102
L_FSM101:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM105
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM105
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM105
L__FSM171:
	MOVLW       4
	MOVWF       _next_state+0 
	GOTO        L_FSM106
L_FSM105:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM109
	BTFSS       _GT4+0, BitPos(_GT4+0) 
	GOTO        L_FSM109
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM109
L__FSM170:
	MOVLW       5
	MOVWF       _next_state+0 
	GOTO        L_FSM110
L_FSM109:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM113
	BTFSS       _GT5+0, BitPos(_GT5+0) 
	GOTO        L_FSM113
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM113
L__FSM169:
	MOVLW       6
	MOVWF       _next_state+0 
	GOTO        L_FSM114
L_FSM113:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM117
	BTFSS       _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM117
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM117
L__FSM168:
	MOVLW       7
	MOVWF       _next_state+0 
	GOTO        L_FSM118
L_FSM117:
	BTFSS       _sn_GoTo+0, BitPos(_sn_GoTo+0) 
	GOTO        L_FSM121
	BTFSS       _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM121
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM121
L__FSM167:
	MOVLW       1
	MOVWF       _next_state+0 
	GOTO        L_FSM122
L_FSM121:
	MOVLW       8
	MOVWF       _next_state+0 
L_FSM122:
L_FSM118:
L_FSM114:
L_FSM110:
L_FSM106:
L_FSM102:
L_FSM98:
	GOTO        L_FSM16
L_FSM123:
	BTFSS       _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	GOTO        L_FSM124
	BTFSS       _GT1+0, BitPos(_GT1+0) 
	GOTO        L_FSM127
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM127
L__FSM166:
	MOVLW       2
	MOVWF       _next_state+0 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM128
L_FSM127:
	BTFSS       _GT2+0, BitPos(_GT2+0) 
	GOTO        L_FSM131
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM131
L__FSM165:
	MOVLW       3
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM132
L_FSM131:
	BTFSS       _GT3+0, BitPos(_GT3+0) 
	GOTO        L_FSM135
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM135
L__FSM164:
	MOVLW       4
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM136
L_FSM135:
	BTFSS       _GT4+0, BitPos(_GT4+0) 
	GOTO        L_FSM139
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM139
L__FSM163:
	MOVLW       5
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM140
L_FSM139:
	BTFSS       _GT5+0, BitPos(_GT5+0) 
	GOTO        L_FSM143
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM143
L__FSM162:
	MOVLW       6
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
	GOTO        L_FSM144
L_FSM143:
	BTFSS       _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM147
	BTFSS       _clock0+0, BitPos(_clock0+0) 
	GOTO        L_FSM147
L__FSM161:
	MOVLW       7
	MOVWF       _next_state+0 
	BCF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	GOTO        L_FSM148
L_FSM147:
	MOVLW       10
	MOVWF       _next_state+0 
L_FSM148:
L_FSM144:
L_FSM140:
L_FSM136:
L_FSM132:
L_FSM128:
L_FSM124:
	GOTO        L_FSM16
L_FSM149:
	BSF         _GT1+0, BitPos(_GT1+0) 
	BCF         _GT2+0, BitPos(_GT2+0) 
	BCF         _GT3+0, BitPos(_GT3+0) 
	BCF         _GT4+0, BitPos(_GT4+0) 
	BCF         _GT5+0, BitPos(_GT5+0) 
	BCF         _GT6+0, BitPos(_GT6+0) 
	BCF         _GT7+0, BitPos(_GT7+0) 
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
	GOTO        L_FSM31
	MOVF        _current_state+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM40
	MOVF        _current_state+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM49
	MOVF        _current_state+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM58
	MOVF        _current_state+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM67
	MOVF        _current_state+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM76
	MOVF        _current_state+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM85
	MOVF        _current_state+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM94
	MOVF        _current_state+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_FSM123
	GOTO        L_FSM149
L_FSM16:
L_end_FSM:
	RETURN      0
; end of _FSM

_Events:

	BTFSS       _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events150
	BTFSS       PORTC+0, 0 
	GOTO        L_Events151
	BCF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BSF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
	GOTO        L_Events152
L_Events151:
	BSF         _sn_PosEdge_1+0, BitPos(_sn_PosEdge_1+0) 
	BCF         _sn_NegEdge_1+0, BitPos(_sn_NegEdge_1+0) 
L_Events152:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	GOTO        L_Events153
L_Events150:
	BTFSS       _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events154
	BTFSS       PORTC+0, 1 
	GOTO        L_Events155
	BCF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BSF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
	GOTO        L_Events156
L_Events155:
	BSF         _sn_PosEdge_2+0, BitPos(_sn_PosEdge_2+0) 
	BCF         _sn_NegEdge_2+0, BitPos(_sn_NegEdge_2+0) 
L_Events156:
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
	GOTO        L_Events157
L_Events154:
	BCF         _interruptC0+0, BitPos(_interruptC0+0) 
	BCF         _interruptC1+0, BitPos(_interruptC1+0) 
L_Events157:
L_Events153:
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
