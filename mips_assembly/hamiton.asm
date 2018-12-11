.data
n: .space 4 # number of vertex
m: .space 4 # number of edge
graph: .space 256
visited: .space 32 # visited vertex
path: .space 32 # hamiton path
.text
input:
    li $v0 5 # input n
    syscall
    move $s0 $v0 # s0 as n
    sw $v0 n
    li $v0 5 # input m
    syscall 
    move $s1 $v0 # s1 as m
    sw $v0 m
    
init:
    lw $t1 n # t1 as loop times
    li $t2 0 # t2 as i
    la $t4 visited 
    la $t5 path
    for_0_begin:
    slt $t3 $t2 $t1
    beq $t3 $0 for_0_end
    nop
    # init visited
    sw $0 0($t4)
    add $t4 $t4 4
    # init path
    li $t6 9
    sw $t6 0($t5)
    add $t5 $t5 4
    
    addi $t2 $t2 1 # i++
    j for_0_begin
    nop
    for_0_end:

input_graph:
    lw $t1 m # t1 as loop times
    li $t2 0 # t2 as i
    for_1_begin:
    slt $t3 $t2 $t1
    beq $t3 $0 for_1_end
    nop
    
    li $v0 5 # input graph
    syscall
    move $t3 $v0
    li $v0 5 # input graph
    syscall
    move $t4 $v0
    
    la $s2 graph # calculate addr
    subi $t5 $t4 1 
    mult $t5 $s0
    mflo $t6
    add $t7 $t6 $t3
    li $t6 4
    mult $t7 $t6
    mflo $t7
    add $s2 $s2 $t7
    add $s2 $s2 -4
    li $t6 1
    sw $t6 0($s2)
    
    la $s2 graph # calculate addr
    subi $t5 $t3 1 
    mult $t5 $s0
    mflo $t6
    add $t7 $t6 $t4  
    li $t6 4
    mult $t7 $t6
    mflo $t7
    add $s2 $s2 $t7
    add $s2 $s2 -4
    li $t6 1
    sw $t6 0($s2)
    
    addi $t2 $t2 1 #i++
    j for_1_begin
    nop
    for_1_end:
    jal search
    nop
    jal output
    nop
    li $v0 10
    syscall
    
search:
	addi $sp $sp -4
	sw $ra 0($sp)
	la $s0 graph # global variable
	la $s1 visited
	la $s2 path
	la $t0 n
	lw $s3 0($t0)
	sw $0 0($s2) # path[0]=0
	li $t0 1
	sw $t0 0($s1) # visited[0]=1
	li $t0 1  # set initial vertex 
	move $a0 $t0
        jal cycle
        nop
	lw $ra 0($sp)
	addi $sp $sp 4
	jr $ra
	
cycle:
	sub $t0 $s3 $a0
	bne $t0 $0 if_1_else #judge if current equal n
	nop
	if_1: # if equal, next judge
	move $t0 $a0
	addi $t0 $t0 -1 # get path[c-1]
	li $t1 4
	mult $t1 $t0
	mflo $t0
	move $t2 $s2
	add $t2 $t2 $t0
	lw $t3 0($t2) # t3 as path[c-1]
	
	move $t0 $s0 # get graph[path[c-1]][0]
	li $t1 4
        mult $t3 $t1
        mflo $t3
        mult $t3 $s3
        mflo $t3
        add $t0 $t0 $t3
        #add $s2 $s2 -4
        lw $t1 0($t0)
        beq $t1 $0 if_2_else # if graph[path[c-1]][0]==1
        nop
         if_2:
	li $v0 1 # return 1
	jr $ra
	nop
	if_2_else:
	li $v0 0 # return 0
	jr $ra
	nop
	
	if_1_else: # if 0
	
	move $t1 $s3 # t1 as n
	li $t2 1 # t2 as i
	for_2_begin:
    	slt $t3 $t2 $t1
   	beq $t3 $0 for_2_end
    	nop
    	move $t3 $s1 # visited[i]
    	li $t4 4
    	mult $t4 $t2
    	mflo $t4
    	add $t3 $t3 $t4
    	lw $s4 0($t3) # s4 as visited[i], t3 as its pointer
    	sge $t4 $0 $s4 
    	
    	move $t0 $a0
	addi $t0 $t0 -1 # get path[c-1]
	li $t5 4
	mult $t5 $t0
	mflo $t0
	move $t6 $s2
	add $t6 $t6 $t0
	lw $t5 0($t6) # t6 as path[c-1] pointer
    	move $t0 $s0 # get graph[path[c-1]][i]
    	mult $t5 $s3
        mflo $t5
        add $t5 $t5 $t2
	li $t7 4
        mult $t7 $t5
        mflo $t7
        add $t0 $t0 $t7
        lw $t7 0($t0)# t7 as graph[path[c-1]][i], t0 as pointer
        sgt $t5 $t7 $0
        
        and $t8 $t5 $t4 # !visited[i]&&graph[path[c-1]][i]
        bne $t8 $0 if_3
        nop
         if_3_else:
        j next
        nop
        if_3:
        li $s4 1
        sw $s4 0($t3) # visited[i]=1
        add $t6 $t6 4
        sw $t2 0($t6) # path[c]=i
        # recursion
        addi $sp $sp -20
        sw $ra 0($sp)
        sw $t3 4($sp)
        sw $t6 8($sp)
        sw $t2 12($sp)
        sw $a0 16($sp)
        
        addi $a0 $a0 1
        jal cycle
        nop
        
        lw $a0 16($sp)
        lw $t2 12($sp)
        lw $t6 8($sp)
        lw $t3 4($sp)
        lw $ra 0($sp)
        addi $sp $sp 20
        
        beq $v0 $0 if_4_else
        nop
        if_4:
        li $v0 1 # return 1
	jr $ra
	nop
        if_4_else:
        li $s4 0
        sw $s4 0($t3) # visited[i]=0
        li $t9 9
        sw $t9 0($t6) # path[c]=9           
        	
   	next:
   	addi $t2 $t2 1 #i++
  	j for_2_begin
   	nop
	for_2_end:
	
	li $v0 0 # return 0
	jr $ra
	nop
	
output:
	beq $v0 $0 if_5_else
	if_5:
	li $t0 1
	move $a0 $t0
	li $v0 1
	syscall
	jr $ra
	if_5_else:
	li $t0 0
	move $a0 $t0
	li $v0 1
	syscall
	jr $ra