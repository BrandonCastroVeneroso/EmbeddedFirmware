//*******************************************************************
// Programa: Libreria Protocolo MODBUS
// Autor(es): Brandon Castro.
// Version: 1.0
//*******************************************************************
// Fecha: 14-06-2024
//*******************************************************************
// Archivos por incluir
//*******************************************************************
// MCU: PIC18LF47K40
// Compiler: XC8 ver 2.46
//*******************************************************************
// TODO:
// - Añadir PresetMultipleRegister
// - Añadir modo Diagnostico
// - Imprimir Exception Codes & Function Code + 0x81 en la funcion
//*******************************************************************

#include <xc.h>

#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "modbus.h"
#include "../mcc_generated_files/uart/eusart1.h"

/********************************************************************/
/********************** Funciones Globales **************************/
/********************************************************************/

/*
 *   Escribimos en Tmr0 el valor para delay de 1.823 ms (~3.5 char @ 19200 bauds)
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ModbusDelay(void){
     TMR0H = 0xDC;
     TMR0L = 0x66;
}

/*
 *   Limpiamos el array de la respuesta obtenida
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ClearResponse(void){
     unsigned int i;
     for(i = 0; i < MAX_PACKET_SIZE; i++){
          response[i] = 0;
     }
}

/*
 *   Decodificamos el paquete recibido
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void DecodePacket(void){
     if((received[0] == SlaveAddress) || received[0] == 0x00){
          if(CheckCRC()){
               switch(received[1]){
                    case 0x01: ReadCoil();        break;
                    case 0x02: ReadDI();          break;
                    case 0x03: ReadHR();          break;
                    case 0x04: ReadIR();          break;
                    case 0x05: WriteCoil();       break;
                    case 0x06: PresetSR();        break;
                    case 0x07: ExceptionStatus(); break;
                    case 0x08:                    break;
                    case 0x0F: WriteMultiCoil();  break;
                    case 0x10:                    break;
                    case 0x11:                    break;
                    default:                      break;
               }
          }
     }
     ModbusMessage = 0;
}

/*
 *   Leemos Holding Registers
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ReadHR(void){
     // Variables de Direccion
     uint16_t StartingAddress = 0;
     uint16_t QtAddresses = 0;
     // Variables varias
     uint16_t CRC = 0;
     uint8_t j = 3;
     uint16_t i = 0;
     // Asignacion de la direccion del registro pedido
     StartingAddress = received[2];
     StartingAddress <<= 8;
     StartingAddress |= received[3];
     // Asignacion del numero de registros pedidos
     QtAddresses = received[4];
     QtAddresses <<= 8;
     QtAddresses |= received[5];
     // Checamos por errores en el Address o en el numero de HR's pedidos
     if(QtAddresses < 1 || QtAddresses >= 5){
          ExceptionCodes.C3 = 1;
          ExceptionCode = 0x03;
          return;
     }
     else if(StartingAddress >= 5 || StartingAddress + QtAddresses >= 5){
          ExceptionCodes.C1 = 1;
          ExceptionCode = 2;
          return;
     }
     // Primera trama de la respuesta
     response[0] = SlaveAddress;
     response[1] = 0x03;
     response[2] = QtAddresses*2;
     // Asignacion de los Holding Registers para respuesta
     for(i = StartingAddress; i < (StartingAddress + QtAddresses); i++){
          if(HoldingRegister[i] > 255){
               response[j] = HoldingRegister[i] >> 8;
               j++;
               response[j] = HoldingRegister[i];
               j++;
          }
          else{
               response[j] = 0x00;
               j++;
               response[j] = HoldingRegister[i];
               j++;
          }
     }
     if(response[j - 1] == 0){
          ExceptionCode = 4;
          return;
     }
     // Añadimos CRC al final de la trama
     CRC = CalculateCRC(response, j);
     response[j] = CRC << 8;
     response[j+1] = CRC;
     j += 3;
     for(i = 0; i != j; i++){
          TX1REG = response[i];
     }
     j = 0;
     ClearResponse();
}

/*
 *   Leemos Input Registers
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ReadIR(void){
     // Variables de Direccion
     uint16_t StartingAddress = 0;
     uint16_t QtAddresses = 0;
     // Variables varias
     uint16_t CRC = 0;
     uint8_t j = 3;
     uint8_t i = 0;
     // Asignacion de la direccion de registro pedido
     StartingAddress = received[2];
     StartingAddress <<= 8;
     StartingAddress |= received[3];
     // Asignacion del numero de registros pedidos
     QtAddresses = received[4];
     QtAddresses <<= 8;
     QtAddresses |= received[5];
     if(QtAddresses < 1 || QtAddresses >= 5){
          ExceptionCode = 3;
          return;
     }
     else if(StartingAddress >= 5 || StartingAddress + QtAddresses >= 5){
          ExceptionCode = 2;
          return;
     }
     // Primera trama de la respuesta
     response[0] = SlaveAddress;
     response[1] = 0x04;
     response[2] = QtAddresses*2;
     // Asignacion de los Input Registers para respuesta
     for(i = StartingAddress; i < (StartingAddress + QtAddresses); i++){
          if(InputRegister[i] > 255){
               response[j] = InputRegister[i] >> 8;
               j++;
               response[j] = InputRegister[i];
               j++;
          }
          else{
               response[j] = 0x00;
               j++;
               response[j] = InputRegister[i];
               j++;
          }
     }
     if(response[j - 1] == 0){
          ExceptionCode = 4;
          return;
     }
     CRC = CalculateCRC(response, j);
     response[j] = CRC << 8;
     response[j+1] = CRC;
     j += 3;
     for(i = 0; i != j; i++){
          TX1REG = response[i];
     }
     j = 0;
     ClearResponse();
}

/*
 *   Escribimos un solo registro
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void PresetSR(void){
     // Variables de Direccion
     uint8_t AddressLow = 0;
     uint8_t AddressHigh = 0;
     uint16_t Address = 0;
     // Variables de valor a escribir
     uint16_t PresetValue = 0;
     uint8_t PresetValueLow = 0;
     uint8_t PresetValueHigh = 0;
     // Variables varias
     uint16_t CRC = 0;
     uint16_t i = 0;
     // Asignacion de Direccion a escribir
     Address = received[2];
     Address <<= 8;
     Address |= received[3];
     AddressLow = received[3];
     AddressHigh = received[2];
     // Asignacion del valor a escribir
     PresetValue = received[4];
     PresetValue <<= 8;
     PresetValue |= received[5];
     PresetValueLow = received[5];
     PresetValueHigh = received[4];
     if(PresetValue < 0x0000 || PresetValue > 0xFFFF){
          ExceptionCode = 3;
          return;
     }
     else if(Address >= 5){
          ExceptionCode = 2;
          return;
     }
     if(conv_hz(PresetValue, Address) == 1){
          // Primera trama de respuesta
          response[0] = SlaveAddress;
          response[1] = 0x06;
          response[2] = AddressHigh;
          response[3] = AddressLow;
          response[4] = PresetValueHigh;
          response[5] = PresetValueLow;
          CRC = CalculateCRC(response, 6);
          response[6] = CRC << 8;
          response[7] = CRC;
     }
     else{
          ExceptionCode = 4;
          return;
     }
     for(i = 0; i != 9; i++){
          TX1REG = response[i];
     }
     ClearResponse();
}

/*
 *   Leemos coils
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ReadCoil(void){
     // Variables para Direccion
     uint16_t StartingAddress = 0;
     uint16_t QtCoils = 0;
     // Variables de asignacion de coils
     uint8_t QtBytes = 0;
     uint8_t udRemaining = 0;
     uint8_t lsb = 0;
     // Variables varias
     uint16_t CRC = 0;
     uint8_t i,j,k,l = 0;
     // Asignacion de la Direccion Inicial
     StartingAddress = received[2];
     StartingAddress <<= 8;
     StartingAddress |= received[3];
     // Asignacion del numero de coils a leer
     QtCoils = received[4];
     QtCoils <<= 8;
     QtCoils |= received[5];
     if(QtCoils < 1 || QtCoils >= 5){
          ExceptionCode = 03;
          return;
     }
     else if(StartingAddress >= 5 || StartingAddress + QtCoils >= 5){
          ExceptionCode = 02;
          return;
     }
     // Asignacion de numero de bits a regresar
     QtBytes = QtCoils / 8;
     udRemaining = QtCoils % 8;
     if(udRemaining){QtBytes += 1;}
     // Primera trama de respuesta
     response[0] = SlaveAddress;
     response[1] = 0x01;
     response[2] = QtBytes;
     // l = Empezamos desde la primera direccion, k = Empezamos a escribir en el elemento 4
     l = StartingAddress;
     k = 3;
     for(i = QtBytes; i != 0; i--){
          if(i > 1){
               for(j = 0; j != 8; j++){
                    if(Coils[l]){
                         lsb = 1;
                    }
                    else{
                         lsb = 0;
                    }
                    response[k] ^= (lsb << j);
                    l++;
               }
               k++;
          }
          else{
               for(j = 0; j != udRemaining; j++){
                    if(Coils[l]){
                         lsb = 1;
                    }
                    else{
                         lsb = 0;
                    }
                    response[k] ^= (lsb << j);
                    l++;
               }
               k++;
          }
     }
     if(response[k-1] == 0x00){
          ExceptionCode = 04;
          return;
     }
     CRC = CalculateCRC(response,k);
     response[k] = CRC << 8;
     response[k+1] = CRC;
     for(i = 0; i != (k + 3); i++){
          TX1REG = response[i];
     }
     ClearResponse();
}

/*
 *   Leemos Discrete Inputs
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ReadDI(void){
     // Variables para direccion
     uint16_t StartingAddress = 0;
     uint16_t QtDI = 0;
     // Variables para asignacion de Discrete Inputs
     uint8_t QtBytes = 0;
     uint8_t udRemaining = 0;
     uint8_t lsb = 0;
     // Variables
     uint16_t CRC = 0;
     uint8_t i,j,k,l = 0;
     // Asignacion de la direccion desde donde leer
     StartingAddress = received[2];
     StartingAddress <<= 8;
     StartingAddress != received[3];
     // Asignacion del numero de Discrete Inputs a leer
     QtDI = received[4];
     QtDI <<= 8;
     QtDI |= received[5];
     if(QtDI < 1 || QtDI >= 17){
          ExceptionCode = 3;
          return;
     }
     else if(StartingAddress >= 17 || StartingAddress + QtDI >= 17){
          ExceptionCode = 2;
          return;
     }
     // Asignacion de numero de bits a regresar
     QtBytes = QtDI / 8;
     udRemaining = QtDI % 8;
     if(udRemaining){
          QtBytes += 1;
     }
     // Primera trama de respuesta
     response[0] = SlaveAddress;
     response[1] = 0x02;
     response[2] = QtBytes;
     // l = Empezamos desde la primera direccion, k = Empezamos a escrbir en el elemnto 4
     l = StartingAddress;
     k = 3;
     for(i = QtBytes; i != 0; i--){
          if(i > 1){
               for(j = 0; j != 8; j++){
                    if(DiscreteInput[l]){
                         lsb = 1;
                    }
                    else{
                         lsb = 0;
                    }
                    response[k] ^= (lsb << j);
                    l++;
               }
               k++;
          }
          else{
               for(j = 0; j != udRemaining; j++){
                    if(DiscreteInput[l]){
                         lsb = 1;
                    }
                    else{
                         lsb = 0;
                    }
                    response[k] ^= (lsb << j);
                    l++;
               }
               k++;
          }
     }
     if(response[k - 1] == 0){
          ExceptionCode = 4;
          return;
     }
     CRC = CalculateCRC(response,k);
     response[k] = CRC << 8;
     response[k+1] = CRC;
     for(i = 0; i != (k + 3); i++){
          TX1REG = response[k];
     }
     ClearResponse();
}

/*
 *   Escribimos un solo coil
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void WriteCoil(void){
     // Variables para Direccion
     uint16_t Address = 0;
     uint16_t AddressHigh = 0;
     uint16_t AddressLow = 0;
     // Variables para el valor a escribir
     uint16_t WriteValue = 0;
     uint16_t WriteValueLow = 0;
     uint16_t WriteValueHigh = 0;
     // Variables varias
     uint16_t CRC = 0;
     uint8_t i = 0;
     // Asignacion inicial de direccion donde escribir
     Address = received[2];
     Address <<= 8;
     Address |= received[3];
     AddressHigh = received[2];
     AddressLow = received[3];
     // Asignacion inicial del valor a escribir
     WriteValue = received[4];
     WriteValue <<= 8;
     WriteValue |= received[5];
     WriteValueHigh = received[4];
     WriteValueLow = received[5];
     if(WriteValue != 0x0000 || WriteValue != 0xFF00){
          ExceptionCode = 3;
          return;
     }
     else if(Address >= 5){
          ExceptionCode = 2;
          return;
     }
     // Escritura del valor pedido
     if(WriteValue){
          Coils[Address] = 0xFF;
     }
     else{
          Coils[Address] = 0x00;
     }
     // Echo de peticion
     if(Coils[Address] == WriteValueHigh){
          response[0] = SlaveAddress;
          response[1] = 0x05;
          response[2] = AddressHigh;
          response[3] = AddressLow;
          response[4] = WriteValueHigh;
          response[5] = WriteValueLow;
     }
     else{
          ExceptionCode = 4;
          return;
     }
     CRC = CalculateCRC(response, 6);
     response[6] = CRC << 8;
     response[7] = CRC;
     for(i = 0; i != 9; i++){
          TX1REG = response[i];
     }
     ClearResponse();
}

/*
 *   Escribimos multiples coils
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void WriteMultiCoil(void){
     // Variables de Direccion
     uint16_t Address = 0;
     uint16_t AddressLow = 0;
     uint16_t AddressHigh = 0;
     // Variables numero de coils
     uint16_t QtCoils = 0;
     uint8_t QtBytes = 0;
     // Variables varias
     uint8_t length = 0;
     uint8_t i,l,k = 0;
     uint16_t CRC = 0;
     // Asignacion inicial de la Direccion a escribir
     Address = received[2];
     Address = (Address << 8) | received[3];
     // Asignacion inicial del numero de coils a escribir
     QtCoils = received[4];
     QtCoils = (QtCoils << 8) | received[5];
     QtBytes = QtCoils / 8;
     if(QtCoils % 8){
          QtBytes += 1;
     }
     // Escribimos los valores sobre los coils
     for(i = 0; i < QtCoils; i++){
          l = i / 8;
          k = i % 8;
          Coils[Address + i] = ((received[7 + l] >> k) & 0x01) ? 0xFF:0x00;
     }
     // Echo del request
     response[0] = received[0];
     response[1] = received[1];
     response[2] = received[2];
     response[3] = received[3];
     response[4] = received[4];
     response[5] = received[5];
     length = 6;
     CRC = CalculateCRC(response, length);
     response[6] = CRC << 8;
     response[7] = CRC;
     for(i = 0; i != 9; i++){
          TX1REG = response[i];
     }
     ClearResponse();
}

/*
 *   Leemos los valores de los 8 exception codes y los regresamos en 1 solo byte
 *   Args:
 *        N/A
 *   Returns:
 *        N/A
 */

void ExceptionStatus(void){
     // Variables varias
     uint8_t i = 0;
     uint16_t CRC = 0;
     // Asignamos la primera trama de la respuesta
     response[0] = SlaveAddress;
     response[1] = 0x07;
     response[2] = ExceptionCodes.Arrayoflags;
     // Calculamos el CRC
     CRC = CalculateCRC(response, 3);
     response[3] = CRC << 8;
     response[4] = CRC;
     for(i = 0; i != 7; i++){
          TX1REG = response[i];
     }
     ClearResponse();
}

/*
 *   Asignamos el valor del preset al registro en direccion n
 *   Args:
 *        _Value .- Valor del preset a poner
 *        _Address .- Direccion del registro
 *   Returns:
 *        0 .- Si el valor no esta dentro de los valores permitidos
 *        1 .- Si el valor esta dentro los valores permitidos
 *             10 Hz ~ 1 kHz
 */

bool conv_hz(uint16_t _Value, uint16_t _Address){
     HoldingRegister[_Address] = _Value;
     if(_Value >= 0x0BDC && _Value <= 0xFD8F){
          frequency[_Address].PulseEnable = 1;
          return 1;
     }
     else{
          return 0;
     }
     // FREQ.Hz = (1/625000) * (1 + (0xFFFF - _Value));
}

/*
 *   Calculamos el CRC del paquete a enviar
 *   Args:
 *        string[] .- string a calcular
 *        _long .- longitud de la string
 *   Returns:
 *        CRC_TEMP .- tipo unsigned byte, MSb first and LSb last
 */

uint16_t CalculateCRC(unsigned char string[], uint16_t _long){
     uint16_t CRC_TEMP;
     uint16_t i;

     CRCCON0bits.CRCEN = 1;
     CRCACCL = 0x00;
     CRCACCH = 0x00;
     CRCXORL = 0x05;
     CRCXORH = 0x80;
     CRCCON1 = 0x7F;
     CRCCON0bits.ACCM = 1;
     CRCCON0bits.SHIFTM = 0;
     CRCCON0bits.CRCGO = 1;

     for(i = 0; i < _long; i++){
          while(CRCCON0bits.FULL);
          CRCDATH = 0x00;
          CRCDATL = string[i] & 0xFF;
     }

     while(CRCCON0bits.BUSY);
     CRC_TEMP = ((CRCACCH << 8) | CRCACCL);

     return CRC_TEMP;
}

/*
 *   Verificamos el CRC del paquete obtenido
 *   Args:
 *        N/A
 *   Returns:
 *        1 .- Si el CRC es correcto
 *        0 .- Si el CRC es incorrecto
 */

uint8_t CheckCRC(void){
     uint16_t CRC_Temp;
     uint8_t CRCH,CRCL;
     uint16_t i;

     CRCCON0bits.CRCEN = 1; // Habilitamos CRC
     CRCACCL = 0x00; // Carga inicial a acumuladores (CRC-16 ANSI) = 0x0000
     CRCACCH = 0x00; 
     CRCXORL = 0x05; // Carga del polinomio a usar x^16+x^15+x^2+1
     CRCXORH = 0x80;
     CRCCON1 = 0x7F; // DLEN (length of word) = 0x07, PLEN (length of poli) = 0x0F
     CRCCON0bits.ACCM = 0; // El dato no tiene padding de 0's
     CRCCON0bits.SHIFTM = 0; // Shift Left (MSb)
     CRCCON0bits.CRCGO = 1;

     for(i = 0; i < (MessageLength - 2); i++){
          while(CRCCON0bits.FULL);
          CRCDATH = 0x00;
          CRCDATL = received[i] & 0xFF;
     }
     while(CRCCON0bits.BUSY);
     CRC_Temp = ((CRCACCH << 8) | CRCACCL);
     CRCH = CRC_Temp >> 8;
     CRCL = CRC_Temp & 255;
     if((CRCL == received[i]) && (CRCH == received[i+1])){
          return 1;
     }
     else{
          return 0;
     }
}