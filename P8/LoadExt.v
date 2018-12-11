`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:21:44 12/21/2017 
// Design Name: 
// Module Name:    LoadExt 
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
module LoadExt(
    input [31:0] mem_out,
    input [2:0] L_S_SL,
    input [1:0] DMAddr,
    output [31:0] EXT_data
    );
	 wire [31:0] lh_out,lb_out,lhu_out,lbu_out;
	 assign lhu_out=(DMAddr[1]==1'b1)?{16'h0000,mem_out[31:16]}:{16'h0000,mem_out[15:0]};
	 assign lbu_out=(DMAddr[1:0]==2'b11)?{24'h000000,mem_out[31:24]}:
						(DMAddr[1:0]==2'b10)?{24'h000000,mem_out[23:16]}:
						(DMAddr[1:0]==2'b01)?{24'h000000,mem_out[15:8]}:
						{24'h000000,mem_out[7:0]};
	 assign lh_out=(DMAddr[1]==1'b1)?{{16{mem_out[31]}},mem_out[31:16]}:{{16{mem_out[15]}},mem_out[15:0]};
	 assign lb_out=(DMAddr[1:0]==2'b11)?{{24{mem_out[31]}},mem_out[31:24]}:
						(DMAddr[1:0]==2'b10)?{{24{mem_out[23]}},mem_out[23:16]}:
						(DMAddr[1:0]==2'b01)?{{24{mem_out[15]}},mem_out[15:8]}:
						{{24{mem_out[7]}},mem_out[7:0]};
	 assign EXT_data=(L_S_SL==`L_S_B)?lb_out:
						  (L_S_SL==`L_S_H)?lh_out:
						  (L_S_SL==`L_S_W)?mem_out:
						  (L_S_SL==`L_S_BU)?lbu_out:
						  (L_S_SL==`L_S_HU)?lhu_out:
						  mem_out;

endmodule
