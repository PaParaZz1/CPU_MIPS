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
	 input if_jump,
	 input [31:0] next_pc,
	 input stall_pc,
    output [31:0] instr,
    output [31:0] PC4,
	 output [31:0] PC8,
	 output [31:0] PC
    );
	reg [31:0] pc,instr_array[4095:0];
	wire [31:0] ins_addr_offset;
	wire [11:0] ins_addr;
	integer i;
	initial begin
		pc<=32'h00003000;
		for(i=0;i<4096;i=i+1) begin
			instr_array[i]=0;
		end
		$readmemh("code.txt",instr_array);

	end
	assign PC8=pc+8;
	assign PC4=pc+4;
	assign ins_addr_offset=pc-32'h00003000;
	assign ins_addr=ins_addr_offset[13:2];
	assign instr=instr_array[ins_addr];
	always @(posedge clk) begin
		if(Reset)
			pc<=32'h00003000;
		else if(!stall_pc)begin
			if(if_jump)
				pc<=next_pc;
			else
				pc<=pc+4;
		end
	end
	assign PC=pc;
endmodule
