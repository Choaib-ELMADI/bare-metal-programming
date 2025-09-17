CC=arm-none-eabi-gcc
MACH=cortex-m4
CCFLAGS=-c -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
# LSFLAGS=-mcpu=$(MACH) -mthumb -mfloat-abi=soft -T stm32f446xx_ls.ld -nostdlib -Wl,-Map=main.map
LSFLAGS=-mcpu=$(MACH) -mthumb -mfloat-abi=soft --specs=nano.specs -T stm32f446xx_ls.ld -Wl,-Map=main.map

main.elf: main.o stm32f446xx_startup.o syscalls.o
	$(CC) $(LSFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CCFLAGS) $^ -o $@

stm32f446xx_startup.o: stm32f446xx_startup.c
	$(CC) $(CCFLAGS) $^ -o $@

syscalls.o: syscalls.c
	$(CC) $(CCFLAGS) $^ -o $@

openocd:
	openocd -f board/st_nucleo_f4.cfg

gdb:
	arm-none-eabi-gdb

clc:
	rm *_log.txt *.i *.s *.o *.elf *.map; clear;
