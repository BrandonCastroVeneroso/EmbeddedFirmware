//*******************************************************************
// Programa: Implementacion Modbus para TAD
// JAHAZIEL es gei
// MCU: PIC18LF47K40bdkjvbdkjrv
//*******************************************************************

/********************************************************************/
/************* Declaración de Constantes Generales ******************/
/********************************************************************/

#include "mcc_generated_files/system/system.h"
#include "mcc_generated_files/timer/tmr2.h"
#include "libs/modbus.h"
#include "libs/conv.h"

/*******************************************************************/
/************************ Variables Globales ***********************/
/*******************************************************************/

volatile char EndOfMessage, NewMessage = 1;
volatile char TimerCount, z = 0;

/*******************************************************************/
/**************************** Prototipos ***************************/
/*******************************************************************/

void rxfunc(void); // ISR para RX
void tmr2func(void); // ISR en tmr2 (Timeout)
void tmr0func(void); // ISR en tmr0
void tmr1func(void); // ISR en tmr1
void tmr3func(void); // ISR en tmr3
void tmr5func(void); // ISR en tmr5
void monitoreo(void); // Asignacion de estado actual a registros MODBUS
void calcAD(char _channel_number); // Calculo ADC de entrada analogica n

/*******************************************************************/
/************************* Main Application ************************/
/*******************************************************************/

int main(void){
    SYSTEM_Initialize();

    INTERRUPT_GlobalInterruptEnable(); 
    INTERRUPT_PeripheralInterruptEnable(); 

    EUSART1_RxCompleteCallbackRegister(rxfunc);
    TMR0_OverflowCallbackRegister(tmr0func);
    TMR1_OverflowCallbackRegister(tmr1func);
    TMR3_OverflowCallbackRegister(tmr3func);
    TMR5_OverflowCallbackRegister(tmr5func);
    TMR2_OverflowCallbackRegister(tmr2func);

    printf("Everything in order sir\n");

    while(1){
        if(ModbusMessage){
            DecodePacket();
            // Code goes here
            // Asignaciones a registros
            monitoreo();
        }
    }    
}

/*
 *   Asignamos los valores deseados a los registros MODBUS
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void monitoreo(void){
    // Asignacion de los Reles a coils
    RELE1_LAT = Coils[0];
    RELE2_LAT = Coils[1];
    RELE3_LAT = Coils[2];
    RELE4_LAT = Coils[3];
    // Asignacion de los I/O Digitales a Discrete Inputs
    DIG1_PORT = DiscreteInput[0];
    DIG2_PORT = DiscreteInput[1];
    DIG3_PORT = DiscreteInput[2];
    DIG4_PORT = DiscreteInput[3];
    DIG5_PORT = DiscreteInput[4];
    DIG6_PORT = DiscreteInput[5];
    DIG7_PORT = DiscreteInput[6];
    DIG8_PORT = DiscreteInput[7];
    DIG9_PORT = DiscreteInput[8];
    DIG10_PORT = DiscreteInput[9];
    DIG11_PORT = DiscreteInput[10];
    DIG12_PORT = DiscreteInput[11];
    DIG13_PORT = DiscreteInput[12];
    DIG14_PORT = DiscreteInput[13];
    DIG15_PORT = DiscreteInput[14];
    DIG16_PORT = DiscreteInput[15];
    // Asignacion del resultado de la entrada al ADC a Input Registers
    calcAD(ANALOG_INPUT1);
    calcAD(ANALOG_INPUT2);
    calcAD(ANALOG_INPUT3);
    calcAD(ANALOG_INPUT4);
    // Asignacion del valor de frequencia a Holding Registers
    frequency[ANALOG_OUTPUT1].HighBlock = HoldingRegister[0] >> 8;
    frequency[ANALOG_OUTPUT1].LowBlock = HoldingRegister[0];
    frequency[ANALOG_OUTPUT2].HighBlock = HoldingRegister[1] >> 8;
    frequency[ANALOG_OUTPUT2].LowBlock = HoldingRegister[1];
    frequency[ANALOG_OUTPUT3].HighBlock = HoldingRegister[2] >> 8;
    frequency[ANALOG_OUTPUT3].LowBlock = HoldingRegister[2];
    frequency[ANALOG_OUTPUT4].HighBlock = HoldingRegister[3] >> 8;
    frequency[ANALOG_OUTPUT4].LowBlock = HoldingRegister[3];
}

/*
 *   Calculamos el promedio de lecturas analogicas (5) de entrada y lo escribimos en el
 *   array de los Input Registers
 *   Args:
 *        1 .- Numero de canal
 *   Returns:
 *        N/A
 */

void calcAD(char _channel_number){
    // Variables para la asignacion de resultado del ADC
    ADC adc;
    int i = 0;
    char offset = 0;
    char ma420[5] = {0, 0, 0, 0, 0};
    // Asignamos valores a las variables de la estructura ADC
    adc.average = average_analog_read;
    adc.sum = 0;
    // Asignamos canales de la entrada analogica a la lista de canales
    adcc_channel_t channel[] = {ANAIN1, ANAIN2, ANAIN3, ANAIN4};
    // Hacemos conversiones hasta el promedio
    for(i = 0; i < adc.average; i++){
        adc.sum += ADCC_GetSingleConversion(channel[_channel_number]);
    }
    // Calculamos el promedio
    adc.ad = adc.sum / adc.average;
    // Convertimos el resultado a punto flotante con resultado de 2000 / 4095
    adc.result = (float) adc.ad * 0.4884 + 1;
    // Pasamos el resultado a nuestra variable de 4-20 mA
    IntToString(ma420, (int)adc.result);
    // Escribimos el resultado en el array de Input Register
    offset = 0 + 4 * _channel_number;
    memmove(InputRegister + offset, ma420, 4);
}

/*
 *   Funcion ISR de interrupcion en RX
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void rxfunc(void){
    if((!EndOfMessage) && (!NewMessage)){
        // No tenemos nada por enviar?
        if(TX1IF){
            // Leemos el registro RX y reseteamos el TimerCount
            received[z] = RC1REG;
            z++;
            TimerCount = 0;
        }
    }
    // Nuevo mensaje?
    if(NewMessage){
        // Iniciamos Timer0
        TMR2_Initialize();
        // Tenemos algo por enviar?
        if(TX1IF){
            // Leemos registro de RX
            received[z] = RC1REG;
            z++;
            NewMessage = 0;
            EndOfMessage = 0;
            MessageLength = 0;
            ModbusMessage = 0;
            TimerCount = 0;
            return;
        }
    }
}

/*
 *   Funcion ISR de desborde en tmr2
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void tmr2func(void){
    TMR2_PeriodCountSet(0);
    // Delay de 3.5 caracteres (MODBUS Application Protocol over Serial Line)
    ModbusDelay();
    TimerCount++;
    // Han pasado 7.292 ms?
    if(TimerCount > 4){
        // Limpiamos el registro de recibo, fin del TimeOut
        EndOfMessage = 1;
        NewMessage = 1;
        MessageLength = z;
        ModbusMessage = 1;
        for(z = MessageLength; z != MAX_PACKET_SIZE; z++){
            received[z] = 0;
        }
        z = 0;
        TMR2_Stop();
        TimerCount = 0;
    }
}

/*
 *   Funcion ISR de desborde en tmr0 (Salida Analogica 1)
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void tmr0func(void){
    TMR0H = frequency[ANALOG_OUTPUT1].HighBlock;
    TMR0L = frequency[ANALOG_OUTPUT1].LowBlock;
    if(frequency[ANALOG_OUTPUT1].PulseEnable == 1){
        ANAOUT1_Toggle();
    }
    else{
        ANAOUT1_SetLow();
    }
}

/*
 *   Funcion ISR de desborde en tmr1 (Salida Analogica 2)
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void tmr1func(void){
    TMR1H = frequency[ANALOG_OUTPUT2].HighBlock;
    TMR1L = frequency[ANALOG_OUTPUT2].LowBlock;
    if(frequency[ANALOG_OUTPUT2].PulseEnable == 1){
        ANAOUT2_Toggle();
    }
    else{
        ANAOUT2_SetLow();
    }
}

/*
 *   Funcion ISR de desborde en tmr3 (Salida Analogica 3)
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void tmr3func(void){
    TMR3H = frequency[ANALOG_OUTPUT3].HighBlock;
    TMR3L = frequency[ANALOG_OUTPUT3].LowBlock;
    if(frequency[ANALOG_OUTPUT3].PulseEnable == 1){
        ANAOUT3_Toggle();
    }
    else{
        ANAOUT3_SetLow();
    }
}

/*
 *   Funcion ISR de desborde en tmr5 (Salida Analogica 4)
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void tmr5func(void){
    TMR5H = frequency[ANALOG_OUTPUT4].HighBlock;
    TMR5L = frequency[ANALOG_OUTPUT4].LowBlock;
    if(frequency[ANALOG_OUTPUT4].PulseEnable == 1){
        ANAOUT4_Toggle();
    }
    else{
        ANAOUT4_SetLow();
    }
}