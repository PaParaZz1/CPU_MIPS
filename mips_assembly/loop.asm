ori $2 $0 0x0801
mtc0 $2 $12
loop:
add $1 $0 $0
add $1 $0 $0
add $1 $0 $0
add $1 $0 $0
beq $0 $0 loop
nop
nop