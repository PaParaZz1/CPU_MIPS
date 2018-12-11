addiu $1 $0 0x7654
addi $2 $0 0x1234
lui $2 0x1234
add $3 $1 $2
sub $4 $1 $2
and $5 $4 $3
andi $6 $5 0x3af7 
sw $4 0($0)
sw $6 4($0)
lw $1 0($0)
lhu $1 0($0)
lhu $1 2($0)
lbu $1 0($0)
lbu $1 1($0)
lbu $1 2($0)
lbu $1 3($0)
lui $2 0xf67f
ori $1 $0 0xee7e
addu $3 $2 $1
sh $3 6($0)
sh $3 4($0)
sb $3 4($0)
sb $3 5($0)
sb $3 6($0)
sb $3 7($0)
sw $3 0($0)
lh $1 0($0)
lh $1 2($0)
lb $1 0($0)
lb $1 1($0)
lb $1 2($0)
lb $1 3($0)
xor $7 $5 $6
xori $8 $7 0x4396
or $9 $8 $6
nor $9 $8 $6
sll $10 $9 5
ori $1 $0 3
sllv $11 $9 $1
sra $12 $11 7
sll $12 $12 9
srav $12 $12 $1
srl $13 $9 4
srlv $13 $9 $1


bne $13 $0 if_1_else
nop
if_1:
lui $1 0xffff
if_1_else:
lui $2 0x7567

blez $1 if_2_else
nop
if_2:
lui $3 0xea44
if_2_else:
lui $4 0xf233

bgez $20 if_3_else
nop
if_3:
lui $5 0x1234
if_3_else:
lui $5 0xb632

bgtz $5 if_4_else
nop
nop
if_4:
lui $1 0
j next
nop
if_4_else:
lui $1 3

next:
bltz $1 if_5_else
nop
if_5:
ori $10 $0 0x3110
jalr $20 $10
nop
j end1
nop
if_5_else:
ori $11 $0 0x3118
jalr $20 $11
nop
j end1
func1:
jr $20
nop
func2:
sll $31 $20 11
jr $20
end1:
lui $1 0xff23
lui $2 0x6732
slt $3 $1 $0
slti $4 $3 -6
sltu $5 $1 $2
sltiu $6 $1 6

andi $1 $0 0
andi $2 $0 0
ori $1 $0 -5
ori $2 $0 3
mult $1 $2
mflo $3
mfhi $4
multu $1 $2
mflo $3
mfhi $4
div $1 $2
mflo $3
mfhi $4
divu $1 $2
mflo $3
mfhi $4