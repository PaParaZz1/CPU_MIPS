`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:16 11/26/2017 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input [31:0] RWData,
    input [4:0] RWAddr,
    input [4:0] rs,
    input [4:0] rt,
	 input [4:0] rd,
    input RegWr,
    input Reset,
	 input stall_GRF,
    output [31:0] RS_OUT,
    output [31:0] RT_OUT,
	 output [31:0] RD_OUT,
	 input [31:0] PC
    );
	reg [31:0] reg_file[31:0];
	integer i;
	initial begin
		for(i=0;i<32;i=i+1) begin
			reg_file[i]<=0;
		end
	end
	always @(posedge clk) begin
		if(Reset) begin
			for(i=0;i<32;i=i+1) begin
				reg_file[i]<=0;
			end
		end
		else if(RegWr&!stall_GRF)begin
			reg_file[RWAddr]<=RWData;
			reg_file[0]<=0;// keep reg0
			if(RWAddr!=5'b00000&!Reset)
				$display("%d@%h:$%d <= %h", $time, PC,  RWAddr,RWData); //  
		end
	
	end
	assign RS_OUT=reg_file[rs];
	assign RT_OUT=reg_file[rt];
	assign RD_OUT=reg_file[rd];
endmodule
