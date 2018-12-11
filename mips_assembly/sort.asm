.data
    array: .word 0:100
    space:.asciiz " "
.text
input:
    li $v0 5
    syscall
    move $s0 $v0 # s0 as n
    li $t0 0
    move $t1 $s0 # t1 as n
    li $t2 0 # t2 as i
    for_1_begin:
        slt $t3 $t2 $t1
        beq $t3 $0 for_1_end
	li $v0 5
    	syscall
    	sw $v0 array($t0)
    	addi $t0 $t0 4
        addi $t2 $t2 1 #i++
        j for_1_begin
        nop
    for_1_end:
sort:
    li $s1 0 # s1 as i
    li $t1 0
    for_2_begin:
    	slt $t0 $s1 $s0
    	beq $t0 $0 for_2_end 
    	lw $s2 array($t1) # s2 as min
    	move $s3 $s1 #i as location of min element
    	sll $s3 $s3 2
    	move $t2 $s1 # t2 as j
    	move $t3 $t1
    	for_3_begin:
    	    slt $t0 $t2 $s0
    	    beq $t0 $0 for_3_end
    	    
    	    lw $t4 array($t3)
    	    slt $t5 $t4 $s2
    	    beq $t5 $0 if_1_else
    	    move $s2 $t4
       	    move $s3 $t2
       	    sll $s3 $s3 2
    	    if_1_else:
    	    
    	    addi $t3 $t3 4
    	    addi $t2 $t2 1
    	    j for_3_begin
    	for_3_end:
    	swap:
    	lw $t9 array($t1)
    	sw $s2 array($t1)
    	sw $t9 array($s3)
    	addi $t1 $t1 4
    	addi $s1 $s1 1 # i++
    	j for_2_begin
    for_2_end:
out:
move $t1 $s0 # t1 as n
li $t2 0 # t2 as i
li $t4 0
for_4_begin:
    slt $t3 $t2 $t1
    beq $t3 $0 for_4_end
    lw $t5 array($t4)
    move $a0 $t5
    li $v0 1
    syscall 	
    la $t5 space
    move $a0 $t5
    li $v0 4
    syscall
    addi $t4 $t4 4
    addi $t2 $t2 1 #i++
    j for_4_begin
for_4_end: