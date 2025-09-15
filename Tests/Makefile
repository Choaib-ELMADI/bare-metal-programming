CC=arm-none-eabi-gcc
MACH=cortex-m4
CFLAGS=-c -mcpu=$(MACH) -mthumb -std=gnu11 -Wall -O0

main.elf: main.o stm32f446xx_startup.o
	$(CC) -T stm32f446xx_ls.ld -nostdlib *.o -o $@

main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

stm32f446xx_startup.o: stm32f446xx_startup.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm *_log.txt *.i *.s *.o *.elf; clear;
