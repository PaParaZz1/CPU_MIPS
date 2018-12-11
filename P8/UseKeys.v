`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:10 01/16/2018 
// Design Name: 
// Module Name:    UseKeys 
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
module UseKeys(
	 input clk,
	 input reset,
	 input [7:0] use_keys,
	 output [31:0] data_out
    );
	 reg [7:0] uk;
	 assign data_out={24'h000000,uk};
	 always @(posedge clk) begin
		 if(reset)begin
			 uk<=8'h00;
		 end
		 else begin
			 uk<=~use_keys;//
		 end
	 end


endmodule
