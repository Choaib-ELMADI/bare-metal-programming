#include <stdint.h>
#include "main.h"

void delay(volatile uint32_t count) {
    while (count--) {
        for (uint8_t i = 0; i < 30; ++i) {
            __asm__ ("nop");
        }
    }
}

int main(void) {
    RCC_AHB1ENR |=  (0b1 << 0);                  // Enable GPIOA clock
    MODER       &= ~(0b11 << (LD2_PIN * 2));    // Clear 11:10 bits of MODER
    MODER       |=  (0b01 << (LD2_PIN * 2));    // Set output mode

    while (1) {
        *GPIOA_PIN5 = 1;
        delay(20000);
        *GPIOA_PIN5 = 0;
        delay(20000);
    }
}
