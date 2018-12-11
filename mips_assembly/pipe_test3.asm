ori $1 $0 0x1231
jal func
nop
j end
nop
func:
ori $2 $0 0x1232
jr $ra
nop
end:
subu $3 $1 $2
