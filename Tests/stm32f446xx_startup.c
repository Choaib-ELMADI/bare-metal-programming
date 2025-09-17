#include <stdint.h>

#define SRAM_START  0x20000000U
#define SRAM_SIZE   (128U * 1024U) // 128 KB
#define SRAM_END    ((SRAM_START) + (SRAM_SIZE))

#define STACK_START SRAM_END

extern uint32_t _etext;
extern uint32_t _sdata, _edata;
extern uint32_t _sbss, _ebss;
extern uint32_t _data_load_address;

int main(void);
void __libc_init_array(void);

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
    uint32_t size = (uint32_t)&_edata - (uint32_t)&_sdata;
    uint8_t *pDst = (uint8_t *)&_sdata; // SRAM
    uint8_t *pSrc = (uint8_t *)&_data_load_address; // FLASH

    for (uint32_t i=0; i<size; ++i) {
        *pDst++ = *pSrc++;
    }

    // Initialize .bss section with 0 in SRAM
    size = (uint32_t)&_ebss - (uint32_t)&_sbss;
    pDst = (uint8_t *)&_sbss;

    for (uint32_t i=0; i<size; ++i) {
        *pDst++ = 0;
    }

    // Initialize standard libraries
    __libc_init_array();

    // Call 'main()'
    main();
}

void NMI_Handler(void) {}

void Default_Handler(void) {
    while (1);
}
