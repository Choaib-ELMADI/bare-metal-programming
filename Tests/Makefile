CC         = arm-none-eabi-gcc
MACH       = cortex-m4
CCFLAGS    = -c -mcpu=$(MACH) -mthumb -mfloat-abi=soft -std=gnu11 -Wall -O0
LSFLAGS_NL = -mcpu=$(MACH)    -mthumb -mfloat-abi=soft -nostdlib            -T stm32f446xx_ls.ld -Wl,-Map=main.map
LSFLAGS_LB = -mcpu=$(MACH)    -mthumb -mfloat-abi=soft --specs=nano.specs   -T stm32f446xx_ls.ld -Wl,-Map=main.map
LSFLAGS_SH = -mcpu=$(MACH)    -mthumb -mfloat-abi=soft --specs=rdimon.specs -T stm32f446xx_ls.ld -Wl,-Map=main.map

main.elf: main.o stm32f446xx_startup.o syscalls.o
	$(CC) $(LSFLAGS_LB) $^ -o $@

main_sh.elf: main.o stm32f446xx_startup.o
	$(CC) $(LSFLAGS_SH) $^ -o $@

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
