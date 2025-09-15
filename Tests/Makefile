CC=arm-none-eabi-gcc
MACH=cortex-m4
CCFLAGS=-c -mcpu=$(MACH) -mthumb -std=gnu11 -Wall -O0
LSFLAGS=-T stm32f446xx_ls.ld -nostdlib -Wl,-Map=main.map

main.elf: main.o stm32f446xx_startup.o
	$(CC) $(LSFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CCFLAGS) $^ -o $@

stm32f446xx_startup.o: stm32f446xx_startup.c
	$(CC) $(CCFLAGS) $^ -o $@

clean:
	rm *_log.txt *.i *.s *.o *.elf; clear;
