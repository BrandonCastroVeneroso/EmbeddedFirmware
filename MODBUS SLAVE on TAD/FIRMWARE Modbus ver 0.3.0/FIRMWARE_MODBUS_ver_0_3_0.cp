#line 1 "D:/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.3.0/FIRMWARE_MODBUS_ver_0_3_0.c"
#line 1 "d:/documents/brandon castro veneroso/01 programas en desarrollo/modbus/firmware modbus ver 0.3.0/libs/system.h"



void DeviceConfig();
void ClockConfig();
void EUSARTConfig();
void InterruptConfig();
void InitSystem();
void EnableTimer0();
#line 1 "d:/documents/brandon castro veneroso/01 programas en desarrollo/modbus/firmware modbus ver 0.3.0/libs/struct.h"
#line 16 "d:/documents/brandon castro veneroso/01 programas en desarrollo/modbus/firmware modbus ver 0.3.0/libs/struct.h"
typedef struct{
 char in_string[25];
 char rxIndex;
 char rxFlag;
 char TimeOutEnable;
 int TimeOut;
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
#line 1 "d:/documents/brandon castro veneroso/01 programas en desarrollo/modbus/firmware modbus ver 0.3.0/libs/convert.h"



float stringToFloat(char *_string);
unsigned int stringToInt(char *_string);
void udintToStr(char *_string, int number);
void uint32ToStr(char *_high, char *_low, long int _result);
signed long int AbsoluteValue(signed long int _num);
void AddBuffer(long int _buffer[], long int _element, int _long);
void swap2(long int *xp, long int *yp);
void BubbleSort(long int _sorted[], long int _buffer[], int _long);
char isFull(long int _buffer[], int _long);
#line 73 "D:/Documents/Brandon Castro Veneroso/01 PROGRAMAS EN DESARROLLO/MODBUS/FIRMWARE Modbus ver 0.3.0/FIRMWARE_MODBUS_ver_0_3_0.c"
volatile int count = 0;


bit uart1;
char uart1_byte;
unsigned char uart1_array[50];
char i = 0;
char letra_i[] = "12345678123456789123456789123456789123456789123456789123456789123456789";
COMINPUT in;
COMOUTPUT out;
char id[] =  "TAD1" ;





void UART1_Write_Text1(char *_cadena);
void UART1_Write_Text2(char *_text, int _long);
void Read_SerialPort();
void rxfunction();
char CheckID(char *s);





void interrupt(){
 if(PIR0.TMR0IF){
 PIR0.TMR0IF = 0;
 TMR0H = 0xB;
 TMR0L = 0xDC;
 }
 if(PIR3.RC1IF){
  LATA.F4  = ~ LATA.F4 ;
 if(UART1_Data_Ready() == 1){
 rxfunction();
 }
 }
}





void main(){

 InitSystem();
 EnableTimer0();
 in.rxIndex = 0;

 while(1){
 if(PIR4.TMR2IF){
 T2TMR = 0;
 if(in.TimeOutEnable){
 in.TimeOut++;
 if(in.TimeOut >= 100){
 in.TimeOut = 0;
 in.rxIndex = 0;
 }
 }
 }
 if(in.rxFlag){
 in.rxFlag = 0;
 }
 }

}





void rxfunction(){
 in.in_string[in.rxIndex++] = UART1_Remappable_Read();
 in.TimeOutEnable = 1;

 if(in.rxIndex >= 24){
 in.rxIndex = 0;
 in.rxFlag = 1;
 in.TimeOutEnable = 0;
 in.TimeOut = 0;
 }
}

void UART1_Write_Text1(char *_cadena){
 while(*_cadena){
 UART1_Write(*_cadena);
 _cadena++;
 }
}

void UART1_Write_Text2(char *_text, int _long){
 while(_long--){
 UART1_Write(*_text++);
 }
}

void Read_SerialPort(){
 uart1_byte = UART1_Read();
 uart1_array[i] = uart1_byte;
 i++;
}
