## [Simultaneo y Alternancia para TAD]

### [Technical specifications]

- MCU: PIC18(L)F47K40 (PIC18F47K42 compatible)
- Compiler: MikroC PRO for PIC18
- Board: T.A.D

### [Overview]

This is a small program written in C, it's connected to 3 relay outputs and has 3 sensor inputs. It controls three different water pumps from three sensors that mark three different levels on a water reservoir (low, very low and critical), each sensor dictates if one pump, two pumps or the three pumps turn on. In sensor 1 every time it's activated it cycles through the three pumps (ON = pump1, OFF, ON = pump2, OFF, ON = pump3, OFF), with sensor 2 it turns on two pumps at the same time and cycles through each case of possible combination with two pumps on and one off, lastly with sensor 3 it turns all pumps at the same time.

### [Roadmap]

- Change from using interruptions to use polling on the three sensors so it doesn't matter the order in which they are laid out.
- Add support to up to 8 pumps with 8 sensors.
- Add a selector for the number of cycles we want to go through with the pump.

## [MODBUS Slave on TAD]

### [Technical specifications]

- MCU: PIC18(L)F47K40 (PIC18F47K42 compatible)
- Compiler MPLAB X IDE 6.0 with XC8 2.47
- Board: T.A.D

### [Overview]

This program is written in C and compiled in MPLAB X IDE ver 6.0 with XC8 ver 2.47, the purpose of this program is having a MODBUS Slave on the T.A.D connected through RS232 to a PC Master. Since the T.A.D already has every pin assigned to analog and digital I/O (16 Digital Inputs, 4 Analog Inputs, 4 Analog Outputs, 4 Relay Outputs) the only thing left is corelate these I/O to the data type in MODBUS (Coils, Discrete Inputs, Holding Registers, Input Registers). It supports codes 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x0F, 0x10.

### [Roadmap]

- Add support to different BaudRates.
- Add return of exceptions codes and diagnostic mode.
- Add more functions.
