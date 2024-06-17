
_stringToFloat:

;convert.c,3 :: 		float stringToFloat(char *_string){
;convert.c,5 :: 		result = (_string[0] - 0x30) * 1000;
	MOVF        FARG_stringToFloat__string+0, 0 
	MOVWF       FSR0L+0 
	MOVF        FARG_stringToFloat__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       stringToFloat_result_L0+0 
	MOVF        R1, 0 
	MOVWF       stringToFloat_result_L0+1 
	MOVF        R2, 0 
	MOVWF       stringToFloat_result_L0+2 
	MOVF        R3, 0 
	MOVWF       stringToFloat_result_L0+3 
;convert.c,6 :: 		result += (_string[1] - 0x30) * 100;
	MOVLW       1
	ADDWF       FARG_stringToFloat__string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_stringToFloat__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	CALL        _int2double+0, 0
	MOVF        stringToFloat_result_L0+0, 0 
	MOVWF       R4 
	MOVF        stringToFloat_result_L0+1, 0 
	MOVWF       R5 
	MOVF        stringToFloat_result_L0+2, 0 
	MOVWF       R6 
	MOVF        stringToFloat_result_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       stringToFloat_result_L0+0 
	MOVF        R1, 0 
	MOVWF       stringToFloat_result_L0+1 
	MOVF        R2, 0 
	MOVWF       stringToFloat_result_L0+2 
	MOVF        R3, 0 
	MOVWF       stringToFloat_result_L0+3 
;convert.c,7 :: 		result += (_string[2] - 0x30) * 10;
	MOVLW       2
	ADDWF       FARG_stringToFloat__string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_stringToFloat__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	CALL        _int2double+0, 0
	MOVF        stringToFloat_result_L0+0, 0 
	MOVWF       R4 
	MOVF        stringToFloat_result_L0+1, 0 
	MOVWF       R5 
	MOVF        stringToFloat_result_L0+2, 0 
	MOVWF       R6 
	MOVF        stringToFloat_result_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       stringToFloat_result_L0+0 
	MOVF        R1, 0 
	MOVWF       stringToFloat_result_L0+1 
	MOVF        R2, 0 
	MOVWF       stringToFloat_result_L0+2 
	MOVF        R3, 0 
	MOVWF       stringToFloat_result_L0+3 
;convert.c,8 :: 		result += (_string[3] - 0x30) * 1;
	MOVLW       3
	ADDWF       FARG_stringToFloat__string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_stringToFloat__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	CALL        _int2double+0, 0
	MOVF        stringToFloat_result_L0+0, 0 
	MOVWF       R4 
	MOVF        stringToFloat_result_L0+1, 0 
	MOVWF       R5 
	MOVF        stringToFloat_result_L0+2, 0 
	MOVWF       R6 
	MOVF        stringToFloat_result_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       stringToFloat_result_L0+0 
	MOVF        R1, 0 
	MOVWF       stringToFloat_result_L0+1 
	MOVF        R2, 0 
	MOVWF       stringToFloat_result_L0+2 
	MOVF        R3, 0 
	MOVWF       stringToFloat_result_L0+3 
;convert.c,9 :: 		result = result / 100;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        stringToFloat_result_L0+0, 0 
	MOVWF       R0 
	MOVF        stringToFloat_result_L0+1, 0 
	MOVWF       R1 
	MOVF        stringToFloat_result_L0+2, 0 
	MOVWF       R2 
	MOVF        stringToFloat_result_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       stringToFloat_result_L0+0 
	MOVF        R1, 0 
	MOVWF       stringToFloat_result_L0+1 
	MOVF        R2, 0 
	MOVWF       stringToFloat_result_L0+2 
	MOVF        R3, 0 
	MOVWF       stringToFloat_result_L0+3 
;convert.c,10 :: 		return result;
	MOVF        stringToFloat_result_L0+0, 0 
	MOVWF       R0 
	MOVF        stringToFloat_result_L0+1, 0 
	MOVWF       R1 
	MOVF        stringToFloat_result_L0+2, 0 
	MOVWF       R2 
	MOVF        stringToFloat_result_L0+3, 0 
	MOVWF       R3 
;convert.c,11 :: 		}
L_end_stringToFloat:
	RETURN      0
; end of _stringToFloat

_stringToInt:

;convert.c,13 :: 		unsigned int stringToInt(char *_string){
;convert.c,15 :: 		result = (_string[0] - 0x30) * 1000;
	MOVF        FARG_stringToInt__string+0, 0 
	MOVWF       FSR0L+0 
	MOVF        FARG_stringToInt__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       stringToInt_result_L0+0 
	MOVF        R1, 0 
	MOVWF       stringToInt_result_L0+1 
;convert.c,16 :: 		result += (_string[1] - 0x30) * 100;
	MOVLW       1
	ADDWF       FARG_stringToInt__string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_stringToInt__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       stringToInt_result_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      stringToInt_result_L0+1, 1 
;convert.c,17 :: 		result += (_string[2] - 0x30) * 10;
	MOVLW       2
	ADDWF       FARG_stringToInt__string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_stringToInt__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       stringToInt_result_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      stringToInt_result_L0+1, 1 
;convert.c,18 :: 		result += (_string[3] - 0x30) * 1;
	MOVLW       3
	ADDWF       FARG_stringToInt__string+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_stringToInt__string+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       stringToInt_result_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      stringToInt_result_L0+1, 1 
;convert.c,19 :: 		return result;
	MOVF        stringToInt_result_L0+0, 0 
	MOVWF       R0 
	MOVF        stringToInt_result_L0+1, 0 
	MOVWF       R1 
;convert.c,20 :: 		}
L_end_stringToInt:
	RETURN      0
; end of _stringToInt

_udintToStr:

;convert.c,22 :: 		void udintToStr(char *_string, int number){
;convert.c,23 :: 		char position = 4;
	MOVLW       4
	MOVWF       udintToStr_position_L0+0 
;convert.c,24 :: 		_string[position] = 0x00;
	MOVF        udintToStr_position_L0+0, 0 
	ADDWF       FARG_udintToStr__string+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_udintToStr__string+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;convert.c,25 :: 		do{
L_udintToStr0:
;convert.c,26 :: 		_string[position - 1] = number % 10 + 0x30;
	DECF        udintToStr_position_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_udintToStr__string+0, 0 
	MOVWF       FLOC__udintToStr+0 
	MOVF        R1, 0 
	ADDWFC      FARG_udintToStr__string+1, 0 
	MOVWF       FLOC__udintToStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_udintToStr_number+0, 0 
	MOVWF       R0 
	MOVF        FARG_udintToStr_number+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__udintToStr+0, FSR1L+0
	MOVFF       FLOC__udintToStr+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;convert.c,27 :: 		number = number / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_udintToStr_number+0, 0 
	MOVWF       R0 
	MOVF        FARG_udintToStr_number+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_udintToStr_number+0 
	MOVF        R1, 0 
	MOVWF       FARG_udintToStr_number+1 
;convert.c,28 :: 		position--;
	DECF        udintToStr_position_L0+0, 1 
;convert.c,29 :: 		}while(position);
	MOVF        udintToStr_position_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_udintToStr0
;convert.c,30 :: 		}
L_end_udintToStr:
	RETURN      0
; end of _udintToStr

_uint32ToStr:

;convert.c,32 :: 		void uint32ToStr(char *_high, char *_low, long int _result){
;convert.c,34 :: 		char position = 8;
	MOVLW       8
	MOVWF       uint32ToStr_position_L0+0 
;convert.c,35 :: 		Aux[8] = 0x00;
	CLRF        uint32ToStr_Aux_L0+8 
;convert.c,36 :: 		do{
L_uint32ToStr3:
;convert.c,37 :: 		Aux[position - 1] = _result % 10 + 0x30;
	DECF        uint32ToStr_position_L0+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       uint32ToStr_Aux_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__uint32ToStr+0 
	MOVLW       hi_addr(uint32ToStr_Aux_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__uint32ToStr+1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_uint32ToStr__result+0, 0 
	MOVWF       R0 
	MOVF        FARG_uint32ToStr__result+1, 0 
	MOVWF       R1 
	MOVF        FARG_uint32ToStr__result+2, 0 
	MOVWF       R2 
	MOVF        FARG_uint32ToStr__result+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVLW       48
	ADDWF       R0, 1 
	MOVFF       FLOC__uint32ToStr+0, FSR1L+0
	MOVFF       FLOC__uint32ToStr+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;convert.c,38 :: 		_result = _result / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_uint32ToStr__result+0, 0 
	MOVWF       R0 
	MOVF        FARG_uint32ToStr__result+1, 0 
	MOVWF       R1 
	MOVF        FARG_uint32ToStr__result+2, 0 
	MOVWF       R2 
	MOVF        FARG_uint32ToStr__result+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_uint32ToStr__result+0 
	MOVF        R1, 0 
	MOVWF       FARG_uint32ToStr__result+1 
	MOVF        R2, 0 
	MOVWF       FARG_uint32ToStr__result+2 
	MOVF        R3, 0 
	MOVWF       FARG_uint32ToStr__result+3 
;convert.c,39 :: 		position--;
	DECF        uint32ToStr_position_L0+0, 1 
;convert.c,40 :: 		}while(position);
	MOVF        uint32ToStr_position_L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_uint32ToStr3
;convert.c,42 :: 		_high[0] = Aux[0];
	MOVF        FARG_uint32ToStr__high+0, 0 
	MOVWF       FSR1L+0 
	MOVF        FARG_uint32ToStr__high+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+0, 0 
	MOVWF       POSTINC1+0 
;convert.c,43 :: 		_high[1] = Aux[1];
	MOVLW       1
	ADDWF       FARG_uint32ToStr__high+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__high+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+1, 0 
	MOVWF       POSTINC1+0 
;convert.c,44 :: 		_high[2] = Aux[2];
	MOVLW       2
	ADDWF       FARG_uint32ToStr__high+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__high+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+2, 0 
	MOVWF       POSTINC1+0 
;convert.c,45 :: 		_high[3] = Aux[3];
	MOVLW       3
	ADDWF       FARG_uint32ToStr__high+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__high+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+3, 0 
	MOVWF       POSTINC1+0 
;convert.c,46 :: 		_high[4] = 0x00;
	MOVLW       4
	ADDWF       FARG_uint32ToStr__high+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__high+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;convert.c,48 :: 		_low[0] = Aux[4];
	MOVF        FARG_uint32ToStr__low+0, 0 
	MOVWF       FSR1L+0 
	MOVF        FARG_uint32ToStr__low+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+4, 0 
	MOVWF       POSTINC1+0 
;convert.c,49 :: 		_low[1] = Aux[5];
	MOVLW       1
	ADDWF       FARG_uint32ToStr__low+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__low+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+5, 0 
	MOVWF       POSTINC1+0 
;convert.c,50 :: 		_low[2] = Aux[6];
	MOVLW       2
	ADDWF       FARG_uint32ToStr__low+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__low+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+6, 0 
	MOVWF       POSTINC1+0 
;convert.c,51 :: 		_low[3] = Aux[7];
	MOVLW       3
	ADDWF       FARG_uint32ToStr__low+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__low+1, 0 
	MOVWF       FSR1L+1 
	MOVF        uint32ToStr_Aux_L0+7, 0 
	MOVWF       POSTINC1+0 
;convert.c,52 :: 		_low[4] = 0x00;
	MOVLW       4
	ADDWF       FARG_uint32ToStr__low+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_uint32ToStr__low+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;convert.c,53 :: 		}
L_end_uint32ToStr:
	RETURN      0
; end of _uint32ToStr

_AbsoluteValue:

;convert.c,55 :: 		signed long int AbsoluteValue(signed long int _num){
;convert.c,56 :: 		if(_num < 0){
	MOVLW       128
	XORWF       FARG_AbsoluteValue__num+3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AbsoluteValue29
	MOVLW       0
	SUBWF       FARG_AbsoluteValue__num+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AbsoluteValue29
	MOVLW       0
	SUBWF       FARG_AbsoluteValue__num+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AbsoluteValue29
	MOVLW       0
	SUBWF       FARG_AbsoluteValue__num+0, 0 
L__AbsoluteValue29:
	BTFSC       STATUS+0, 0 
	GOTO        L_AbsoluteValue6
;convert.c,57 :: 		return _num * (-1);
	MOVF        FARG_AbsoluteValue__num+0, 0 
	MOVWF       R0 
	MOVF        FARG_AbsoluteValue__num+1, 0 
	MOVWF       R1 
	MOVF        FARG_AbsoluteValue__num+2, 0 
	MOVWF       R2 
	MOVF        FARG_AbsoluteValue__num+3, 0 
	MOVWF       R3 
	MOVLW       255
	MOVWF       R4 
	MOVLW       255
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	GOTO        L_end_AbsoluteValue
;convert.c,58 :: 		}
L_AbsoluteValue6:
;convert.c,59 :: 		return _num;
	MOVF        FARG_AbsoluteValue__num+0, 0 
	MOVWF       R0 
	MOVF        FARG_AbsoluteValue__num+1, 0 
	MOVWF       R1 
	MOVF        FARG_AbsoluteValue__num+2, 0 
	MOVWF       R2 
	MOVF        FARG_AbsoluteValue__num+3, 0 
	MOVWF       R3 
;convert.c,60 :: 		}
L_end_AbsoluteValue:
	RETURN      0
; end of _AbsoluteValue

_AddBuffer:

;convert.c,62 :: 		void AddBuffer(long int _buffer[], long int _element, int _long){
;convert.c,64 :: 		for(j = 0; j < _long - 1; j++){
	CLRF        AddBuffer_j_L0+0 
L_AddBuffer7:
	MOVLW       1
	SUBWF       FARG_AddBuffer__long+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      FARG_AddBuffer__long+1, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AddBuffer31
	MOVF        R1, 0 
	SUBWF       AddBuffer_j_L0+0, 0 
L__AddBuffer31:
	BTFSC       STATUS+0, 0 
	GOTO        L_AddBuffer8
;convert.c,65 :: 		_buffer[_long - 1 - j] = _buffer[_long - 2 - j];
	MOVLW       1
	SUBWF       FARG_AddBuffer__long+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_AddBuffer__long+1, 0 
	MOVWF       R1 
	MOVF        AddBuffer_j_L0+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_AddBuffer__buffer+0, 0 
	MOVWF       FLOC__AddBuffer+0 
	MOVF        R1, 0 
	ADDWFC      FARG_AddBuffer__buffer+1, 0 
	MOVWF       FLOC__AddBuffer+1 
	MOVLW       2
	SUBWF       FARG_AddBuffer__long+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_AddBuffer__long+1, 0 
	MOVWF       R1 
	MOVF        AddBuffer_j_L0+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_AddBuffer__buffer+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_AddBuffer__buffer+1, 0 
	MOVWF       FSR0L+1 
	MOVFF       FLOC__AddBuffer+0, FSR1L+0
	MOVFF       FLOC__AddBuffer+1, FSR1H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;convert.c,64 :: 		for(j = 0; j < _long - 1; j++){
	INCF        AddBuffer_j_L0+0, 1 
;convert.c,66 :: 		}
	GOTO        L_AddBuffer7
L_AddBuffer8:
;convert.c,67 :: 		_buffer[0] = _element;
	CLRF        R0 
	CLRF        R1 
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_AddBuffer__buffer+0, 0 
	MOVWF       FSR1L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_AddBuffer__buffer+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_AddBuffer__element+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddBuffer__element+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddBuffer__element+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddBuffer__element+3, 0 
	MOVWF       POSTINC1+0 
;convert.c,68 :: 		}
L_end_AddBuffer:
	RETURN      0
; end of _AddBuffer

_swap2:

;convert.c,70 :: 		void swap2(long int *xp, long int *yp){
;convert.c,71 :: 		long int temp = *xp;
	MOVFF       FARG_swap2_xp+0, FSR0L+0
	MOVFF       FARG_swap2_xp+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       swap2_temp_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       swap2_temp_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       swap2_temp_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       swap2_temp_L0+3 
;convert.c,72 :: 		*xp = *yp;
	MOVFF       FARG_swap2_yp+0, FSR0L+0
	MOVFF       FARG_swap2_yp+1, FSR0H+0
	MOVFF       FARG_swap2_xp+0, FSR1L+0
	MOVFF       FARG_swap2_xp+1, FSR1H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;convert.c,73 :: 		*yp = temp;
	MOVFF       FARG_swap2_yp+0, FSR1L+0
	MOVFF       FARG_swap2_yp+1, FSR1H+0
	MOVF        swap2_temp_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        swap2_temp_L0+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        swap2_temp_L0+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        swap2_temp_L0+3, 0 
	MOVWF       POSTINC1+0 
;convert.c,74 :: 		}
L_end_swap2:
	RETURN      0
; end of _swap2

_BubbleSort:

;convert.c,76 :: 		void BubbleSort(long int _sorted[], long int _buffer[], int _long){
;convert.c,78 :: 		for(i = 0; i < _long; i++){
	CLRF        BubbleSort_i_L0+0 
L_BubbleSort10:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_BubbleSort__long+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BubbleSort34
	MOVF        FARG_BubbleSort__long+0, 0 
	SUBWF       BubbleSort_i_L0+0, 0 
L__BubbleSort34:
	BTFSC       STATUS+0, 0 
	GOTO        L_BubbleSort11
;convert.c,79 :: 		_sorted[i] = _buffer[i];
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        BubbleSort_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_BubbleSort__sorted+0, 0 
	MOVWF       FLOC__BubbleSort+0 
	MOVF        R1, 0 
	ADDWFC      FARG_BubbleSort__sorted+1, 0 
	MOVWF       FLOC__BubbleSort+1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        BubbleSort_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_BubbleSort__buffer+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_BubbleSort__buffer+1, 0 
	MOVWF       FSR0L+1 
	MOVFF       FLOC__BubbleSort+0, FSR1L+0
	MOVFF       FLOC__BubbleSort+1, FSR1H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;convert.c,78 :: 		for(i = 0; i < _long; i++){
	INCF        BubbleSort_i_L0+0, 1 
;convert.c,80 :: 		}
	GOTO        L_BubbleSort10
L_BubbleSort11:
;convert.c,81 :: 		for(i = 0; i < _long - 1; i++){
	CLRF        BubbleSort_i_L0+0 
L_BubbleSort13:
	MOVLW       1
	SUBWF       FARG_BubbleSort__long+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      FARG_BubbleSort__long+1, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BubbleSort35
	MOVF        R1, 0 
	SUBWF       BubbleSort_i_L0+0, 0 
L__BubbleSort35:
	BTFSC       STATUS+0, 0 
	GOTO        L_BubbleSort14
;convert.c,82 :: 		for(j = 0; j < _long - 1 - i; j++){
	CLRF        BubbleSort_j_L0+0 
L_BubbleSort16:
	MOVLW       1
	SUBWF       FARG_BubbleSort__long+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      FARG_BubbleSort__long+1, 0 
	MOVWF       R1 
	MOVF        BubbleSort_i_L0+0, 0 
	SUBWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	SUBWFB      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BubbleSort36
	MOVF        R2, 0 
	SUBWF       BubbleSort_j_L0+0, 0 
L__BubbleSort36:
	BTFSC       STATUS+0, 0 
	GOTO        L_BubbleSort17
;convert.c,83 :: 		if(_sorted[j] > _sorted[j + 1]){
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        BubbleSort_j_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_BubbleSort__sorted+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_BubbleSort__sorted+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__BubbleSort+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__BubbleSort+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__BubbleSort+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       FLOC__BubbleSort+3 
	MOVF        BubbleSort_j_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_BubbleSort__sorted+0, 0 
	MOVWF       FSR2L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_BubbleSort__sorted+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FLOC__BubbleSort+3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BubbleSort37
	MOVF        FLOC__BubbleSort+2, 0 
	SUBWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BubbleSort37
	MOVF        FLOC__BubbleSort+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__BubbleSort37
	MOVF        FLOC__BubbleSort+0, 0 
	SUBWF       R1, 0 
L__BubbleSort37:
	BTFSC       STATUS+0, 0 
	GOTO        L_BubbleSort19
;convert.c,84 :: 		swap2(&_sorted[j], &_sorted[j + 1]);
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        BubbleSort_j_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_BubbleSort__sorted+0, 0 
	MOVWF       FARG_swap2_xp+0 
	MOVF        R1, 0 
	ADDWFC      FARG_BubbleSort__sorted+1, 0 
	MOVWF       FARG_swap2_xp+1 
	MOVF        BubbleSort_j_L0+0, 0 
	ADDLW       1
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       4
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_BubbleSort__sorted+0, 0 
	MOVWF       FARG_swap2_yp+0 
	MOVF        R1, 0 
	ADDWFC      FARG_BubbleSort__sorted+1, 0 
	MOVWF       FARG_swap2_yp+1 
	CALL        _swap2+0, 0
;convert.c,85 :: 		}
L_BubbleSort19:
;convert.c,82 :: 		for(j = 0; j < _long - 1 - i; j++){
	INCF        BubbleSort_j_L0+0, 1 
;convert.c,86 :: 		}
	GOTO        L_BubbleSort16
L_BubbleSort17:
;convert.c,81 :: 		for(i = 0; i < _long - 1; i++){
	INCF        BubbleSort_i_L0+0, 1 
;convert.c,87 :: 		}
	GOTO        L_BubbleSort13
L_BubbleSort14:
;convert.c,88 :: 		}
L_end_BubbleSort:
	RETURN      0
; end of _BubbleSort

_isFull:

;convert.c,90 :: 		char isFull(long int _buffer[], int _long){
;convert.c,91 :: 		char i = 0;
	CLRF        isFull_i_L0+0 
;convert.c,92 :: 		for(i = 0; i < _long; i++){
	CLRF        isFull_i_L0+0 
L_isFull20:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_isFull__long+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__isFull39
	MOVF        FARG_isFull__long+0, 0 
	SUBWF       isFull_i_L0+0, 0 
L__isFull39:
	BTFSC       STATUS+0, 0 
	GOTO        L_isFull21
;convert.c,93 :: 		if(_buffer[i] == -1){
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        isFull_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_isFull__buffer+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_isFull__buffer+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       255
	MOVWF       R0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__isFull40
	MOVF        R0, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__isFull40
	MOVF        R0, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__isFull40
	MOVF        R1, 0 
	XORLW       255
L__isFull40:
	BTFSS       STATUS+0, 2 
	GOTO        L_isFull23
;convert.c,94 :: 		return 0;
	CLRF        R0 
	GOTO        L_end_isFull
;convert.c,95 :: 		}
L_isFull23:
;convert.c,92 :: 		for(i = 0; i < _long; i++){
	INCF        isFull_i_L0+0, 1 
;convert.c,96 :: 		}
	GOTO        L_isFull20
L_isFull21:
;convert.c,97 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;convert.c,98 :: 		}
L_end_isFull:
	RETURN      0
; end of _isFull
