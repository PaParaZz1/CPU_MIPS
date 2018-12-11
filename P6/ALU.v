`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:01 11/26/2017 
// Design Name: 
// Module Name:    ALU 
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

module ALU(
    input [3:0] ALUOp,
    input [31:0] inputA,
    input [31:0] inputB,
	 input [31:0] inputC,
    input [4:0] shift,
	 input SHIFTV,
	 output move_judge,
    output [31:0] ALU_result
    );
	 wire [4:0] s;
	 assign s=(SHIFTV)?inputA[4:0]:shift;
	 assign ALU_result=(ALUOp==`ALU_ADDU)?inputA+inputB:
							 (ALUOp==`ALU_SUBU)?inputA-inputB:
							 (ALUOp==`ALU_AND)?inputA&inputB:
							 (ALUOp==`ALU_NOR)?~(inputA|inputB):
							 (ALUOp==`ALU_OR)?inputA|inputB:
							 (ALUOp==`ALU_XOR)?inputA^inputB:
							 (ALUOp==`ALU_SLT)?$signed(inputA)<$signed(inputB):
							 (ALUOp==`ALU_SLTU)?inputA<inputB:
							 (ALUOp==`ALU_SLL)?inputB<<s:
							 (ALUOp==`ALU_SRL)?inputB>>s:
							 (ALUOp==`ALU_SRA)?$signed($signed(inputB)>>>s):
							 (ALUOp==`ALU_EZ)?((inputB==0)?inputA:inputC):   //({0,inputA[31:0]})<({0,inputB[31:0]})
							 32'h00000000;
	 assign move_judge=(ALUOp==`ALU_EZ)&(inputB!=0);
endmodule
