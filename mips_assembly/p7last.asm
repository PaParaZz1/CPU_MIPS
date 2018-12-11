#interrupt mode0
.text
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