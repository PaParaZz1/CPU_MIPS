.text
lui $t0,0x0fff		#构造正数
ori $t0,$t0,123
lui $t1,,0xffff		#构造负数
ori $t1,$t1,0xffff
lui $t2,0x0000		#构造正数
ori $t2,$t2,123
lui $t3,0xffff		#构造负数
ori $t3,$t3,0
lui $t4,0x2342		#构造数据
ori $t4,$t4,0x9824
lui $t5,0x0000		#构造正数
ori $t5,$t5,1
lui $t6,0x0fab		#构造正数
ori $t6,$t6,567
lui $t7,0xfedc		#构造负数
ori $t7,$t7,0xab
nop
nop
nop				#排空流水线
sw $t0,0($0)			#存入数据
sw $t1,4($0)			#存入数据
sw $t2,8($0)			#存入数据
sw $t3,12($0)			#存入数据
sw $t4,16($0)			#存入数据
sw $t5,20($0)			#存入数据
sw $t6,24($0)			#存入数据
sw $t7,28($0)			#存入数据
nop
nop
nop				#排空流水线

addu $t5,$t5,$t5		#运算类R1前序指令
subu $s0,$t5,$0			#运算类R1 E-M
subu $s0,$t5,$t5		#运算类R1 ID-M
subu $s0,$0,$t5			#运算类R1 ID-W
sll $t5,$t0,5			#运算类R2前序指令
subu $s1,$t5,$t3		#运算类R1 E-M
subu $s1,$t5,$t1		#运算类R1 ID-M
subu $s1,$0,$t5			#运算类R1 ID-W
ori $t5,$t6,100			#运算类I1前序指令		
srav $s2,$t5,$t5		#运算类R1 E-M		
srav $s2,$t5,$0			#运算类R1 ID-M
srav $s2,$s2,$t5		#运算类R1 ID-W
lui $t5,0xffff			#运算类I2前序指令
slt $s3,$0,$t5			#运算类R1 E-M
slt $s3,$t5,$0			#运算类R1 ID-M
slt $s3,$t5,$t5			#运算类R1 ID-W
jal loop1			#j类前序指令
addu $0,$0,$t1			#延迟槽

lw $s6,8($0)			#load类前序指令
xori $s6,$t5,000		#检验无效的rt域是否会发生多余暂停
ori $s6,$0,1			#构造正数
lw $t5,4($0)			#load类前序指令
xori $s7,$t5,123		#运算类I1 ID-E
xori $s7,$t1,456		#运算类I1 ID-M
xori $s7,$t4,010		#运算类I1 ID-W
lw $s0,4($0)			#load类前序指令
lui $s0,0xffff			#检验无效的rs，rt域是否会发生多余的暂停
j loop2
addu $t5,$0,$0			#延迟槽

loop1:
addu $s4,$0,$ra			#运算类R1 E-M
subu $s4,$0,$ra			#运算类R1 ID-M
addu $s4,$s4,$ra		#运算类R1 ID-W
lw $t5,0($0)			#load类前序指令
addu $s5,$t5,$t1		#运算类R1 ID-E
addu $s5,$t1,$t5		#运算类R1 ID-M
addu $s5,$t5,$t5		#运算类R1 ID-W
jr $ra
nop				#延迟槽

loop2:
#(load类指令和store类指令的rs寄存器使用与运算类I1无太大区别，这里就不全面测试了)
lw $s0,16($0)			#load类前序指令
sw $s0,32($0)			#store类ID-E
sw $s0,36($0)			#store类ID-M
lw $s0,12($0)			#load类前序指令
lw $s0,8($0)			#load类前序指令
addu $s0,$0,$t6			#运算类R1前序指令
sw $s0,40($0)			#检验在有多种新值的情况下，转发是否完全且优先级正确
jal loop3			#j类前序指令	
nop

sw $ra,52($0)			#若跳转正确，该条指令不会执行
sw $ra,56($0)			#若跳转正确，该条指令执行
ori $s0,$0,0x3184		#装入Loop4地址
jalr $ra,$s0			#j类ID-E
nop

addu $t1,$t1,$s3		#运算类R1前序指令
beq $t1,$t2,loop5		#B类ID-E
nop
addu $t1,$0,$s1			#运算类R1前序指令
addu $0,$s0,$s2			#xxxx
beq $t1,$t2,loop5		#B类ID-M
nop
beq $0,$0,loop5			#分支执行
sll $s5,$s4,5			#延迟槽

loop3:
sw $ra,44($0)			#store类ID-M
sw $ra,48($0)			#store类ID-W
ori $t0,$0,4
addu $ra,$ra,$t0		#改变跳转地址
jr $ra				#j类ID-E
nop

loop4:
jr $ra				#j类ID-M
nop

loop5:				#小循环
ori $t0,$0,0			#i=0
loop6:
ori $t1,$0,5			#n=5
ori $t2,$0,1			
addu $t0,$t0,$t2		#i++
beq $t0,$t1,loop7
sw $t0,60($0)
j loop6
nop

loop7:
lw $t1,32($0)			#load类前序指令
bgez $t1,loop8			#B类ID-E
nop
addu $t0,$t0,$0

loop8:
addu $t0,$0,$s5
sw $t0,64($0)
nop
nop
j loop10

loop9:
mult $ra,$ra
mfhi $t0
jr $ra
nop

loop10:
lui $t0,0x0123
ori $t0,$t0,0x4567
addi $t0,$0,0xffff
add $t0,$t0,$t0			#运算类R1前序指令
add $t0,$t0,$t0
add $t0,$t0,$t0
multu $t0,$t1			#md类指令
nop
nop
nop
sll $t0,$t0,4			#运算类R2前序指令
srl $t0,$t0,4
sra $t0,$t0,4
divu $t1,$t0			#md类指令
nop
nop
nop
nop
nop
nop
nop
nop
addi $t0,$t0,0xffff		#运算类I1前序指令
addi $t0,$t0,0xffff
addi $t0,$t0,0xffff
mthi $t0			#md类指令
mult $t1,$t0			#md类指令
nop
nop
nop
lw $t2,32($0)			#load类前序指令
lw $t3,36($0)
mtlo $t2			#md类指令
mult $t2,$t3			#md类指令
nop
nop
nop
nop
nop
jal loop9
nop
div $t0,$t1



