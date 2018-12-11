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
	 input if_handler,
	 input [31:0] handler_pc,
    output [31:0] instr,
	 output [31:0] PC,
	 output [4:0] IFU_EXC
    );
	reg [31:0] pc,instr_array1[4095:0];//,instr_array2[4095:0];
	wire [31:0] ins_addr_offset1;//,ins_addr_offset2;
	wire [14:2] ins_addr1;//,ins_addr2;
	integer i;
	initial begin
		pc<=32'h00003000;
		for(i=0;i<4096;i=i+1) begin
			instr_array1[i]=0;
			//instr_array2[i]=0;
		end
		$readmemh("code.txt",instr_array1);
		$readmemh("code_handler.txt",instr_array1,1120,2047);
		//$readmemh("handler.txt",instr_array2);

	end
	assign ins_addr_offset1=pc-32'h00003000;
	//assign ins_addr_offset2=pc-32'h00004180;
	assign ins_addr1=ins_addr_offset1[14:2];
	//assign ins_addr2=ins_addr_offset2[14:2];
	//assign instr=(pc>=32'h00003000&&pc<=32'h00003FFF)?instr_array1[ins_addr1]:
					 //(pc>=32'h00004180&&pc<=32'h00004FFF)?instr_array2[ins_addr2]:
					 //0;
	assign instr=(IFU_EXC==`NO_EXC)?instr_array1[ins_addr1]:0;
	always @(posedge clk) begin
		if(Reset)
			pc<=32'h00003000;
		else if(!stall_pc|if_handler)begin//
			if(if_handler)
				pc<=handler_pc;
			else if(if_jump)
				pc<=next_pc;
			else
				pc<=pc+4;
		end
	end
	assign PC=pc;
	assign IFU_EXC=((pc>=`IM_INIT&&pc<=`IM_END)&(pc[1:0]==2'b00))?`NO_EXC:`ADEL;
endmodule
