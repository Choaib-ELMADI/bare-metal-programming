/* This is a first comment */
// This is a second comment

#define x 5

void HardFault_Handler(void) {}

int main(void) {
    int y = x;
    y++;

    return 0;
}
