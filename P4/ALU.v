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
    input [2:0] ALUOp,
    input [31:0] inputA,
    input [31:0] inputB,
    input [4:0] shift,
    output zero,
    output [31:0] ALU_result
    );
	 wire c;
	 wire [4:0] s;
	 assign s=inputA[4:0];
	 assign ALU_result=(ALUOp==`ALU_ADDU)?inputA+inputB:
							 (ALUOp==`ALU_SUBU)?inputA-inputB:
							 (ALUOp==`ALU_OR)?inputA|inputB:
							 (ALUOp==`ALU_SLL)?inputB<<shift:
							 (ALUOp==`ALU_SLT)?$signed(inputA)<$signed(inputB):
							 (ALUOp==`ALU_SRAV)?$signed(inputB)>>>s:
							 32'h00000000;
	
	assign zero=((inputA==inputB)|($signed(inputA)<=0));
endmodule
