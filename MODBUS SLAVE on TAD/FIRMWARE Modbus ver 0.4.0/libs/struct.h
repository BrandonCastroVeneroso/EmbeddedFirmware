#ifndef struct_h
#define struct_h

#define ANALOG_INPUT_1 0
#define ANALOG_INPUT_2 1
#define ANALOG_INPUT_3 2
#define ANALOG_INPUT_4 3

#define ANALOG_OUTPUT_1 0
#define ANALOG_OUTPUT_2 1
#define ANALOG_OUTPUT_3 2
#define ANALOG_OUTPUT_4 3

#define AVERAGE_ANALOG_READ 5

typedef struct{
     char in_string[25];
     char rxIndex;
     char rxFlag;
     char TimeOutEnable;
     int  TimeOut;
} COMINPUT;

typedef struct{
     char out_string[37];
} COMOUTPUT;

typedef struct{
     long int sum;
     unsigned int average;
     long int ad;
     float result;
} ADC;

typedef struct{
     char PulseEnable;
     char high;
     char low;
     unsigned int hz;
} FREQ;

#endif