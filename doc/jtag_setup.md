# Didactic JTAG Setup using FT2232H Mini Module

- Data Sheet: https://ftdichip.com/wp-content/uploads/2020/07/DS_FT2232H_Mini_Module.pdf
## Setup
- Connect VBUS to VCC (CN3, pin 1 to CN3, pin 3)
- Connect V3V3 to VIO (CN2, pins 1, 3 & 5 to CN2, pins 11 & 21 and CN3, pins 12 & 22)
- Connect JTAG pins:
	- **TCK** – AD0 (CN2-7)
	- **TDI** – AD1 (CN2-10)
	- **TDO** – AD2 (CN2-9)
	- **TMS** – AD3 (CN2-12)
	- **GND** – GND
- select FTDI channel 0 in `fpga/xilinx/openocd-didactic.cfg` using `ftdi channel 0`