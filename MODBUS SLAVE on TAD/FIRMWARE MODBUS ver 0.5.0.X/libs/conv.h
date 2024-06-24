#ifndef conv_h

#define conv_h


#include <stdint.h>
#include <string.h>

float StringToFloat(uint8_t *_string);
uint16_t StringToInt(char *_string);
void IntToString(char *_string, int number);
void uint32ToString(char *_high, char *_low, uint32_t _result);
int32_t AbsVal(int32_t _num);
void AddBuffer(long _buffer[], long _element, int _long);
void SwapNibble(long *xp, long *yp);
void BubbleSort(long _sorted[], long _buffer[], int _long);
char isFull(long _buffer[], int _long);

#endif