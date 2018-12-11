`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:49 12/04/2017 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
	input [31:0] PC_4,
	input judge,
	input [1:0] NPC_SL,
	input [15:0] IMM16,
	input [25:0] IMM26,
	input [31:0] RS_OUT,
	output [31:0] next_pc,
	output if_jump
    );
	 wire [31:0] pc_b,pc_j,pc_jr,IMM32;
	 assign IMM32={{16{IMM16[15]}},IMM16};
	 assign pc_b=(IMM32<<2)+PC_4;
	 assign pc_j={PC_4[31:28],IMM26,2'b00};
	 assign pc_jr=RS_OUT;
	 assign next_pc=(NPC_SL==`NPC_general)?PC_4:
				  (NPC_SL==`NPC_B)?((judge==1)?pc_b:PC_4):
				  (NPC_SL==`NPC_J)?pc_j:
				  (NPC_SL==`NPC_JR)?pc_jr:
				  32'h00003000;
	 assign if_jump=((NPC_SL==`NPC_J)|(NPC_SL==`NPC_JR)|((NPC_SL==`NPC_B)&(judge==1)))?1'b1:1'b0;


endmodule
