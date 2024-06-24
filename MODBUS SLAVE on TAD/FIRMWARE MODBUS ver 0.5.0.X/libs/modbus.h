/******************************************************************************/
/* User Level #define Macros                                                  */
/******************************************************************************/
#define MAX_PACKET_SIZE 256
#define SlaveAddress 0x25
typedef enum ModbusFuncs{
     READ_COILS                = 1,
     READ_DISCRETE_INPUTS      = 2,
     READ_HOLDING_REGISTERS    = 3,
     READ_INPUT_REGISTERS      = 4,
     FORCE_SINGLE_COIL         = 5,
     PRESET_SINGLE_REGISTER    = 6,
     FORCE_MULTIPLE_COILS      = 15,
     PRESET_MULTIPLE_REGISTERS = 16
} modfunction;
#define average_analog_read 5 // Promedio de lectura analoga
#define ANALOG_INPUT1 0
#define ANALOG_INPUT2 1
#define ANALOG_INPUT3 2
#define ANALOG_INPUT4 3
#define ANALOG_OUTPUT1 0
#define ANALOG_OUTPUT2 1
#define ANALOG_OUTPUT3 2
#define ANALOG_OUTPUT4 3
union{
     uint8_t Arrayoflags;
     struct{
          unsigned C1:1; // 01 Illegal Function
          unsigned C2:1; // 02 Illegal Data Address
          unsigned C3:1; // 03 Illegal Data Value
          unsigned C4:1; // 04 Server Device Failure
          unsigned C5:1; // 05 Acknowledge
          unsigned C6:1; // 06 Server Device Busy
          unsigned C7:1; // 07 Negative Acknowledge
          unsigned C8:1; // 08 Memory Parity Error
     };
} ExceptionCodes = {0x00};
typedef struct{
    uint32_t sum;
    uint16_t average;
    uint32_t ad;
    float result;
} ADC;
typedef struct{
    uint8_t PulseEnable;
    uint8_t HighBlock;
    uint8_t LowBlock;
    uint16_t Hz;
} FREQ;
FREQ frequency[4] = {
    {0, 0x0B, 0xDC, 0}, {0, 0x0B, 0xDC, 0},
    {0, 0x0B, 0xDC, 0}, {0, 0x0B, 0xDC, 0}
};
extern volatile unsigned int HoldingRegister[50];
extern volatile unsigned int InputRegister[50];
extern volatile unsigned char Coils[50];
extern volatile unsigned char DiscreteInput[50];
extern volatile unsigned char response[MAX_PACKET_SIZE];
extern volatile unsigned char received[MAX_PACKET_SIZE];
extern volatile char ModbusMessage,MessageLength;
extern volatile uint8_t ExceptionCode;
/******************************************************************************/
/* User Function Prototypes                                                   */
/******************************************************************************/
void ModbusDelay(void);
void ClearResponse(void);
void DecodePacket(void);
void ReadHR(void);
void ReadIR(void);
void PresetSR(void);
void ReadCoil(void);
void ReadDI(void);
void WriteCoil(void);
void WriteMultiCoil(void);
void ExceptionStatus(void);
bool conv_hz(uint16_t _Value, uint16_t _Address);
uint16_t CalculateCRC(unsigned char string[], uint16_t _long);
uint8_t CheckCRC(void);