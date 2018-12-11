ori $1 $0 0x1234
lui $2 0x8765
nop
nop
nop
addu $3 $2 $1
beq $1 $0 if_1_else
nop
nop
if_1:
ori $7 $0 0x0011
j next
nop
nop
nop
if_1_else:
ori $7 $0 0x1112
next:
beq $0 $0 if_2_else
nop
nop
if_2:
lui $8 0x2312
j next2
nop
nop
nop
if_2_else:
lui $8 0x2331
subu $4 $2 $1
next2:
sw $3 0($0)
lw $5 0($0)
