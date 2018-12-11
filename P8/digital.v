`timescale 1ns / 1ns
`define zero 8'b01111110
`define one 8'b00110000
`define two 8'b01101101
`define three 8'b01111001
`define four 8'b00110011
`define five 8'b01011011
`define six 8'b01011111
`define seven 8'b01110000
`define eight 8'b01111111
`define nine 8'b01111011
`define ten 8'b01110111
`define eleven 8'b00011111
`define twelve 8'b01001110
`define thirteen 8'b00111101
`define fourteen 8'b01001111
`define fifteen 8'b01000111
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:09:17 01/11/2018 
// Design Name: 
// Module Name:    digital 
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
module digital(
	 input clk,
	 input reset,
	 input [31:0] data_in,
    input [4:2] Addr,////
	 input enable,
	 output [3:0] sel0,
	 output [3:0] sel1,
	 output sel2,
	 output [7:0] code2,
	 output [7:0] code0,
	 output [7:0] code1,
	 output [31:0] data_return_cpu
    );
	 reg [3:0] led_bit[8:0];
	 reg [7:0] code0_3,code4_7;
	 reg [7:0] led_code[8:0];
	 reg [3:0] sel0_3,sel4_7;
	 reg [31:0] j;
	 integer i;
	 
	 always @ (posedge clk) begin
		 if(reset) begin
			code0_3<=8'h00;
			code4_7<=8'h00;
			sel0_3<=4'h0;
			sel4_7<=4'h0;
			j<=32'h00000000;
			for(i=0;i<9;i=i+1) begin
				led_bit[i]<=4'b0000;
				led_code[i]<=8'h00;
			end
			
		 end
		 else begin
		   if(enable)begin
		     if(Addr==3'b110) begin
					led_bit[0]<=data_in[3:0];
					led_bit[1]<=data_in[7:4];
					led_bit[2]<=data_in[11:8];
					led_bit[3]<=data_in[15:12];
					led_bit[4]<=data_in[19:16];
					led_bit[5]<=data_in[23:20];
					led_bit[6]<=data_in[27:24];
					led_bit[7]<=data_in[31:28];
			  end
			  else begin
			      led_bit[8]<=data_in[3:0];
			  end
		   end
			
			
			
		   for(i=0;i<9;i=i+1)begin
				case(led_bit[i])
					4'b0000:led_code[i]<=`zero;
					4'b0001:led_code[i]<=`one;
					4'b0010:led_code[i]<=`two;
					4'b0011:led_code[i]<=`three;
					4'b0100:led_code[i]<=`four;
					4'b0101:led_code[i]<=`five;
					4'b0110:led_code[i]<=`six;
					4'b0111:led_code[i]<=`seven;
					4'b1000:led_code[i]<=`eight;
					4'b1001:led_code[i]<=`nine;
					4'b1010:led_code[i]<=`ten;
					4'b1011:led_code[i]<=`eleven;
					4'b1100:led_code[i]<=`twelve;
					4'b1101:led_code[i]<=`thirteen;
					4'b1110:led_code[i]<=`fourteen;
					4'b1111:led_code[i]<=`fifteen;
				endcase
			end
			
			j<=(j+1)%80;
			
			if(j<=20)begin
				sel0_3<=4'b0001;
				sel4_7<=4'b0001;
				code0_3<=led_code[0];
				code4_7<=led_code[4];
			end
			else if(j<=40)begin
				sel0_3<=4'b0010;
				sel4_7<=4'b0010;
				code0_3<=led_code[1];
				code4_7<=led_code[5];
			end
			else if(j<=60)begin
				sel0_3<=4'b0100;
				sel4_7<=4'b0100;
				code0_3<=led_code[2];
				code4_7<=led_code[6];
			end
			else begin
				sel0_3<=4'b1000;
				sel4_7<=4'b1000;
				code0_3<=led_code[3];
				code4_7<=led_code[7];
			end
		end
		 
	

		 
	 end
	 assign code2=~led_code[8];
	 assign sel0=sel0_3;
	 assign sel1=sel4_7;
	 assign sel2=(j>40)?1'b0:1'b1;
	 assign code0=~code0_3;//
	 assign code1=~code4_7;//
	 assign data_return_cpu=(Addr==3'b110)?{led_bit[7],led_bit[6],led_bit[5],led_bit[4],
					            led_bit[3],led_bit[2],led_bit[1],led_bit[0]}:
					            {28'h0000000,led_bit[8]};
	
	 


endmodule
