.text
lui $t0,0x0fff		#��������
ori $t0,$t0,123
lui $t1,,0xffff		#���츺��
ori $t1,$t1,0xffff
lui $t2,0x0000		#��������
ori $t2,$t2,123
lui $t3,0xffff		#���츺��
ori $t3,$t3,0
lui $t4,0x2342		#��������
ori $t4,$t4,0x9824
lui $t5,0x0000		#��������
ori $t5,$t5,1
lui $t6,0x0fab		#��������
ori $t6,$t6,567
lui $t7,0xfedc		#���츺��
ori $t7,$t7,0xab
nop
nop
nop				#�ſ���ˮ��
sw $t0,0($0)			#��������
sw $t1,4($0)			#��������
sw $t2,8($0)			#��������
sw $t3,12($0)			#��������
sw $t4,16($0)			#��������
sw $t5,20($0)			#��������
sw $t6,24($0)			#��������
sw $t7,28($0)			#��������
nop
nop
nop				#�ſ���ˮ��

addu $t5,$t5,$t5		#������R1ǰ��ָ��
subu $s0,$t5,$0			#������R1 E-M
subu $s0,$t5,$t5		#������R1 ID-M
subu $s0,$0,$t5			#������R1 ID-W
sll $t5,$t0,5			#������R2ǰ��ָ��
subu $s1,$t5,$t3		#������R1 E-M
subu $s1,$t5,$t1		#������R1 ID-M
subu $s1,$0,$t5			#������R1 ID-W
ori $t5,$t6,100			#������I1ǰ��ָ��		
srav $s2,$t5,$t5		#������R1 E-M		
srav $s2,$t5,$0			#������R1 ID-M
srav $s2,$s2,$t5		#������R1 ID-W
lui $t5,0xffff			#������I2ǰ��ָ��
slt $s3,$0,$t5			#������R1 E-M
slt $s3,$t5,$0			#������R1 ID-M
slt $s3,$t5,$t5			#������R1 ID-W
jal loop1			#j��ǰ��ָ��
addu $0,$0,$t1			#�ӳٲ�

lw $s6,8($0)			#load��ǰ��ָ��
xori $s6,$t5,000		#������Ч��rt���Ƿ�ᷢ��������ͣ
ori $s6,$0,1			#��������
lw $t5,4($0)			#load��ǰ��ָ��
xori $s7,$t5,123		#������I1 ID-E
xori $s7,$t1,456		#������I1 ID-M
xori $s7,$t4,010		#������I1 ID-W
lw $s0,4($0)			#load��ǰ��ָ��
lui $s0,0xffff			#������Ч��rs��rt���Ƿ�ᷢ���������ͣ
j loop2
addu $t5,$0,$0			#�ӳٲ�

loop1:
addu $s4,$0,$ra			#������R1 E-M
subu $s4,$0,$ra			#������R1 ID-M
addu $s4,$s4,$ra		#������R1 ID-W
lw $t5,0($0)			#load��ǰ��ָ��
addu $s5,$t5,$t1		#������R1 ID-E
addu $s5,$t1,$t5		#������R1 ID-M
addu $s5,$t5,$t5		#������R1 ID-W
jr $ra
nop				#�ӳٲ�

loop2:
#(load��ָ���store��ָ���rs�Ĵ���ʹ����������I1��̫����������Ͳ�ȫ�������)
lw $s0,16($0)			#load��ǰ��ָ��
sw $s0,32($0)			#store��ID-E
sw $s0,36($0)			#store��ID-M
lw $s0,12($0)			#load��ǰ��ָ��
lw $s0,8($0)			#load��ǰ��ָ��
addu $s0,$0,$t6			#������R1ǰ��ָ��
sw $s0,40($0)			#�������ж�����ֵ������£�ת���Ƿ���ȫ�����ȼ���ȷ
jal loop3			#j��ǰ��ָ��	
nop

sw $ra,52($0)			#����ת��ȷ������ָ���ִ��
sw $ra,56($0)			#����ת��ȷ������ָ��ִ��
ori $s0,$0,0x3184		#װ��Loop4��ַ
jalr $ra,$s0			#j��ID-E
nop

addu $t1,$t1,$s3		#������R1ǰ��ָ��
beq $t1,$t2,loop5		#B��ID-E
nop
addu $t1,$0,$s1			#������R1ǰ��ָ��
addu $0,$s0,$s2			#xxxx
beq $t1,$t2,loop5		#B��ID-M
nop
beq $0,$0,loop5			#��ִ֧��
sll $s5,$s4,5			#�ӳٲ�

loop3:
sw $ra,44($0)			#store��ID-M
sw $ra,48($0)			#store��ID-W
ori $t0,$0,4
addu $ra,$ra,$t0		#�ı���ת��ַ
jr $ra				#j��ID-E
nop

loop4:
jr $ra				#j��ID-M
nop

loop5:				#Сѭ��
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
lw $t1,32($0)			#load��ǰ��ָ��
bgez $t1,loop8			#B��ID-E
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
add $t0,$t0,$t0			#������R1ǰ��ָ��
add $t0,$t0,$t0
add $t0,$t0,$t0
multu $t0,$t1			#md��ָ��
nop
nop
nop
sll $t0,$t0,4			#������R2ǰ��ָ��
srl $t0,$t0,4
sra $t0,$t0,4
divu $t1,$t0			#md��ָ��
nop
nop
nop
nop
nop
nop
nop
nop
addi $t0,$t0,0xffff		#������I1ǰ��ָ��
addi $t0,$t0,0xffff
addi $t0,$t0,0xffff
mthi $t0			#md��ָ��
mult $t1,$t0			#md��ָ��
nop
nop
nop
lw $t2,32($0)			#load��ǰ��ָ��
lw $t3,36($0)
mtlo $t2			#md��ָ��
mult $t2,$t3			#md��ָ��
nop
nop
nop
nop
nop
jal loop9
nop
div $t0,$t1



