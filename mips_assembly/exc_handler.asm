.ktext 0x00004180
mfc0 $t0,$13
andi $t0,$t0,0x0000007c		#掩码
beq $t0,$0,interrupt
nop
beq $t0,16,load
nop
beq $t0,20,store
nop
beq $t0,40,il_code
nop
beq $t0,48,overflow
nop




interrupt:
sw $0,0x00007f00($0)		#写CTRL[3]为0
lui $t0,0xffff
ori $t0,$t0,0xff08		#4'b1000
sw $t0,0x00007f00($0)		#写CTRL[3]为1
lui $t0,0xffff
ori $t0,$t0,0xff09		#4'b1001
sw $t0,0x00007f00($0)		#写CTRL[0]为1
eret







load:
mfc0 $t0,$14
addiu $t0,$t0,4
mtc0 $t0,$14			#出现异常则跳过该指令
eret

store:
mfc0 $t0,$14
addiu $t0,$t0,4
mtc0 $t0,$14			#出现异常则跳过该指令
eret

il_code:
mfc0 $t0,$14
addiu $t0,$t0,4
mtc0 $t0,$14			#出现异常则跳过该指令
eret

overflow:
mfc0 $t0,$14
addiu $t0,$t0,4
mtc0 $t0,$14			#出现异常则跳过该指令
eret



















