`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:29:20 11/26/2017 
// Design Name: 
// Module Name:    controller 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module controller(
    input [5:0] op,
    input [5:0] func,
	 input [4:0] rt,
    output RegWr,
    output ALUsrc,
    output DMWr,
	 output SHIFTV,
	 output M_D_judge, // MD指令判断信号
	 output is_signed,
	 output [1:0] Other_Reg_Wr,
	 output [1:0] M_D_Cal,
	 output [1:0] M_D_Read,
	 output [1:0] RegDst,
	 output [1:0] RegData,// 寄存器写回数据来源
	 output [1:0] ExtOp,
    output [2:0] L_S_SL,
    output [3:0] ALUOp,
    output [1:0] NPC_SL,
	 output [2:0] newdatatype,
	 output [1:0] rt_tuse,
	 output [1:0] rs_tuse
    );
	 wire Rtype,add,addi,addiu,addu,and_,andi,beq,bgez,bgtz,blez,bltz,bne,div,divu,bgezal,beql,
			j,jal,jalr,jr,lui,lb,lbu,lh,lhu,lw,movz,mfhi,mflo,mthi,mtlo,mult,multu,nor_,or_,ori,
			sw,sll,sllv,slt,slti,sltiu,sltu,sra,srav,srl,srlv,sub,subu,sb,sh,xori,madd;
	 assign Rtype=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];
	 assign add=Rtype&func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0];//R100000
	 assign addi=!op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0];//001000
	 assign addiu=!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0];//001001
	 assign addu=Rtype&func[5]&!func[4]&!func[3]&!func[2]&!func[1]&func[0];//R100001
	 assign and_=Rtype&func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0];//R100100
	 assign andi=!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0];//001100
	 assign beq=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];//000100
	 assign bgez=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0]&rt[0];//000001+rt[0]  
	 assign bgtz=!op[5]&!op[4]&!op[3]&op[2]&op[1]&op[0];//000111
	 assign blez=!op[5]&!op[4]&!op[3]&op[2]&op[1]&!op[0];//000110
	 assign bltz=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0]&!rt[0];//000001+!rt[0]  
	 assign bne=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&op[0];//000101
	 assign j=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&!op[0];//000010
	 assign jal=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];//000011
	 assign jr=Rtype&!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0];//R001000
	 assign jalr=Rtype&!func[5]&!func[4]&func[3]&!func[2]&!func[1]&func[0];//R001001
	 assign lh=op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0];//100001
	 assign lhu=op[5]&!op[4]&!op[3]&op[2]&!op[1]&op[0];//100101
	 assign lb=op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];//100000
	 assign lbu=op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];//100100
	 assign lui=!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0];//001111
	 assign lw=op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];//100011
	 assign movz=Rtype&!func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0];//R001010
	 assign div=Rtype&!func[5]&func[4]&func[3]&!func[2]&func[1]&!func[0];//R011010
	 assign divu=Rtype&!func[5]&func[4]&func[3]&!func[2]&func[1]&func[0];//R011011
	 assign mfhi=Rtype&!func[5]&func[4]&!func[3]&!func[2]&!func[1]&!func[0];//R010000
	 assign mflo=Rtype&!func[5]&func[4]&!func[3]&!func[2]&func[1]&!func[0];//R010010
	 assign mthi=Rtype&!func[5]&func[4]&!func[3]&!func[2]&!func[1]&func[0];//R010001
	 assign mtlo=Rtype&!func[5]&func[4]&!func[3]&!func[2]&func[1]&func[0];//R010011
	 assign mult=Rtype&!func[5]&func[4]&func[3]&!func[2]&!func[1]&!func[0];//R011000
	 assign multu=Rtype&!func[5]&func[4]&func[3]&!func[2]&!func[1]&func[0];//R011001
	 assign nor_=Rtype&func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0];//R100111
	 assign or_=Rtype&func[5]&!func[4]&!func[3]&func[2]&!func[1]&func[0];//R100101
	 assign ori=!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0];//001101
	 assign sll=Rtype&!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0];//R000000
	 assign sllv=Rtype&!func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0];//R000100
	 assign slt=Rtype&func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0];//R101010
	 assign slti=!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0];//001010
	 assign sltiu=!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0];//001011
	 assign sltu=Rtype&func[5]&!func[4]&func[3]&!func[2]&func[1]&func[0];//R101011
	 assign sw=op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0];//101011
	 assign sb=op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0];//101000
	 assign sh=op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0];//101001
	 assign sra=Rtype&!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0];//R000011
	 assign srav=Rtype&!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0];//R000111
	 assign srl=Rtype&!func[5]&!func[4]&!func[3]&!func[2]&func[1]&!func[0];//R000010
	 assign srlv=Rtype&!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0];//R000110
	 assign sub=Rtype&func[5]&!func[4]&!func[3]&!func[2]&func[1]&!func[0];//R100010
	 assign subu=Rtype&func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0];//R100011
	 assign xor_=Rtype&func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0];//R100110
	 assign xori=!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0];//001110
	 assign madd=!op[5]&op[4]&op[3]&op[2]&!op[1]&!op[0];//011100
	 
	 


	 assign RegWr=add|addi|addiu|addu|and_|andi|sub|subu|mfhi|mflo|nor_|or_|ori|lhu|lbu|lw|lui|lh|lb
					  |jal|jalr|slt|slti|sltiu|sltu|sll|sllv|sra|srav|srl|srlv|xori|xor_|movz;
	 assign ALUsrc=addi|addiu|andi|lhu|lw|lbu|lh|lui|lb|ori|sw|sh|sb|slti|sltiu|xori;
	 assign DMWr=sw|sh|sb;
	 assign RegDst=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|jalr|xor_|movz|mflo|mfhi)?`rd:
						 (addi|addiu|andi|lw|lh|lb|lbu|lhu|ori|lui|slti|sltiu|xori)?`rt:
						 (jal)?`ra:
						 2'b11;
	 assign RegData=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|xor_|movz|addi
						 |addiu|andi|ori|lui|slti|sltiu|xori|mflo|mfhi)?`ALU_data:
						 (lw|lh|lb|lhu|lbu)?`DM_data:
						 (jal|jalr)?`PC_data:
						 (mfhi|mflo)?`MD_data:
						 2'b00;
	 assign ExtOp=(andi|ori|xori)?`zero_ext:
					  (addi|addiu|lhu|lbu|lw|sw|lh|lb|sb|sh|slti|sltiu)?`sign_ext:
					  (lui)?`lui_ext:
					  2'b11;
	 assign L_S_SL=(lw|sw)?`L_S_W:
						(lh|sh)?`L_S_H:
						(lb|sb)?`L_S_B:
						(lbu)?`L_S_BU:
						(lhu)?`L_S_HU:
						3'b111;
	 assign ALUOp=(add|addi|addiu|addu|lbu|lhu|lw|sw|lh|lb|sh|sb)?`ALU_ADDU:
					  (sub|subu)?`ALU_SUBU:
					  (and_|andi)?`ALU_AND:
					  (nor_)?`ALU_NOR:
					  (or_|ori|lui)?`ALU_OR:
					  (xor_|xori)?`ALU_XOR:
					  (slt|slti)?`ALU_SLT:
					  (sltu|sltiu)?`ALU_SLTU:
					  (sll|sllv)?`ALU_SLL:
					  (srl|srlv)?`ALU_SRL:
					  (sra|srav)?`ALU_SRA:
					  (movz)?`ALU_EZ:
					  4'b1111;
	 assign SHIFTV=(sllv|srlv|srav)?1:0;
	 assign NPC_SL=(beq|bgez|bgtz|blez|bltz|bne)?`NPC_B:
						(jal|j)?`NPC_J:
						(jr|jalr)?`NPC_JR:
						`NPC_general;
	 assign rs_tuse=(add|addi|addu|addiu|and_|andi|lw|lb|lh|lbu|lhu|nor_|or_|ori|sub|subu|slt|sltu|slti|sltiu
						 |sllv|srlv|srav|sw|sh|sb|xori|xor_|movz|mthi|mtlo|mult|multu|div|divu|madd)?`RS1:
					    (beq|jalr|jr|bgez|bgtz|blez|bltz|bne)?`RS0:
						 2'b11;
	 assign rt_tuse=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|xor_|movz|multu|mult|div|divu|madd)?`RT1:
						 (beq|bne)?`RT0:
						 (sw|sh|sb)?`RT2:
						 2'b11;
	 assign newdatatype=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|xor_|movz|addi
							  |addiu|andi|ori|lui|slti|sltiu|xori|mfhi|mflo)?`NEW_ALU:
							  (lw|lh|lb|lbu|lhu)?`NEW_DM:
							  (jal|jalr)?`NEW_PC:
							  3'b000;
	 assign M_D_Cal=(mult|multu)?`MULT:
						 (div|divu)?`DIV:
						 (madd)?`MADD:
						 2'b00;
	 assign M_D_Read=(mflo)?`LO_Read:
						  (mfhi)?`HI_Read:
						  2'b00;
	 assign Other_Reg_Wr=(mtlo)?`RegLO:
								(mthi)?`RegHI:
								2'b00;
	 assign M_D_judge=mfhi|mflo|mthi|mtlo|mult|multu|div|divu|madd;
	 assign is_signed=div|mult|madd;
endmodule
