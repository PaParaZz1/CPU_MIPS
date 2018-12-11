
    #ori $16 $0
    mfc0 $27 $13
    mfc0 $26 $14
    lui $20 0x1000 # BD
    and $21 $20 $27
    subu $22 $20 $21
    bne $22 $0 if_not_delay_slot
    nop
    ori $23 $0 4
    sub $26 $26 $23
    if_not_delay_slot:
    ori $24 $0 0x007c
    and $25 $24 $0
    
error_PC:
    ori $26 $0 0x3000
    mtc0 $26 $14
    eret
illegal_instr:
    mfc0 $26 $14
    addi $26 $26 4
    mtc0 $26 $14
    eret
overflow:
    mfc0 $26 $14
    addi $26 $26 4
    mtc0 $26 $14
    eret
load_error:
    mfc0 $26 $14
    addi $26 $26 4
    mtc0 $26 $14
    eret
store_error:
    mfc0 $26 $14
    addi $26 $26 4
    mtc0 $26 $14
    eret