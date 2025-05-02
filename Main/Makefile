CC = arm-none-eabi-gcc
MACH = cortex-m4
CFLAGS = -c -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
CSFLAGS = -S -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
LDFLAGS = -mcpu=$(MACH) -mthumb -mfloat-abi=soft -nostdlib -T stm32f446xx_ls.ld -Wl,-Map=main.map

all: main.s main.o stm32f446xx_startup.o main.elf

main.s: main.c
	$(CC) $(CSFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

stm32f446xx_startup.o: stm32f446xx_startup.c
	$(CC) $(CFLAGS) $^ -o $@

main.elf: main.o stm32f446xx_startup.o
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	clear; rm -r *.s *.o *.elf *.map

load:
	openocd -f board/st_nucleo_f4.cfg
