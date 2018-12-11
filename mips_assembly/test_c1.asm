ori $1,$0,0x2100
nop
nop
ori $2,$0,0x8ace
jal work
nop
lui $5,0x1092
addu $7,$4,$5
sw $7,0($0)
ori $8,$0,1
ori $9,$0,2
ori $10,$0,1
sw $8,4($0)
sw $9,8($0)
sw $10,12($0)
jal work2
nop
beq $11,$12,end
nop
sw $4,16($0)
beq $11,$13,end
nop
sw $5,20($0)
work:
addu $3,$1,$2
subu $4,$3,$1
subu $4,$4,$1
jr $ra
nop
work2:
lw $11,4($0)
lw $11,8($0)
lw $11,12($0)
jr $ra
end:
