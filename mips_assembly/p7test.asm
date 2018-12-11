# new instr test
ori $1 $0 0x1234
mtc0 $1 $14
mfc0 $2 $14
ori $1 $0 0
mtc0 $1 $14
mfc0 $2 $14
ori $1 $0 0xfc01 #1111_1100_0000_0001
mtc0 $1 $12
mfc0 $2 $12
ori $1 $0 0
lui $3 0x8000
ori $1 $0 0x007c #0000_0000_0111_1100
addu $1 $1 $3
mtc0 $1 $13
mfc0 $2 $13
mtc0 $0 $13
ori $1 $0 0
ori $1 $0 0x3054
mtc0 $1 $14
eret
lui $4 0x1234
ori $3 $0 0x5678

# CP0 forward
ori $3 $0 0x007c
ori $1 $0 0x8666
mtc0 $1 $14
ori $2 $0 0x7c01
mtc0 $2 $12
sw $3 0($0)
lw $4 0($0)
mtc0 $4 $13
mfc0 $5 $13
sw $5 4($0)
mfc0 $6 $14
subu $6 $0 $6
mfc0 $7 $12
blez $7 if_1_else
nop
if_1:
j end
nop
if_1_else:
sll $8 $1 7
end:
sll $8 $1 3
# PC error
lui $3 0x8000
ori $1 $0 0x007c 
addu $1 $1 $3
ori $4 $0 4
jr $4
nop
# illegal instr
lui $3 0x8000
ori $1 $0 0x007c 
addu $1 $1 $3
ori $4 $0 0x0008
movz $1 $6 $0 #illegal
add $7 $6 $3
nop
# load_EXC
#beyond the boundary
ori $1 $0 0x3000
ori $2 $0 3
lw $4 0($1)
addu $5 $4 $2
ori $1 $0 0x7F0c
ori $2 $0 4
lw $4 0($1)
addu $5 $4 $2
ori $1 $0 0x7F00
ori $2 $0 5
lw $4 0($1)
addu $5 $4 $2
# unaligned

ori $1 $0 0x1234
lui $2 0x8765
add $2 $2 $1
sw $2 0($0)
lh $10 0($0)
lh $11 1($0)
lh $12 2($0)
lh $13 3($0)
lw $14 0($0)
lw $15 2($0)
lb $16 3($0)

#timer 
ori $1 $0 0x7F00
ori $2 $0 6
lw $4 1($1)
addu $5 $4 $2
lh $16 0($1)
addu $30 $1 $1
lhu $16 0($1)
addu $30 $1 $1
lb $15 0($1)
addu $30 $1 $1
lbu $15 0($1)
addu $30 $1 $1

# store_EXC
#beyond the boundary
ori $1 $0 0x3004
ori $2 $0 0x1234
lui $3 0x9876
add $4 $3 $2
sw $4 0($1)
ori $1 $0 0x0004
sw $4 0($1)
ori $1 $0 0x7F10
ori $6 $0 5
sw $6 0($1)
sw $6 4($1)
sw $6 8($1)
ori $1 $0 0x7F00
sw $6 8($1)
sw $6 0($1)
#unaligned
ori $1 $0 0x1234
lui $2 0x8765
add $2 $2 $1
sb $2 1($0)
sw $2 1($0)
sb $2 6($0)
sw $2 6($0)
sb $2 11($0)
sw $2 11($0)
sb $2 13($0)
sh $2 13($0)
sb $2 18($0)
sh $2 18($0)
sb $2 23($0)
sw $2 23($0)
sb $2 28($0)
sh $2 28($0)
ori $1 $0 0x7f10
#timer
addu $30 $1 $1
sb $2 0($1)
addu $30 $1 $1
sh $2 0($1)
addu $30 $1 $1
sw $2 8($1)
addu $30 $1 $1


#delay slot exception
lui $1 0x7fff
ori $1 $1 0xffff
blez $1 if_1_else
add $2 $1 $1
if_1:
addu $4 $1 $1
j end1
nop
if_1_else:
addu $3 $1 $1
end1:
add $2 $1 $1
addu $3 $1 $1
addu $3 $1 $1

jal func1
movz $5 $4 $3
addu $3 $1 $1

add $2 $1 $1
addu $3 $1 $1
addu $3 $1 $1

la $9 func2
jalr $9
add $2 $1 $1
addu $26 $1 $1
addu $27 $1 $1
jr $ra
sw $5 1($0)
j end2
nop
func1:
addu $6 $1 $1
addu $7 $1 $1
jr $ra
sw $5 1($0)
func2:
addu $16 $1 $1
addu $17 $1 $1
jr $ra
sw $5 3($0)
end2:

#interrupt mode0
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
sw $4 0($5)  #
addu $2 $2 $1 
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff

#interrupt mode1
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x000b #1011
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1

#÷–∂œ“Ï≥£≥ÂÕª
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
add $11 $1 $1#### ÷–∂œ“Ï≥£≥ÂÕª
addu $2 $2 $1
lui $1 0x7fff

#—”≥Ÿ≤€÷–∂œ
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
addu $2 $2 $1
addu $2 $2 $1
j next
addu $11 $1 $1#### —”≥Ÿ≤€÷–∂œ
addu $2 $2 $1 
lui $1 0x7fff
ori $1 $1 0xffff
next:
ori $1 $1 0xffff
sw $4 0($5)  #
addu $2 $2 $1 
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
addu $2 $2 $1

#‘›Õ£µƒnop÷–∂œ
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
addu $2 $2 $1
addu $2 $2 $1
lui $1 0xffff
beq $1 $0 if_1#### ‘›Õ£nop÷–∂œ
addu $2 $2 $1 
lui $1 0x7fff
ori $1 $1 0xffff
if_1:
ori $1 $1 0xffff
sw $4 0($5)  #
addu $2 $2 $1 
lui $1 0x7fff

#‘›Õ£÷–∂œ
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
nop
nop
lui $1 0x7fff
addu $2 $2 $1
addu $2 $2 $1
lui $1 0xffff
beq $1 $0 if_1#### ‘›Õ£÷–∂œ
addu $2 $2 $1 
lui $1 0x7fff
ori $1 $1 0xffff
if_1:
ori $1 $1 0xffff
sw $4 0($5)  #
addu $2 $2 $1 
lui $1 0x7fff

#c≥À≥˝÷–∂œ
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
mult $2 $5
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
addu $2 $2 $1
addu $2 $2 $1
lui $1 0xffff
mflo $15#### ≥À≥˝÷–∂œ
mult $1 $1
lui $1 0x7fff
ori $1 $1 0xffff
if_1:
ori $1 $1 0xffff
sw $4 0($5)  #
addu $2 $2 $1 
lui $1 0x7fff
ori $1 $1 0xffff
addu $2 $2 $1
addu $2 $2 $1
lui $1 0x7fff
ori $1 $1 0xffff

#c≥À≥˝÷–∂œ2
ori $1 $0 4 # time-cycle
ori $2 $0 0x7f00
ori $5 $0 0x7f00
ori $3 $0 0xfc01 # SR
ori $4 $0 0x0009 #1001
mtc0 $3 $12
sw $1 4($2)
sw $4 0($2)
mult $2 $5
ori $1 $1 0xffff
addu $2 $2 $1
lui $1 0x7fff
addu $2 $2 $1
addu $2 $2 $1
lui $1 0xffff
mflo $15#### ≥À≥˝÷–∂œ2
mtlo $3
lui $1 0x7fff
ori $1 $1 0xffff