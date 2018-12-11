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
    //output RegDst,
    //output RA_EN,
    //output DMtoReg,
    output RegWr,
    output ALUsrc,
    output DMWr,
	 output [1:0] RegDst,
	 output [1:0] RegData,// 寄存器写回数据来源
	 output [1:0] ExtOp,
    output [2:0] L_S_SL,
    output [2:0] ALUOp,
    output [1:0] NPC_SL,
	 output [1:0] CMP_SL
    );
	 wire Rtype,addu,subu,ori,lui,lw,sw,j,jal,jr,lh,sll,slt,beq;
	 assign Rtype=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];
	 assign addu=Rtype&func[5]&!func[4]&!func[3]&!func[2]&!func[1]&func[0];//R100001
	 assign subu=Rtype&func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0];//R100011
	 assign beq=!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0];//000100
	 assign j=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&!op[0];//000010
	 assign jal=!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];//000011
	 assign jr=Rtype&!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0];//R001000
	 assign lh=op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0];//100001
	 assign lb=op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];//100000
	 assign lui=!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0];//001111
	 assign lw=op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0];//100011
	 assign ori=!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0];//001101
	 assign sll=Rtype&!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0];//R000000
	 assign slt=Rtype&func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0];//R101010
	 assign sw=op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0];//101011
	 assign sb=op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0];//101000
	 assign sh=op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0];//101001
	 assign srav=Rtype&!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0];//R000111
	 assign blez=!op[5]&!op[4]&!op[3]&op[2]&op[1]&!op[0];//000110


	 //assign RegDst=addu|subu|sll|slt;
	 //assign RA_EN=jal;
	 //assign DMtoReg=lw|lh|lb;
	 assign RegWr=addu|subu|ori|lw|lui|slt|sll|lh|lb|jal|srav;
	 assign ALUsrc=ori|lw|sw|lh|lui|lb|sh|sb;
	 assign DMWr=sw|sh|sb;
	 assign CMP_SL=(beq)?`BEQ:
					   (blez)?`BLEZ:
						2'b11;
	 assign RegDst=(addu|subu|slt|sll|srav)?`rd:
						 (lw|lh|lb|ori|lui)?`rt:
						 (jal)?`ra:
						 2'b11;
	 assign RegData=(addu|subu|ori|slt|sll|lui|srav)?`ALU_data:
						 (lw|lh|lb)?`DM_data:
						 (jal)?`RA_data:
						 2'b11;
	 assign ExtOp=(ori)?`zero_ext:
					  (lw|sw|lh|lb|sb|sh)?`sign_ext:
					  (lui)?`lui_ext:
					  2'b11;
	 assign L_S_SL=(lw|sw)?`L_S_W:
						(lh|sh)?`L_S_H:
						(lb|sb)?`L_S_B:
						2'b11;
	 assign ALUOp=(addu|lw|sw|lh|lb|sh|sb)?`ALU_ADDU:
					  (subu)?`ALU_SUBU:
					  (ori|lui)?`ALU_OR:
					  (slt)?`ALU_SLT:
					  (sll)?`ALU_SLL:
					  (srav)?`ALU_SRAV:
					  3'b111;
	 assign NPC_SL=(addu|subu|lw|lh|lb|lui|ori|sw|sll|slt|sh|sb|srav)?`NPC_general:
						(beq|blez)?`NPC_B:
						(jal|j)?`NPC_J:
						(jr)?`NPC_JR:
						2'b00;
endmodule
