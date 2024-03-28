.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:
    # Prologue
    addi sp, sp, -32
    sw ra, 28(sp)
    sw a0, 24(sp)
    sw a1, 20(sp)
    sw a2, 16(sp)
    sw a3, 12(sp)
    sw a4, 8(sp)
    sw a5, 4(sp)
    sw a6, 0(sp)

    # Check if the number of columns in the first matrix is equal to the number of rows in the second matrix
    bne a2, a4, error_exit

    # Initialize the row and column counters
    addi t0, zero, 0  # row counter
    addi t1, zero, 0  # column counter

outer_loop_start:
    # Check if we have processed all rows
    bge t0, a1, outer_loop_end

    inner_loop_start:
        # Check if we have processed all columns
        bge t1, a5, inner_loop_end

        # Calculate the addresses of the current row and column
        add t2, a0, t0  # address of the current row
        add t3, a3, t1  # address of the current column

        # Call the dot function
        add a0, t2, zero
        add a1, a2, zero
        add a2, t3, zero
        add a3, a5, zero
        jal ra, dot

        # Store the result in the output matrix
        add t4, a6, t0
        add t4, t4, t1
        sw a0, 0(t4)

        # Increment the column counter
        addi t1, t1, 1
        j inner_loop_start

    inner_loop_end:
        # Increment the row counter
        addi t0, t0, 1
        j outer_loop_start

outer_loop_end:
    # Epilogue
    lw ra, 28(sp)
    lw a0, 24(sp)
    lw a1, 20(sp)
    lw a2, 16(sp)
    lw a3, 12(sp)
    lw a4, 8(sp)
    lw a5, 4(sp)
    lw a6, 0(sp)
    addi sp, sp, 32
    jr ra

error_exit:
    # Exit with error code 4
    li a7, 4
    ecall