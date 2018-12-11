.data
.text
    ori $0 $t0 0x2333 # 检测0号寄存器能保持值为0
    ori $1 $t0 0x0000 # 检测1-9号寄存器是否能正常读写并且检测ori指令
    ori $2 $t0 0x2333 
    ori $3 $t0 0x2333 
    ori $4 $t0 0x2333 
    ori $5 $t0 0x2333 
    ori $6 $t0 0x2333 
    ori $7 $t0 0x2333 
    ori $8 $t0 0xbaaa
    ori $9 $t0 0xbaaa
    nop #检测nop指令
    addu $10 $1 $1 #检测10-12号寄存器是否能正常读写并检测addu指令
    addu $11 $1 $9
    addu $12 $9 $9
    nop
    subu $13 $1 $1 #检测13-15号寄存器是否能正常读写并检测subu指令
    subu $14 $1 $9
    subu $15 $9 $1
    nop
    lui $16 0x0002 #检测16-18号寄存器是否能正常读写并检测subu指令
    lui $17 0x0001
    lui $18 0x6666
    nop
    sw $16 0($1) #检测sw指令
    sw $17 8($1)
    sw $18 12($1)
    nop
    lw $19 0($1) #检测19-21号寄存器并检测lw指令
    lw $20 4($1)
    lw $21 8($1)
    lui $1 0x9999
    lui $2 0xa891
    add $3 $1 $2
