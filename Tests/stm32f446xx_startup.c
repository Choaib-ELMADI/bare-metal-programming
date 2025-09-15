#include <stdint.h>

#define SRAM_START  0x20000000U
#define SRAM_SIZE   (128U * 1024U) // 128 KB
#define SRAM_END    ((SRAM_START) + (SRAM_SIZE))

#define STACK_START SRAM_END

void Reset_Handler(void);
void NMI_Handler(void);
void HardFault_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void MemManage_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
// Same for other exception/interrupt handlers

// 1 MSP + 12 Exceptions + 97 Interrupts
uint32_t vector_table[110] __attribute__ ((section (".vector_table"))) = {
    STACK_START,
    (uint32_t)&Reset_Handler,
    (uint32_t)&NMI_Handler,
    (uint32_t)&HardFault_Handler,
    (uint32_t)&MemManage_Handler,
    // Other exception/interrupt handler' addresses
};

void Reset_Handler(void) {
    // Copy .data section into SRAM

    // Initialize .bss section with 0 in SRAM

    // Initialize standard libraries

    // Call 'main()'
}

void NMI_Handler(void) {}

void Default_Handler(void) {
    while (1);
}
