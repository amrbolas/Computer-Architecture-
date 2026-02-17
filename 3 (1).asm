.data
input:        .asciiz "Enter dividend and divisor : "
Quotient:     .asciiz "Quotient : "
Remainder:    .asciiz "Remainder : "
newline:      .asciiz "\n"
errormessage: .asciiz "Error: division by zero!"

.text
.globl main

main:
    li $v0, 4
    la $a0, input
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    li $v0, 5
    syscall
    move $s1, $v0

    beqz $s1, handle_error

    li $t0, 0
    move $t1, $s0
    li $t2, 0
    li $t3, 32

division_loop:
    sll $t2, $t2, 1
    srl $t4, $t1, 31
    or  $t2, $t2, $t4
    sll $t1, $t1, 1
    sub $t5, $t2, $s1
    bltz $t5, restore
    move $t2, $t5
    sll $t0, $t0, 1
    ori $t0, $t0, 1
    j continue

restore:
    sll $t0, $t0, 1

continue:
    addi $t3, $t3, -1
    bgtz $t3, division_loop

    li $v0, 4
    la $a0, Quotient
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, Remainder
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    j exit

handle_error:
    li $v0, 4
    la $a0, errormessage
    syscall

exit:
    li $v0, 10
    syscall
