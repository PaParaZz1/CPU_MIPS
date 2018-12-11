.data
.text
    #main
    li $a0 3
    li $a1 1
    li $a2 2
    jal sort
    li $v0 1 # output 
    syscall
    li $v0 1
    move $a0 $a1
    syscall
    li $v0 1
    move $a0 $a2
    syscall
    li $v0 10
    syscall
    sort:
    move $s0 $a0
    move $s1 $a1
    move $s2 $a2
    slt $t1 $a0 $a1 # if a0<a1
    beq $t1 $0 if_1_else
    if_1: # a0<a1
    slt $t1 $a1 $a2
    beq $t1 $0 if_2_else # if a1<a2
    if_2: # a1<a2 return
    jr $ra
    if_2_else: #if a1>a2
    slt $t1 $a0 $a2
    beq $t1 $0 if_3_else # if a0<a2
    if_3: # a0<a2
    move $a1 $s2
    move $a2 $s1
    jr $ra
    if_3_else: # a0>a2
    move $a0 $s2
    move $a1 $s0
    move $a2 $s1
    jr $ra
    if_1_else:
    slt $t1 $a0 $a2
    beq $t1 $0 if_4_else # if a0<a2
    if_4: # a0<a2 return
    move $a0 $s1
    move $a1 $s0
    jr $ra
    if_4_else: #if a0>a2
    slt $t1 $a1 $a2
    beq $t1 $0 if_5_else # if a1<a2
    if_5: # a1<a2
    move $a0 $s1
    move $a1 $s2
    move $a2 $s0
    jr $ra
    if_5_else: # a1>a2
    move $a0 $s2
    move $a1 $s1
    move $a2 $s0
    jr $ra