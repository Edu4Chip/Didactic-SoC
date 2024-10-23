/*
 * name: spi.h
 * contributor(S):
 *    - Matti Käyrä (matti.kayra@tuni.fi)
 * description:
 *    - helper functions to use spi
 *    -
 * notes:
 */
#ifndef __SPI_H__
#define __SPI_H__

#include <stdint.h>

#define SPI_BASE 0x01030200

#define STATUS *(uint32_t*)(SPI_BASE + 0x00u)
#define CLKDIV *(uint32_t*)(SPI_BASE + 0x04u)
#define SPICMD *(uint32_t*)(SPI_BASE + 0x08u)
#define SPIADR *(uint32_t*)(SPI_BASE + 0x0Cu)
#define SPILEN *(uint32_t*)(SPI_BASE + 0x10u)
#define SPIDUM *(uint32_t*)(SPI_BASE + 0x14u)
#define TXFIFO *(uint32_t*)(SPI_BASE + 0x18u)
#define RXFIFO *(uint32_t*)(SPI_BASE + 0x20u)
#define INTCFG *(uint32_t*)(SPI_BASE + 0x24u)
#define INTSTA *(uint32_t*)(SPI_BASE + 0x28u)

#define CTRL_BASE 0x01040000
#define SPI_PAD_CFG_DATA0 *(uint32_t*)(CTRL_BASE + 0x54)
#define SPI_PAD_CFG_DATA1 *(uint32_t*)(CTRL_BASE + 0x58)
#define SPI_PAD_CFG_DATA2 *(uint32_t*)(CTRL_BASE + 0x5C)
#define SPI_PAD_CFG_DATA3 *(uint32_t*)(CTRL_BASE + 0x60)

void spi_init(){
  // cfg regs 8 through 14
  // 4C - 60
  // purpose of these is to set sensible values if defaults are no okay.
  // ins
  SPI_PAD_CFG_DATA0 = 0xFFFFFFFF;
  SPI_PAD_CFG_DATA1 = 0xFFFFFFFF;
  SPI_PAD_CFG_DATA2 = 0xFFFFFFFF;
  SPI_PAD_CFG_DATA3 = 0xFFFFFFFF;
  // outs
  SPI_PAD_CFG_DATA0 = 0x0;
  SPI_PAD_CFG_DATA1 = 0x0;
  SPI_PAD_CFG_DATA2 = 0x0;
  SPI_PAD_CFG_DATA3 = 0x0;
}

void spi_read(uint32_t addr){
  //toggle data pins to inputs
  volatile uint32_t mask = 0;
  mask = SPI_PAD_CFG_DATA0;
  SPI_PAD_CFG_DATA0 = (mask | 1u);
  mask = SPI_PAD_CFG_DATA1;
  SPI_PAD_CFG_DATA1 = (mask | 1u);
  mask = SPI_PAD_CFG_DATA2;
  SPI_PAD_CFG_DATA2 = (mask | 1u);
  mask = SPI_PAD_CFG_DATA3;
  SPI_PAD_CFG_DATA3 = (mask | 1u);

           //data      addr    cmd
  SPILEN = (32u<<16 | 32u<<8 | 8u);
  SPIADR = 35u;
            //En interrupt  //En counter    //CNTRX
  INTCFG = (1u<<31        | 1u<<30        | 1u<<24);
  SPICMD = 11u<<24; //read command
  SPIDUM = 33u;
            //CS    //RD
  STATUS = (1u<<8 | 1u<<0);
}


void spi_write(uint32_t data, uint32_t addr){
  // toggle data pins to outputs
  volatile uint32_t mask = 0;
  mask = SPI_PAD_CFG_DATA0;
  SPI_PAD_CFG_DATA0 = (mask & (~1u));
  mask = SPI_PAD_CFG_DATA1;
  SPI_PAD_CFG_DATA1 = (mask & (~1u));
  mask = SPI_PAD_CFG_DATA2;
  SPI_PAD_CFG_DATA2 = (mask & (~1u));
  mask = SPI_PAD_CFG_DATA3;
  SPI_PAD_CFG_DATA3 = (mask & (~1u));

           //data      addr     cmd
  SPILEN = (32u<<16 | 32u<<8 | 8u);
  SPIADR = 35u;
  SPICMD = 2u<<24; //write command
           //En interrupt  //En counter    //CNTTX
  INTCFG = (1u<<31        | 1u<<30        | 1u<<16);
  TXFIFO = 80u; // data to be sent
            //CS    //WR
  STATUS = (1u<<8 | 1u<<1);

}

#endif //__SPI_H__
