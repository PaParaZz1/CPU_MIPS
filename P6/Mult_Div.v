`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:31 12/19/2017 
// Design Name: 
// Module Name:    Mult_Div 
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
module Mult_Div(
	 input clk,
    input [31:0] inputA,
    input [31:0] inputB,
	 input reset,
	 input is_signed,
	 input [1:0] Other_Reg_Wr, //Ð´³Ë³ý
	 input [1:0] M_D_Cal, //¼ÆËã³Ë³ý
	 output busy,
	 output [31:0] HI,
	 output [31:0] LO
    );
	 integer i;
	 wire [63:0] multi,multi_unsigned;
	 wire [31:0] divide,mod,divide_unsigned,mod_unsigned;
	 reg [31:0] hi,lo;
	 reg Busy;
	 reg [2:0] calculate;
	 reg [31:0] calA,calB;
	 reg cal_is_signed;
	 wire busy_mul,busy_div;
	 assign busy=(busy_div)|(busy_mul);				 
	 assign busy_mul=(i!=5)&(calculate==2'b01|calculate==2'b11|M_D_Cal==2'b01|M_D_Cal==2'b11);
	 assign busy_div=(i!=10)&(calculate==2'b10|M_D_Cal==2'b10);
	 assign multi=$signed(calA)*$signed(calB);
	 assign multi_unsigned=calA*calB;
	 assign divide=$signed(calA)/$signed(calB);
	 assign divide_unsigned=calA/calB;
	 assign mod=$signed(calA)%$signed(calB);
	 assign mod_unsigned=calA%calB;
	 assign HI=hi;
	 assign LO=lo;
	 initial begin
		i<=0;
		lo<=0;
		hi<=0;
		Busy<=0;
		calculate<=0;
		calA<=0;
		calB<=0;
		cal_is_signed<=0;
	 end
	 always @(posedge clk) begin
		if(reset) begin
			i<=0;
			lo<=0;
			hi<=0;
			Busy<=0;
			calculate<=0;
			calA<=0;
			calB<=0;
			cal_is_signed<=0;
		end
		else if(Other_Reg_Wr!=2'b00) begin
			case(Other_Reg_Wr)
				`RegHI:hi<=inputA;
				`RegLO:lo<=inputA;
			endcase
		end
		else if(calculate!=2'b00|M_D_Cal!=2'b00) begin
			if(calculate==2'b00) begin
				calculate<=M_D_Cal;
				calA<=inputA;
				calB<=inputB;
				cal_is_signed<=is_signed;
			end
			i<=i+1;
			case(calculate)
				`MULT: begin
					if(i%5==0) begin
						i<=0;
						if(cal_is_signed) begin
							hi<=multi[63:32];
							lo<=multi[31:0];
						end
						else begin
							hi<=multi_unsigned[63:32];
							lo<=multi_unsigned[31:0];
						end
						calculate<=2'b00;
						cal_is_signed<=0;
					end
				end
				`DIV :begin
					if(i%10==0) begin
						i<=0;
						if(cal_is_signed) begin
							hi<=mod;
							lo<=divide;
						end
						else begin
							hi<=mod_unsigned;
							lo<=divide_unsigned;
						end
						calculate<=2'b00;
						cal_is_signed<=0;
					end
				end
				`MADD: begin
					if(i%5==0) begin
						i<=0;
						if(cal_is_signed) begin
							hi<=hi+multi[63:32];
							lo<=lo+multi[31:0];
						end
						else begin
							hi<=hi+multi_unsigned[63:32];
							lo<=lo+multi_unsigned[31:0];
						end
						calculate<=2'b00;
						cal_is_signed<=0;
					end
				end
			endcase
		end
	 end


endmodule
