ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx) : ORIGIN=0x08000000, LENGTH=1024K
    SRAM (rwx) : ORIGIN=0x20000000, LENGTH=128K
}

_max_heap_size = 0x400;
_max_stack_size = 0x200;

SECTIONS
{
    .text:
    {
        .vector_table of stm32f446xx_startup.o
        *(.text)
        *(.rodata)
        _etext = .;
    } > FLASH /* Virtual Memory Address AT> Load Memory Address */

    .data:
    {
        _sdata = .;
        *(.data)
        _edata = .;
    } > SRAM AT > FLASH

    .bss:
    {
        _sbss = .;
        *(.bss)
        _ebss = .;
    } > SRAM
}
