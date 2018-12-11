.data
.text
	lui $t0,0x0004 
	lui $t1,0x0008 
	ori $t3,$zero,0x2004
	sw $t0,4($t3)
for1:
	addu $t2,$t2,$t1
	lw $t4,4($t3)
	lui $t5,0x0004
	subu $t7,$t6,$t5
	addu $t0,$t0,$t5
	addu $t6,$t6,$t0
	beq $t0,$t1,for1
	addu $t0,$t0,$t5
	lui $v0,0x0001
	lui $v1,0x0002
	addu $v0,$v0,$v1
	addu $v1,$v0,$v1
	ori $a0,$v0,0xffff
	ori $s0 $t3 0xfff7
for2:	
	subu $a2,$v1,$v0
	addu $a1,$a2,$a1
	beq $a1,$v1,for2
