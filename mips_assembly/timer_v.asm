ori $1 $0 0x7F00
ori $2 $0 0x7F10
ori $3 $0 0x7F2C
ori $4 $0 0x7F34
ori $5 $0 0x7F38
ori $6 $0 0x7F40
ori $7 $0 0x0009
ori $8 $0 0x0401
ori $9 $0 0 #init
mtc0 $8 $12
loop:
lw $10 0($3)
nop
nop
beq $9 $10 end
nop
if_not_equal:
move $8 $10 # 8 count
move $9 $10
sw $7 0($1) # timer 
nop
end:
beq $11 $0 next
nop
ori $11 $0 0
sw $7 0($1)
next:
sw $8 0($5) # DIGIT
beq $0 $0 loop
nop