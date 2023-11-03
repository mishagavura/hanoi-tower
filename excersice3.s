# Mykhailo Gavura
# COSC 121
# 48541528
# Hanoi Tower


.data
    number_of_disks: .space 12  # 0 0 0 MEMORY
    input_str: .asciiz "Enter the number of disks: "
    towers_str: .asciiz "["


.text
.globl main

# the function in general is responsible for printing the value in the way it is in the assignment
print_towers:
    li $v0, 4           # Print string syscall code
    la $a0, towers_str  # Load address of the towers string
    syscall

    lw $t0, number_of_disks  # load number_of_disks array
    lw $a0, 0($t0)           # load 0 elem
    lw $a1, 4($t0)           # load 1 elem
    lw $a2, 8($t0)           # load 2 удуь

    li $v0, 1
    syscall

    li $v0, 11
    li $a0, ','
    syscall

    li $v0, 1
    move $a0, $a1
    syscall

    li $v0, 11
    li $a0, ','
    syscall

    li $v0, 1
    move $a0, $a2 # 2 elem to $a0 saving
    syscall

    li $v0, 11
    li $a0, ']'
    syscall

    li $v0, 11
    li $a0, '\n'
    syscall

    jr $ra

hanoi:
    addi $sp, $sp, -16   # Allocate space on the stack
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)

    move $s0, $a1
    move $s1, $a2
    move $s2, $a3
    move $t0, $a0

    # base case
    li $t1, 1
    beq $t0, $t1, move_disk

    # general recursion
    sub $t0, $t0, 1
    move $a0, $t0
    move $a1, $s0
    move $a2, $s2
    move $a3, $s1
    jal hanoi

move_disk:
    lw $t2, number_of_disks
    lw $t3, 0($t2)
    lw $t4, 8($t2)
    sub $t3, $t3, 1
    add $t4, $t4, 1
    sw $t3, 0($t2)
    sw $t4, 8($t2)

    jal print_towers

    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $s2, 0($sp)
    addi $sp, $sp, 16

    jr $ra

main:
    li $v0, 4   # Print string
    la $a0, input_str   # Save input
    syscall

    # read input
    li $v0, 5          
    syscall
    move $t0, $v0     # Save the input in $t0

    li $t1, 0
    li $t2, 0
    li $t3, 0
    sw $t0, number_of_disks
    sw $t1, 4($t4)
    sw $t2, 8($t4)

    jal print_towers

    move $a0, $t0
    li $a1, 0
    li $a2, 1
    li $a3, 2
    jal hanoi

    jal print_towers

    li $v0, 10
    syscall



