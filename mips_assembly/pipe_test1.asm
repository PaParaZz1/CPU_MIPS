ori $s1 $0 0x8284
sw $s1 0($0)
lui $31 0x1123
lui $31 0x9982
jal func
nop
ori $31 $0 0x1021
lb $s1 0($0)
func:
ori $30 $0 0x8888

jr $31
nop