.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -8
    sw ra, 4(sp)
    sw a1, 0(sp)

    # Check if the length of the array is less than 1
    blez a1, error_exit


loop_start:
    # Load the current element into a register
    lw t0, 0(a0)

    # Compare the value with 0
    bltz t0, set_zero

    # Continue to the next element
    addi a0, a0, 4
    addi a1, a1, -1
    bnez a1, loop_start
    j loop_end

set_zero:
    # Set the value to 0
    sw zero, 0(a0)

    # Continue to the next element
    addi a0, a0, 4
    addi a1, a1, -1
    bnez a1, loop_start


loop_end:
    # Epilogue
    lw ra, 4(sp)
    lw a1, 0(sp)
    addi sp, sp, 8
    jr ra

error_exit:
    # Exit with error code 8
    li a7, 8
    ecall