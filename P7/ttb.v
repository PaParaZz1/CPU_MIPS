`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:49:27 01/04/2018
// Design Name:   timer
// Module Name:   C:/Users/nyz/Desktop/p7/p7/ttb.v
// Project Name:  p7
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: timer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ttb;

	// Inputs
	reg clk;
	reg reset;
	reg [3:2] PrAddr;
	reg Wr_en;
	reg [31:0] Data_in;

	// Outputs
	wire IRQ;
	wire [31:0] Data_out;

	// Instantiate the Unit Under Test (UUT)
	timer uut (
		.clk(clk), 
		.reset(reset), 
		.PrAddr(PrAddr), 
		.Wr_en(Wr_en), 
		.Data_in(Data_in), 
		.IRQ(IRQ), 
		.Data_out(Data_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		PrAddr = 0;
		Wr_en = 0;
		Data_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=0;
		ADD_I = 0;
		WE_I = 0;
		DAT_I = 9;
		#10;
		ADD_I = 2'b01;
		WE_I = 1;
		RST_I = 0;
		#10;
		ADD_I = 2'b00;
		DAT_I = {28'd0,1'b1,2'b00,1'b1};
		#10;
		WE_I = 0;
		#200;
		WE_I = 1;
		DAT_I = {28'd0,1'b0,2'b01,1'b1};
		#10;
		WE_I = 0;
        
		// Add stimulus here

	end
      
endmodule

