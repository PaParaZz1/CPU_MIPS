`timescale 1ns / 1ns
`define DEV1 28'h00007F0
`define DEV2 28'h00007F1
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
	input [31:2] PrAddr,
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
	output DEV_WE3,
	output DEV_WE4,
	output DEV_WE5,
	output DEV_WE6,
	output [31:0] PrRD,
	output [3:2] DEV_ADDR,
	output [31:0] DEV_WD
    );
	 wire HIT_DEV1,HIT_DEV2;
	 assign DEV_WD=PrWD;
	 assign DEV_ADDR=PrAddr[3:2];// max{each device memory space}
	 assign HIT_DEV1=(PrAddr[31:4]==`DEV1);
	 assign HIT_DEV2=(PrAddr[31:4]==`DEV2);
	 assign PrRD=(HIT_DEV1)?DEV_RD1:
					 (HIT_DEV2)?DEV_RD2:
					 `DEBUG_DEV_DATA;
	 assign DEV_WE1=PrWe&HIT_DEV1;
	 assign DEV_WE2=PrWe&HIT_DEV2;
	 


endmodule
