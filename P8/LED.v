`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:04 01/16/2018 
// Design Name: 
// Module Name:    LED 
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
module LED(
	 input clk,
	 input reset,
	 input enable,
	 input [31:0] data_in, 
	 output [31:0] led_lights,
	 output [31:0] data_return_cpu
    );
	 reg [31:0] led;
	 assign led_lights=~led;
	 assign data_return_cpu=led;
	 always @(posedge clk) begin
		 if(reset) begin
			 led<=32'h11111111;
		 end
		 else if(enable) begin
			 led<=data_in;
		 end
	 end


endmodule
