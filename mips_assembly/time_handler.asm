beq $8 $0 end
nop
if_not_zero:
subi $8 $8 1
ori $11 $0 0x2333 # flag
end:
sw $0 0($1) # CTRL
nop
nop
nop
eret
nop
nop
nop