.text
ori $t0,$0,0x00000000
mtc0 $t0,$12		#SR初始化
ori $t1,$0,100		#present = 100	
sw $t1,0x00007f04($0)	#写present
lui $t0,0xffff
ori $t0,$t0,0xff09		#4'b1001
sw $t0,0x00007f00($0)	#写CTRL
#计数开始

ori $a0,$0,123		#检验ori指令对0与非零数操作的情况，并构造正数123
ori $a1,$a0,456		#检验ori指令对两个非零数操作的情况
lui $a2,123		#检验lui指令，并构造正数
lui $a3,0x8000		#
ori $a3,$a3,0		#构造超大负数
addu $s0,$a0,$a2	#检验addu指令，正正相加
addu $s1,$a0,$a3	#检验addu指令，正负相加
add $s2,$a3,$a3
nop									#产生算术溢出异常
sw $s0,144($0)		#检验sw指令，并保存addu指令的执行情况
sw $s1,148($0)		#检验sw指令，并保存addu指令的执行情况
sw $s2,152($0)		#检验sw指令，并保存addu指令的执行情况
addiu $s0,$a0,0x0fff	#检验addiu指令，正正相加
addiu $s1,$a0,0xff00	#检验addiu指令，正负相加
addi $s2,$a3,0x80000000						#产生算术溢出异常
subu $s3,$a0,$a2	#检验subu指令，正正相减
lui $a0,0x7000		#构造超大正数
sub $s4,$a0,$a3								#产生算术溢出异常
subu $s5,$a3,$a3	#检验subu指令，负负相减
xori $s6,$a3,0xac00	#检验xori指令
ori $t0,$0,0x0000	#装入数据段初始地址
sw $a1,8($0)		#检验sw指令，并保存ori指令的执行情况
sw $a3,12($0)		#检验sw指令，并保存lui指令的执行情况
sw $s0,16($0)		#检验sw指令，并保存addiu指令的执行情况
sw $s2,22($0)									#产生存地址异常(不对齐)
sw $s4,24($0)		#检验sw指令，并保存subiu指令的执行情况
sw $s5,28($0)		#检验sw指令，并保存subiu指令的执行情况
sw $s6,32($0)		#检验sw指令
lw $a0,4($0)		#检验lw指令
exc:
lw $a1,14($0)									#产生取数地址异常(不对齐)
lh $s0,4($0)		#检验lh指令
lh $s1,12($0)		#检验lh指令
sw $a0,32($0)		#保存lw指令的执行情况
sw $a1,36($0)		#保存lw指令的执行情况
sw $s0,40($0)		#保存lh指令的执行情况
sw $s1,0x00003180($0)								#产生存地址异常(超范围)
jal done		#检验jal指令
nop
loop1:
sw $s5,48($0)		#检验跳转的地址是否正确
jal done1		#检验jal指令
nop
sw $ra,52($0)		#检验跳转的地址是否正确
beq $ra,$ra,loop2	#检验beq指令跳转的情况
nop
done:
ori $a0,$0,1		#重新给$a0赋值
ori $a2,$0,1		#重新给$a2赋值
la $t0,exc
addi $t0,$t0,4#1
#jalr $t0										#产生pc地址异常
nop
sw $a0,0($0)		#检验sw指令，并保存ori指令的执行情况
jalr $s5,$ra		#检验jalr指令
nop
loop2:			#构造综合性的指令测试
sw $a2,4($0)		#检验sw指令，并保存ori指令的执行情况
xori $a2,$a2,0x0000	#检验xori指令
addu $s0,$s0,$s3	#检验addu指令
subu $s1,$s1,$s2	#检验subu指令
xori $s2,$s2,1111	#检验xori指令
lui $s3,6789		#检验lui指令
ori $s3,$s3,3810	#检验ori指令
lh $s4,31($t0)									#产生取数地址异常(不对齐)
addu $s4,$s4,$s3	#检验addu指令
lw $s5,40($0)		#检验lw指令
sw $a2,56($0)		#存入xori指令执行情况
sw $s0,60($0)		#存入addu指令执行情况
sw $s1,64($0)		#存入subu指令执行情况
sw $s2,68($0)		#存入xori指令执行情况
sw $s3,72($0)		#存入ori，lui指令执行情况
sw $s4,76($0)		#存入lh指令执行情况
sw $s5,80($0)		#存入lw指令执行情况
j done2
nop
done1:
jr $ra			#检验jr指令，返回到loop1中的beq指令
nop
done2:
sw $ra,84($0)		#保存返回值地址
lui $t1,0x1111
ori $t1,$t1,0xffff
sw $t1,88($0)
sw $t1,92($0)
sw $t1,96($0)
lh $t1,88($0)		#检验lh
sw $t1,100($0) 
lh $t1,90($0)
sw $t1,104($0)
lui $t1,0xffff
ori $t1,$t1,0xffff
sh $t1,107($0)									#产生存地址异常(不对齐)
sh $t1,114($0)		#检验sh
la $t1,0x00002000
jr $t1										#产生pc地址异常
nop
bgez $0,return2
nop
return1:
sw $t1,116($0)
return2:
sw $t1,120($0)
ori $t2,$0,0x000a
srav $t3,$t1,$t2	#检验srav
sw $t3,124($0)
sll $t1,$t1,10		#检验sll
sw $t1,128($0)
slt $t1,$a0,$a1		#检验slt
sw $t1,132($0)
slt $t1,$a1,$a0		#检验slt
sw $t1,136($0)
lb $t1,0x00007011($0)								#产生取数地址异常(超范围)
sw $t1,140($0)
nop
nop
nop			#排空流水线
lui $t0,0xffff
ori $t0,0xffff		#构造数据
and $t1,$0,$t0		#检验and指令
and $t2,$t0,$t0		#检验and指令
andi $t3,$0,0xffff	#检验andi指令
andi $t4,$t0,0x0fff	#检验andi指令
sllv $t5,$t0,$t4	#检验sllv指令
sllv $t6,$t0,$0		#检验sllv指令
sra $t7,$t0,7		#检验sra指令
ori $t8,$0,0xffff	#构造数据
sra $t8,$t8,5		#检验sra指令
srl $t9,$t0,10		#检验srl指令
sw $t0,156($0)		
sw $t1,160($0)		#保存and指令执行结果
sw $t2,164($0)		#保存and指令执行结果
sw $t3,168($0)		#保存andi指令执行结果
sw $t4,172($0)		#保存andi指令执行结果
sw $t5,176($0)		#保存sllv指令执行结果
sw $t6,180($0)		#保存sllv指令执行结果
sw $t7,184($0)		#保存sra指令执行结果
sw $t8,188($0)		#保存sra指令执行结果
sw $t9,192($0)		#保存srl指令执行结果
xor $t1,$t0,$t0		#检验xor指令
xor $t2,$t0,$0		#检验xor指令
nor $t3,$t0,$0		#检验nor指令
nor $t4,$0,$0		#检验nor指令
sw $t1,196($0)
sw $t2,200($0)
sw $t3,204($0)
sw $t4,208($0)
sltu $t1,$t0,$0		#检验sltu指令
sltu $t2,$0,$t0		#检验sltu指令
slti $t3,$0,-100	#检验slti指令
slti $t4,$t0,0x0001	#检验slti指令
sltiu $t5,$t0,0x0001	#检验sltiu指令
sltiu $t6,$0,-1234	#检验sltiu指令
sw $t1,212($0)
sw $t2,216($0)
sw $t3,220($0)
sw $t4,224($0)
sw $t5,228($0)
sw $t6,232($0)
sb $t6,239($0)		#检验sb指令
sb $t6,238($0)		#检验sb指令
sb $t6,237($0)		#检验sb指令
sb $t6,236($0)		#检验sb指令
lbu $t1,156($0)		#检验lbu指令
lbu $t2,157($0)		#检验lbu指令
lbu $t3,158($0)		#检验lbu指令
lbu $t4,159($0)		#检验lbu指令
lwl $t4,159($0)									#产生非法指令异常
lhu $t5,156($0)		#检验lhu指令
lhu $t6,158($0)		#检验lhu指令
lh $t7,158($0)		#检验lh指令
lb $t8,159($0)		#检验lb指令
sw $t1,240($0)
sw $t2,244($0)
sw $t3,248($0)
sw $t4,252($0)
sw $t5,256($0)
sw $t6,260($0)
sw $t7,264($0)
sw $t8,268($0)
				#小循环
ori $t0,$0,0			#i=0
ori $t1,$0,5			#n=5
ori $t2,$0,1	
loop3:	
addu $t0,$t0,$t2		#i++
bne $t0,$t1,loop3		#检验bne指令
sw $t0,272($0)

ori $t0,$0,5			#n=5
loop4:	
addiu $t0,$t0,-1		#n--
bgtz $t0,loop4			#检验bgtz指令
sw $t0,276($0)

ori $t0,$0,-5			#n=-5
sw $t0,280($0)
loop5:	
addu $t0,$t0,$t2		#n++
blez $t0,loop5			#检验blez指令
sw $t0,284($0)

ori $t0,$0,-5			#n=-5
sw $t0,288($0)
loop6:	
addu $t0,$t0,$t2		#n++
bltz $t0,loop6			#检验bltz指令
sw $t0,292($0)

lui $t0,0x0123
ori $t0,$t0,0x4567
ori $t1,$0,0x1234
add $t2,$t0,$t1			#检验add指令
sub $t3,$t0,$t1			#检验sub指令
addi $t3,$t1,0x6789		#检验addi指令
sw $t1,296($0)
sw $t2,300($0)
sw $t3,304($0)

lui $t0,0xffff
ori $t0,$t0,0xffff
lui $t1,0x1234
ori $t1,$t1,0x5678

mult $t0,$t1			#检验mult指令
nop				#检验mult指令阻塞的情况
nop
nop
mfhi $t2			#检验mfhi指令
mflo $t3			#检验mflo指令
multu $t0,$t1			#检验multu指令
nop
mfhi $t2
mflo $t3
div $t1,$t0			#检验div指令
nop				#检验div指令的阻塞情况
nop
nop
nop
nop
mfhi $t2
mflo $t3
divu $t0,$t1			#检验divu指令
addi $t0,$t0,0x0fff		#检验乘除槽能否正常运行
xori $t1,$t1,0xffff
nop
nop
mfhi $t2
mflo $t3
mthi $t0
mtlo $t1

or $t0,$t1,$0
srlv $t1,$t0,$ra
andi $t0,$t0,0
lui $t0,0x8000
andi $t1,$t1,0
lui $t1,0x8000
j exc1
add $t0,$t0,$t1									#检验延迟槽指令异常

fo:
mfc0 $t1,$14
sw $t1,316($0)
j return
nop

exc1:
#异常中断指令检测
lui $t0,0xffff
ori $t0,$t0,0xffff
mtc0 $t0,$12
mfc0 $t1,$12
sw $t1,308($0)
mtc0 $t0,$13
mfc0 $t1,$13
sw $t1,312($0)
la $t0,fo
mtc0 $t0,$14
eret

return:
