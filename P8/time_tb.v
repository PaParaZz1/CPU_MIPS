`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:18:29 01/18/2018
// Design Name:   mips
// Module Name:   C:/Users/nyz/Desktop/p8/P8/time_tb.v
// Project Name:  P8
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module time_tb;

	// Inputs
	reg clk_in;
	reg sys_rstn;
	reg [7:0] user_key;
	reg [7:0] dip_switch0;
	reg [7:0] dip_switch1;
	reg [7:0] dip_switch2;
	reg [7:0] dip_switch3;
	reg [7:0] dip_switch4;
	reg [7:0] dip_switch5;
	reg [7:0] dip_switch6;
	reg [7:0] dip_switch7;
	reg uart_rxd;

	// Outputs
	wire uart_txd;
	wire [31:0] led_light;
	wire [7:0] digital_tube0;
	wire [3:0] digital_tube_sel0;
	wire [7:0] digital_tube1;
	wire [3:0] digital_tube_sel1;
	wire [7:0] digital_tube2;
	wire digital_tube_sel2;

	// Instantiate the Unit Under Test (UUT)
	mips uut (
		.clk_in(clk_in), 
		.sys_rstn(sys_rstn), 
		.user_key(user_key), 
		.dip_switch0(dip_switch0), 
		.dip_switch1(dip_switch1), 
		.dip_switch2(dip_switch2), 
		.dip_switch3(dip_switch3), 
		.dip_switch4(dip_switch4), 
		.dip_switch5(dip_switch5), 
		.dip_switch6(dip_switch6), 
		.dip_switch7(dip_switch7), 
		.uart_rxd(uart_rxd), 
		.uart_txd(uart_txd), 
		.led_light(led_light), 
		.digital_tube0(digital_tube0), 
		.digital_tube_sel0(digital_tube_sel0), 
		.digital_tube1(digital_tube1), 
		.digital_tube_sel1(digital_tube_sel1), 
		.digital_tube2(digital_tube2), 
		.digital_tube_sel2(digital_tube_sel2)
	);

	initial begin
		// Initialize Inputs
		clk_in = 0;
		sys_rstn = 1;
		user_key = 0;
		dip_switch0 = 0;
		dip_switch1 = 8'hFF;
		dip_switch2 = 8'hFF;
		dip_switch3 = 8'hFF;
		dip_switch4 = 8'hFF;
		dip_switch5 = 8'hFF;
		dip_switch6 = 8'hFF;
		dip_switch7 = 8'hFF;
		uart_rxd = 0;

		// Wait 100 ns for global reset to finish
		#300;
		sys_rstn=0;
		dip_switch0=~9;
		#120;
		dip_switch0=~13;
        
		// Add stimulus here

	end
	always #5 clk_in=~clk_in;
      
endmodule

