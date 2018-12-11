.data
.text
    ori $1 $0 0
    ori $2 $0 4
    ori $6 $0 1
    for_1_begin:
    	slt $3 $1 $2
    	beq $0 $3 for_1_end
    	addu $4 $4 $2
    	addu $1 $1 $6
    	j for_1_begin
    for_1_end:
    ori $5 $0 3