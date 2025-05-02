#include <stdint.h>

#define SRAM_START  0x20000000U
#define SRAM_SIZE   (128U * 1024U)
#define SRAM_END    ((SRAM_START) + (SRAM_SIZE))
#define STACK_START SRAM_END

extern const uint32_t _etext;
extern const uint32_t _sdata;
extern const uint32_t _edata;
extern const uint32_t _la_data;
extern const uint32_t _sbss;
extern const uint32_t _ebss;

void Reset_Handler(void);
int main(void);

/* ---- ---- ---- */

uint32_t vectors[1 + 15 + 82] __attribute__ ((section (".vector_table"))) = {
    STACK_START,
	(uint32_t)Reset_Handler,
};

void Reset_Handler(void) {
    // Copy .data section to SRAM
    uint32_t size = (uint32_t)&_edata - (uint32_t)&_sdata;
    uint8_t *pDst = (uint8_t *)&_sdata;   // SRAM
    uint8_t *pSrc = (uint8_t *)&_la_data; // FLASH

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
