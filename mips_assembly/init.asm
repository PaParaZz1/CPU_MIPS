 #init graph
    lw $s1 n # t1 as loop times
    li $s2 0 # t2 as i
    for_01_begin:
    slt $s3 $s2 $s1
    beq $s3 $0 for_01_end
    nop
    la $t7 graph 
    li $t6 9
    sw $t6 0($t5)
    add $t4 $t4 4
    
    addi $s2 $s2 1 #i++
    j for_01_begin
    nop
    for_01_end: