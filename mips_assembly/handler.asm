    #ori $1 $0 0x3008
    #lui $2 0x1000
   # mtc0 $2 $13
   # mtc0 $1 $14
    
    
  #.ktext 0x00004180
    mfc0 $25 $12
    mfc0 $27 $13
    mfc0 $26 $14
    ori $19 $0 0x007c
    and $21 $19 $27
    beq $21 $0 if_interrupt
    nop
    nop
    nop
    if_interrupt:
    ori $22 $0 0
    ori $13 $0 0
    ori $22 $0 0x0800
    and $22 $27 $22
    ori $13 $0 0x0800
    beq $22 $13 if_uart
    nop
    nop
    if_timer: 
    ori $22 $0 0
    ori $13 $0 0
    ori $22 $0 0x7F00
    ori $13 $0 0x0006
    lw $14 0($22)
    and $14 $14 $13
    bne $14 $0 mode1
    nop
    mode0:
    ori $15 $0 0
    sw $15 0($22)
    nop
    nop
    eret
    mode1:
    nop
    nop
    nop
    eret
    nop
    nop
    
    if_uart:
    ori $22 $0 0
    ori $13 $0 0
    ori $22 $0 0x7F10
    lw $13 0($22)
    sw $13 0($22)
    nop
    nop
    nop
    eret
    nop
    nop
    nop
    nop
    nop
    nop
    
    
