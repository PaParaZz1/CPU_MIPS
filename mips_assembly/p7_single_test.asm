.text
ori $t0,$0,0x00000000
mtc0 $t0,$12		#SR��ʼ��
ori $t1,$0,100		#present = 100	
sw $t1,0x00007f04($0)	#дpresent
lui $t0,0xffff
ori $t0,$t0,0xff09		#4'b1001
sw $t0,0x00007f00($0)	#дCTRL
#������ʼ

ori $a0,$0,123		#����oriָ���0����������������������������123
ori $a1,$a0,456		#����oriָ����������������������
lui $a2,123		#����luiָ�����������
lui $a3,0x8000		#
ori $a3,$a3,0		#���쳬����
addu $s0,$a0,$a2	#����adduָ��������
addu $s1,$a0,$a3	#����adduָ��������
add $s2,$a3,$a3
nop									#������������쳣
sw $s0,144($0)		#����swָ�������adduָ���ִ�����
sw $s1,148($0)		#����swָ�������adduָ���ִ�����
sw $s2,152($0)		#����swָ�������adduָ���ִ�����
addiu $s0,$a0,0x0fff	#����addiuָ��������
addiu $s1,$a0,0xff00	#����addiuָ��������
addi $s2,$a3,0x80000000						#������������쳣
subu $s3,$a0,$a2	#����subuָ��������
lui $a0,0x7000		#���쳬������
sub $s4,$a0,$a3								#������������쳣
subu $s5,$a3,$a3	#����subuָ��������
xori $s6,$a3,0xac00	#����xoriָ��
ori $t0,$0,0x0000	#װ�����ݶγ�ʼ��ַ
sw $a1,8($0)		#����swָ�������oriָ���ִ�����
sw $a3,12($0)		#����swָ�������luiָ���ִ�����
sw $s0,16($0)		#����swָ�������addiuָ���ִ�����
sw $s2,22($0)									#�������ַ�쳣(������)
sw $s4,24($0)		#����swָ�������subiuָ���ִ�����
sw $s5,28($0)		#����swָ�������subiuָ���ִ�����
sw $s6,32($0)		#����swָ��
lw $a0,4($0)		#����lwָ��
exc:
lw $a1,14($0)									#����ȡ����ַ�쳣(������)
lh $s0,4($0)		#����lhָ��
lh $s1,12($0)		#����lhָ��
sw $a0,32($0)		#����lwָ���ִ�����
sw $a1,36($0)		#����lwָ���ִ�����
sw $s0,40($0)		#����lhָ���ִ�����
sw $s1,0x00003180($0)								#�������ַ�쳣(����Χ)
jal done		#����jalָ��
nop
loop1:
sw $s5,48($0)		#������ת�ĵ�ַ�Ƿ���ȷ
jal done1		#����jalָ��
nop
sw $ra,52($0)		#������ת�ĵ�ַ�Ƿ���ȷ
beq $ra,$ra,loop2	#����beqָ����ת�����
nop
done:
ori $a0,$0,1		#���¸�$a0��ֵ
ori $a2,$0,1		#���¸�$a2��ֵ
la $t0,exc
addi $t0,$t0,4#1
#jalr $t0										#����pc��ַ�쳣
nop
sw $a0,0($0)		#����swָ�������oriָ���ִ�����
jalr $s5,$ra		#����jalrָ��
nop
loop2:			#�����ۺ��Ե�ָ�����
sw $a2,4($0)		#����swָ�������oriָ���ִ�����
xori $a2,$a2,0x0000	#����xoriָ��
addu $s0,$s0,$s3	#����adduָ��
subu $s1,$s1,$s2	#����subuָ��
xori $s2,$s2,1111	#����xoriָ��
lui $s3,6789		#����luiָ��
ori $s3,$s3,3810	#����oriָ��
lh $s4,31($t0)									#����ȡ����ַ�쳣(������)
addu $s4,$s4,$s3	#����adduָ��
lw $s5,40($0)		#����lwָ��
sw $a2,56($0)		#����xoriָ��ִ�����
sw $s0,60($0)		#����adduָ��ִ�����
sw $s1,64($0)		#����subuָ��ִ�����
sw $s2,68($0)		#����xoriָ��ִ�����
sw $s3,72($0)		#����ori��luiָ��ִ�����
sw $s4,76($0)		#����lhָ��ִ�����
sw $s5,80($0)		#����lwָ��ִ�����
j done2
nop
done1:
jr $ra			#����jrָ����ص�loop1�е�beqָ��
nop
done2:
sw $ra,84($0)		#���淵��ֵ��ַ
lui $t1,0x1111
ori $t1,$t1,0xffff
sw $t1,88($0)
sw $t1,92($0)
sw $t1,96($0)
lh $t1,88($0)		#����lh
sw $t1,100($0) 
lh $t1,90($0)
sw $t1,104($0)
lui $t1,0xffff
ori $t1,$t1,0xffff
sh $t1,107($0)									#�������ַ�쳣(������)
sh $t1,114($0)		#����sh
la $t1,0x00002000
jr $t1										#����pc��ַ�쳣
nop
bgez $0,return2
nop
return1:
sw $t1,116($0)
return2:
sw $t1,120($0)
ori $t2,$0,0x000a
srav $t3,$t1,$t2	#����srav
sw $t3,124($0)
sll $t1,$t1,10		#����sll
sw $t1,128($0)
slt $t1,$a0,$a1		#����slt
sw $t1,132($0)
slt $t1,$a1,$a0		#����slt
sw $t1,136($0)
lb $t1,0x00007011($0)								#����ȡ����ַ�쳣(����Χ)
sw $t1,140($0)
nop
nop
nop			#�ſ���ˮ��
lui $t0,0xffff
ori $t0,0xffff		#��������
and $t1,$0,$t0		#����andָ��
and $t2,$t0,$t0		#����andָ��
andi $t3,$0,0xffff	#����andiָ��
andi $t4,$t0,0x0fff	#����andiָ��
sllv $t5,$t0,$t4	#����sllvָ��
sllv $t6,$t0,$0		#����sllvָ��
sra $t7,$t0,7		#����sraָ��
ori $t8,$0,0xffff	#��������
sra $t8,$t8,5		#����sraָ��
srl $t9,$t0,10		#����srlָ��
sw $t0,156($0)		
sw $t1,160($0)		#����andָ��ִ�н��
sw $t2,164($0)		#����andָ��ִ�н��
sw $t3,168($0)		#����andiָ��ִ�н��
sw $t4,172($0)		#����andiָ��ִ�н��
sw $t5,176($0)		#����sllvָ��ִ�н��
sw $t6,180($0)		#����sllvָ��ִ�н��
sw $t7,184($0)		#����sraָ��ִ�н��
sw $t8,188($0)		#����sraָ��ִ�н��
sw $t9,192($0)		#����srlָ��ִ�н��
xor $t1,$t0,$t0		#����xorָ��
xor $t2,$t0,$0		#����xorָ��
nor $t3,$t0,$0		#����norָ��
nor $t4,$0,$0		#����norָ��
sw $t1,196($0)
sw $t2,200($0)
sw $t3,204($0)
sw $t4,208($0)
sltu $t1,$t0,$0		#����sltuָ��
sltu $t2,$0,$t0		#����sltuָ��
slti $t3,$0,-100	#����sltiָ��
slti $t4,$t0,0x0001	#����sltiָ��
sltiu $t5,$t0,0x0001	#����sltiuָ��
sltiu $t6,$0,-1234	#����sltiuָ��
sw $t1,212($0)
sw $t2,216($0)
sw $t3,220($0)
sw $t4,224($0)
sw $t5,228($0)
sw $t6,232($0)
sb $t6,239($0)		#����sbָ��
sb $t6,238($0)		#����sbָ��
sb $t6,237($0)		#����sbָ��
sb $t6,236($0)		#����sbָ��
lbu $t1,156($0)		#����lbuָ��
lbu $t2,157($0)		#����lbuָ��
lbu $t3,158($0)		#����lbuָ��
lbu $t4,159($0)		#����lbuָ��
lwl $t4,159($0)									#�����Ƿ�ָ���쳣
lhu $t5,156($0)		#����lhuָ��
lhu $t6,158($0)		#����lhuָ��
lh $t7,158($0)		#����lhָ��
lb $t8,159($0)		#����lbָ��
sw $t1,240($0)
sw $t2,244($0)
sw $t3,248($0)
sw $t4,252($0)
sw $t5,256($0)
sw $t6,260($0)
sw $t7,264($0)
sw $t8,268($0)
				#Сѭ��
ori $t0,$0,0			#i=0
ori $t1,$0,5			#n=5
ori $t2,$0,1	
loop3:	
addu $t0,$t0,$t2		#i++
bne $t0,$t1,loop3		#����bneָ��
sw $t0,272($0)

ori $t0,$0,5			#n=5
loop4:	
addiu $t0,$t0,-1		#n--
bgtz $t0,loop4			#����bgtzָ��
sw $t0,276($0)

ori $t0,$0,-5			#n=-5
sw $t0,280($0)
loop5:	
addu $t0,$t0,$t2		#n++
blez $t0,loop5			#����blezָ��
sw $t0,284($0)

ori $t0,$0,-5			#n=-5
sw $t0,288($0)
loop6:	
addu $t0,$t0,$t2		#n++
bltz $t0,loop6			#����bltzָ��
sw $t0,292($0)

lui $t0,0x0123
ori $t0,$t0,0x4567
ori $t1,$0,0x1234
add $t2,$t0,$t1			#����addָ��
sub $t3,$t0,$t1			#����subָ��
addi $t3,$t1,0x6789		#����addiָ��
sw $t1,296($0)
sw $t2,300($0)
sw $t3,304($0)

lui $t0,0xffff
ori $t0,$t0,0xffff
lui $t1,0x1234
ori $t1,$t1,0x5678

mult $t0,$t1			#����multָ��
nop				#����multָ�����������
nop
nop
mfhi $t2			#����mfhiָ��
mflo $t3			#����mfloָ��
multu $t0,$t1			#����multuָ��
nop
mfhi $t2
mflo $t3
div $t1,$t0			#����divָ��
nop				#����divָ����������
nop
nop
nop
nop
mfhi $t2
mflo $t3
divu $t0,$t1			#����divuָ��
addi $t0,$t0,0x0fff		#����˳����ܷ���������
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
add $t0,$t0,$t1									#�����ӳٲ�ָ���쳣

fo:
mfc0 $t1,$14
sw $t1,316($0)
j return
nop

exc1:
#�쳣�ж�ָ����
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
