`timescale 1ns / 1ns
`define COUNT_MODE0 2'b00
`define COUNT_MODE1 2'b01
`define ADDR_CTRL 2'b00
`define ADDR_PRESET 2'b01
`define ADDR_COUNT 2'b10
`define STATE_IDLE 0
`define STATE_LOAD 1
`define STATE_CNT 2
`define STATE_INT 3
`define ADDR_TEN 2'b11
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:12:56 12/29/2017 
// Design Name: 
// Module Name:    timer 
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
module timer(
	input clk,
	input reset,
	input [3:2] PrAddr,
	input Wr_en,
	input [31:0] Data_in,
	output IRQ,
	output [31:0] Data_out
    );
	integer state;
	wire [3:2] ADDR_IN;
	reg interrupt;
	reg [31:0] PRESET,COUNT;
	reg [3:0] CTRL;// CTRL[3]:ÖÐ¶ÏÆÁ±Î  CTRL[2:1]:mode_sel, CTRL[0]:enable
	reg [31:0] second;
	reg [31:0] ten;
	assign mod=ten;
	assign ADDR_IN[3:2]=PrAddr[3:2];
	assign IRQ=interrupt&CTRL[3];
	assign Data_out=(ADDR_IN==`ADDR_CTRL)?{{28{1'b0}},CTRL}:
						 (ADDR_IN==`ADDR_PRESET)?PRESET:
						 (ADDR_IN==`ADDR_COUNT)?COUNT:
						 (ADDR_IN==`ADDR_TEN)?ten:
						 0;
	always @(posedge clk) begin
		if(reset) begin
			COUNT<=32'h00000000;
			PRESET<=32'h0000000c;
			CTRL<=4'b0000;
			state<=`STATE_IDLE;
			interrupt<=1'b0;
			second<=0;
			ten<=0;
		end
		else if(Wr_en)begin
			if(ADDR_IN==`ADDR_CTRL)begin
				CTRL[3:0]<=Data_in[3:0];
			end
			else if(ADDR_IN==`ADDR_PRESET) begin
				PRESET<=Data_in;
			end
		end
		if(CTRL[3]==0)
			interrupt<=0;
		case(state)
			`STATE_IDLE:begin
				if(CTRL[0]==1)begin
					state<=`STATE_LOAD;
					interrupt<=0;
				end
				if(COUNT==1)begin
					second<=second+1;
					if(second==20000000)begin
						COUNT<=0;
						ten<=(ten+1)%10;
					end
				end
				
			end
			`STATE_LOAD:begin
				COUNT<=PRESET;
				ten<=0;
				second<=0;
				if(PRESET!=0)
					state<=`STATE_CNT;
				else
					state<=`STATE_INT;
			end
			`STATE_CNT:begin
				interrupt<=0;
				second<=second+1;
				if(COUNT==1)begin
					state<=`STATE_INT;
				end
				if(second==40000000&&COUNT>=1)begin//
					second<=0;
					COUNT<=COUNT-1;
					ten<=(ten+1)%10;
				end
				if(Wr_en) begin
					state<=`STATE_IDLE;
				end
				else begin
				end
			end
			`STATE_INT:begin
				if(CTRL[2:1]==`COUNT_MODE0)begin
					if(!Wr_en)begin
						CTRL[0]<=0;
					end
               state<=`STATE_IDLE;			
					interrupt<=1;
				end
				else if(CTRL[2:1]==`COUNT_MODE1)begin
					COUNT<=PRESET;
					state<=`STATE_CNT;
					interrupt<=1;
				end
				else begin// undefined mode
					state<=`STATE_IDLE;
				end
					
			end
		endcase
	end

endmodule
