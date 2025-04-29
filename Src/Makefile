CC=arm-none-eabi-gcc
MACH=cortex-m4
CFLAGS= -c -mcpu=$(MACH) -mthumb -std=gnu11 -Wall -O0
LDFLAGS = -nostdlib -T stm32f446xx_ls.ld

all: main.o led.o stm32f446xx_startup.o final.elf

main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

led.o: led.c
	$(CC) $(CFLAGS) $^ -o $@

stm32f446xx_startup.o: stm32f446xx_startup.c
	$(CC) $(CFLAGS) $^ -o $@

final.elf: main.o led.o stm32f446xx_startup.o
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	@echo Run: rm -r *.o; rm -r *.elf
