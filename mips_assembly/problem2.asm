.data
    example100: .word 0:100
.text
li $s0 0 # i
li $s1 100 
li $s2 0 # sum
loop:
    sll $s0 $s0 2
    lw $t1 example100($s0)
    srl $s0 $s0 2
    add $s2 $s2 $t1 # sum+=e[i]
    addi $s0 $s0 1
    bne $s0 $s1 loop
    sll $s0 $s0 2
    sw $s2 example100($s0) # memory sum
    