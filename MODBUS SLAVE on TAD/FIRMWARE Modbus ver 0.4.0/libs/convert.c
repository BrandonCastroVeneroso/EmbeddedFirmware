#include "convert.h"

float stringToFloat(char *_string){
     float result;
     result = (_string[0] - 0x30) * 1000;
     result += (_string[1] - 0x30) * 100;
     result += (_string[2] - 0x30) * 10;
     result += (_string[3] - 0x30) * 1;
     result = result / 100;
     return result;
}

unsigned int stringToInt(char *_string){
     unsigned int result;
     result = (_string[0] - 0x30) * 1000;
     result += (_string[1] - 0x30) * 100;
     result += (_string[2] - 0x30) * 10;
     result += (_string[3] - 0x30) * 1;
     return result;
}

void udintToStr(char *_string, int number){
     char position = 4;
     _string[position] = 0x00;
     do{
          _string[position - 1] = number % 10 + 0x30;
          number = number / 10;
          position--;
     }while(position);
}

void uint32ToStr(char *_high, char *_low, long int _result){
     char Aux[9];
     char position = 8;
     Aux[8] = 0x00;
     do{
          Aux[position - 1] = _result % 10 + 0x30;
          _result = _result / 10;
          position--;
     }while(position);

     _high[0] = Aux[0];
     _high[1] = Aux[1];
     _high[2] = Aux[2];
     _high[3] = Aux[3];
     _high[4] = 0x00;

     _low[0] = Aux[4];
     _low[1] = Aux[5];
     _low[2] = Aux[6];
     _low[3] = Aux[7];
     _low[4] = 0x00;
}

signed long int AbsoluteValue(signed long int _num){
     if(_num < 0){
          return _num * (-1);
     }
     return _num;
}

void AddBuffer(long int _buffer[], long int _element, int _long){
     char j;
     for(j = 0; j < _long - 1; j++){
          _buffer[_long - 1 - j] = _buffer[_long - 2 - j];
     }
     _buffer[0] = _element;
}

void swap2(long int *xp, long int *yp){
     long int temp = *xp;
     *xp = *yp;
     *yp = temp;
}

void BubbleSort(long int _sorted[], long int _buffer[], int _long){
     char i, j;
     for(i = 0; i < _long; i++){
          _sorted[i] = _buffer[i];
     }
     for(i = 0; i < _long - 1; i++){
          for(j = 0; j < _long - 1 - i; j++){
               if(_sorted[j] > _sorted[j + 1]){
                    swap2(&_sorted[j], &_sorted[j + 1]);
               }
          }
     }
}

char isFull(long int _buffer[], int _long){
     char i = 0;
     for(i = 0; i < _long; i++){
          if(_buffer[i] == -1){
               return 0;
          }
     }
     return 1;
}