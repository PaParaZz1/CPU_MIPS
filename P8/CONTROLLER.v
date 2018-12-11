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
	 input [4:0] rs,
	 input [4:0] rt,
    output RegWr,
    output ALUsrc,
    output DMWr,
	 output SHIFTV,
	 output is_eret,
	 output legal_instr,
	 output if_overflow,
	 output [1:0] RegDst,
	 output [1:0] RegData,// 寄存器写回数据来源
	 output [1:0] ExtOp,
    output [2:0] L_S_SL,
    output [3:0] ALUOp,
    output [1:0] NPC_SL,
	 output [1:0] newdatatype,
	 output [1:0] rt_tuse,
	 output [1:0] rs_tuse,
	 output CP0Wr,
	 output CP0Read,
	 output jump_instr
    );
	 wire Rtype,add,addi,addiu,addu,and_,andi,beq,bgez,bgtz,blez,bltz,bne,
			j,jal,jalr,jr,lui,lb,lbu,lh,lhu,lw,nor_,or_,ori,
			sw,sll,sllv,slt,slti,sltiu,sltu,sra,srav,srl,srlv,sub,subu,sb,sh,xori,eret,mfc0,mtc0;
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
	 assign eret=!op[5]&op[4]&!op[3]&!op[2]&!op[1]&!op[0]&!func[5]&func[4]&func[3]&!func[2]&!func[1]&!func[0];//010000_011000
	 assign mfc0=!op[5]&op[4]&!op[3]&!op[2]&!op[1]&!op[0]&!rs[4]&!rs[3]&!rs[2]&!rs[1]&!rs[0];//010000_00000
	 assign mtc0=!op[5]&op[4]&!op[3]&!op[2]&!op[1]&!op[0]&!rs[4]&!rs[3]&rs[2]&!rs[1]&!rs[0];//010000_00100
	 
	 
	 
	 
	 assign legal_instr=add|addi|addiu|addu|and_|andi|beq|bgez|bgtz|blez|bltz|bne|
			j|jal|jalr|jr|lui|lb|lbu|lh|lhu|lw|nor_|or_|ori|
			sw|sll|sllv|slt|slti|sltiu|sltu|sra|srav|srl|srlv|sub|subu|sb|sh|xori|eret|mfc0|mtc0|xor_;
	 
	 


	 assign RegWr=add|addi|addiu|addu|and_|andi|sub|subu|mfc0|nor_|or_|ori|lhu|lbu|lw|lui|lh|lb
					  |jal|jalr|slt|slti|sltiu|sltu|sll|sllv|sra|srav|srl|srlv|xori|xor_;
	 assign ALUsrc=addi|addiu|andi|lhu|lw|lbu|lh|lui|lb|ori|sw|sh|sb|slti|sltiu|xori;
	 assign DMWr=sw|sh|sb;
	 assign RegDst=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|jalr|xor_)?`rd:
						 (addi|addiu|andi|lw|lh|lb|lbu|lhu|ori|lui|slti|sltiu|xori|mfc0)?`rt:
						 (jal)?`ra:
						 2'b11;
	 assign RegData=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|xor_|addi
						 |addiu|andi|ori|lui|slti|sltiu|xori)?`ALU_data:
						 (lw|lh|lb|lhu|lbu|mfc0)?`DM_data:
						 (jal|jalr)?`PC_data:
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
					  4'b1111;
	 assign SHIFTV=(sllv|srlv|srav)?1'b1:1'b0;
	 assign NPC_SL=(beq|bgez|bgtz|blez|bltz|bne)?`NPC_B:
						(jal|j)?`NPC_J:
						(jr|jalr)?`NPC_JR:
						`NPC_general;
	 assign rs_tuse=(add|addi|addu|addiu|and_|andi|lw|lb|lh|lbu|lhu|nor_|or_|ori|sub|subu|slt|sltu|slti|sltiu
						 |sllv|srlv|srav|sw|sh|sb|xori|xor_)?`RS1:
					    (beq|jalr|jr|bgez|bgtz|blez|bltz|bne|eret)?`RS0:
						 2'b11;
	 assign rt_tuse=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|xor_)?`RT1:
						 (beq|bne)?`RT0:
						 (sw|sh|sb|mtc0)?`RT2:
						 2'b11;
	 assign newdatatype=(add|addu|and_|nor_|or_|sub|subu|slt|sltu|sll|sllv|srl|srlv|sra|srav|xor_|addi
							  |addiu|andi|ori|lui|slti|sltiu|xori)?`NEW_ALU:
							  (lw|lh|lb|lbu|lhu|mfc0)?`NEW_DM:
							  (jal|jalr)?`NEW_PC:
							  2'b00;
	 assign if_overflow=add|sub|addi;
	 assign CP0Read=mfc0;
	 assign CP0Wr=mtc0;
	 assign is_eret=eret;
	 assign jump_instr=j|jal|jalr|jr|beq|bne|blez|bltz|bgez|bgtz;
endmodule
