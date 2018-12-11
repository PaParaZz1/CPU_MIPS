`timescale 1ns / 1ns
`include "head.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:09 11/26/2017 
// Design Name: 
// Module Name:    mips 
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
	 //wire_control
	 wire RA_EN,DMtoReg,RegWr,ALUsrc,DMWr;
	 wire [1:0] ExtOp,NPC_SL,RegData,RegDst,CMP_SL;
	 wire [2:0] ALUOp,L_S_SL;
	 //wire decode;
	 wire [5:0] opcode,func;
	 wire [4:0] rd,rs,rt,shift;
	 wire [15:0] imm16;
	 wire [25:0] index;
	 //wire IFU
	 wire zero;
	 wire [31:0] RA,PC_4,instr,WPC;
	 //wire GRF
	 wire [4:0] RWAddr;
	 wire [31:0] WrData,RS_OUT,RT_OUT;
	 //wire EXT
	 wire [31:0] EXT_OUT;
	 //wire ALU
	 wire [31:0] inputA,inputB,ALU_result;
	 //wire DM
	 wire [31:0] DOUT;


	 
	 //module controller
	 controller control_uut(
		 .op(opcode),
		 .func(func),
		 .RegDst(RegDst),
		 //.RA_EN(RA_EN),
		 //.DMtoReg(DMtoReg),
		 .RegWr(RegWr),
		 .ALUsrc(ALUsrc),
		 .DMWr(DMWr),
		 .RegData(RegData),
		 .ExtOp(ExtOp),
		 .L_S_SL(L_S_SL),
		 .ALUOp(ALUOp),
		 .NPC_SL(NPC_SL)
		 );
	 //module IFU
	 IFU IFU_uut(
		 .clk(clk),
		 .Reset(reset),
		 .zero(zero),
		 .NPC_SL(NPC_SL),
		 .imm16(imm16),
		 .instr_index(index),
		 .RA(RA),
		 .instr(instr),
		 .PC_4(PC_4),
		 .WPC(WPC)
		 );
	//module decode
	decode decode_uut(
		.instr(instr),
		.opcode(opcode),
		.rd(rd),
		.rs(rs),
		.rt(rt),
		.shift(shift),
		.func(func),
		.imm16(imm16),
		.instr_index(index)
		);
	//module GRF
	assign RWAddr=(RegDst==`rd)?rd:
	              (RegDst==`rt)?rt:
					  (RegDst==`ra)?5'b11111:
					  5'b00000;
	GRF GRF_uut(
		.clk(clk),
		.WrData(WrData),
		.RWAddr(RWAddr),
		.rs(rs),
		.rt(rt),
		.RegWr(RegWr),
		.Reset(reset),
		//.PC_4(PC_4),
		//.RA_EN(RA_EN),
		.RS_OUT(RS_OUT),
		.RT_OUT(RT_OUT),
		.RA(RA),
		.WPC(WPC)
		);
	//module EXT
	EXT EXT_uut(
		.ExtOp(ExtOp),
		.imm16(imm16),
		.EXT_OUT(EXT_OUT)
		);
	//module ALU
	assign inputB=(ALUsrc)?EXT_OUT:RT_OUT;
	assign inputA=RS_OUT;
	ALU ALU_uut(
		.ALUOp(ALUOp),
		.inputA(inputA),
		.inputB(inputB),
		.shift(shift),
		.zero(zero),
		.ALU_result(ALU_result)
		);
	//module DM
	DM DM_uut(
		.clk(clk),
		.DMWr(DMWr),
		.DMAddr(ALU_result),
		.DIN(RT_OUT),
		.L_S_SL(L_S_SL),
		.DOUT(DOUT),
		.Reset(reset),
		.WPC(WPC)
		);
	assign WrData=(RegData==`ALU_data)?ALU_result:
					  (RegData==`DM_data)?DOUT:
					  (RegData==`RA_data)?PC_4:
					  32'h00000000;/*
	case (Regdata)
		`ALU_data: WrData=ALU_result;
		`DM_data: WrData=DOUT;
		`RA_data: WrData=PC_4;
		default : WrData=32'h00000000;
	endcase   
	 wire s1, s2, s3;
   xor xor1(sum, a, b, cin);
   and and1(s1, a, b);
   and and2(s2, a, cin);
   and and3(s3, b, cin);
   or or1(overflow, s1, s2, s3);*/
		



endmodule
