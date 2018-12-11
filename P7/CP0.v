`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:25 12/29/2017 
// Design Name: 
// Module Name:    CP0 
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
module CP0(
	input clk,
	input reset,
	input [4:0] ReadAddr,
	input [4:0] WrAddr,
	input [6:2] Ext_code,
	input [5:0] HWInt,
	input BDop,
	input CP0Wr,
	input [1:0] ext_int_control,
	input [31:0] PC,
	input [31:0] CP0_IN,
	output IntReq,
	output [31:0] EPC_OUT,
	output [31:0] CP0_OUT,
	output EXL_val
    );
	reg [31:0] EPC,PRId;
	//SR:
	reg [15:10] IM;
	reg IE,EXL;
	//Cause
	reg BD;
	reg [15:10] IP;
	reg [6:2] ExtCode;
	initial begin
		PRId<=`NYZ_ID;
		EPC<=0;
		IM<=0;
		IE<=0;
		EXL<=0;
		BD<=0;
		IP<=0;
		ExtCode<=`NO_EXC;
	end
	always @(posedge clk) begin
		if(reset) begin
			PRId<=`NYZ_ID;
			EPC<=0;
			IM<=0;
			IE<=0;
			EXL<=0;
			BD<=0;
			IP<=0;
			ExtCode<=`NO_EXC;
		end
		else begin
			IP<=HWInt[5:0];
			if(CP0Wr) begin//MTC0
				case(WrAddr)
					`SR_CODE:begin
						{IM,EXL,IE}<={CP0_IN[15:10],CP0_IN[1],CP0_IN[0]};
					end
					`CAUSE_CODE:begin
						{BD,ExtCode}<={CP0_IN[31],CP0_IN[6:2]};
					end
					`EPC_CODE:
						EPC<=CP0_IN;
				endcase
			end
			if(ext_int_control==`BEGIN)begin
				EXL<=1;
				EPC<=(BDop==1)?PC-4:PC;
				ExtCode<=Ext_code;
				IP<=HWInt;
				BD<=BDop;
			end
			else if(ext_int_control==`END)begin
				EXL<=0;
				//EPC<=0;
				//ExtCode<=`NO_EXC;
				//IP<=0;
				//BD<=0;
			end
		end
	end
	assign IntReq=|(IM[15:10]&HWInt[5:0])&!EXL&IE;
	//MFC0
	assign EPC_OUT=EPC;
	assign CP0_OUT=(ReadAddr==`SR_CODE)?{16'b0,IM,8'b0,EXL,IE}:
						(ReadAddr==`CAUSE_CODE)?{BD,15'b0,IP,3'b0,ExtCode,2'b0}:
						(ReadAddr==`EPC_CODE)?{EPC[31:2],2'b00}:
						(ReadAddr==`PRID_CODE)?PRId:
						0;
   assign EXL_val=EXL;
endmodule
