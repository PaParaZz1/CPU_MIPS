.data
.text
    ori $1 $0 0x1234
    lui $2 0x9898
    addu $4 $1 $2
    sw $1 0($0)
    lw $3 0($0)
    sw $4 0($0)
    lh $5 2($0)
    lb $6 0($0)
    lb $7 1($0)
    lb $8 3($0)
    lh $20 0($0)
    lh $21 2($0)
    sll $9 $8 3
    slt $10 $1 $4
    ori $11 $0 0x9876
    lui $12 0x2345
    addu $12 $11 $12
    sb $12 1($0)
    lw $12 0($0)
    sb $13 2($0)
    lw $13 0($0)
    sb $14 3($0)
    lw $14 0($0) 
    sh $15 0($0)
    sh $16 2($0)
    ori $1 $0 3
    srav $17 $11 $1
    ori $22 $0 0x0001 #测试22-31号寄存器并测试beq指令
    ori $27 $0 0x0003
    ori $28 $0 0x1234
    lui $29  0x5678
    addu $22 $28 $29
    sw $22 0($0)
    lb $21 1($0)
    sh $22 4($0)
    beq $8 $0 if_1_else #beq测试，进行跳转
    nop
    if_1:
    ori $30 $0 0x6666
    if_1_else:
    ori $30 $0 0x1111
    ori $31 $0 0x3333
    beq $29 $0 if_2_else #beq测试，不进行跳转，顺序执行
    nop
    if_2:
    ori $11 $0 0x2222
    if_2_else:
    
    jal func # jal 测试
    nop
    j end # j 测试，同时跳到末尾结束程
    nop
func:
    ori $12 $0 0x0022
    jr $ra # jr 测试
    nop
end:
    lui $1 0x9889 
    blez $1 if_4_else
    nop
    if_4:
    lui $2 0x1122
    j end1
    nop
    if_4_else:
    lui $2 0x9982
    end1:
