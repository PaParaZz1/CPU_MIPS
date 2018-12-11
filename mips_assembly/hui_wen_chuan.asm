.data
    array:.word 0:20
.text
input:
    li $v0 5
    syscall
    move $s0 $v0 # s0 as n
    li $t1 0 # t1 as i
    for_1_begin:
    	slt $t0 $t1 $s0
    	beq $t0 $0 for_1_end
    	li $v0 12
    	syscall
    	sll $t2 $t1 2
    	sw $v0 array($t2)
    	addi $t1 $t1 1
    	j for_1_begin
    for_1_end:
judge:
    li $s7 1
    li $t1 0 # t1 as i=0
    addi $t2 $s0 -1 # t2 as j=n-1
    for_2_begin:
    	slt $t0 $t1 $t2
    	beq $t0 $0 for_2_end
    	sll $t3 $t1 2
    	sll $t4 $t2 2
    	lw $t5 array($t3)
    	lw $t6 array($t4)
    	beq $t5 $t6 if_1_else
    	li $s7 0
    	j out
    	if_1_else:
    	addi $t1 $t1 1
    	addi $t2 $t2 -1
    	j for_2_begin
    for_2_end:
out:
    move $a0 $s7
    li $v0 1
    syscall
