.data
space: .asciiz " "
enter: .asciiz "\n"
stack: .space 100
n: .word 1
m: .word 1
array: .word 2500
.text
input:
	li $v0 5 # input n
	syscall
	la $t0 n
	move $s0 $v0 # s0 as n
	sw $v0 0($t0)
	li $v0 5 # input m
	syscall
	la $t0 m
	move $s1 $v0 # s1 as m
	sw $v0 0($t0)
input_array:
	mult $s0 $s1
	mflo $t0
	move $t1 $t0 # t1 as n*m
	li $t2 0 # t2 as i
	li $t8 1 # t8 as row
	li $t9 1 # t9 as column
	la $s2 array # s2 as addr of array
	move $t4 $s2 # t4 as current pointer
	for_1_begin:
    		slt $t3 $t2 $t1
    		beq $t3 $0 for_1_end
    		nop
    		li $v0 5 # input element
    		syscall
    		addi $t2 $t2 1 #i++
    		bne $v0 $0 store # if nonzero element, them store
    		nop
    		j judge
    		nop
    		store:
    			sw $t8 0($t4) #store row
    			addi $t4 $t4 4
    			sw $t9 0($t4) #store column
    			addi $t4 $t4 4
    			sw $v0 0($t4) #store value
    			addi $t4 $t4 4
    		judge:
    		addi $t9 $t9 1 # column add 1
    		slt $t5 $s1 $t9#judge row
    		beq $t5 $0 next
    		nop
    		li $t9 1 #if t9 equal m
    		addi $t8 $t8 1
    		next:
    	j for_1_begin
    	nop
	for_1_end:	
output:
addi $t4 $t4 -12
move $t1 $s2 # t1 as n
move $t2 $t4 # t2 as i
addi $t1 $t1 -1
for_2_begin:
    slt $t3 $t1 $t2
    beq $t3 $0 for_2_end
    nop
    
    li $v0 1
    lw $t0 0($t2)
    move $a0 $t0
    syscall
    addi $t2 $t2 4 #i+=4
    li $v0 4
    la $t0 space
    move $a0 $t0
    lw $t0 0($t2)
    syscall
    
    li $v0 1
    lw $t0 0($t2)
    move $a0 $t0
    syscall
    addi $t2 $t2 4 #i+=4
    li $v0 4
    la $t0 space
    move $a0 $t0
    lw $t0 0($t2)
    syscall
    
    li $v0 1
    lw $t0 0($t2)
    move $a0 $t0
    syscall
    addi $t2 $t2 -20#i+=4    
    li $v0 4
    la $t0 enter
    move $a0 $t0
    syscall
    j for_2_begin
    nop
for_2_end: