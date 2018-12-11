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
    input [31:0] WrData,
    input [4:0] RWAddr,
    input [4:0] rs,
    input [4:0] rt,
    input RegWr,
    input Reset,
    //input [31:0] PC_4,
    //input RA_EN,
    output [31:0] RS_OUT,
    output [31:0] RT_OUT,
    output [31:0] RA,
	 input [31:0] WPC
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
		else if(RegWr)begin
			reg_file[RWAddr]<=WrData;
			reg_file[0]<=0;// keep reg0
			if(RWAddr!=5'b00000)
				$display("@%h: $%d <= %h", WPC, RWAddr,WrData); 
		end
		/*if(RA_EN)begin
			reg_file[31]<=PC_4;
			$display("@%h: $%d <= %h", WPC, 5'b11111,PC_4); 
		end*/
	end
	assign RS_OUT=reg_file[rs];
	assign RT_OUT=reg_file[rt];
	assign RA=reg_file[rs];
endmodule
