`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:41:54 12/04/2017 
// Design Name: 
// Module Name:    compare 
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
module compare(
    input [31:0] RS_OUT,
    input [31:0] RT_OUT,
    input [5:0] opcode,
	 input rt0,
	 output judge
    );
	 assign judge=(RS_OUT==RT_OUT&&opcode==6'b000100)?1'b1://beq
					  (RS_OUT!=RT_OUT&&opcode==6'b000101)?1'b1://bne
					  ($signed(RS_OUT)>=0&&opcode==6'b000001&&rt0)?1'b1://bgez
					  ($signed(RS_OUT)>0&&opcode==6'b000111)?1'b1://bgtz
					  ($signed(RS_OUT)<=0&&opcode==6'b000110)?1'b1://blez
					  ($signed(RS_OUT)<0&&opcode==6'b000001&&!rt0)?1'b1://bltz
						1'b0;			  

endmodule
