CC=arm-none-eabi-gcc
MACH=cortex-m4
CFLAGS= -c -mcpu=$(MACH) -mthumb -std=gnu11 -O0

# TARGET: DEPENDENCY
main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

# DEPENDENCY --> $^ ==> main.c
# TARGET     --> $@ ==> main.o
