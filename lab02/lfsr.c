#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

void lfsr_calculate(uint16_t *reg) {
    uint16_t bit;
    /* Get the XOR of bits 0, 2, 3, 5 */
    bit = ((*reg >> 0) ^ (*reg >> 2) ^ (*reg >> 3) ^ (*reg >> 5) ) & 1u;
    /* Shift register to the right by one bit */
    *reg = *reg >> 1;
    /* Insert the XOR bit at the leftmost position */
    *reg = *reg | (bit << 15);
}


