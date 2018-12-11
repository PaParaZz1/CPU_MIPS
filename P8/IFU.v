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
    input clk2,
    input Reset,
	 input if_jump,
	 input [31:0] next_pc,
	 input stall_pc,
	 input if_handler,
	 input [31:0] handler_pc,
    output [31:0] instr,
	 output [31:0] PC,
	 output [4:0] IFU_EXC
    );
	 reg [31:0] pc;
	wire [31:0] ins_addr_offset;
	wire [12:2] ins_addr;
	wire [3:0] BE;
	/*assign pc1=(Reset)?`IM_INIT:
	          (if_handler)?handler_pc:
				 (stall_pc)?pc1:
				 (if_jump)?next_pc:
				 pc1+4;*/
	always @(posedge clk) begin
		if(Reset)
			pc<=32'h00003000;
		else if(stall_pc!=1'b1|if_handler)begin//
			if(if_handler)
				pc<=handler_pc;
			else if(if_jump)
				pc<=next_pc;
			else
				pc<=pc+4;
		end
		else 
			pc<=pc;
	end
	assign ins_addr_offset=pc-32'h00003000;
	assign ins_addr=ins_addr_offset[12:2];
	assign BE=4'b0000;
	IM3 IM_uut(
		.clka(clk2),
		.wea(BE),
		.addra(ins_addr),
		.douta(instr)
		);
	assign PC=pc;
	assign IFU_EXC=((pc>=`IM_INIT&&pc<=`IM_END)&(pc[1:0]==2'b00))?`NO_EXC:`ADEL;
endmodule
