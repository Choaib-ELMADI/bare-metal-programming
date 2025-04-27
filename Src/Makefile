CC=arm-none-eabi-gcc
MACH=cortex-m4
CFLAGS= -c -mcpu=$(MACH) -mthumb -std=gnu11 -Wall -O0

all: main.o led.o startup_stm32f446xx.o

main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

led.o: led.c
	$(CC) $(CFLAGS) $^ -o $@

startup_stm32f446xx.o: startup_stm32f446xx.c
	$(CC) $(CFLAGS) $^ -o $@

clean:
	@echo Run: rm -r *.o; rm -r *.elf
