# M to D RS PC
jal func
nop
j end
nop
func:
jr $ra
nop
end:
lui $2 0x0921
# W to D RS PC
jal func1
nop
j end1
nop
func1:
lui $3 0x1234
jr $ra
nop
end1:
lui $2 0x0922
# M to D RS ALU
ori $1 $8 5
nop
beq $1 $0 if_1_else
nop
if_1:
lui $3 3
j end
nop
if_1_else:
lui $3 4
end:

	# jump version
ori $1 $8 0
nop
beq $1 $0 if_1_else
nop
if_1:
lui $3 3
j end
nop
if_1_else:
lui $3 4
end:

# W to D RS ALU
ori $1 $8 0
nop
nop
beq $1 $0 if_1_else
nop
if_1:
lui $3 3
j end
nop
if_1_else:
lui $3 4
end:

# W to D RS DM
lw $1 0($0)
nop
nop
beq $1 $0 if_1_else
nop
if_1:
lui $3 3
j end
nop
if_1_else:
lui $3 4
end:

# M to E RS ALU
ori $1 $0 4
addu $3 $1 $0
# W to E RS ALU
ori $1 $0 4
nop
addu $3 $1 $0
# W to E RS DM
ori $2 $0 5
nop
nop
nop
sw $2 0($0)
nop
nop
lw $1 0($0)
nop
addu $3 $1 $0
# W to M RT ALU
ori $2 $0 3
sw $2 4($0)
# W to M RT DM
ori $2 $0 4
sw $2 0($0)
nop
lw $2 8($0)
sw $2 4($0)
# M to E RS PC
jal func
addu $4 $31 $0
j end
nop
func:
ori $3 $0 2333
subu $2 $1 $3
jr $ra
nop
end:
# W to E RS PC
jal func
nop
addu $4 $31 $0
j end
nop
func:
ori $3 $31 0x2333
subu $2 $1 $3
jr $ra
nop
end: