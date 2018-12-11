`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:15:27 11/26/2017 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input clk,
    input Reset,
    input zero,
    input [1:0] NPC_SL,
    input [15:0] imm16,
    input [25:0] instr_index,
    input [31:0] RA,
    output [31:0] instr,
    output [31:0] PC_4,
	 output [31:0] WPC
    );
	reg [31:0] pc,instr_array[1023:0];
	wire [31:0] npc;
	wire [9:0] ins_addr;
	wire [31:0] pc_add4,pc_b,pc_j,pc_jr;
	wire [31:0] imm32;
	initial begin
		pc<=32'h00003000;
		$readmemh("code.txt",instr_array);
	end
	assign imm32={{16{imm16[15]}},imm16};
	assign pc_add4=pc+4;
	assign pc_b=(imm32<<2)+pc_add4;
	assign pc_j={pc[31:28],instr_index,2'b00};
	assign pc_jr=RA;
	assign npc=(NPC_SL==`NPC_general)?pc_add4:
				  (NPC_SL==`NPC_B)?((zero==1)?pc_b:pc_add4):
				  (NPC_SL==`NPC_J)?pc_j:
				  (NPC_SL==`NPC_JR)?pc_jr:
				  32'h00003000;
	//assign npc=npc-32'h00003000;
	always @(posedge clk) begin
		if(Reset)
			pc<=32'h00003000;
		else begin
			pc<=npc;
		end
	end
	assign ins_addr=pc[11:2];
	assign instr=instr_array[ins_addr];
	assign PC_4=pc_add4;
	assign WPC=pc;
endmodule
