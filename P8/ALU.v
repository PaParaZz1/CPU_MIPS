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
    input [4:0] shift,
	 input SHIFTV,
	 //output move_judge,
	 input judge_overflow,// if judge overflow
	 output overflow,// if overflow happens
    output [31:0] ALU_result
    );
	 wire upper;
	 wire [31:0] result;
	 wire [4:0] s;
	 wire [32:0] A,B;
	 assign s=(SHIFTV)?inputA[4:0]:shift;
	 assign A={inputA[31],inputA};
	 assign B={inputB[31],inputB};
	 assign {upper,result}=(ALUOp==`ALU_ADDU)?A+B:
								  (ALUOp==`ALU_SUBU)?A-B:
								  0;
	 assign ALU_result=(ALUOp==`ALU_ADDU)?result:
							 (ALUOp==`ALU_SUBU)?result:
							 (ALUOp==`ALU_AND)?inputA&inputB:
							 (ALUOp==`ALU_NOR)?~(inputA|inputB):
							 (ALUOp==`ALU_OR)?inputA|inputB:
							 (ALUOp==`ALU_XOR)?inputA^inputB:
							 (ALUOp==`ALU_SLT)?$signed(inputA)<$signed(inputB):
							 (ALUOp==`ALU_SLTU)?inputA<inputB:
							 (ALUOp==`ALU_SLL)?inputB<<s:
							 (ALUOp==`ALU_SRL)?inputB>>s:
							 (ALUOp==`ALU_SRA)?$signed($signed(inputB)>>>s):
							 32'h00000000;
	  assign overflow=judge_overflow&(result[31]!=upper);
endmodule
