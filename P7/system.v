`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:34 12/29/2017 
// Design Name: 
// Module Name:    system 
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
module mips(
    input clk,
    input reset
    );
	 wire [31:0] PrRD,PrWD,DEV_WD,DEV_RD1,DEV_RD2,DEV_RD3,DEV_RD4,DEV_RD5,DEV_RD6;
	 wire [31:2] PrAddr;
	 wire [7:2] HWInt;
	 wire [3:0] PrBE;
	 wire [3:2] DEV_ADDR;
	 wire PrWe,DEV_WE1,DEV_WE2,DEV_WE3,DEV_WE4,DEV_WE5,DEV_WE6;
	 assign HWInt[7:4]=0;
	 cpu cpu_uut(
		.clk(clk),
		.reset(reset),
		.PrRD(PrRD),
		.PrWD(PrWD),
		.HWInt(HWInt),
		.PrAddr(PrAddr),
		.PrWe(PrWe)
		);
	 bridge bridge_uut(
		//.PrAddr(PrAddr),
	   .PrWD(PrWD),
		.PrAddr(PrAddr),
		.PrWe(PrWe),
		.PrRD(PrRD),
		.DEV_RD1(DEV_RD1),
		.DEV_RD2(DEV_RD2),
		.DEV_RD3(DEV_RD3),
		.DEV_RD4(DEV_RD4),
		.DEV_RD5(DEV_RD5),
		.DEV_RD6(DEV_RD6),
		.DEV_WE1(DEV_WE1),
		.DEV_WE2(DEV_WE2),
		.DEV_WE3(DEV_WE3),
		.DEV_WE4(DEV_WE4),
		.DEV_WE5(DEV_WE5),
		.DEV_WE6(DEV_WE6),
		.DEV_ADDR(DEV_ADDR),
		.DEV_WD(DEV_WD)
		);
	 timer timer_uut1(
		.clk(clk),
		.reset(reset),
		.PrAddr(DEV_ADDR),
		.Wr_en(DEV_WE1),
		.Data_in(DEV_WD),
		.IRQ(HWInt[2]),
		.Data_out(DEV_RD1)
		);
	 timer timer_uut2(
	 	.clk(clk),
		.reset(reset),
		.PrAddr(DEV_ADDR),
		.Wr_en(DEV_WE2),
		.Data_in(DEV_WD),
		.IRQ(HWInt[3]),
		.Data_out(DEV_RD2)
		);


endmodule
