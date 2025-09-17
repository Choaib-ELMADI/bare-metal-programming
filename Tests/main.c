/* This is a first comment */
// This is a second comment

#include <stdio.h>

#define x 5

extern void initialise_monitor_handles(void);

void HardFault_Handler(void) {}

const int var = 100;
const char b = 'b';
int init;
int zero = 0;
int one = 1;

int array[x];

int main(void) {
    initialise_monitor_handles();

    printf("Hello, World!\n");

    int y = x;
    y++;

    return 0;
}
