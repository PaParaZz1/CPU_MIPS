ori $1 $0 17
ori $2 $0 13
mult $1 $2
mflo $11
mfhi $12
div $1 $2
mflo $13
mfhi $14
ori $3 $0 19
ori $4 $0 11
multu $3 $4
mflo $11
mfhi $12
divu $3 $4
mflo $13
mfhi $14
mtlo $3
mflo $21
mthi $4
mfhi $22

# M to D RS MD
andi $1 $0 0
andi $2 $0 0
ori $1 $0 9
ori $2 $0 0xfffb
lui $3 0xffff
addu $2 $3 $2
multu $1 $2
mflo $11
blez $11 if_1_else
nop
if_1:
ori $3 $0 5
sllv $12 $11 $3
j end
nop
if_1_else:
ori $3 $0 3
srav $12 $11 $3
end:
sub $13 $2 $12

# W to D RS MD
andi $1 $0 0
andi $2 $0 0
ori $1 $0 9
ori $2 $0 0xfffb
lui $3 0xffff
addu $2 $3 $2
multu $1 $2
mflo $11
nop
blez $11 if_2_else
nop
if_2:
ori $3 $0 5
sllv $12 $11 $3
j end1
nop
if_2_else:
ori $3 $0 3
srav $12 $11 $3
end1:
sub $13 $2 $12

# M to E RS MD
andi $1 $0 0
andi $2 $0 0
ori $1 $0 9
ori $2 $0 0xfffb
lui $3 0xffff
addu $2 $3 $2
multu $1 $2
mflo $11
multu $11 $2
mflo $11
mthi $11
mfhi $11
mtlo $11
# W to E RS MD
andi $1 $0 0
andi $2 $0 0
ori $1 $0 9
ori $2 $0 0xfffb
lui $3 0xffff
addu $2 $3 $2
multu $1 $2
mflo $11
nop
multu $11 $2
mflo $11
nop
mthi $11
mfhi $11
nop
mtlo $11
# W to M RT MD
andi $1 $0 0
andi $2 $0 0
ori $1 $0 9
ori $2 $0 0xfffb
lui $3 0xffff
addu $2 $3 $2
multu $1 $2
mflo $11
sw $11 0($0)
multu $11 $2
mfhi $11
sw $11 4($0)
# no stall
andi $1 $0 0
andi $2 $0 0
ori $1 $0 18
ori $2 $0 15
multu $1 $2
lui $3 0x1234
xori $4 $1 0xffff
add $5 $3 $4
#sw $5 0($0)
#lh $6 2($0)
mflo $7
nor $7 $7 $2
slt $8 $7 $0


