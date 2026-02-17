.data
input:         .asciiz "Enter dividend and divisor : "
Quotient:      .asciiz "Quotient : "
Remainder:     .asciiz "Remainder : "
newline:       .asciiz "\n"
errormessage:  .asciiz "Error: division by zero!"

.text
.globl main

main:
    li $v0, 4
    la $a0, input
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

    beqz $t1, handle_error

    div $t0, $t1
    mflo $t2
    mfhi $t3

    li $v0, 4
    la $a0, Quotient
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 4
    la $a0, Remainder
    syscall

    li $v0, 1
    move $a0, $t3
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
