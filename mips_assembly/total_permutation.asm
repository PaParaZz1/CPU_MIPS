.data
    array:.word 0:7
    symbol: .word 0:7
    space:.asciiz " "
    enter: .asciiz "\n"
   # stack:.space 1600
.text
    li $v0 5
    syscall
    move $s0 $v0 # s0 as n
    li $a0 0
    jal full_array
    li $v0 10
    syscall
full_array:
    move $s1 $a0 # s1 as index
    slt $t0 $s1 $s0
    bne $t0 $0 if_1_else 
    if_1: # index>=n
    	li $t1 0
    	for_1_begin:
    	    slt $t0 $t1 $s0
    	    beq $t0 $0 for_1_end
    	    sll $t2 $t1 2
    	    lw $a0 array($t2)
    	    li $v0 1
    	    syscall
    	    
    	    la $t2 space
    	    move $a0 $t2
    	    li $v0 4
    	    syscall
    	    addi $t1 $t1 1
    	    j for_1_begin
    	for_1_end:
    	la $t2 enter
    	move $a0 $t2
    	li $v0 4
    	syscall
    	jr $ra
    if_1_else: 
        li $t1 0 #t1 as i
        for_2_begin:
            slt $t0 $t1 $s0
            beq $t0 $0 for_2_end
            
            sll $t2 $t1 2
            lw $t3 symbol($t2)
            bne $t3 $0 if_2_else
             if_2: #symbol[i]==0
            addi $t3 $t3 1
            sw $t3 symbol($t2) # symbol[i]=1
            addi $t4 $t1 1 # t4 as i+1
            sll $t5 $s1 2
            sw $t4 array($t5) # array[index]=i+1
            
            addi $sp $sp -16
            sw $ra 0($sp)
            sw $t1 4($sp)
            sw $t2 8($sp)
            sw $s1 12($sp)
            
            addi $a0 $s1 1 #index+1 as next argument
            jal full_array
            
            lw $s1 12($sp)
            lw $t2 8($sp)
            lw $t1 4($sp)
            lw $ra 0($sp)
            addi $sp $sp 16
            
            sw $0 symbol($t2) # symbol[i]=0
             if_2_else:
            addi $t1 $t1 1
            j for_2_begin
       for_2_end:
      jr $ra
        
