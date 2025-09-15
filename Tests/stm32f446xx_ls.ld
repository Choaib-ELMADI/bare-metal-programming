ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 512 * 1024
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 128 * 1024
}

__max_heap_size  = 0x400;
__max_stack_size = 0x200;

SECTIONS
{
    .text:
    {
        .vector_table
        *(.text)
        *(.rodata)
        _etext = .;
    } > FLASH

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
