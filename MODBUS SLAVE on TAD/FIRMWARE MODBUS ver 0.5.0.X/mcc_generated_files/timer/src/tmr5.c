/**
  * TMR5 Generated Driver File
  *
  * @file tmr5.c
  *
  * @ingroup tmr5
  *
  * @brief Driver implementation for the TMR5 driver
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

/**
 * Section: Included Files
*/

#include <xc.h>
#include "../tmr5.h"

/**
 * Section: Global Variables Definitions
*/
volatile uint16_t timer5ReloadVal;
void (*TMR5_InterruptHandler)(void);

const struct TMR_INTERFACE Timer5 = {
    .Initialize = TMR5_Initialize,
    .Start = TMR5_Start,
    .Stop = TMR5_Stop,
    .PeriodCountSet = TMR5_PeriodCountSet,
    .TimeoutCallbackRegister = TMR5_OverflowCallbackRegister,
    .Tasks = NULL
};
static void (*TMR5_OverflowCallback)(void);
static void TMR5_DefaultOverflowCallback(void);
static void (*TMR5_GateCallback)(void);
static void TMR5_DefaultGateCallback(void);

void TMR5_Initialize(void)
{
    //Disable timer
    T5CONbits.TMR5ON = 0;
    //TGGO done; TGSPM disabled; TGTM disabled; TGPOL low; TMRGE disabled; 
    T5GCON = 0x0;
    //TGSS T5G_pin; 
    T5GATE = 0x0;
    //TMRCS FOSC/4; 
    T5CLK = 0x1;
    //TMRH 11; 
    TMR5H = 0xB;
    //TMRL 220; 
    TMR5L = 0xDC;

    // Load the TMR5 value to reload variable
    timer5ReloadVal=((uint16_t)TMR5H << 8) | TMR5L;

    //Set default callback for TMR5 overflow interrupt
    TMR5_OverflowCallbackRegister(TMR5_DefaultOverflowCallback);

    //Set default callback for TMR5 gate interrupt
    TMR5_GateCallbackRegister(TMR5_DefaultGateCallback);

    // Clearing TMRI IF flag before enabling the interrupt.
     PIR4bits.TMR5IF = 0;
    // Enabling TMRI interrupt.
     PIE4bits.TMR5IE = 1;
    
    //TMRON enabled; TRD16 enabled; nTSYNC synchronize; TCKPS 1:8; 
    T5CON = 0x33;
}

void TMR5_Start(void)
{
    // Start the Timer by writing to TMRxON bit
    T5CONbits.TMR5ON = 1;
}

void TMR5_Stop(void)
{
    // Stop the Timer by writing to TMRxON bit
    T5CONbits.TMR5ON = 0;
}

uint16_t TMR5_Read(void)
{
    uint16_t readVal;
    uint8_t readValHigh;
    uint8_t readValLow;
    	
    readValLow = TMR5L;
    readValHigh = TMR5H;
    
    readVal = ((uint16_t)readValHigh << 8) | readValLow;

    return readVal;
}

void TMR5_Write(size_t timerVal)
{
    if (T5CONbits.nT5SYNC == 1)
    {
        // Stop the Timer by writing to TMRxON bit
        T5CONbits.TMR5ON = 0;

        // Write to the Timer5 register
        TMR5H = (uint8_t)(timerVal >> 8);
        TMR5L = (uint8_t)timerVal;

        // Start the Timer after writing to the register
        T5CONbits.TMR5ON = 1;
    }
    else
    {
        // Write to the Timer5 register
        TMR5H = (uint8_t)(timerVal >> 8);
        TMR5L = (uint8_t)timerVal;
    }
}

void TMR5_Reload(void)
{
    TMR5_Write(timer5ReloadVal);
}

void TMR5_PeriodCountSet(size_t periodVal)
{
   timer5ReloadVal = (uint16_t) periodVal;
}

void TMR5_StartSinglePulseAcquisition(void)
{
    T5GCONbits.T5GGO = 1;
}

uint8_t TMR5_CheckGateValueStatus(void)
{
    return (T5GCONbits.T5GVAL);
}

void TMR5_OverflowISR(void)
{

    // Clear the TMR5 interrupt flag
    PIR4bits.TMR5IF = 0;
    TMR5_Write(timer5ReloadVal);

    if(TMR5_OverflowCallback)
    {
        TMR5_OverflowCallback();
    }
}

void TMR5_OverflowCallbackRegister(void (* CallbackHandler)(void))
{
    TMR5_OverflowCallback = CallbackHandler;
}

static void TMR5_DefaultOverflowCallback(void)
{
    //Add your interrupt code here or
    //Use TMR5_OverflowCallbackRegister function to use Custom ISR
}

bool TMR5_HasOverflowOccured(void)
{
    return(PIR4bits.TMR5IF);
}

void TMR5_GateISR(void)
{
    // clear the TMR5 interrupt flag
    PIR5bits.TMR5GIF = 0;
    if(TMR5_GateCallback)
    {
        TMR5_GateCallback();
    }
}

void TMR5_GateCallbackRegister(void (* CallbackHandler)(void))
{
    TMR5_GateCallback = CallbackHandler;
}

static void TMR5_DefaultGateCallback(void)
{
    //Add your interrupt code here or
    //Use TMR5_GateCallbackRegister function to use Custom ISR
}


/**
  End of File
*/
