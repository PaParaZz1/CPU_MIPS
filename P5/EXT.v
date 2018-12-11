`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:35 11/26/2017 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [1:0] ExtOp,
    input [15:0] imm16,
    output [31:0] EXT_OUT
    );
	 assign EXT_OUT=(ExtOp==`zero_ext)?{16'h0000,imm16}:
						 (ExtOp==`sign_ext)?{{16{imm16[15]}},imm16}:
						 (ExtOp==`lui_ext)? {imm16,16'h0000}:
						 32'h00000000;

endmodule
