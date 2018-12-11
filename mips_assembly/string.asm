.data
    array: .word 0:100
    space: .asciiz " "
    enter: .asciiz "\n"
    end: .asciiz "$" 
.text
input:
    li $v0 5
    syscall
    move $s0 $v0 # s0 as n
    li $t1 0 # ti as i
    lw $t0 end($0)
    do:
    li $v0 8
    li $a1 4
    syscall
    move $t2 $v0
    sub $t3 $t2 $t0
    beq $t3 $0 while_end
    sll $t1 $t1 2
    sw $t2 array($t1)
    srl $t1 $t1 2
    addi $t1 $t1 1
    j do
    while_end:
