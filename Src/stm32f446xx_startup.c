#include <stdint.h>

#define SRAM_START  0x20000000U
#define SRAM_SIZE   (128U * 1024U) // 128 KBytes
#define SRAM_END    ((SRAM_START) + (SRAM_SIZE))

#define STACK_START SRAM_END

extern const uint32_t _etext;
extern const uint32_t _sdata;
extern const uint32_t _edata;
extern const uint32_t _sbss;
extern const uint32_t _ebss;

int main(void);

void Reset_Handler(void);
void NMI_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void HardFault_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void MemManage_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void BusFault_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void UsageFault_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void SVCall_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));
void DebugMonitor_Handler(void) __attribute__ ((weak, alias ("Default_Handler")));

// VECTOR TABLE DEFINITION
/*

    The 'section' attribute specifies that a variable (or function) lives in a particular section.

*/
uint32_t vectors[1 + 15 + 82] __attribute__ ((section (".vector_table"))) = {
    STACK_START,
	(uint32_t)Reset_Handler,
	(uint32_t)NMI_Handler,
	(uint32_t)HardFault_Handler,
	(uint32_t)MemManage_Handler,
	(uint32_t)BusFault_Handler,
	(uint32_t)UsageFault_Handler,
    0,
	(uint32_t)SVCall_Handler,
	(uint32_t)DebugMonitor_Handler,
};

// ROUTINES DEFINITION
void Reset_Handler(void) {
    // Copy .data section to SRAM
    uint32_t size = (uint32_t)&_edata - (uint32_t)&_sdata;
    uint8_t *pDst = (uint8_t *)&_sdata; // SRAM
    uint8_t *pSrc = (uint8_t *)&_etext; // FLASH

    for (uint32_t i = 0; i < size; ++i) {
        *pDst++ = *pSrc++;
    }

    // Zero-initialize .bss section in SRAM
    size = (uint32_t)&_ebss - (uint32_t)&_sbss;
    uint8_t *bssPDst = (uint8_t *)&_sbss; // SRAM

    for (uint32_t i = 0; i < size; ++i) {
        *bssPDst++ = 0;
    }

    // Call std library 'init' function if used!

    // Call 'main'
    main();
}

void Default_Handler(void) {
    while (1);
}
