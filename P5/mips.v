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
	 wire RegWr,ALUsrc,DMWr,jal;
	 wire [1:0] ExtOp,NPC_SL,RegData,RegDst,newdatatype,rs_tuse,rt_tuse;
	 wire [2:0] ALUOp,L_S_SL;
	 //wire decode;
	 wire [5:0] opcode,func;
	 wire [4:0] rd,rs,rt,shift;
	 wire [15:0] imm16;
	 wire [25:0] index;
	 //wire IFU
	 wire [31:0] PC8,PC4,instr,PC;
	 //wire GRF
	 wire [4:0] WB,RWAddr;
	 wire [31:0] WrData,RS_OUT,RT_OUT,RD_OUT;
	 //wire EXT
	 wire [31:0] EXT_OUT;
	 //wire ALU
	 wire [31:0] inputA,inputB,ALU_result;
	 wire movz_judge;
	 //wire DM
	 wire [31:0] DOUT;
	 //wire compare
	 wire judge;
	 //wire NPC
	 wire [31:0] next_pc;
	 wire if_jump;
	 //wire HAZARD
	 wire reset_E,reset_D,reset_M,reset_W,stall_pc,stall_D,stall_E,stall_M,stall_W;
	 wire [3:0] D_RSdata,E_RSdata,D_RTdata,E_RTdata,M_RTdata;
	 
	 
	 
	 
	 // E级
	 reg [31:0] E_RS_OUT,E_RT_OUT,E_RD_OUT,E_EXT,E_PC8,E_PC4,E_PC;
	 reg [4:0] E_WB,E_SHIFT,E_RS,E_RT,E_WR;
	 reg [1:0] E_RegData,E_newdatatype;
	 reg [2:0] E_ALUOp,E_L_S_SL;
	 reg E_if_jump,E_RegWr,E_ALUsrc,E_DMWr;
	 // M级
	 reg [31:0] M_ALU_result,M_DIN,M_PC8,M_PC4,M_PC;
	 reg [4:0] M_WB,M_RS,M_RT,M_WR;
	 reg [2:0] M_L_S_SL;
	 reg [1:0] M_RegData,M_newdatatype;
	 reg M_RegWr,M_DMWr;
	 // W级
	 reg [31:0] W_WrData,W_PC8,W_PC4,W_DOUT,W_ALU_result,W_PC;
	 reg [4:0] W_WB,W_RS,W_RT,W_WR;
	 reg [1:0] W_newdatatype;
	 reg W_RegWr;
	 initial begin
			D_instr<=0;
			D_PC8<=0;
			D_PC4<=0;
			D_PC<=0;		
			E_RS_OUT<=0;
			E_RT_OUT<=0;
			E_EXT<=0;
			E_PC8<=0;
			E_PC4<=0;
			E_WB<=0;
			E_SHIFT<=0;
			E_RegWr<=0;
			E_ALUsrc<=0;
			E_DMWr<=0;
			E_RegData<=0;
			E_L_S_SL<=0;
			E_ALUOp<=0;
			E_RS<=0;
			E_RT<=0;
			E_newdatatype<=0;
			E_PC<=0;
			M_ALU_result<=0;
			M_DIN<=0;
			M_WB<=0;
			M_RegWr<=0;
			M_DMWr<=0;
			M_RegData<=0;
			M_L_S_SL<=0;
			M_PC8<=0;
			M_PC4<=0;
			M_RS<=0;
			M_RT<=0;
			M_newdatatype<=0;
			M_PC<=0;
			W_WrData<=0;
			W_WB<=0;
			W_RegWr=0;
			W_PC8<=0;
			W_PC4<=0;
			W_RS<=0;
			W_RT<=0;
			W_newdatatype<=0;
			W_ALU_result<=0;
			W_DOUT<=0;
			W_PC<=0;
	 end

	 //module IFU
	 IFU IFU_uut(
		 .clk(clk),
		 .Reset(reset),
		 .next_pc(next_pc),
		 .if_jump(if_jump),
		 .instr(instr),
		 .PC8(PC8),
		 .PC4(PC4),
		 .stall_pc(stall_pc),
		 .PC(PC)
		 );
	// pipeline register IF/ID  D级
	reg [31:0] D_instr,D_PC8,D_PC4,D_PC;
	always @(posedge clk) begin
		if(reset|reset_D) begin
			D_instr<=0;
			D_PC8<=0;
			D_PC4<=0;
			D_PC<=0;
		end
		else if(!stall_D)begin
			D_instr<=instr;
			D_PC8<=PC8;
			D_PC4<=PC4;
			D_PC<=PC;
		end
	end
	//module controller
	 controller control_uut(
		 .op(opcode),
		 .func(func),
		 .rt(rt),
		 .RegDst(RegDst),
		 .RegWr(init_RegWr),
		 .ALUsrc(ALUsrc),
		 .DMWr(DMWr),
		 .RegData(RegData),
		 .ExtOp(ExtOp),
		 .L_S_SL(L_S_SL),
		 .ALUOp(ALUOp),
		 .NPC_SL(NPC_SL),
		 .newdatatype(newdatatype),
		 .rs_tuse(rs_tuse),
		 .rt_tuse(rt_tuse)
		 );
	//module decode
	decode decode_uut(
		.instr(D_instr),
		.opcode(opcode),
		.rd(rd),
		.rs(rs),
		.rt(rt),
		.shift(shift),
		.func(func),
		.imm16(imm16),
		.instr_index(index)
		);
					
	assign WB=(RegDst==`rd)?rd:
				 (RegDst==`rt)?rt:
				 (RegDst==`ra)?5'b11111:
				 5'b00000;
	//module GRF
	GRF GRF_uut(
		.clk(clk),
		.RWData(W_WrData),
		.RWAddr(W_WB),
		.rs(rs),
		.rt(rt),
		.rd(rd),
		.RegWr(W_RegWr),
		.Reset(reset),
		.RS_OUT(RS_OUT),
		.RT_OUT(RT_OUT),
		.RD_OUT(RD_OUT),
		.PC(W_PC)
		);
	//forwarding D级 RS
	wire [31:0] D_forw_RS,D_forw_RT;
	assign D_forw_RS=(D_RSdata==`EtoD_PC_RS)?E_PC8:
						  (D_RSdata==`MtoD_PC_RS)?M_PC8:
						  (D_RSdata==`MtoD_ALU_RS)?M_ALU_result:
						  (D_RSdata==`WtoD_PC_RS)?W_PC8:
						  (D_RSdata==`WtoD_ALU_RS)?W_ALU_result:
						  (D_RSdata==`WtoD_DM_RS)?W_DOUT:
						  RS_OUT;
	//forwarding D级 RT
	assign D_forw_RT=(D_RTdata==`MtoD_ALU_RT)?M_ALU_result:
						  (D_RTdata==`WtoD_PC_RT)?W_PC8:
						  (D_RTdata==`WtoD_ALU_RT)?W_ALU_result:
						  (D_RTdata==`WtoD_DM_RT)?W_DOUT:
						  RT_OUT;
	//module HAZARD
	HAZARD HAZARD_uut(
		.E_newdata_type(E_newdatatype),
	   .M_newdata_type(M_newdatatype),
	   .W_newdata_type(W_newdatatype),
	   .rs_tuse(rs_tuse),
	   .rt_tuse(rt_tuse),
	   .rs(rs),
	   .rt(rt),
		.WB(WB),
		.E_WB(E_WB),
		.M_WB(M_WB),
		.W_WB(W_WB),
	   .E_RS(E_RS),
	   .E_RT(E_RT),
	   .M_RS(M_RS),
	   .M_RT(M_RT),
	   .W_RS(W_RS),
	   .W_RT(W_RT),
	   .stall_pc(stall_pc),
	   .stall_D(stall_D),
	   .stall_E(stall_E),
	   .stall_M(stall_M),
	   .stall_W(stall_W),
	   .reset_E(reset_E),
		.reset_D(reset_D),
		.reset_M(reset_M),
		
	   .D_RSdata(D_RSdata),
	   .E_RSdata(E_RSdata),
	   .D_RTdata(D_RTdata),
	   .E_RTdata(E_RTdata),
	   .M_RTdata(M_RTdata)
		);
	//module EXT
	EXT EXT_uut(
		.ExtOp(ExtOp),
		.imm16(imm16),
		.EXT_OUT(EXT_OUT)
		);
	//module compare 
	compare compare_uut(
		.RS_OUT(D_forw_RS),
		.RT_OUT(D_forw_RT),
		.opcode(opcode),
		.rt(rt),
		.judge(judge)
		);
	//module NPC
	NPC NPC_uut(
		.PC_4(D_PC4),
		.judge(judge),
		.IMM16(imm16),
		.IMM26(index),
		.RS_OUT(D_forw_RS),
		.next_pc(next_pc),
		.if_jump(if_jump),
		.NPC_SL(NPC_SL)
		);
	//pipeline register ID/EX E级
	always @(posedge clk) begin
		if(reset|reset_E) begin
			E_RS_OUT<=0;
			E_RT_OUT<=0;
			E_EXT<=0;
			E_PC8<=0;
			E_PC4<=0;
			E_WB<=0;
			E_SHIFT<=0;
			E_RegWr<=0;
			E_ALUsrc<=0;
			E_DMWr<=0;
			E_RegData<=0;
			E_L_S_SL<=0;
			E_ALUOp<=0;
			E_RS<=0;
			E_RT<=0;
			E_newdatatype<=0;
			E_PC<=0;
			E_RD_OUT<=RD_OUT;
		end
		else begin
			E_RS_OUT<=D_forw_RS;
			E_RT_OUT<=D_forw_RT;
			E_EXT<=EXT_OUT;
			E_PC8<=D_PC8;
			E_PC4<=D_PC4;
			E_WB<=WB;
			E_SHIFT<=shift;
			E_RegWr<=init_RegWr;
			E_ALUsrc<=ALUsrc;
			E_DMWr<=DMWr;
			E_RegData<=RegData;
			E_L_S_SL<=L_S_SL;
			E_ALUOp<=ALUOp;
			E_RS<=rs;
			E_RT<=rt;
			E_newdatatype<=newdatatype;
			E_PC<=D_PC;
			E_RD_OUT<=RD_OUT;
		end

	end
	//module ALU
	wire [31:0] E_forw_RS,E_forw_RT;
	//forwarding E级 RS
	assign E_forw_RS=(E_RSdata==`MtoE_PC_RS)?M_PC8:
						  (E_RSdata==`MtoE_ALU_RS)?M_ALU_result:
						  (E_RSdata==`MtoE_PC_RS)?W_PC8:
						  (E_RSdata==`WtoE_ALU_RS)?W_ALU_result:
						  (E_RSdata==`WtoE_DM_RS)?W_DOUT:
						  E_RS_OUT;
	//forwarding E级 RT
	assign E_forw_RT=(E_RTdata==`MtoE_PC_RT)?M_PC8:
						  (E_RTdata==`MtoE_ALU_RT)?M_ALU_result:
						  (E_RTdata==`WtoE_PC_RT)?W_PC8:
						  (E_RTdata==`WtoE_ALU_RT)?W_ALU_result:
						  (E_RTdata==`WtoE_DM_RT)?W_DOUT:
						  E_RT_OUT;
	assign inputB=(E_ALUsrc)?E_EXT:E_forw_RT;
	assign inputA=E_forw_RS;
	ALU ALU_uut(
		.ALUOp(E_ALUOp),
		.inputA(inputA),
		.inputB(inputB),
		.inputC(E_RD_OUT),
		.shift(E_SHIFT),
		.movz_judge(movz_judge),
		.ALU_result(ALU_result)
		);
	//pipeline register EX/MEM M级
	always @(posedge clk) begin
		if(reset|reset_M|movz_judge) begin
			M_ALU_result<=0;
			M_DIN<=0;
			M_WB<=0;
			M_RegWr<=0;
			M_DMWr<=0;
			M_RegData<=0;
			M_L_S_SL<=0;
			M_PC8<=0;
			M_PC4<=0;
			M_RS<=0;
			M_RT<=0;
			M_newdatatype<=0;
			M_PC<=0;
		end
		/*else if(movz_judge) begin
			M_ALU_result<=0;
			M_DIN<=0;
			M_WB<=0;
			M_RegWr<=0;
			M_DMWr<=0;
			M_RegData<=0;
			M_L_S_SL<=0;
			M_PC8<=0;
			M_PC4<=0;
			M_RS<=0;
			M_RT<=0;
			M_newdatatype<=0;
			M_PC<=0;
		end*/
		else begin
			M_ALU_result<=ALU_result;
			M_DIN<=E_forw_RT;
			M_WB<=E_WB;
			M_RegWr<=E_RegWr;
			M_DMWr<=E_DMWr;
			M_RegData<=E_RegData;
			M_L_S_SL<=E_L_S_SL;
			M_PC8<=E_PC8;
			M_PC4<=E_PC4;
			M_RS<=E_RS;
			M_RT<=E_RT;
			M_newdatatype<=E_newdatatype;
			M_PC<=E_PC;
		end
	end
	//forwarding M级 RT
	wire [31:0] M_forw_RT;
	assign M_forw_RT=(M_RTdata==`WtoM_ALU_RT)?W_ALU_result:
						  (M_RTdata==`WtoM_DM_RT)?W_DOUT:
						  M_DIN;
	//module DM
	DM DM_uut(
		.clk(clk),
		.DMWr(M_DMWr),
		.DMAddr(M_ALU_result),
		.DIN(M_forw_RT),
		.L_S_SL(M_L_S_SL),
		.DOUT(DOUT),
		.PC(M_PC),
		.Reset(reset)
		);
	assign WrData=(M_RegData==`ALU_data)?M_ALU_result:
					  (M_RegData==`DM_data)?DOUT:
					  (M_RegData==`PC_data)?M_PC8:
					  32'h00000000;
	//pipeline register W级
	//reg [31:0] W_Wrdata;
	//reg [4:0] W_WB;
	//reg W_RegWr;
	
	always @(posedge clk) begin
		if(reset|reset_W)begin
			W_WrData<=0;
			W_WB<=0;
			W_RegWr=0;
			W_PC8<=0;
			W_PC4<=0;
			W_RS<=0;
			W_RT<=0;
			W_newdatatype<=0;
			W_ALU_result<=0;
			W_DOUT<=0;
			W_PC<=0;
		end
		else begin
			W_WrData<=WrData;
			W_WB<=M_WB;
			W_RegWr=M_RegWr;
			W_PC8<=M_PC8;
			W_PC4<=M_PC4;
			W_RS<=M_RS;
			W_RT<=M_RT;
			W_newdatatype<=M_newdatatype;
			W_ALU_result<=M_ALU_result;
			W_DOUT<=DOUT;
			W_PC<=M_PC;
		end
	end
endmodule
