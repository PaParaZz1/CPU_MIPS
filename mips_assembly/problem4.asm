.text
    #main
    li $a0 3 # first call
    jal ABS
    move $a0 $v0
    li $v0 1
    syscall #first output
    li $a0 -3 # second call
    jal ABS
    move $a0 $v0
    li $v0 1
    syscall #second output
    li $v0 10 # end
    syscall
    ABS:
        slt $t1 $a0 $0 # if a0<0
        bne $t1 $0 if_1_else
        if_1:
        move $v0 $a0
        jr $ra
        if_1_else:
        sub $v0 $0 $a0
        jr $ra
