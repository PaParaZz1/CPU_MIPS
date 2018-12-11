ori $1 0x7F00
ori $2 0x0005
ori $3 $0 7
sw $3 4($1)
sw $2 0($1)
lw $5 4($1)
lw $6 0($1)
ori $1 0x7F10
ori $2 0x0005
ori $3 $0 9
sw $3 4($1)
sw $2 0($1)
lw $5 4($1)
lw $6 0($1)