#include "conv.h"
#include <stdlib.h>

float StringToFloat(uint8_t *_string){
     float result;
     result = (_string[0] - 0x30) * 1000;
     result += (_string[1] - 0x30) * 100;
     result += (_string[2] - 0x30) * 10;
     result += (_string[3] - 0x30) * 1;
     result = result / 100;
     return result;
}

uint16_t StringToInt(char *_string){
     uint16_t result;
     result = (_string[0] - 0x30) * 1000;
     result += (_string[1] - 0x30) * 100;
     result += (_string[2] - 0x30) * 10;
     result += (_string[3] - 0x30) * 1;
     return result;
}

void IntToString(char *_string, int number){
     char pos = 4;
     _string[pos] = 0x00;
     do{
          _string[pos - 1] = number % 10 + 0x30;
     }while(pos);
}

void uint32ToString(char *_high, char *_low, uint32_t _result){
     char aux[9];
     uint8_t pos = 8;
     aux[8] = 0x00;

     do{
          aux[pos - 1] = _result % 10 + 0x30;
          _result = _result / 10;
          pos--;
     }while(pos);

     _high[0] = aux[0];
     _high[1] = aux[1];
     _high[2] = aux[2];
     _high[3] = aux[3];
     _high[4] = 0x00;

     _low[0] = aux[4];
     _low[1] = aux[5];
     _low[2] = aux[6];
     _low[3] = aux[7];
     _low[4] = 0x00;
}

int32_t AbsVal(int32_t _num){
     if(_num < 0){
          return _num * (-1);
     }
     return _num;
}

void AddBuffer(long _buffer[], long _element, int _long){
     char j;
     for(j = 0; j < _long - 1; j++){
          _buffer[_long - 1 - j] = _buffer[_long - 2 - j];
     }
     _buffer[0] = _element;
}

void SwapNibble(long *xp, long *yp){
     long temp = *xp;
     *xp = *yp;
     *yp = temp;
}

void BubbleSort(long _sorted[], long _buffer[], int _long){
     char i, j;
     for(i = 0; i < _long; i++){
          _sorted[i] = _buffer[i];
     }
     for(i = 0; i < _long - 1; i++){
          for(j = 0; j < _long - 1 - i; j++){
               if(_sorted[j] > _sorted[j + 1]){
                    SwapNibble(&_sorted[j], &_sorted[j + 1]);
               }
          }
     }
}

char isFull(long _buffer[], int _long){
     char i = 0;
     for(i = 0; i < _long; i++){
          if(_buffer[i] == -1){
               return 0;
          }
     }
     return 1;
}