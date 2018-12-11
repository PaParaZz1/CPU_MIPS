	lui $t0,1
	lui $t1,10
	lui $t2,1
	lui $t3,0
loop:
	beq $t3,$t1,save
	nop
	addu $a0,$a0,$a1
	subu $a2,$a2,$a3
	ori $s0,$s1,111
	
	addu $t3,$t3,$t0
save:
	sw $t3,0($0)
	nop
		
