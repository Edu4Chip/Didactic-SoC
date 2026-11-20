/*
 * Name: mystery.h
 */
#ifndef __MYSTERY_H__
#define __MYSTERY_H__

#include <stdint.h>

#define SS0_BASE 0x01050000
#define SS1_BASE 0x01051000
#define SS2_BASE 0x01052000
#define SS3_BASE 0x01053000

#define SS0_ID_RO         *( volatile uint32_t* )(SS0_BASE+0x00)
#define SS0_IDENTIFY      *( volatile uint32_t* )(SS0_BASE+0x04)
#define SS0_REG08         *( volatile uint32_t* )(SS0_BASE+0x08)
#define SS0_REG0C         *( volatile uint32_t* )(SS0_BASE+0x0C)
#define SS0_REG10_RO      *( volatile uint32_t* )(SS0_BASE+0x10)
#define SS0_REG14_RO      *( volatile uint32_t* )(SS0_BASE+0x14)
#define SS0_REG18_RO      *( volatile uint32_t* )(SS0_BASE+0x18)
#define SS0_REG1C_RO      *( volatile uint32_t* )(SS0_BASE+0x1C)
#define SS0_REG20_RO      *( volatile uint32_t* )(SS0_BASE+0x20)
#define SS0_REG24         *( volatile uint32_t* )(SS0_BASE+0x24)
#define SS0_REG28         *( volatile uint32_t* )(SS0_BASE+0x28)
#define SS0_REG2C         *( volatile uint32_t* )(SS0_BASE+0x2C)
#define SS0_REG30         *( volatile uint32_t* )(SS0_BASE+0x30)
#define SS0_REG34         *( volatile uint32_t* )(SS0_BASE+0x34)
#define SS0_REG38         *( volatile uint32_t* )(SS0_BASE+0x38)
#define SS0_END_RO        *( volatile uint32_t* )(SS0_BASE+0x3C)

#define SS1_ID_RO         *( volatile uint32_t* )(SS1_BASE+0x00)
#define SS1_IDENTIFY      *( volatile uint32_t* )(SS1_BASE+0x04)
#define SS1_REG08         *( volatile uint32_t* )(SS1_BASE+0x08)
#define SS1_REG0C         *( volatile uint32_t* )(SS1_BASE+0x0C)
#define SS1_REG10         *( volatile uint32_t* )(SS1_BASE+0x10)
#define SS1_REG14_RO      *( volatile uint32_t* )(SS1_BASE+0x14)
#define SS1_REG18_RO      *( volatile uint32_t* )(SS1_BASE+0x18)
#define SS1_REG1C         *( volatile uint32_t* )(SS1_BASE+0x1C)
#define SS1_REG20         *( volatile uint32_t* )(SS1_BASE+0x20)
#define SS1_REG24         *( volatile uint32_t* )(SS1_BASE+0x24)
#define SS1_REG28         *( volatile uint32_t* )(SS1_BASE+0x28)
#define SS1_REG2C         *( volatile uint32_t* )(SS1_BASE+0x2C)
#define SS1_REG30         *( volatile uint32_t* )(SS1_BASE+0x30)
#define SS1_REG34         *( volatile uint32_t* )(SS1_BASE+0x34)
#define SS1_REG38         *( volatile uint32_t* )(SS1_BASE+0x38)
#define SS1_END_RO        *( volatile uint32_t* )(SS1_BASE+0x3C)

#define SS2_ID_RO         *( volatile uint32_t* )(SS2_BASE+0x00)
#define SS2_IDENTIFY      *( volatile uint32_t* )(SS2_BASE+0x04)
#define SS2_REG08         *( volatile uint32_t* )(SS2_BASE+0x08)
#define SS2_REG0C         *( volatile uint32_t* )(SS2_BASE+0x0C)
#define SS2_REG10_RO      *( volatile uint32_t* )(SS2_BASE+0x10)
#define SS2_REG14_RO      *( volatile uint32_t* )(SS2_BASE+0x14)
#define SS2_REG18_RO      *( volatile uint32_t* )(SS2_BASE+0x18)
#define SS2_REG1C         *( volatile uint32_t* )(SS2_BASE+0x1C)
#define SS2_REG20         *( volatile uint32_t* )(SS2_BASE+0x20)
#define SS2_REG24         *( volatile uint32_t* )(SS2_BASE+0x24)
#define SS2_REG28         *( volatile uint32_t* )(SS2_BASE+0x28)
#define SS2_REG2C         *( volatile uint32_t* )(SS2_BASE+0x2C)
#define SS2_REG30         *( volatile uint32_t* )(SS2_BASE+0x30)
#define SS2_REG34         *( volatile uint32_t* )(SS2_BASE+0x34)
#define SS2_REG38         *( volatile uint32_t* )(SS2_BASE+0x38)
#define SS2_END_RO        *( volatile uint32_t* )(SS2_BASE+0x3C)

#define SS3_ID_RO         *( volatile uint32_t* )(SS3_BASE+0x00)
#define SS3_IDENTIFY      *( volatile uint32_t* )(SS3_BASE+0x04)
#define SS3_REG08         *( volatile uint32_t* )(SS3_BASE+0x08)
#define SS3_REG0C_RO      *( volatile uint32_t* )(SS3_BASE+0x0C)
#define SS3_REG10_RO      *( volatile uint32_t* )(SS3_BASE+0x10)
#define SS3_REG14_RO      *( volatile uint32_t* )(SS3_BASE+0x14)
#define SS3_REG18_RO      *( volatile uint32_t* )(SS3_BASE+0x18)
#define SS3_REG1C_RO      *( volatile uint32_t* )(SS3_BASE+0x1C)
#define SS3_REG20_RO      *( volatile uint32_t* )(SS3_BASE+0x20)
#define SS3_REG24_RO      *( volatile uint32_t* )(SS3_BASE+0x24)
#define SS3_REG28         *( volatile uint32_t* )(SS3_BASE+0x28)
#define SS3_REG2C         *( volatile uint32_t* )(SS3_BASE+0x2C)
#define SS3_REG30         *( volatile uint32_t* )(SS3_BASE+0x30)
#define SS3_REG34         *( volatile uint32_t* )(SS3_BASE+0x34)
#define SS3_REG38         *( volatile uint32_t* )(SS3_BASE+0x38)
#define SS3_END_RO        *( volatile uint32_t* )(SS3_BASE+0x3C)

#endif //__MYSTERY_H__
