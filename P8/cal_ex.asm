ori $1 $0 0x7F00
ori $2 $0 0x7F10
ori $3 $0 0x7F2C
ori $4 $0 0x7F34
ori $5 $0 0x7F38
ori $6 $0 0x7F40
loop:
lw $11 0($6) # op
lw $12 0($3) # num1
lw $13 4($3) # num2
ori $21 0x1 # add
ori $22 0x2 # or
ori $23 0x4 # and
ori $24 0x8 # xor
ori $25 0x10 # not and
ori $26 0x20 # not nor
ori $27 0x40 # logic left shift 4
ori $28 0x80 # logic right shift 4
andi $15 $11 0xFF
beq $15 $21 add_
nop
beq $15 $22 or_
nop
beq $15 $23 and_
nop
beq $15 $24 xor_
nop
beq $15 $25 not_and
nop
beq $15 $26 not_or
nop
beq $15 $27 sll4
nop
beq $15 $28 srl4
nop
j continue
nop
add_:
add $16 $12 $13
j continue
nop
or_:
or $16 $12 $13
j continue
nop
and_:
and $16 $12 $13
j continue
nop
xor_:
xor $16 $12 $13
j continue
nop
not_and:
and $16 $12 $13
not $16 $16
j continue
nop
not_or:
or $16 $12 $13
not $16 $16
j continue
nop
sll4:
sllv $16 $12 $13
j continue
nop
srl4:
srlv $16 $12 $13
j continue
nop
continue:
sw $16 0($5)
beq $17 $16 end
nop
sw $16 0($2)
move $17 $16
end:
beq $0 $0 loop
nop