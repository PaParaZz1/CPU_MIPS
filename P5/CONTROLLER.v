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
	 output jal_,
	 output [1:0] RegDst,
	 output [1:0] RegData,// 寄存器写回数据来源
	 output [1:0] ExtOp,
    output [2:0] L_S_SL,
    output [2:0] ALUOp,
    output [1:0] NPC_SL,
	 output [1:0] newdatatype,
	 output [1:0] rt_tuse,
	 output [1:0] rs_tuse
    );
	 wire Rtype,add,addi,addiu,addu,and_,andi,beq,bgez,bgtz,blez,bltz,bne,
			j,jal,jalr,jr,lui,lb,lbu,lh,lhu,lw,movz,subu,ori,sw,sll,slt,srav,sb,sh,xori;
	 assign Rtype=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];
	 assign add=Rtype&func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0];//R100000
	 assign addi=!op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0];//001000
	 assign addiu=!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0];//001001
	 assign addu=Rtype&func[5]&!func[4]&!func[3]&!func[2]&!func[1]&func[0];//R100001
	 assign and_=Rtype&func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0];//R100100
	 assign andi=!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0];//001100
	 assign subu=Rtype&func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0];//R100011
	 assign beq=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];//000100
	 assign bgez=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0]&rt[0];//000001+rt[0]  
	 assign bgtz=!op[5]&!op[4]&!op[3]&op[2]&op[1]&op[0];//000111
	 assign blez=!op[5]&!op[4]&!op[3]&op[2]&op[1]&!op[0];//000110
	 assign bltz=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0]&!rt[0];//000001+!rt[0]  
	 assign bne=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&op[0];//000101
	 assign j=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&!op[0];//000010
	 assign jal=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];//000011
	 assign jr=Rtype&!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0];//R001000
	 assign lh=op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0];//100001
	 assign lhu=op[5]&!op[4]&!op[3]&op[2]&!op[1]&op[0];//100101
	 assign lb=op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];//100000
	 assign lbu=op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];//100100
	 assign lui=!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0];//001111
	 assign lw=op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];//100011
	 assign ori=!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0];//001101
	 assign sll=Rtype&!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0];//R000000
	 assign slt=Rtype&func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0];//R101010
	 assign sw=op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0];//101011
	 assign sb=op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0];//101000
	 assign sh=op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0];//101001
	 assign jalr=Rtype&!func[5]&!func[4]&func[3]&!func[2]&!func[1]&func[0];//R001001
	 assign srav=Rtype&!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0];//R000111
	 assign xori=!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0];//001110
	 assign movz=Rtype&!func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0];//R001010


	 assign RegWr=addu|subu|ori|lw|lui|slt|lh|lb|jal|srav|jalr|sll|xori|addi|movz;
	 assign ALUsrc=ori|lw|sw|lh|lui|lb|sh|sb|xori|addi;
	 assign DMWr=sw|sh|sb;
	 assign RegDst=(addu|subu|slt|sll|srav|jalr|movz)?`rd:
						 (lw|lh|lb|ori|lui|xori|addi)?`rt:
						 (jal|jalr)?`ra:
						 2'b11;
	 assign RegData=(addu|subu|ori|slt|sll|lui|srav|xori|addi|movz)?`ALU_data:
						 (lw|lh|lb)?`DM_data:
						 (jal|jalr)?`PC_data:
						 2'b00;
	 assign ExtOp=(ori|xori|addi)?`zero_ext:
					  (lw|sw|lh|lb|sb|sh)?`sign_ext:
					  (lui)?`lui_ext:
					  2'b11;
	 assign L_S_SL=(lw|sw)?`L_S_W:
						(lh|sh)?`L_S_H:
						(lb|sb)?`L_S_B:
						(lbu)?`L_S_BU:
						(lhu)?`L_S_HU:
						3'b111;
	 assign ALUOp=(addu|lw|sw|lh|lb|sh|sb|addi)?`ALU_ADDU:
					  (subu)?`ALU_SUBU:
					  (ori|lui)?`ALU_OR:
					  (slt)?`ALU_SLT:
					  (sll)?`ALU_SLL:
					  (srav)?`ALU_SRAV:
					  (xori)?`ALU_XORI:
					  3'b111;
	 assign NPC_SL=(addu|subu|lw|lh|lb|lui|ori|sw|sll|slt|sh|sb|srav|xori|addi|movz)?`NPC_general:
						(beq|bgez)?`NPC_B:
						(jal|j)?`NPC_J:
						(jr)?`NPC_JR:
						2'b00;
	 assign rs_tuse=(addu|subu|ori|lw|sw|slt|srav|sh|sb|lh|lb|xori|addi|movz)?`RS1:
					    (beq|jalr|jr|bgez)?`RS0:
						 2'b11;
	 assign rt_tuse=(addu|subu|sll|slt|srav|movz)?`RT1:
						 (beq)?`RT0:
						 (sw)?`RT2:
						 2'b11;
	 assign newdatatype=(addu|subu|ori|lui|slt|sll|srav|xori|addi|movz)?`NEW_ALU:
							  (lw|lh|lb)?`NEW_DM:
							  (jal|jalr)?`NEW_PC:
							  2'b11;
endmodule
