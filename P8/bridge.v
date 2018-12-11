`timescale 1ns / 1ns
`include "head.v"
`define DEV1 28'h00007F0
`define DEV6 28'h00007F4
`define DEBUG_DEV_DATA 32'h23333333
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:06 12/29/2017 
// Design Name: 
// Module Name:    bridge 
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
module bridge(
	input [31:0] PrAddr,
	input [31:0] PrWD,
	input PrWe,
	input [31:0] DEV_RD1,
	input [31:0] DEV_RD2,
	input [31:0] DEV_RD3,
	input [31:0] DEV_RD4,
	input [31:0] DEV_RD5,
	input [31:0] DEV_RD6,
	output DEV_WE1,
	output DEV_WE2,
	output DEV_WE4,
	output DEV_WE5,
	output [31:0] PrRD,
	output [4:2] DEV_ADDR,
	output [31:0] DEV_WD
    );
	 wire HIT_DEV1,HIT_DEV2,HIT_DEV3,HIT_DEV4,HIT_DEV5,HIT_DEV6;
	 assign DEV_WD=PrWD;
	 assign DEV_ADDR=PrAddr[4:2];// max{each device memory space}
	 assign HIT_DEV1=(PrAddr[31:4]==`DEV1);
	 assign HIT_DEV2=(PrAddr>=`UART_BEGIN&&PrAddr<=`UART_END);
	 assign HIT_DEV3=(PrAddr>=`SWITCH_BEGIN&&PrAddr<=`SWITCH_END);
	 assign HIT_DEV4=(PrAddr>=`LED_BEGIN&&PrAddr<=`LED_END);
	 assign HIT_DEV5=(PrAddr>=`DIGIT_BEGIN&&PrAddr<=`DIGIT_END);
	 assign HIT_DEV6=(PrAddr[31:4]==`DEV6);
	 assign PrRD=(HIT_DEV1)?DEV_RD1:
					 (HIT_DEV2)?DEV_RD2:
					 (HIT_DEV3)?DEV_RD3:
					 (HIT_DEV4)?DEV_RD4:
					 (HIT_DEV5)?DEV_RD5:
					 (HIT_DEV6)?DEV_RD6:
					 `DEBUG_DEV_DATA;
	 assign DEV_WE1=PrWe&HIT_DEV1;
	 assign DEV_WE2=PrWe&HIT_DEV2;
	 assign DEV_WE4=PrWe&HIT_DEV4;
	 assign DEV_WE5=PrWe&HIT_DEV5;
	 


endmodule
