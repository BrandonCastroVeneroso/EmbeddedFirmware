/******************************************************************************/
/* User Level #define Macros                                                  */
/******************************************************************************/
#define MAX_PACKET_SIZE 256
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
/******************************************************************************/
/* User Function Prototypes                                                   */
/******************************************************************************/
