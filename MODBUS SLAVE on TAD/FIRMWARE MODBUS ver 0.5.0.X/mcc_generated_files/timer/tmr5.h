/**
 * TMR5 Generated Driver API Header File
 *
 * @file tmr5.h
 *
 * @defgroup tmr5 TMR5
 *
 * @brief This file contains the API prototypes and other data types for the TMR5 driver.
 *
 * @version TMR5 Driver Version 3.1.4
*/
/*
© [2024] Microchip Technology Inc. and its subsidiaries.

    Subject to your compliance with these terms, you may use Microchip 
    software and any derivatives exclusively with Microchip products. 
    You are responsible for complying with 3rd party license terms  
    applicable to your use of 3rd party software (including open source  
    software) that may accompany Microchip software. SOFTWARE IS ?AS IS.? 
    NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS 
    SOFTWARE, INCLUDING ANY IMPLIED WARRANTIES OF NON-INFRINGEMENT,  
    MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT 
    WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY 
    KIND WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF 
    MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE 
    FORESEEABLE. TO THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP?S 
    TOTAL LIABILITY ON ALL CLAIMS RELATED TO THE SOFTWARE WILL NOT 
    EXCEED AMOUNT OF FEES, IF ANY, YOU PAID DIRECTLY TO MICROCHIP FOR 
    THIS SOFTWARE.
*/

#ifndef TMR5_H
#define TMR5_H

#include <stdbool.h>
#include <stdint.h>
#include "timer_interface.h"


/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_Initialize API
 */
#define Timer5_Initialize TMR5_Initialize

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_Start API
 */
#define Timer5_Start TMR5_Start

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_Stop API
 */
#define Timer5_Stop TMR5_Stop

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_Read API
 */
#define Timer5_Read TMR5_Read

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_Write API
 */
#define Timer5_Write TMR5_Write

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_PeriodCountSet API
 */
#define Timer5_PeriodCountSet TMR5_PeriodCountSet

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_OverflowISR API
 */
#define Timer5_OverflowISR TMR5_OverflowISR

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_Reload API
 */
#define Timer5_Reload TMR5_Reload

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_GateCallbackRegister API
 */
#define Timer5_GateCallbackRegister TMR5_GateCallbackRegister

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_GateISR API
 */
#define Timer5_GateISR TMR5_GateISR

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_HasOverflowOccured API
 */
#define Timer5_HasOverflowOccured TMR5_HasOverflowOccured

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_CheckGateValueStatus API
 */
#define Timer5_CheckGateValueStatus TMR5_CheckGateValueStatus

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_StartSinglePulseAcquisition API
 */
#define Timer5_StartSinglePulseAcquisition TMR5_StartSinglePulseAcquisition

/**
 * @ingroup tmr5
 * @brief Defines the Custom Name for the \ref TMR5_OverflowCallbackRegister API
 */
#define Timer5_OverflowCallbackRegister TMR5_OverflowCallbackRegister


/**
 * @ingroup tmr5
 * @struct TMR_INTERFACE
 * @brief This is an instance of TMR_INTERFACE for Timer module
 */
extern const struct TMR_INTERFACE Timer5;

/**
 * @ingroup tmr5
 * @brief Initializes the timer module.
 *        This routine must be called before any other timer routines.
 * @param None.
 * @return None.
 */
void TMR5_Initialize(void);

/**
 * @ingroup tmr5
 * @brief Starts the timer.
 * @pre The timer should be initialized with TMR5_Initialize() before calling this API.
 * @param None.
 * @return None.
 */
void TMR5_Start(void);

/**
 * @ingroup tmr5
 * @brief Stops the timer.
 * @pre The timer should be initialized with TMR5_Initialize() before calling this API.
 * @param None.
 * @return None.
 */
void TMR5_Stop(void);

/**
 * @ingroup tmr5
 * @brief Reads the 16-bit from the TMR5 register.
 *        The Timer should be initialized with TMR5_Initialize() before calling this API.
 * @param None.
 * @return uint16_t - 16-bit data from the TMR5 register.
 */
uint16_t TMR5_Read(void);

/**
 * @ingroup tmr5
 * @brief Writes the 16-bit value to the TMR5 register.
 * @pre The timer should be initialized with TMR5_Initialize() before calling this API.
 * @param size_t timerVal - 16-bit value written to the TMR5 register.
 * @return None.
 */
void TMR5_Write(size_t timerVal);

/**
 * @ingroup tmr5
 * @brief Loads the 8-bit value to the TMR5 register.
 * @pre The timer should be initialized with TMR5_Initialize() before calling this API.
 * @param None.
 * @return None.
 */
void TMR5_Reload(void);

/**
 * @ingroup tmr5
 * @brief Loads the 16-bit value to the timer5ReloadVal variable.
 * @param periodVal - 16-bit value. 
 * @return None.
 */
void TMR5_PeriodCountSet(size_t periodVal);

/**
 * @ingroup tmr5
 * @brief Starts the single pulse acquisition in TMR5 gate operation.
 * @pre This function must be used when the TMR5 gate is enabled.
 * @param None.
 * @return None.
 */
void TMR5_StartSinglePulseAcquisition(void);

/**
 * @ingroup tmr5
 * @brief Reads the TMR5 gate value and returns it.
 * @pre This function must be used when the TMR5 gate is enabled.
 * @param None.
 * @return uint8_t - Gate value status.
 */
uint8_t TMR5_CheckGateValueStatus(void);

/**
 * @ingroup tmr5
 * @brief Timer Interrupt Service Routine (ISR) called by the Interrupt Manager for overflow.
 * @param None.
 * @return None.
 */
void TMR5_OverflowISR(void);

/**
 * @ingroup tmr5
 * @brief Setter function for the Timer overflow callback.
 * @param void (* CallbackHandler)(void) - Pointer to the custom callback.
 * @return None.
 */
 void TMR5_OverflowCallbackRegister(void (* CallbackHandler)(void));


/**
 * @ingroup tmr5
 * @brief Checks for the timer overflow flag when in Polling mode.
 * @param None.
 * @retval true  - Timer overflow has occured.
 * @retval false - Timer overflow has not occured.
 */
bool TMR5_HasOverflowOccured(void);

/**
 * @ingroup tmr5
 * @brief Timer Gate Interrupt Service Routine (ISR) called by the Interrupt Manager.
 * @param None.
 * @return None.
 */
void TMR5_GateISR(void);

/**
 * @ingroup tmr5
 * @brief Setter function for the Timer gate callback.
 * @param void (* CallbackHandler)(void) - Pointer to the custom callback.
 * @return None.
 */
 void TMR5_GateCallbackRegister(void (* CallbackHandler)(void));

#endif // TMR5_H