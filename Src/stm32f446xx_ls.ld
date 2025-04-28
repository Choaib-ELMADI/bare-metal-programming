ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx) : ORIGIN=0x08000000, LENGTH=1024K
    SRAM (rwx) : ORIGIN=0x20000000, LENGTH=128K
}

SECTIONS
{
    .text:
    {
        .vector_table of startup_stm32f446xx.o
        *(.text)
        *(.rodata)
    }> FLASH /* Virtual Memory Address AT> Load Memory Address */

    .data:
    {
        *(.data)
    }> SRAM AT> FLASH

    .bss:
    {
        *(.bss)
    }> SRAM
}
