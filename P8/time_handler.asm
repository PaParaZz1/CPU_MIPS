#.ktext 0x00004180
beq $8 $0 end
nop
if_not_zero:
subi $8 $8 1
ori $11 $0 0x2333 # flag
end:
ori $1 $0 0x7F00
sw $0 0($1) # CTRL
nop
nop
nop
eret
nop
nop
nop