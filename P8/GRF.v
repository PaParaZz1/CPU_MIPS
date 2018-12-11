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
    input RegWr,
    input Reset,
    output [31:0] RS_OUT,
    output [31:0] RT_OUT
	 //input [31:0] PC
    );
	reg [31:0] reg_file[31:0];
	integer i;
	always @(posedge clk) begin
		if(Reset) begin
			for(i=0;i<32;i=i+1) begin
				reg_file[i]<=32'h00000000;
			end
		end
		else if(RegWr&RWAddr!=5'b00000)begin
			reg_file[RWAddr]<=RWData;
			//reg_file[0]<=32'h00000000;// keep reg0
			//if(!Reset)
				//$display("$%d <= %h",  RWAddr,RWData); // %d@%h: $time, PC, 
		end
	
	end
	assign RS_OUT=reg_file[rs];
	assign RT_OUT=reg_file[rt];
endmodule
