#ifndef __CSR_UTILS_H__
#define __CSR_UTILS_H__

// Performance monitors
#define CSR_MCYCLE     		0xB00 
#define CSR_MINSTRET   		0xB02
#define CSR_MCYCLEH    		0xB80 
#define CSR_MINSTRETH  		0xB82


#include <stdint.h>

#define assert(expression)                                         \
	do {                                                           \
		if (!(expression)) {                                       \
			printf("%s:%d: assert error\n", __FILE__, __LINE__);   \
			exit(1);                                               \
		}                                                          \
	} while (0)

#define __CSR_EXPAND(x) #x


#define csr_read(csr)                                              \
	({                                                             \
		register unsigned long __val;                              \
		asm volatile("csrr %0, " __CSR_EXPAND(csr)                 \
			     : "=r"(__val)                                     \
			     :                                                 \
			     : "memory");                                      \
		__val;                                                     \
	})


#define csr_write(csr, val)                                        \
	({                                                             \
		unsigned long __val = (unsigned long)(val);                \
		asm volatile("csrw " __CSR_EXPAND(csr) ", %0"              \
			     :                                                 \
			     : "rK"(__val)                                     \
			     : "memory");                                      \
	})


/* TODO: I hope this properly does a memory barrier with the "memory" hint */
#define csr_read_clear(csr, val)                                               \
	({                                                                     \
		unsigned long __val = (unsigned long)(val);                    \
		asm volatile("csrrc %0, " __CSR_EXPAND(csr) ", %1"             \
			     : "=r"(__val)                                     \
			     : "rK"(__val)                                     \
			     : "memory");                                      \
		__val;                                                         \
	})

#define csr_read_set(csr, val)                                                 \
	({                                                                     \
		unsigned long __val = (unsigned long)(val);                    \
		asm volatile("csrrs %0, " __CSR_EXPAND(csr) ", %1"             \
			     : "=r"(__val)                                     \
			     : "rK"(__val)                                     \
			     : "memory");                                      \
		__val;                                                         \
	})

#endif