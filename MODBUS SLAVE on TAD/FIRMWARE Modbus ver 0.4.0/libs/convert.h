#ifndef convert_h
#define convert_h

float stringToFloat(char *_string);
unsigned int stringToInt(char *_string);
void udintToStr(char *_string, int number);
void uint32ToStr(char *_high, char *_low, long int _result);
signed long int AbsoluteValue(signed long int _num);
void AddBuffer(long int _buffer[], long int _element, int _long);
void swap2(long int *xp, long int *yp);
void BubbleSort(long int _sorted[], long int _buffer[], int _long);
char isFull(long int _buffer[], int _long);

#endif