.data
    array: .word 0:10
    space: .asciiz " "
.text
input:
    li $v0 5
    syscall
    move $s0 $v0 # s0 as n
    li $t1 0
    li $t3 0
    move $t2 $s0
    for_1_begin:
        slt $t0 $t1 $t2
        beq $t0 $0 for_1_end
        li $v0 5
        syscall
        sw $v0 array($t3)
        addi $t3 $t3 4
        addi $t1 $t1 1 # i++
        j for_1_begin
    for_1_end:
    
    li $a0 0
    addi $t0 $s0 -1 # t0 as n-1
    move $a1 $t0
    jal quick_sort
output:
    li $t1 0
    li $t3 0
    move $t2 $s0
    for_2_begin:
        slt $t0 $t1 $t2
        beq $0 $t0 for_2_end
        li $v0 1
        lw $a0 array($t3)
        syscall
        la $a0 space
        li $v0 4
        syscall
        addi $t3 $t3 4
        addi $t1 $t1 1
        j for_2_begin
    for_2_end:
    li $v0 10
    syscall
quick_sort: # argument p,r
    slt $t0 $a0 $a1
    beq $0 $t0 if_1_else # p>=q
    if_1: #p<q
    
    addi $sp $sp -12
    sw $ra 0($sp)
    sw $a0 4($sp)
    sw $a1 8($sp)
    
    # a0=p
    # a1=q
    jal partition
    move $s1 $v0 # s1 as q
    
    addi $sp $sp -4
    sw $s1 0($sp)
    
    # a0=p
    addi $a1 $s1 -1 # a1 = q-1
    jal quick_sort
    
    lw $s1 0($sp)
    addi $sp $sp 4
    lw $a1 8($sp)
    lw $a0 4($sp)
    lw $ra 0($sp)
    addi $sp $sp 12
    
    
    move $t0 $s1 # t0=q
    move $t1 $a1 # t1=r
    addi $sp $sp -12
    sw $ra 0($sp)
    sw $a0 4($sp)
    sw $a1 8($sp)
    move $a0 $t0 #a0=q
    addi $a0 $a0 1 #a0=q+1
    move $a1 $t1 #a1=r
    jal quick_sort

    lw $a1 8($sp)
    lw $a0 4($sp)
    lw $ra 0($sp)
    addi $sp $sp 12
    jr $ra
    if_1_else:
    jr $ra
partition:
    sll $a1 $a1 2
    lw $s2 array($a1) # s2 as pivot=array[r],r=a1
    srl $a1 $a1 2
    move $t3 $a0 # t3 as i=a0
    move $t0 $a0 # t0 as j=a0
    move $t1 $a1 # t1=a1, j from a0 to a1
    for_3_begin:
        slt $t2 $t0 $t1
        beq $0 $t2 for_3_end
        sll $t0 $t0 2
        lw $t4 array($t0) # t4=a[j]
        srl $t0 $t0 2
        slt $t2 $t4 $s2 # if a[i]<pivot
        beq $0 $t2 if_2_else
        #swap a[i] a[j]
        sll $t3 $t3 2
        sll $t0 $t0 2
        lw $t5 array($t3) # t5=a[i]
        sw $t4 array($t3) # a[i]=t4=a[j]
        sw $t5 array($t0) # a[j]=t5=a[i]
        srl $t3 $t3 2
        srl $t0 $t0 2
        addi $t3 $t3 1 #i++
         if_2_else:
        addi $t0 $t0 1 #j++
        j for_3_begin
   for_3_end:
   # swap a[0] a[i]
   sll $t3 $t3 2
   sll $a1 $a1 2
   lw $t5 array($a1)
   lw $t6 array($t3)
   sw $t5 array($t3)
   sw $t6 array($a1) 
   srl $t3 $t3 2
   srl $a1 $a1 2
   move $v0 $t3 # return i
   jr $ra
