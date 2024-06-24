/**
 * Generated Pins header File
 * 
 * @file pins.h
 * 
 * @defgroup  pinsdriver Pins Driver
 * 
 * @brief This is generated driver header for pins. 
 *        This header file provides APIs for all pins selected in the GUI.
 *
 * @version Driver Version  3.1.0
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

#ifndef PINS_H
#define PINS_H

#include <xc.h>

#define INPUT   1
#define OUTPUT  0

#define HIGH    1
#define LOW     0

#define ANALOG      1
#define DIGITAL     0

#define PULL_UP_ENABLED      1
#define PULL_UP_DISABLED     0

// get/set RA0 aliases
#define ANAIN1_TRIS                 TRISAbits.TRISA0
#define ANAIN1_LAT                  LATAbits.LATA0
#define ANAIN1_PORT                 PORTAbits.RA0
#define ANAIN1_WPU                  WPUAbits.WPUA0
#define ANAIN1_OD                   ODCONAbits.ODCA0
#define ANAIN1_ANS                  ANSELAbits.ANSELA0
#define ANAIN1_SetHigh()            do { LATAbits.LATA0 = 1; } while(0)
#define ANAIN1_SetLow()             do { LATAbits.LATA0 = 0; } while(0)
#define ANAIN1_Toggle()             do { LATAbits.LATA0 = ~LATAbits.LATA0; } while(0)
#define ANAIN1_GetValue()           PORTAbits.RA0
#define ANAIN1_SetDigitalInput()    do { TRISAbits.TRISA0 = 1; } while(0)
#define ANAIN1_SetDigitalOutput()   do { TRISAbits.TRISA0 = 0; } while(0)
#define ANAIN1_SetPullup()          do { WPUAbits.WPUA0 = 1; } while(0)
#define ANAIN1_ResetPullup()        do { WPUAbits.WPUA0 = 0; } while(0)
#define ANAIN1_SetPushPull()        do { ODCONAbits.ODCA0 = 0; } while(0)
#define ANAIN1_SetOpenDrain()       do { ODCONAbits.ODCA0 = 1; } while(0)
#define ANAIN1_SetAnalogMode()      do { ANSELAbits.ANSELA0 = 1; } while(0)
#define ANAIN1_SetDigitalMode()     do { ANSELAbits.ANSELA0 = 0; } while(0)

// get/set RA1 aliases
#define ANAIN2_TRIS                 TRISAbits.TRISA1
#define ANAIN2_LAT                  LATAbits.LATA1
#define ANAIN2_PORT                 PORTAbits.RA1
#define ANAIN2_WPU                  WPUAbits.WPUA1
#define ANAIN2_OD                   ODCONAbits.ODCA1
#define ANAIN2_ANS                  ANSELAbits.ANSELA1
#define ANAIN2_SetHigh()            do { LATAbits.LATA1 = 1; } while(0)
#define ANAIN2_SetLow()             do { LATAbits.LATA1 = 0; } while(0)
#define ANAIN2_Toggle()             do { LATAbits.LATA1 = ~LATAbits.LATA1; } while(0)
#define ANAIN2_GetValue()           PORTAbits.RA1
#define ANAIN2_SetDigitalInput()    do { TRISAbits.TRISA1 = 1; } while(0)
#define ANAIN2_SetDigitalOutput()   do { TRISAbits.TRISA1 = 0; } while(0)
#define ANAIN2_SetPullup()          do { WPUAbits.WPUA1 = 1; } while(0)
#define ANAIN2_ResetPullup()        do { WPUAbits.WPUA1 = 0; } while(0)
#define ANAIN2_SetPushPull()        do { ODCONAbits.ODCA1 = 0; } while(0)
#define ANAIN2_SetOpenDrain()       do { ODCONAbits.ODCA1 = 1; } while(0)
#define ANAIN2_SetAnalogMode()      do { ANSELAbits.ANSELA1 = 1; } while(0)
#define ANAIN2_SetDigitalMode()     do { ANSELAbits.ANSELA1 = 0; } while(0)

// get/set RA2 aliases
#define ANAIN3_TRIS                 TRISAbits.TRISA2
#define ANAIN3_LAT                  LATAbits.LATA2
#define ANAIN3_PORT                 PORTAbits.RA2
#define ANAIN3_WPU                  WPUAbits.WPUA2
#define ANAIN3_OD                   ODCONAbits.ODCA2
#define ANAIN3_ANS                  ANSELAbits.ANSELA2
#define ANAIN3_SetHigh()            do { LATAbits.LATA2 = 1; } while(0)
#define ANAIN3_SetLow()             do { LATAbits.LATA2 = 0; } while(0)
#define ANAIN3_Toggle()             do { LATAbits.LATA2 = ~LATAbits.LATA2; } while(0)
#define ANAIN3_GetValue()           PORTAbits.RA2
#define ANAIN3_SetDigitalInput()    do { TRISAbits.TRISA2 = 1; } while(0)
#define ANAIN3_SetDigitalOutput()   do { TRISAbits.TRISA2 = 0; } while(0)
#define ANAIN3_SetPullup()          do { WPUAbits.WPUA2 = 1; } while(0)
#define ANAIN3_ResetPullup()        do { WPUAbits.WPUA2 = 0; } while(0)
#define ANAIN3_SetPushPull()        do { ODCONAbits.ODCA2 = 0; } while(0)
#define ANAIN3_SetOpenDrain()       do { ODCONAbits.ODCA2 = 1; } while(0)
#define ANAIN3_SetAnalogMode()      do { ANSELAbits.ANSELA2 = 1; } while(0)
#define ANAIN3_SetDigitalMode()     do { ANSELAbits.ANSELA2 = 0; } while(0)

// get/set RA3 aliases
#define ANAIN4_TRIS                 TRISAbits.TRISA3
#define ANAIN4_LAT                  LATAbits.LATA3
#define ANAIN4_PORT                 PORTAbits.RA3
#define ANAIN4_WPU                  WPUAbits.WPUA3
#define ANAIN4_OD                   ODCONAbits.ODCA3
#define ANAIN4_ANS                  ANSELAbits.ANSELA3
#define ANAIN4_SetHigh()            do { LATAbits.LATA3 = 1; } while(0)
#define ANAIN4_SetLow()             do { LATAbits.LATA3 = 0; } while(0)
#define ANAIN4_Toggle()             do { LATAbits.LATA3 = ~LATAbits.LATA3; } while(0)
#define ANAIN4_GetValue()           PORTAbits.RA3
#define ANAIN4_SetDigitalInput()    do { TRISAbits.TRISA3 = 1; } while(0)
#define ANAIN4_SetDigitalOutput()   do { TRISAbits.TRISA3 = 0; } while(0)
#define ANAIN4_SetPullup()          do { WPUAbits.WPUA3 = 1; } while(0)
#define ANAIN4_ResetPullup()        do { WPUAbits.WPUA3 = 0; } while(0)
#define ANAIN4_SetPushPull()        do { ODCONAbits.ODCA3 = 0; } while(0)
#define ANAIN4_SetOpenDrain()       do { ODCONAbits.ODCA3 = 1; } while(0)
#define ANAIN4_SetAnalogMode()      do { ANSELAbits.ANSELA3 = 1; } while(0)
#define ANAIN4_SetDigitalMode()     do { ANSELAbits.ANSELA3 = 0; } while(0)

// get/set RA4 aliases
#define LED_TRIS                 TRISAbits.TRISA4
#define LED_LAT                  LATAbits.LATA4
#define LED_PORT                 PORTAbits.RA4
#define LED_WPU                  WPUAbits.WPUA4
#define LED_OD                   ODCONAbits.ODCA4
#define LED_ANS                  ANSELAbits.ANSELA4
#define LED_SetHigh()            do { LATAbits.LATA4 = 1; } while(0)
#define LED_SetLow()             do { LATAbits.LATA4 = 0; } while(0)
#define LED_Toggle()             do { LATAbits.LATA4 = ~LATAbits.LATA4; } while(0)
#define LED_GetValue()           PORTAbits.RA4
#define LED_SetDigitalInput()    do { TRISAbits.TRISA4 = 1; } while(0)
#define LED_SetDigitalOutput()   do { TRISAbits.TRISA4 = 0; } while(0)
#define LED_SetPullup()          do { WPUAbits.WPUA4 = 1; } while(0)
#define LED_ResetPullup()        do { WPUAbits.WPUA4 = 0; } while(0)
#define LED_SetPushPull()        do { ODCONAbits.ODCA4 = 0; } while(0)
#define LED_SetOpenDrain()       do { ODCONAbits.ODCA4 = 1; } while(0)
#define LED_SetAnalogMode()      do { ANSELAbits.ANSELA4 = 1; } while(0)
#define LED_SetDigitalMode()     do { ANSELAbits.ANSELA4 = 0; } while(0)

// get/set RA5 aliases
#define RELE1_TRIS                 TRISAbits.TRISA5
#define RELE1_LAT                  LATAbits.LATA5
#define RELE1_PORT                 PORTAbits.RA5
#define RELE1_WPU                  WPUAbits.WPUA5
#define RELE1_OD                   ODCONAbits.ODCA5
#define RELE1_ANS                  ANSELAbits.ANSELA5
#define RELE1_SetHigh()            do { LATAbits.LATA5 = 1; } while(0)
#define RELE1_SetLow()             do { LATAbits.LATA5 = 0; } while(0)
#define RELE1_Toggle()             do { LATAbits.LATA5 = ~LATAbits.LATA5; } while(0)
#define RELE1_GetValue()           PORTAbits.RA5
#define RELE1_SetDigitalInput()    do { TRISAbits.TRISA5 = 1; } while(0)
#define RELE1_SetDigitalOutput()   do { TRISAbits.TRISA5 = 0; } while(0)
#define RELE1_SetPullup()          do { WPUAbits.WPUA5 = 1; } while(0)
#define RELE1_ResetPullup()        do { WPUAbits.WPUA5 = 0; } while(0)
#define RELE1_SetPushPull()        do { ODCONAbits.ODCA5 = 0; } while(0)
#define RELE1_SetOpenDrain()       do { ODCONAbits.ODCA5 = 1; } while(0)
#define RELE1_SetAnalogMode()      do { ANSELAbits.ANSELA5 = 1; } while(0)
#define RELE1_SetDigitalMode()     do { ANSELAbits.ANSELA5 = 0; } while(0)

// get/set RB0 aliases
#define ANAOUT1_TRIS                 TRISBbits.TRISB0
#define ANAOUT1_LAT                  LATBbits.LATB0
#define ANAOUT1_PORT                 PORTBbits.RB0
#define ANAOUT1_WPU                  WPUBbits.WPUB0
#define ANAOUT1_OD                   ODCONBbits.ODCB0
#define ANAOUT1_ANS                  ANSELBbits.ANSELB0
#define ANAOUT1_SetHigh()            do { LATBbits.LATB0 = 1; } while(0)
#define ANAOUT1_SetLow()             do { LATBbits.LATB0 = 0; } while(0)
#define ANAOUT1_Toggle()             do { LATBbits.LATB0 = ~LATBbits.LATB0; } while(0)
#define ANAOUT1_GetValue()           PORTBbits.RB0
#define ANAOUT1_SetDigitalInput()    do { TRISBbits.TRISB0 = 1; } while(0)
#define ANAOUT1_SetDigitalOutput()   do { TRISBbits.TRISB0 = 0; } while(0)
#define ANAOUT1_SetPullup()          do { WPUBbits.WPUB0 = 1; } while(0)
#define ANAOUT1_ResetPullup()        do { WPUBbits.WPUB0 = 0; } while(0)
#define ANAOUT1_SetPushPull()        do { ODCONBbits.ODCB0 = 0; } while(0)
#define ANAOUT1_SetOpenDrain()       do { ODCONBbits.ODCB0 = 1; } while(0)
#define ANAOUT1_SetAnalogMode()      do { ANSELBbits.ANSELB0 = 1; } while(0)
#define ANAOUT1_SetDigitalMode()     do { ANSELBbits.ANSELB0 = 0; } while(0)

// get/set RB1 aliases
#define ANAOUT2_TRIS                 TRISBbits.TRISB1
#define ANAOUT2_LAT                  LATBbits.LATB1
#define ANAOUT2_PORT                 PORTBbits.RB1
#define ANAOUT2_WPU                  WPUBbits.WPUB1
#define ANAOUT2_OD                   ODCONBbits.ODCB1
#define ANAOUT2_ANS                  ANSELBbits.ANSELB1
#define ANAOUT2_SetHigh()            do { LATBbits.LATB1 = 1; } while(0)
#define ANAOUT2_SetLow()             do { LATBbits.LATB1 = 0; } while(0)
#define ANAOUT2_Toggle()             do { LATBbits.LATB1 = ~LATBbits.LATB1; } while(0)
#define ANAOUT2_GetValue()           PORTBbits.RB1
#define ANAOUT2_SetDigitalInput()    do { TRISBbits.TRISB1 = 1; } while(0)
#define ANAOUT2_SetDigitalOutput()   do { TRISBbits.TRISB1 = 0; } while(0)
#define ANAOUT2_SetPullup()          do { WPUBbits.WPUB1 = 1; } while(0)
#define ANAOUT2_ResetPullup()        do { WPUBbits.WPUB1 = 0; } while(0)
#define ANAOUT2_SetPushPull()        do { ODCONBbits.ODCB1 = 0; } while(0)
#define ANAOUT2_SetOpenDrain()       do { ODCONBbits.ODCB1 = 1; } while(0)
#define ANAOUT2_SetAnalogMode()      do { ANSELBbits.ANSELB1 = 1; } while(0)
#define ANAOUT2_SetDigitalMode()     do { ANSELBbits.ANSELB1 = 0; } while(0)

// get/set RB2 aliases
#define ANAOUT3_TRIS                 TRISBbits.TRISB2
#define ANAOUT3_LAT                  LATBbits.LATB2
#define ANAOUT3_PORT                 PORTBbits.RB2
#define ANAOUT3_WPU                  WPUBbits.WPUB2
#define ANAOUT3_OD                   ODCONBbits.ODCB2
#define ANAOUT3_ANS                  ANSELBbits.ANSELB2
#define ANAOUT3_SetHigh()            do { LATBbits.LATB2 = 1; } while(0)
#define ANAOUT3_SetLow()             do { LATBbits.LATB2 = 0; } while(0)
#define ANAOUT3_Toggle()             do { LATBbits.LATB2 = ~LATBbits.LATB2; } while(0)
#define ANAOUT3_GetValue()           PORTBbits.RB2
#define ANAOUT3_SetDigitalInput()    do { TRISBbits.TRISB2 = 1; } while(0)
#define ANAOUT3_SetDigitalOutput()   do { TRISBbits.TRISB2 = 0; } while(0)
#define ANAOUT3_SetPullup()          do { WPUBbits.WPUB2 = 1; } while(0)
#define ANAOUT3_ResetPullup()        do { WPUBbits.WPUB2 = 0; } while(0)
#define ANAOUT3_SetPushPull()        do { ODCONBbits.ODCB2 = 0; } while(0)
#define ANAOUT3_SetOpenDrain()       do { ODCONBbits.ODCB2 = 1; } while(0)
#define ANAOUT3_SetAnalogMode()      do { ANSELBbits.ANSELB2 = 1; } while(0)
#define ANAOUT3_SetDigitalMode()     do { ANSELBbits.ANSELB2 = 0; } while(0)

// get/set RB3 aliases
#define RX_TRIS                 TRISBbits.TRISB3
#define RX_LAT                  LATBbits.LATB3
#define RX_PORT                 PORTBbits.RB3
#define RX_WPU                  WPUBbits.WPUB3
#define RX_OD                   ODCONBbits.ODCB3
#define RX_ANS                  ANSELBbits.ANSELB3
#define RX_SetHigh()            do { LATBbits.LATB3 = 1; } while(0)
#define RX_SetLow()             do { LATBbits.LATB3 = 0; } while(0)
#define RX_Toggle()             do { LATBbits.LATB3 = ~LATBbits.LATB3; } while(0)
#define RX_GetValue()           PORTBbits.RB3
#define RX_SetDigitalInput()    do { TRISBbits.TRISB3 = 1; } while(0)
#define RX_SetDigitalOutput()   do { TRISBbits.TRISB3 = 0; } while(0)
#define RX_SetPullup()          do { WPUBbits.WPUB3 = 1; } while(0)
#define RX_ResetPullup()        do { WPUBbits.WPUB3 = 0; } while(0)
#define RX_SetPushPull()        do { ODCONBbits.ODCB3 = 0; } while(0)
#define RX_SetOpenDrain()       do { ODCONBbits.ODCB3 = 1; } while(0)
#define RX_SetAnalogMode()      do { ANSELBbits.ANSELB3 = 1; } while(0)
#define RX_SetDigitalMode()     do { ANSELBbits.ANSELB3 = 0; } while(0)

// get/set RB4 aliases
#define TX_TRIS                 TRISBbits.TRISB4
#define TX_LAT                  LATBbits.LATB4
#define TX_PORT                 PORTBbits.RB4
#define TX_WPU                  WPUBbits.WPUB4
#define TX_OD                   ODCONBbits.ODCB4
#define TX_ANS                  ANSELBbits.ANSELB4
#define TX_SetHigh()            do { LATBbits.LATB4 = 1; } while(0)
#define TX_SetLow()             do { LATBbits.LATB4 = 0; } while(0)
#define TX_Toggle()             do { LATBbits.LATB4 = ~LATBbits.LATB4; } while(0)
#define TX_GetValue()           PORTBbits.RB4
#define TX_SetDigitalInput()    do { TRISBbits.TRISB4 = 1; } while(0)
#define TX_SetDigitalOutput()   do { TRISBbits.TRISB4 = 0; } while(0)
#define TX_SetPullup()          do { WPUBbits.WPUB4 = 1; } while(0)
#define TX_ResetPullup()        do { WPUBbits.WPUB4 = 0; } while(0)
#define TX_SetPushPull()        do { ODCONBbits.ODCB4 = 0; } while(0)
#define TX_SetOpenDrain()       do { ODCONBbits.ODCB4 = 1; } while(0)
#define TX_SetAnalogMode()      do { ANSELBbits.ANSELB4 = 1; } while(0)
#define TX_SetDigitalMode()     do { ANSELBbits.ANSELB4 = 0; } while(0)

// get/set RB5 aliases
#define ANAOUT4_TRIS                 TRISBbits.TRISB5
#define ANAOUT4_LAT                  LATBbits.LATB5
#define ANAOUT4_PORT                 PORTBbits.RB5
#define ANAOUT4_WPU                  WPUBbits.WPUB5
#define ANAOUT4_OD                   ODCONBbits.ODCB5
#define ANAOUT4_ANS                  ANSELBbits.ANSELB5
#define ANAOUT4_SetHigh()            do { LATBbits.LATB5 = 1; } while(0)
#define ANAOUT4_SetLow()             do { LATBbits.LATB5 = 0; } while(0)
#define ANAOUT4_Toggle()             do { LATBbits.LATB5 = ~LATBbits.LATB5; } while(0)
#define ANAOUT4_GetValue()           PORTBbits.RB5
#define ANAOUT4_SetDigitalInput()    do { TRISBbits.TRISB5 = 1; } while(0)
#define ANAOUT4_SetDigitalOutput()   do { TRISBbits.TRISB5 = 0; } while(0)
#define ANAOUT4_SetPullup()          do { WPUBbits.WPUB5 = 1; } while(0)
#define ANAOUT4_ResetPullup()        do { WPUBbits.WPUB5 = 0; } while(0)
#define ANAOUT4_SetPushPull()        do { ODCONBbits.ODCB5 = 0; } while(0)
#define ANAOUT4_SetOpenDrain()       do { ODCONBbits.ODCB5 = 1; } while(0)
#define ANAOUT4_SetAnalogMode()      do { ANSELBbits.ANSELB5 = 1; } while(0)
#define ANAOUT4_SetDigitalMode()     do { ANSELBbits.ANSELB5 = 0; } while(0)

// get/set RC0 aliases
#define DIG1_TRIS                 TRISCbits.TRISC0
#define DIG1_LAT                  LATCbits.LATC0
#define DIG1_PORT                 PORTCbits.RC0
#define DIG1_WPU                  WPUCbits.WPUC0
#define DIG1_OD                   ODCONCbits.ODCC0
#define DIG1_ANS                  ANSELCbits.ANSELC0
#define DIG1_SetHigh()            do { LATCbits.LATC0 = 1; } while(0)
#define DIG1_SetLow()             do { LATCbits.LATC0 = 0; } while(0)
#define DIG1_Toggle()             do { LATCbits.LATC0 = ~LATCbits.LATC0; } while(0)
#define DIG1_GetValue()           PORTCbits.RC0
#define DIG1_SetDigitalInput()    do { TRISCbits.TRISC0 = 1; } while(0)
#define DIG1_SetDigitalOutput()   do { TRISCbits.TRISC0 = 0; } while(0)
#define DIG1_SetPullup()          do { WPUCbits.WPUC0 = 1; } while(0)
#define DIG1_ResetPullup()        do { WPUCbits.WPUC0 = 0; } while(0)
#define DIG1_SetPushPull()        do { ODCONCbits.ODCC0 = 0; } while(0)
#define DIG1_SetOpenDrain()       do { ODCONCbits.ODCC0 = 1; } while(0)
#define DIG1_SetAnalogMode()      do { ANSELCbits.ANSELC0 = 1; } while(0)
#define DIG1_SetDigitalMode()     do { ANSELCbits.ANSELC0 = 0; } while(0)

// get/set RC1 aliases
#define DIG2_TRIS                 TRISCbits.TRISC1
#define DIG2_LAT                  LATCbits.LATC1
#define DIG2_PORT                 PORTCbits.RC1
#define DIG2_WPU                  WPUCbits.WPUC1
#define DIG2_OD                   ODCONCbits.ODCC1
#define DIG2_ANS                  ANSELCbits.ANSELC1
#define DIG2_SetHigh()            do { LATCbits.LATC1 = 1; } while(0)
#define DIG2_SetLow()             do { LATCbits.LATC1 = 0; } while(0)
#define DIG2_Toggle()             do { LATCbits.LATC1 = ~LATCbits.LATC1; } while(0)
#define DIG2_GetValue()           PORTCbits.RC1
#define DIG2_SetDigitalInput()    do { TRISCbits.TRISC1 = 1; } while(0)
#define DIG2_SetDigitalOutput()   do { TRISCbits.TRISC1 = 0; } while(0)
#define DIG2_SetPullup()          do { WPUCbits.WPUC1 = 1; } while(0)
#define DIG2_ResetPullup()        do { WPUCbits.WPUC1 = 0; } while(0)
#define DIG2_SetPushPull()        do { ODCONCbits.ODCC1 = 0; } while(0)
#define DIG2_SetOpenDrain()       do { ODCONCbits.ODCC1 = 1; } while(0)
#define DIG2_SetAnalogMode()      do { ANSELCbits.ANSELC1 = 1; } while(0)
#define DIG2_SetDigitalMode()     do { ANSELCbits.ANSELC1 = 0; } while(0)

// get/set RC2 aliases
#define DIG3_TRIS                 TRISCbits.TRISC2
#define DIG3_LAT                  LATCbits.LATC2
#define DIG3_PORT                 PORTCbits.RC2
#define DIG3_WPU                  WPUCbits.WPUC2
#define DIG3_OD                   ODCONCbits.ODCC2
#define DIG3_ANS                  ANSELCbits.ANSELC2
#define DIG3_SetHigh()            do { LATCbits.LATC2 = 1; } while(0)
#define DIG3_SetLow()             do { LATCbits.LATC2 = 0; } while(0)
#define DIG3_Toggle()             do { LATCbits.LATC2 = ~LATCbits.LATC2; } while(0)
#define DIG3_GetValue()           PORTCbits.RC2
#define DIG3_SetDigitalInput()    do { TRISCbits.TRISC2 = 1; } while(0)
#define DIG3_SetDigitalOutput()   do { TRISCbits.TRISC2 = 0; } while(0)
#define DIG3_SetPullup()          do { WPUCbits.WPUC2 = 1; } while(0)
#define DIG3_ResetPullup()        do { WPUCbits.WPUC2 = 0; } while(0)
#define DIG3_SetPushPull()        do { ODCONCbits.ODCC2 = 0; } while(0)
#define DIG3_SetOpenDrain()       do { ODCONCbits.ODCC2 = 1; } while(0)
#define DIG3_SetAnalogMode()      do { ANSELCbits.ANSELC2 = 1; } while(0)
#define DIG3_SetDigitalMode()     do { ANSELCbits.ANSELC2 = 0; } while(0)

// get/set RC3 aliases
#define DIG4_TRIS                 TRISCbits.TRISC3
#define DIG4_LAT                  LATCbits.LATC3
#define DIG4_PORT                 PORTCbits.RC3
#define DIG4_WPU                  WPUCbits.WPUC3
#define DIG4_OD                   ODCONCbits.ODCC3
#define DIG4_ANS                  ANSELCbits.ANSELC3
#define DIG4_SetHigh()            do { LATCbits.LATC3 = 1; } while(0)
#define DIG4_SetLow()             do { LATCbits.LATC3 = 0; } while(0)
#define DIG4_Toggle()             do { LATCbits.LATC3 = ~LATCbits.LATC3; } while(0)
#define DIG4_GetValue()           PORTCbits.RC3
#define DIG4_SetDigitalInput()    do { TRISCbits.TRISC3 = 1; } while(0)
#define DIG4_SetDigitalOutput()   do { TRISCbits.TRISC3 = 0; } while(0)
#define DIG4_SetPullup()          do { WPUCbits.WPUC3 = 1; } while(0)
#define DIG4_ResetPullup()        do { WPUCbits.WPUC3 = 0; } while(0)
#define DIG4_SetPushPull()        do { ODCONCbits.ODCC3 = 0; } while(0)
#define DIG4_SetOpenDrain()       do { ODCONCbits.ODCC3 = 1; } while(0)
#define DIG4_SetAnalogMode()      do { ANSELCbits.ANSELC3 = 1; } while(0)
#define DIG4_SetDigitalMode()     do { ANSELCbits.ANSELC3 = 0; } while(0)

// get/set RC4 aliases
#define DIG9_TRIS                 TRISCbits.TRISC4
#define DIG9_LAT                  LATCbits.LATC4
#define DIG9_PORT                 PORTCbits.RC4
#define DIG9_WPU                  WPUCbits.WPUC4
#define DIG9_OD                   ODCONCbits.ODCC4
#define DIG9_ANS                  ANSELCbits.ANSELC4
#define DIG9_SetHigh()            do { LATCbits.LATC4 = 1; } while(0)
#define DIG9_SetLow()             do { LATCbits.LATC4 = 0; } while(0)
#define DIG9_Toggle()             do { LATCbits.LATC4 = ~LATCbits.LATC4; } while(0)
#define DIG9_GetValue()           PORTCbits.RC4
#define DIG9_SetDigitalInput()    do { TRISCbits.TRISC4 = 1; } while(0)
#define DIG9_SetDigitalOutput()   do { TRISCbits.TRISC4 = 0; } while(0)
#define DIG9_SetPullup()          do { WPUCbits.WPUC4 = 1; } while(0)
#define DIG9_ResetPullup()        do { WPUCbits.WPUC4 = 0; } while(0)
#define DIG9_SetPushPull()        do { ODCONCbits.ODCC4 = 0; } while(0)
#define DIG9_SetOpenDrain()       do { ODCONCbits.ODCC4 = 1; } while(0)
#define DIG9_SetAnalogMode()      do { ANSELCbits.ANSELC4 = 1; } while(0)
#define DIG9_SetDigitalMode()     do { ANSELCbits.ANSELC4 = 0; } while(0)

// get/set RC5 aliases
#define DIG10_TRIS                 TRISCbits.TRISC5
#define DIG10_LAT                  LATCbits.LATC5
#define DIG10_PORT                 PORTCbits.RC5
#define DIG10_WPU                  WPUCbits.WPUC5
#define DIG10_OD                   ODCONCbits.ODCC5
#define DIG10_ANS                  ANSELCbits.ANSELC5
#define DIG10_SetHigh()            do { LATCbits.LATC5 = 1; } while(0)
#define DIG10_SetLow()             do { LATCbits.LATC5 = 0; } while(0)
#define DIG10_Toggle()             do { LATCbits.LATC5 = ~LATCbits.LATC5; } while(0)
#define DIG10_GetValue()           PORTCbits.RC5
#define DIG10_SetDigitalInput()    do { TRISCbits.TRISC5 = 1; } while(0)
#define DIG10_SetDigitalOutput()   do { TRISCbits.TRISC5 = 0; } while(0)
#define DIG10_SetPullup()          do { WPUCbits.WPUC5 = 1; } while(0)
#define DIG10_ResetPullup()        do { WPUCbits.WPUC5 = 0; } while(0)
#define DIG10_SetPushPull()        do { ODCONCbits.ODCC5 = 0; } while(0)
#define DIG10_SetOpenDrain()       do { ODCONCbits.ODCC5 = 1; } while(0)
#define DIG10_SetAnalogMode()      do { ANSELCbits.ANSELC5 = 1; } while(0)
#define DIG10_SetDigitalMode()     do { ANSELCbits.ANSELC5 = 0; } while(0)

// get/set RC6 aliases
#define DIG11_TRIS                 TRISCbits.TRISC6
#define DIG11_LAT                  LATCbits.LATC6
#define DIG11_PORT                 PORTCbits.RC6
#define DIG11_WPU                  WPUCbits.WPUC6
#define DIG11_OD                   ODCONCbits.ODCC6
#define DIG11_ANS                  ANSELCbits.ANSELC6
#define DIG11_SetHigh()            do { LATCbits.LATC6 = 1; } while(0)
#define DIG11_SetLow()             do { LATCbits.LATC6 = 0; } while(0)
#define DIG11_Toggle()             do { LATCbits.LATC6 = ~LATCbits.LATC6; } while(0)
#define DIG11_GetValue()           PORTCbits.RC6
#define DIG11_SetDigitalInput()    do { TRISCbits.TRISC6 = 1; } while(0)
#define DIG11_SetDigitalOutput()   do { TRISCbits.TRISC6 = 0; } while(0)
#define DIG11_SetPullup()          do { WPUCbits.WPUC6 = 1; } while(0)
#define DIG11_ResetPullup()        do { WPUCbits.WPUC6 = 0; } while(0)
#define DIG11_SetPushPull()        do { ODCONCbits.ODCC6 = 0; } while(0)
#define DIG11_SetOpenDrain()       do { ODCONCbits.ODCC6 = 1; } while(0)
#define DIG11_SetAnalogMode()      do { ANSELCbits.ANSELC6 = 1; } while(0)
#define DIG11_SetDigitalMode()     do { ANSELCbits.ANSELC6 = 0; } while(0)

// get/set RC7 aliases
#define DIG12_TRIS                 TRISCbits.TRISC7
#define DIG12_LAT                  LATCbits.LATC7
#define DIG12_PORT                 PORTCbits.RC7
#define DIG12_WPU                  WPUCbits.WPUC7
#define DIG12_OD                   ODCONCbits.ODCC7
#define DIG12_ANS                  ANSELCbits.ANSELC7
#define DIG12_SetHigh()            do { LATCbits.LATC7 = 1; } while(0)
#define DIG12_SetLow()             do { LATCbits.LATC7 = 0; } while(0)
#define DIG12_Toggle()             do { LATCbits.LATC7 = ~LATCbits.LATC7; } while(0)
#define DIG12_GetValue()           PORTCbits.RC7
#define DIG12_SetDigitalInput()    do { TRISCbits.TRISC7 = 1; } while(0)
#define DIG12_SetDigitalOutput()   do { TRISCbits.TRISC7 = 0; } while(0)
#define DIG12_SetPullup()          do { WPUCbits.WPUC7 = 1; } while(0)
#define DIG12_ResetPullup()        do { WPUCbits.WPUC7 = 0; } while(0)
#define DIG12_SetPushPull()        do { ODCONCbits.ODCC7 = 0; } while(0)
#define DIG12_SetOpenDrain()       do { ODCONCbits.ODCC7 = 1; } while(0)
#define DIG12_SetAnalogMode()      do { ANSELCbits.ANSELC7 = 1; } while(0)
#define DIG12_SetDigitalMode()     do { ANSELCbits.ANSELC7 = 0; } while(0)

// get/set RD0 aliases
#define DIG5_TRIS                 TRISDbits.TRISD0
#define DIG5_LAT                  LATDbits.LATD0
#define DIG5_PORT                 PORTDbits.RD0
#define DIG5_WPU                  WPUDbits.WPUD0
#define DIG5_OD                   ODCONDbits.ODCD0
#define DIG5_ANS                  ANSELDbits.ANSELD0
#define DIG5_SetHigh()            do { LATDbits.LATD0 = 1; } while(0)
#define DIG5_SetLow()             do { LATDbits.LATD0 = 0; } while(0)
#define DIG5_Toggle()             do { LATDbits.LATD0 = ~LATDbits.LATD0; } while(0)
#define DIG5_GetValue()           PORTDbits.RD0
#define DIG5_SetDigitalInput()    do { TRISDbits.TRISD0 = 1; } while(0)
#define DIG5_SetDigitalOutput()   do { TRISDbits.TRISD0 = 0; } while(0)
#define DIG5_SetPullup()          do { WPUDbits.WPUD0 = 1; } while(0)
#define DIG5_ResetPullup()        do { WPUDbits.WPUD0 = 0; } while(0)
#define DIG5_SetPushPull()        do { ODCONDbits.ODCD0 = 0; } while(0)
#define DIG5_SetOpenDrain()       do { ODCONDbits.ODCD0 = 1; } while(0)
#define DIG5_SetAnalogMode()      do { ANSELDbits.ANSELD0 = 1; } while(0)
#define DIG5_SetDigitalMode()     do { ANSELDbits.ANSELD0 = 0; } while(0)

// get/set RD1 aliases
#define DIG6_TRIS                 TRISDbits.TRISD1
#define DIG6_LAT                  LATDbits.LATD1
#define DIG6_PORT                 PORTDbits.RD1
#define DIG6_WPU                  WPUDbits.WPUD1
#define DIG6_OD                   ODCONDbits.ODCD1
#define DIG6_ANS                  ANSELDbits.ANSELD1
#define DIG6_SetHigh()            do { LATDbits.LATD1 = 1; } while(0)
#define DIG6_SetLow()             do { LATDbits.LATD1 = 0; } while(0)
#define DIG6_Toggle()             do { LATDbits.LATD1 = ~LATDbits.LATD1; } while(0)
#define DIG6_GetValue()           PORTDbits.RD1
#define DIG6_SetDigitalInput()    do { TRISDbits.TRISD1 = 1; } while(0)
#define DIG6_SetDigitalOutput()   do { TRISDbits.TRISD1 = 0; } while(0)
#define DIG6_SetPullup()          do { WPUDbits.WPUD1 = 1; } while(0)
#define DIG6_ResetPullup()        do { WPUDbits.WPUD1 = 0; } while(0)
#define DIG6_SetPushPull()        do { ODCONDbits.ODCD1 = 0; } while(0)
#define DIG6_SetOpenDrain()       do { ODCONDbits.ODCD1 = 1; } while(0)
#define DIG6_SetAnalogMode()      do { ANSELDbits.ANSELD1 = 1; } while(0)
#define DIG6_SetDigitalMode()     do { ANSELDbits.ANSELD1 = 0; } while(0)

// get/set RD2 aliases
#define DIG7_TRIS                 TRISDbits.TRISD2
#define DIG7_LAT                  LATDbits.LATD2
#define DIG7_PORT                 PORTDbits.RD2
#define DIG7_WPU                  WPUDbits.WPUD2
#define DIG7_OD                   ODCONDbits.ODCD2
#define DIG7_ANS                  ANSELDbits.ANSELD2
#define DIG7_SetHigh()            do { LATDbits.LATD2 = 1; } while(0)
#define DIG7_SetLow()             do { LATDbits.LATD2 = 0; } while(0)
#define DIG7_Toggle()             do { LATDbits.LATD2 = ~LATDbits.LATD2; } while(0)
#define DIG7_GetValue()           PORTDbits.RD2
#define DIG7_SetDigitalInput()    do { TRISDbits.TRISD2 = 1; } while(0)
#define DIG7_SetDigitalOutput()   do { TRISDbits.TRISD2 = 0; } while(0)
#define DIG7_SetPullup()          do { WPUDbits.WPUD2 = 1; } while(0)
#define DIG7_ResetPullup()        do { WPUDbits.WPUD2 = 0; } while(0)
#define DIG7_SetPushPull()        do { ODCONDbits.ODCD2 = 0; } while(0)
#define DIG7_SetOpenDrain()       do { ODCONDbits.ODCD2 = 1; } while(0)
#define DIG7_SetAnalogMode()      do { ANSELDbits.ANSELD2 = 1; } while(0)
#define DIG7_SetDigitalMode()     do { ANSELDbits.ANSELD2 = 0; } while(0)

// get/set RD3 aliases
#define DIG8_TRIS                 TRISDbits.TRISD3
#define DIG8_LAT                  LATDbits.LATD3
#define DIG8_PORT                 PORTDbits.RD3
#define DIG8_WPU                  WPUDbits.WPUD3
#define DIG8_OD                   ODCONDbits.ODCD3
#define DIG8_ANS                  ANSELDbits.ANSELD3
#define DIG8_SetHigh()            do { LATDbits.LATD3 = 1; } while(0)
#define DIG8_SetLow()             do { LATDbits.LATD3 = 0; } while(0)
#define DIG8_Toggle()             do { LATDbits.LATD3 = ~LATDbits.LATD3; } while(0)
#define DIG8_GetValue()           PORTDbits.RD3
#define DIG8_SetDigitalInput()    do { TRISDbits.TRISD3 = 1; } while(0)
#define DIG8_SetDigitalOutput()   do { TRISDbits.TRISD3 = 0; } while(0)
#define DIG8_SetPullup()          do { WPUDbits.WPUD3 = 1; } while(0)
#define DIG8_ResetPullup()        do { WPUDbits.WPUD3 = 0; } while(0)
#define DIG8_SetPushPull()        do { ODCONDbits.ODCD3 = 0; } while(0)
#define DIG8_SetOpenDrain()       do { ODCONDbits.ODCD3 = 1; } while(0)
#define DIG8_SetAnalogMode()      do { ANSELDbits.ANSELD3 = 1; } while(0)
#define DIG8_SetDigitalMode()     do { ANSELDbits.ANSELD3 = 0; } while(0)

// get/set RD4 aliases
#define DIG13_TRIS                 TRISDbits.TRISD4
#define DIG13_LAT                  LATDbits.LATD4
#define DIG13_PORT                 PORTDbits.RD4
#define DIG13_WPU                  WPUDbits.WPUD4
#define DIG13_OD                   ODCONDbits.ODCD4
#define DIG13_ANS                  ANSELDbits.ANSELD4
#define DIG13_SetHigh()            do { LATDbits.LATD4 = 1; } while(0)
#define DIG13_SetLow()             do { LATDbits.LATD4 = 0; } while(0)
#define DIG13_Toggle()             do { LATDbits.LATD4 = ~LATDbits.LATD4; } while(0)
#define DIG13_GetValue()           PORTDbits.RD4
#define DIG13_SetDigitalInput()    do { TRISDbits.TRISD4 = 1; } while(0)
#define DIG13_SetDigitalOutput()   do { TRISDbits.TRISD4 = 0; } while(0)
#define DIG13_SetPullup()          do { WPUDbits.WPUD4 = 1; } while(0)
#define DIG13_ResetPullup()        do { WPUDbits.WPUD4 = 0; } while(0)
#define DIG13_SetPushPull()        do { ODCONDbits.ODCD4 = 0; } while(0)
#define DIG13_SetOpenDrain()       do { ODCONDbits.ODCD4 = 1; } while(0)
#define DIG13_SetAnalogMode()      do { ANSELDbits.ANSELD4 = 1; } while(0)
#define DIG13_SetDigitalMode()     do { ANSELDbits.ANSELD4 = 0; } while(0)

// get/set RD5 aliases
#define DIG14_TRIS                 TRISDbits.TRISD5
#define DIG14_LAT                  LATDbits.LATD5
#define DIG14_PORT                 PORTDbits.RD5
#define DIG14_WPU                  WPUDbits.WPUD5
#define DIG14_OD                   ODCONDbits.ODCD5
#define DIG14_ANS                  ANSELDbits.ANSELD5
#define DIG14_SetHigh()            do { LATDbits.LATD5 = 1; } while(0)
#define DIG14_SetLow()             do { LATDbits.LATD5 = 0; } while(0)
#define DIG14_Toggle()             do { LATDbits.LATD5 = ~LATDbits.LATD5; } while(0)
#define DIG14_GetValue()           PORTDbits.RD5
#define DIG14_SetDigitalInput()    do { TRISDbits.TRISD5 = 1; } while(0)
#define DIG14_SetDigitalOutput()   do { TRISDbits.TRISD5 = 0; } while(0)
#define DIG14_SetPullup()          do { WPUDbits.WPUD5 = 1; } while(0)
#define DIG14_ResetPullup()        do { WPUDbits.WPUD5 = 0; } while(0)
#define DIG14_SetPushPull()        do { ODCONDbits.ODCD5 = 0; } while(0)
#define DIG14_SetOpenDrain()       do { ODCONDbits.ODCD5 = 1; } while(0)
#define DIG14_SetAnalogMode()      do { ANSELDbits.ANSELD5 = 1; } while(0)
#define DIG14_SetDigitalMode()     do { ANSELDbits.ANSELD5 = 0; } while(0)

// get/set RD6 aliases
#define DIG15_TRIS                 TRISDbits.TRISD6
#define DIG15_LAT                  LATDbits.LATD6
#define DIG15_PORT                 PORTDbits.RD6
#define DIG15_WPU                  WPUDbits.WPUD6
#define DIG15_OD                   ODCONDbits.ODCD6
#define DIG15_ANS                  ANSELDbits.ANSELD6
#define DIG15_SetHigh()            do { LATDbits.LATD6 = 1; } while(0)
#define DIG15_SetLow()             do { LATDbits.LATD6 = 0; } while(0)
#define DIG15_Toggle()             do { LATDbits.LATD6 = ~LATDbits.LATD6; } while(0)
#define DIG15_GetValue()           PORTDbits.RD6
#define DIG15_SetDigitalInput()    do { TRISDbits.TRISD6 = 1; } while(0)
#define DIG15_SetDigitalOutput()   do { TRISDbits.TRISD6 = 0; } while(0)
#define DIG15_SetPullup()          do { WPUDbits.WPUD6 = 1; } while(0)
#define DIG15_ResetPullup()        do { WPUDbits.WPUD6 = 0; } while(0)
#define DIG15_SetPushPull()        do { ODCONDbits.ODCD6 = 0; } while(0)
#define DIG15_SetOpenDrain()       do { ODCONDbits.ODCD6 = 1; } while(0)
#define DIG15_SetAnalogMode()      do { ANSELDbits.ANSELD6 = 1; } while(0)
#define DIG15_SetDigitalMode()     do { ANSELDbits.ANSELD6 = 0; } while(0)

// get/set RD7 aliases
#define DIG16_TRIS                 TRISDbits.TRISD7
#define DIG16_LAT                  LATDbits.LATD7
#define DIG16_PORT                 PORTDbits.RD7
#define DIG16_WPU                  WPUDbits.WPUD7
#define DIG16_OD                   ODCONDbits.ODCD7
#define DIG16_ANS                  ANSELDbits.ANSELD7
#define DIG16_SetHigh()            do { LATDbits.LATD7 = 1; } while(0)
#define DIG16_SetLow()             do { LATDbits.LATD7 = 0; } while(0)
#define DIG16_Toggle()             do { LATDbits.LATD7 = ~LATDbits.LATD7; } while(0)
#define DIG16_GetValue()           PORTDbits.RD7
#define DIG16_SetDigitalInput()    do { TRISDbits.TRISD7 = 1; } while(0)
#define DIG16_SetDigitalOutput()   do { TRISDbits.TRISD7 = 0; } while(0)
#define DIG16_SetPullup()          do { WPUDbits.WPUD7 = 1; } while(0)
#define DIG16_ResetPullup()        do { WPUDbits.WPUD7 = 0; } while(0)
#define DIG16_SetPushPull()        do { ODCONDbits.ODCD7 = 0; } while(0)
#define DIG16_SetOpenDrain()       do { ODCONDbits.ODCD7 = 1; } while(0)
#define DIG16_SetAnalogMode()      do { ANSELDbits.ANSELD7 = 1; } while(0)
#define DIG16_SetDigitalMode()     do { ANSELDbits.ANSELD7 = 0; } while(0)

// get/set RE0 aliases
#define RELE2_TRIS                 TRISEbits.TRISE0
#define RELE2_LAT                  LATEbits.LATE0
#define RELE2_PORT                 PORTEbits.RE0
#define RELE2_WPU                  WPUEbits.WPUE0
#define RELE2_OD                   ODCONEbits.ODCE0
#define RELE2_ANS                  ANSELEbits.ANSELE0
#define RELE2_SetHigh()            do { LATEbits.LATE0 = 1; } while(0)
#define RELE2_SetLow()             do { LATEbits.LATE0 = 0; } while(0)
#define RELE2_Toggle()             do { LATEbits.LATE0 = ~LATEbits.LATE0; } while(0)
#define RELE2_GetValue()           PORTEbits.RE0
#define RELE2_SetDigitalInput()    do { TRISEbits.TRISE0 = 1; } while(0)
#define RELE2_SetDigitalOutput()   do { TRISEbits.TRISE0 = 0; } while(0)
#define RELE2_SetPullup()          do { WPUEbits.WPUE0 = 1; } while(0)
#define RELE2_ResetPullup()        do { WPUEbits.WPUE0 = 0; } while(0)
#define RELE2_SetPushPull()        do { ODCONEbits.ODCE0 = 0; } while(0)
#define RELE2_SetOpenDrain()       do { ODCONEbits.ODCE0 = 1; } while(0)
#define RELE2_SetAnalogMode()      do { ANSELEbits.ANSELE0 = 1; } while(0)
#define RELE2_SetDigitalMode()     do { ANSELEbits.ANSELE0 = 0; } while(0)

// get/set RE1 aliases
#define RELE3_TRIS                 TRISEbits.TRISE1
#define RELE3_LAT                  LATEbits.LATE1
#define RELE3_PORT                 PORTEbits.RE1
#define RELE3_WPU                  WPUEbits.WPUE1
#define RELE3_OD                   ODCONEbits.ODCE1
#define RELE3_ANS                  ANSELEbits.ANSELE1
#define RELE3_SetHigh()            do { LATEbits.LATE1 = 1; } while(0)
#define RELE3_SetLow()             do { LATEbits.LATE1 = 0; } while(0)
#define RELE3_Toggle()             do { LATEbits.LATE1 = ~LATEbits.LATE1; } while(0)
#define RELE3_GetValue()           PORTEbits.RE1
#define RELE3_SetDigitalInput()    do { TRISEbits.TRISE1 = 1; } while(0)
#define RELE3_SetDigitalOutput()   do { TRISEbits.TRISE1 = 0; } while(0)
#define RELE3_SetPullup()          do { WPUEbits.WPUE1 = 1; } while(0)
#define RELE3_ResetPullup()        do { WPUEbits.WPUE1 = 0; } while(0)
#define RELE3_SetPushPull()        do { ODCONEbits.ODCE1 = 0; } while(0)
#define RELE3_SetOpenDrain()       do { ODCONEbits.ODCE1 = 1; } while(0)
#define RELE3_SetAnalogMode()      do { ANSELEbits.ANSELE1 = 1; } while(0)
#define RELE3_SetDigitalMode()     do { ANSELEbits.ANSELE1 = 0; } while(0)

// get/set RE2 aliases
#define RELE4_TRIS                 TRISEbits.TRISE2
#define RELE4_LAT                  LATEbits.LATE2
#define RELE4_PORT                 PORTEbits.RE2
#define RELE4_WPU                  WPUEbits.WPUE2
#define RELE4_OD                   ODCONEbits.ODCE2
#define RELE4_ANS                  ANSELEbits.ANSELE2
#define RELE4_SetHigh()            do { LATEbits.LATE2 = 1; } while(0)
#define RELE4_SetLow()             do { LATEbits.LATE2 = 0; } while(0)
#define RELE4_Toggle()             do { LATEbits.LATE2 = ~LATEbits.LATE2; } while(0)
#define RELE4_GetValue()           PORTEbits.RE2
#define RELE4_SetDigitalInput()    do { TRISEbits.TRISE2 = 1; } while(0)
#define RELE4_SetDigitalOutput()   do { TRISEbits.TRISE2 = 0; } while(0)
#define RELE4_SetPullup()          do { WPUEbits.WPUE2 = 1; } while(0)
#define RELE4_ResetPullup()        do { WPUEbits.WPUE2 = 0; } while(0)
#define RELE4_SetPushPull()        do { ODCONEbits.ODCE2 = 0; } while(0)
#define RELE4_SetOpenDrain()       do { ODCONEbits.ODCE2 = 1; } while(0)
#define RELE4_SetAnalogMode()      do { ANSELEbits.ANSELE2 = 1; } while(0)
#define RELE4_SetDigitalMode()     do { ANSELEbits.ANSELE2 = 0; } while(0)

/**
 * @ingroup  pinsdriver
 * @brief GPIO and peripheral I/O initialization
 * @param none
 * @return none
 */
void PIN_MANAGER_Initialize (void);

/**
 * @ingroup  pinsdriver
 * @brief Interrupt on Change Handling routine
 * @param none
 * @return none
 */
void PIN_MANAGER_IOC(void);


#endif // PINS_H
/**
 End of File
*/