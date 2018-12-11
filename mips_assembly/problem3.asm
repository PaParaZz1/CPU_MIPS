.data
    SRC: .word 0:100
    DEST: .word 0:100
.text
    li $t0 0 # i
    li $t1 100
    loop:
        sll $t0 $t0 2
        lw $t2 SRC($t0)
        sw $t2 DEST($t0)
        srl $t0 $t0 2
        addi $t0 $t0 1 #i++
        bne $t0 $t1 loop