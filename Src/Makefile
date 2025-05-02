CC = arm-none-eabi-gcc
MACH = cortex-m4
CFLAGS = -c -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
CSFLAGS = -S -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
# LDFLAGS = -nostdlib -T stm32f446xx_ls.ld -Wl,-Map=final.map
LDFLAGS = -mcpu=$(MACH) -mthumb -mfloat-abi=soft --specs=nano.specs -T stm32f446xx_ls.ld -Wl,-Map=final.map

all: main.s main.o led.o stm32f446xx_startup.o syscalls.o final.elf

main.s: main.c
	$(CC) $(CSFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

led.o: led.c
	$(CC) $(CFLAGS) $^ -o $@

stm32f446xx_startup.o: stm32f446xx_startup.c
	$(CC) $(CFLAGS) $^ -o $@

syscalls.o: syscalls.c
	$(CC) $(CFLAGS) $^ -o $@

final.elf: main.o led.o stm32f446xx_startup.o syscalls.o
	$(CC) $(LDFLAGS) $^ -o $@

clean:
	clear; rm -r *.s *.o *.elf *.map

load:
	openocd -f board/st_nucleo_f4.cfg
