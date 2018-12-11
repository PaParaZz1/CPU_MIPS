# store_EXC
.text
ori $1 $0 0xffff
lui $2 0x7fff
addu $2 $1 $2
bne $2 $0 if_else
addi $3 $2 0x1234
if_2:
ori $4 $0 7
if_else:
ori $4 $0 9

