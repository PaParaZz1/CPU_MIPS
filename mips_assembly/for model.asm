# for loop model

#for(i=0;i<n;i++)
    #//statement
li $t1 10 # t1 as n
li $t2 0 # t2 as i
for_1_begin:
    slt $t3 $t2 $t1
    beq $t3 $0 for_1_end
    nop
    
    addi $t2 $t2 1 #i++
    j for_1_begin
    nop
for_1_end: