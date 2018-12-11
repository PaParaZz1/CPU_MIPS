.data
	matrix_1:.word 0:64
	matrix_2:.word 0:64
	space: .asciiz " "
	enter: .asciiz "\n"
.text
	li $v0 5 #input n
	syscall
	move $s0 $v0 # s0 as n
input1:
	li $t0 0
	mult $s0 $s0 
	mflo $t1 # t1 as n*n
	li $t2 0 # t2 as i
	for_1_begin:
    		slt $t3 $t2 $t1
    		beq $t3 $0 for_1_end
    		li $v0 5
    		syscall
    		sw $v0 matrix_1($t0)
    		addi $t0 $t0 4
    		addi $t2 $t2 1 #i++
    		j for_1_begin
	for_1_end:
input2:
	li $t0 0
	mult $s0 $s0 
	mflo $t1 # t1 as n*n
	li $t2 0 # t2 as i
	for_2_begin:
    		slt $t3 $t2 $t1
    		beq $t3 $0 for_2_end
    		li $v0 5
    		syscall
    		sw $v0 matrix_2($t0)
    		addi $t0 $t0 4
    		addi $t2 $t2 1 #i++
    		j for_2_begin
	for_2_end:
multiple:
	li $t0 0
	mult $s0 $s0 
	mflo $t1 # t1 as n*n
	li $t2 0 # t2 as i
	for_3_begin:
    		slt $t3 $t2 $t1
    		beq $t3 $0 for_3_end
		div $t2 $s0
		mflo $s1 # s1 as row
		mfhi $s2 # s2 as column
		move $s3 $0 # s3 as result for each calculate
		cal:
		move $t6 $s0 # t6 as n
		li $t4 0 # t4 as k
		for_4_begin:
    			slt $t5 $t4 $t6
    			beq $t5 $0 for_4_end
    			mult $s1 $s0
    			mflo $t7
    			add $t7 $t7 $t4
    			sll $t7 $t7 2 # t7 as a[i][k]
    			mult $t4 $s0
    			mflo $t8
    			add $t8 $t8 $s2
    			sll $t8 $t8 2 # t8 as a[k][j]
    			lw $s4 matrix_1($t7)
    			lw $s5 matrix_2($t8)
    			mult $s4 $s5
    			mflo $t9
    			add $s3 $s3 $t9 #result+=a[i][k]*a[k][j]
    			addi $t4 $t4 1 #j++
    			j for_4_begin
		for_4_end:
		out:
		move $a0 $s3
		li $v0 1
		syscall
		la $t9 space
		la $t8 enter
    		addi $t2 $t2 1 #i++
    		div $t2 $s0
    		mfhi $t5
    		beq $t5 $0 en
    		li $v0 4
    		move $a0 $t9
    		syscall
    		j for_3_begin
    		en:
    		li $v0 4
    		move $a0 $t8
    		syscall
    		j for_3_begin
	for_3_end:	