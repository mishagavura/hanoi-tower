# Mykhailo Gavura
# COSC 121
# 48541528
# First 100 prime numbers


.data
    newline: .asciiz "\n"
.text
.globl main

main:
    li $t0, 2  # define first number
    li $t1, 0  # we need to count the amount of numbers, so this is the counter

    while_100:
        beq $t1, 100, exit  # If we found 100 numbers, by having counter == 100 then we jump to the exit
        move $a0, $t0  # run the procedure to the if number is prime
        jal test_prime
        beqz $v0, not_prime  # if not prime then we jump to not prime and there we just +1 to counter

        # Print the prime number
        move $a0, $t0
        li $v0, 1
        syscall

        # Print new line
        la $a0, newline
        li $v0, 4
        syscall

        addi $t1, $t1, 1  # +1 to the counter anyways

    not_prime:
        addi $t0, $t0, 1  # Go to the next number
        j while_100

    exit:
        li $v0, 10
        syscall


test_prime:
    li $t2, 2  # we will be dividing by 2 from the start
    sqrt_loop:
        mul $t3, $t2, $t2  # if divisor squared is > than number
        bgt $t3, $a0, is_prime

        rem $t3, $a0, $t2  # if number is divisible by current divisor
        beqz $t3, not_prime_p

        addi $t2, $t2, 1  # +1 to divisor to go for the next step
        j sqrt_loop

    is_prime:
        li $v0, 1
        jr $ra

    not_prime_p:
        li $v0, 0
        jr $ra
