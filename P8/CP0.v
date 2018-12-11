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
	reg [31:0] EPC;//,PRId;
	//SR:
	reg [15:10] IM;
	reg IE,EXL;
	//Cause
	reg BD;
	reg [5:0] IP;//15:10
	reg [6:2] ExtCode;
	always @(posedge clk) begin
		if(reset) begin
			//PRId<=`NYZ_ID;
			EPC<=32'h0000000;
			IM<=6'b000000;
			IE<=1'b0;
			EXL<=1'b0;
			BD<=1'b0;
			IP<=6'b000000;
			ExtCode<=`NO_EXC;
		end
		else begin
			IP<=HWInt;
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
					default:;
				endcase
			end
			if(ext_int_control==`BEGIN)begin
				EXL<=1'b1;
				EPC<=(BDop==1)?PC-4:PC;
				ExtCode<=Ext_code;
				BD<=BDop;
			end
			else if(ext_int_control==`END)begin
				EXL<=1'b0;
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
	assign CP0_OUT=(ReadAddr==`SR_CODE)?{16'h0000,IM,8'h00,EXL,IE}:
						(ReadAddr==`CAUSE_CODE)?{BD,15'b000000000000000,IP,3'b000,ExtCode,2'b00}:
						(ReadAddr==`EPC_CODE)?{EPC[31:2],2'b00}:
						//(ReadAddr==`PRID_CODE)?PRId:
						0;
   assign EXL_val=EXL;
endmodule
