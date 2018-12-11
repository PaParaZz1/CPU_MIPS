`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:40 01/16/2018 
// Design Name: 
// Module Name:    switch 
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
module switch(
	 input clk,
	 input reset,
	 input [4:2] ReadAddr,///
	 input [7:0] dip_switch0,
	 input [7:0] dip_switch1,
	 input [7:0] dip_switch2,
	 input [7:0] dip_switch3,
	 input [7:0] dip_switch4,
	 input [7:0] dip_switch5,
	 input [7:0] dip_switch6,
	 input [7:0] dip_switch7,
	 output [31:0] data_out
    );
	 reg [31:0] ds1,ds2;
	 assign data_out=(ReadAddr==3'b011)?ds1:ds2;
	 always @(posedge clk) begin
		 if(reset) begin
			 ds1<=32'h00000000;
			 ds2<=32'h00000000;
		 end
		 else begin
			 ds1<=~{dip_switch3,dip_switch2,dip_switch1,dip_switch0};//
			 ds2<=~{dip_switch7,dip_switch6,dip_switch5,dip_switch4};//
		 end
	 end


endmodule
