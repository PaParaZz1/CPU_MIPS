`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:49 11/26/2017 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input Reset,
    input DMWr,
	 input stall_DM,
    input [31:0] DMAddr,
    input [31:0] DIN,
    input [2:0] L_S_SL,
	 output [1:0] LoadSelect,
    output [31:0] DOUT,
	 input [31:0] PC
    );
	 reg [31:0] memory[4095:0];
	 wire [31:0] mem_out;// 内存整字输出
	 wire [11:0] addr_in;// 实际内存地址
	 wire [31:0] sh_in,sb_in,data_in;
	 integer i;
	 assign addr_in=DMAddr[13:2];
	 assign mem_out=memory[addr_in];
	 assign sh_in=(DMAddr[1]==1'b1)?{DIN[15:0],mem_out[15:0]}:{mem_out[31:16],DIN[15:0]};
	 assign sb_in=(DMAddr[1:0]==2'b11)?{DIN[7:0],mem_out[23:0]}:
						(DMAddr[1:0]==2'b10)?{mem_out[31:24],DIN[7:0],mem_out[15:0]}:
						(DMAddr[1:0]==2'b01)?{mem_out[31:16],DIN[7:0],mem_out[7:0]}:
						{mem_out[31:8],DIN[7:0]};
	 assign data_in=(L_S_SL==`L_S_B)?sb_in:
						  (L_S_SL==`L_S_H)?sh_in:
						  (L_S_SL==`L_S_W)?DIN:
						  32'h00000000;
	 initial begin
		 for(i=0;i<4096;i=i+1)
			memory[i]<=0;
	 end
	 always @(posedge clk) begin
		 if(Reset)begin
			 for(i=0;i<4096;i=i+1)
				 memory[i]<=0;
		 end
		 else begin
			 if(!stall_DM&DMWr&!Reset) begin
				 memory[addr_in]<=data_in;
				 $display("*%h <= %h", {DMAddr[31:2],2'b00},data_in); //%d@%h: $time, PC,
			 end
		 end
	 end

	 assign LoadSelect=DMAddr[1:0];
	 assign DOUT=mem_out;
endmodule
