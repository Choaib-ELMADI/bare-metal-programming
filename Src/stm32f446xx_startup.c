#include <stdint.h>

#define SRAM_START  0x20000000U
#define SRAM_SIZE   (128U * 1024U) // 128 KBytes
#define SRAM_END    ((SRAM_START) + (SRAM_SIZE))

#define STACK_START SRAM_END

void Reset_Handler(void);
void NMI_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));

// VECTOR TABLE DEFINITION
/*

    The 'section' attribute specifies that a variable (or function) lives in a particular section.

*/
uint32_t vectors[1 + 15 + 82] __attribute__ ((section (".vector_table"))) = {
    STACK_START,
	(uint32_t)Reset_Handler,
	(uint32_t)NMI_Handler,
};

// ROUTINES DEFINITION
void Reset_Handler(void) {
    // Copy .data section to SRAM

    // Zero-initialize .bss section in SRAM

    // Call std library 'init' function if used!

    // Call 'main'
}

void Default_Handler(void) {
    while (1);
}
