.data
year: .space 4
.text
	li $t9, 0 # flag value
	li $t1, 4 # three constants for judge
	li $t2, 100
	li $t3, 400
	la $t8, year
input:
	li $v0, 5 # input a year(integer)
	syscall
	move $t0, $v0 # memory year
judge1:
	div $t0, $t1 # judge divide with mo remainer
	mfhi $t4
	beq $t4, $0, judge2 # if remainer equal zero, jump judge2
	nop
output:
	sw $t9, 0($t8)
	lw $a0, 0($t8)
	li $v0, 1
	syscall
	li $v0, 10
	syscall
judge2:
	div $t0, $t2
	mfhi $t4
	beq $t4, $0, judge3
	add $t9, $t9, 1
	j output
	nop
judge3:	div $t0, $t3
	mfhi $t4
	beq $t4, $0, L1
	j output
	nop
	L1:
	li $t9, 1
	j output
	nop
