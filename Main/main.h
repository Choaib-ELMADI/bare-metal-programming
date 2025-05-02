#ifndef _MAIN_H_
#define _MAIN_H_

#include <stdint.h>

#define RCC_AHB1ENR             (*(volatile uint32_t *)(0x40023830))
#define MODER                   (*(volatile uint32_t *)(0x40020000))

#define BITBAND_PERI_BASE       0x40000000UL
#define ALIAS_PERI_BASE         0x42000000UL

#define BITBAND_PERI(addr, bit) ((uint32_t *)(ALIAS_PERI_BASE + (((uint32_t)(addr) - BITBAND_PERI_BASE) * 32U) + ((bit) * 4U)))

#define GPIOA_PERH_ADDR         0x40020000UL
#define ODR_ADDR_OFF            0x14U
#define LD2_PIN                 5U

#define GPIOA_ODR_ADDR          (GPIOA_PERH_ADDR + ODR_ADDR_OFF)
#define GPIOA_PIN5              BITBAND_PERI(GPIOA_ODR_ADDR, LD2_PIN)

#endif // _MAIN_H_
