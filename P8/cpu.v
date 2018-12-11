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
module cpu(
    input clk,
	 input clk2,
    input reset,
	 input [31:0] PrRD,
	 input [7:2] HWInt,
	 output [31:0] PrAddr,
	 //output [3:0] PrBE,
	 output [31:0] PrWD,
	 output PrWe
    );
	 //wire_control
	 wire RegWr,ALUsrc,DMWr,SHIFTV,legal_instr,is_eret,if_overflow,CP0Wr,CP0Read,jump_instr;
	 wire [1:0] ExtOp,NPC_SL,RegData,RegDst,rs_tuse,rt_tuse,newdatatype;
	 wire [2:0] L_S_SL;
	 wire [3:0] ALUOp;
	 //wire decode;
	 wire [5:0] opcode,func;
	 wire [4:0] rd,rs,rt,shift;
	 wire [15:0] imm16;
	 wire [25:0] index;
	 //wire IFU
	 wire [31:0] instr,PC,handler_pc;
	 wire [4:0] IFU_EXC;
	 wire if_handler;
	 //wire GRF
	 wire [4:0] WB,RWAddr;
	 wire [31:0] WrData,RS_OUT,RT_OUT,RD_OUT;
	 //wire EXT
	 wire [31:0] EXT_OUT;
	 //wire ALU
	 wire overflow;
	 wire [31:0] inputA,inputB,ALU_result;
	 wire [4:0] ALU_EXC;
	 //wire DM
	 wire [1:0] LoadSelect;
	 wire [4:0] L_S_EXC;
	 wire [31:0] DOUT;
	 //wire compare
	 wire judge;
	 //wire NPC
	 wire [31:0] next_pc;
	 wire if_jump;
	 //wire HAZARD
	 wire reset_E,reset_D,reset_M,reset_W,stall_pc,stall_D,stall_GRF,stall_DM;
	 wire [3:0] D_RSdata,E_RSdata,D_RTdata,E_RTdata,M_RTdata;
	 //wire LoadExt
	 wire [31:0] EXT_data;
	 //wire CP0
	 wire [6:2] Ext_code;
	 wire IntReq,EXL_val;
	 wire [31:0] EPC_OUT,CP0_OUT;
	 wire [1:0] ext_int_control;
	 wire stall_eret;
	 
	 
	 
	 
	 // E级
	 reg [31:0] E_RS_OUT,E_RT_OUT,E_EXT,E_PC8,E_PC;
	 reg [4:0] E_WB,E_SHIFT,E_RS,E_RT,E_RD,E_WR,E_EXC;
	 reg [1:0] E_RegData,E_newdatatype;
	 reg [2:0] E_L_S_SL;
	 reg [3:0] E_ALUOp;
	 reg E_RegWr,E_ALUsrc,E_DMWr,E_SHIFTV,E_if_overflow,E_CP0Read,E_CP0Wr,E_jump_instr;
	 // M级
	 reg [31:0] M_ALU_result,M_DIN,M_PC8,M_PC;
	 reg [4:0] M_WB,M_RT,M_RD,M_WR,M_EXC;
	 reg [2:0] M_L_S_SL;
	 reg [1:0] M_RegData,M_newdatatype;
	 reg M_RegWr,M_DMWr,M_CP0Read,M_CP0Wr,M_jump_instr;
	 // W级
	 reg [31:0] W_PC8,W_DOUT,W_ALU_result;//,W_PC;
	 reg [4:0] W_WB,W_WR;
	 reg [2:0] W_L_S_SL;
	 reg [1:0] W_LoadSelect,W_RegData,W_newdatatype;
	 reg W_RegWr,W_jump_instr;

	 //module IFU
	 IFU IFU_uut(
		 .clk(clk),
		 .clk2(clk2),
		 .Reset(reset),
		 .next_pc(next_pc),
		 .if_jump(if_jump),
		 .if_handler(if_handler),
		 .handler_pc(handler_pc),
		 .instr(instr),
		 .stall_pc(stall_pc),
		 .PC(PC),
		 .IFU_EXC(IFU_EXC)
		 );
	// pipeline register IF/ID  D级
	reg [31:0] D_instr,D_PC8,D_PC4,D_PC;
	reg [4:0] D_EXC;
	always @(posedge clk) begin
		if(reset|reset_D) begin
			D_instr<=0;
			D_PC8<=0;
			D_PC4<=0;
			D_PC<=0;
			D_EXC<=`NO_EXC;
		end
		else if(!stall_D)begin
			D_instr<=instr;
			D_PC8<=PC+8;
			D_PC4<=PC+4;
			D_PC<=PC;
			D_EXC<=IFU_EXC;
		end
	end
	//module controller
	 controller control_uut(
		 .op(opcode),
		 .func(func),
		 .rt(rt),
		 .rs(rs),
		 .RegDst(RegDst),
		 .RegWr(init_RegWr),
		 .ALUsrc(ALUsrc),
		 .DMWr(DMWr),
		 .SHIFTV(SHIFTV),
		 .legal_instr(legal_instr),
		 .if_overflow(if_overflow),
		 .is_eret(is_eret),
		 .RegData(RegData),
		 .ExtOp(ExtOp),
		 .L_S_SL(L_S_SL),
		 .ALUOp(ALUOp),
		 .NPC_SL(NPC_SL),
		 .newdatatype(newdatatype),
		 .rs_tuse(rs_tuse),
		 .rt_tuse(rt_tuse),
		 .CP0Wr(CP0Wr),
		 .CP0Read(CP0Read),
		 .jump_instr(jump_instr)
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
		.RWData(WrData),
		.RWAddr(W_WB),
		.rs(rs),
		.rt(rt),
		//.PC(W_PC),
		.RegWr(W_RegWr),
		.Reset(reset),
		.RS_OUT(RS_OUT),
		.RT_OUT(RT_OUT)
		
		);
	//forwarding D级 RS
	wire [31:0] D_forw_RS,D_forw_RT;
	assign D_forw_RS=(D_RSdata==`EtoD_PC_RS)?E_PC8:
						  (D_RSdata==`MtoD_PC_RS)?M_PC8:
						  (D_RSdata==`MtoD_ALU_RS)?M_ALU_result:
						  (D_RSdata==`WtoD_PC_RS)?W_PC8:
						  (D_RSdata==`WtoD_ALU_RS)?W_ALU_result:
						  (D_RSdata==`WtoD_DM_RS)?EXT_data:
						  RS_OUT;
	//forwarding D级 RT
	assign D_forw_RT=(D_RTdata==`MtoD_ALU_RT)?M_ALU_result:
						  (D_RTdata==`WtoD_PC_RT)?W_PC8:
						  (D_RTdata==`WtoD_ALU_RT)?W_ALU_result:
						  (D_RTdata==`WtoD_DM_RT)?EXT_data:
						  RT_OUT;
	//module HAZARD
	HAZARD HAZARD_uut(
		.is_eret(is_eret),
		.E_newdata_type(E_newdatatype),
	   .M_newdata_type(M_newdatatype),
	   .W_newdata_type(W_newdatatype),
	   .rs_tuse(rs_tuse),
	   .rt_tuse(rt_tuse),
	   .rs(rs),
	   .rt(rt),
		//.WB(WB),
		.E_WB(E_WB),
		.M_WB(M_WB),
		.W_WB(W_WB),
	   .E_RS(E_RS),
	   .E_RT(E_RT),
	   .M_RT(M_RT),
		.ext_int_control(ext_int_control),
		.E_CP0Wr(E_CP0Wr),
		.M_CP0Wr(M_CP0Wr),
		.stall_eret(stall_eret),
	   .stall_pc(stall_pc),
	   .stall_D(stall_D),
	   .reset_E(reset_E),
		.reset_D(reset_D),
		.reset_M(reset_M),
		.reset_W(reset_W),
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
		.rt0(rt[0]),
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
			E_RD<=0;
			E_newdatatype<=0;
			E_PC<=stall_pc?D_PC:0;;
			E_SHIFTV<=0;
			E_EXC<=`NO_EXC;
			E_if_overflow<=0;
			E_CP0Read<=0;
			E_CP0Wr<=0;
			E_jump_instr<=0;
		end
		else begin
			E_RS_OUT<=D_forw_RS;
			E_RT_OUT<=D_forw_RT;
			E_EXT<=EXT_OUT;
			E_PC8<=D_PC8;
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
			E_RD<=rd;
			E_newdatatype<=newdatatype;
			E_PC<=D_PC;
			E_SHIFTV<=SHIFTV;
			E_EXC<=(legal_instr==1'b1)?D_EXC:`RI;
			E_if_overflow<=if_overflow;
			E_CP0Read<=CP0Read;
			E_CP0Wr<=CP0Wr;
			E_jump_instr<=jump_instr;
		end

	end
	//module ALU
	wire [31:0] E_forw_RS,E_forw_RT,MD_result;
	//forwarding E级 RS
	assign E_forw_RS=(E_RSdata==`MtoE_PC_RS)?M_PC8:
						  (E_RSdata==`MtoE_ALU_RS)?M_ALU_result:
						  (E_RSdata==`MtoE_PC_RS)?W_PC8:
						  (E_RSdata==`WtoE_ALU_RS)?W_ALU_result:
						  (E_RSdata==`WtoE_DM_RS)?EXT_data:
						  E_RS_OUT;
	//forwarding E级 RT
	assign E_forw_RT=(E_RTdata==`MtoE_PC_RT)?M_PC8:
						  (E_RTdata==`MtoE_ALU_RT)?M_ALU_result:
						  (E_RTdata==`WtoE_PC_RT)?W_PC8:
						  (E_RTdata==`WtoE_ALU_RT)?W_ALU_result:
						  (E_RTdata==`WtoE_DM_RT)?EXT_data:
						  E_RT_OUT;
	assign inputB=(E_ALUsrc)?E_EXT:E_forw_RT;
	assign inputA=E_forw_RS;
	ALU ALU_uut(
		.ALUOp(E_ALUOp),
		.inputA(inputA),
		.inputB(inputB),
		.shift(E_SHIFT),
		.SHIFTV(E_SHIFTV),
		.judge_overflow(E_if_overflow),
		.overflow(overflow),
		.ALU_result(ALU_result)
		);
	//pipeline register EX/MEM M级
	always @(posedge clk) begin
		if(reset|reset_M) begin
			M_ALU_result<=0;
			M_DIN<=0;
			M_WB<=0;
			M_RegWr<=0;
			M_DMWr<=0;
			M_RegData<=0;
			M_L_S_SL<=0;
			M_PC8<=0;
			M_RT<=0;
			M_RD<=0;
			M_newdatatype<=0;
			M_PC<=0;
			M_EXC<=`NO_EXC;
			M_CP0Read<=0;
			M_CP0Wr<=0;
			M_jump_instr<=0;
		end
		else  begin
			M_ALU_result<=ALU_result;
			M_DIN<=E_forw_RT;
			M_WB<=E_WB;
			M_RegWr<=E_RegWr;
			M_DMWr<=E_DMWr;
			M_RegData<=E_RegData;
			M_L_S_SL<=E_L_S_SL;
			M_PC8<=E_PC8;
			M_RT<=E_RT;
			M_RD<=E_RD;
			M_newdatatype<=E_newdatatype;
			M_PC<=E_PC;
			M_EXC<=(overflow)?`OV:E_EXC;
			M_CP0Read<=E_CP0Read;
			M_CP0Wr<=E_CP0Wr;
			M_jump_instr<=E_jump_instr;
		end
	end
	//forwarding M级 RT
	wire [31:0] M_forw_RT;
	wire DMWr_judge,HIT_DM;//防止误写DM
	wire [31:0] ReadData;
	wire lh_timer,sh_timer;
	assign M_forw_RT=(M_RTdata==`WtoM_ALU_RT)?W_ALU_result:
						  (M_RTdata==`WtoM_DM_RT)?EXT_data:
						  M_DIN;
	assign HIT_DM=(M_ALU_result>=`DM_INIT&&M_ALU_result<=`DM_END);
	assign DMWr_judge=M_DMWr&HIT_DM&(ext_int_control!=`BEGIN);
	assign PrAddr=M_ALU_result;
	assign PrWD=M_forw_RT;
	assign PrWe=M_DMWr&!HIT_DM&(ext_int_control!=`BEGIN);
	//DM Addr exception judge
	wire load_EXC,store_EXC;
	wire [4:0] DM_EXC;
	wire beyond_range_load,beyond_range_store;
	assign beyond_range_load=!((M_ALU_result>=`DM_INIT&&M_ALU_result<=`DM_END)|
									  (M_ALU_result>=`TIMER1_INIT&&M_ALU_result<=`TIMER1_END)|
									  (M_ALU_result>=`UART_BEGIN&&M_ALU_result<=`UART_END)|
									  (M_ALU_result>=`SWITCH_BEGIN&&M_ALU_result<=`SWITCH_END)|
									  (M_ALU_result>=`LED_BEGIN&&M_ALU_result<=`LED_END)|
									  (M_ALU_result>=`DIGIT_BEGIN&&M_ALU_result<=`DIGIT_END)|
									  (M_ALU_result>=`BUTTON_BEGIN&&M_ALU_result<=`BUTTON_END)
									  );
	assign beyond_range_store=!((M_ALU_result>=`DM_INIT&&M_ALU_result<=`DM_END)|
										(M_ALU_result>=`TIMER1_INIT&&M_ALU_result<=32'h00007F07)|
										(M_ALU_result>=`UART_BEGIN&&M_ALU_result<=`UART_END)|
									   (M_ALU_result>=`LED_BEGIN&&M_ALU_result<=`LED_END)|
									   (M_ALU_result>=`DIGIT_BEGIN&&M_ALU_result<=`DIGIT_END)
									);
	assign lh_timer=(M_L_S_SL==`L_S_H|M_L_S_SL==`L_S_HU|M_L_S_SL==`L_S_B|M_L_S_SL==`L_S_BU)&
						 ((M_ALU_result>=`TIMER1_INIT&&M_ALU_result<=`TIMER1_END)
						 );
	assign sh_timer=(M_L_S_SL==`L_S_H|M_L_S_SL==`L_S_B)&
						 ((M_ALU_result>=`TIMER1_INIT&&M_ALU_result<=32'h00007F07)
						 );
	assign load_EXC=((M_newdatatype==`NEW_DM)&!M_CP0Read)&
						 (lh_timer|beyond_range_load|
						 ((M_L_S_SL==`L_S_W)&(M_ALU_result[1:0]!=2'b00)|
						 (M_L_S_SL==`L_S_H)&(M_ALU_result[0]!=1'b0)|
						 (M_L_S_SL==`L_S_HU)&(M_ALU_result[0]!=1'b0)))
						 ;
	assign store_EXC=M_DMWr&
						 (sh_timer|beyond_range_store|
						 ((M_L_S_SL==`L_S_W)&(M_ALU_result[1:0]!=2'b00)|
						 (M_L_S_SL==`L_S_H)&(M_ALU_result[0]!=1'b0)))
						 ;
   assign DM_EXC=(load_EXC==1)?`ADEL:
					  (store_EXC==1)?`ADES:
					  M_EXC;
	//module exception/interrupt judge

	assign Ext_code=(IntReq==1)?`INT:DM_EXC;
	assign ext_int_control=(!EXL_val&(IntReq|DM_EXC!=`NO_EXC))?`BEGIN:
	                       (is_eret&!stall_eret)?`END:
								  `NORMAL;
	assign handler_pc=(ext_int_control==`BEGIN)?`EX_HANDLER:
						   (ext_int_control==`END)?EPC_OUT:
							0;
	assign if_handler=(ext_int_control==`BEGIN)|(ext_int_control==`END);
					    
	//module CP0
	CP0 CP0_uut(
		.clk(clk),
		.reset(reset),
		.ReadAddr(M_RD),
		.WrAddr(M_RD),
		.Ext_code(Ext_code),
		.HWInt(HWInt),
		.BDop(W_jump_instr),
		.CP0Wr(M_CP0Wr&(ext_int_control!=`BEGIN)),//
		.ext_int_control(ext_int_control),
		.PC(M_PC),
		.CP0_IN(M_forw_RT),
		.IntReq(IntReq),
		.EPC_OUT(EPC_OUT),
		.CP0_OUT(CP0_OUT),
		.EXL_val(EXL_val)
		);
	//module DM
	DM DM_uut(
		.clk(clk),
		.clk2(clk2),
		.DMWr(DMWr_judge),
		.DMAddr(M_ALU_result),
		.DIN(M_forw_RT),
		.L_S_SL(M_L_S_SL),
		.DOUT(DOUT),
		.PC(M_PC),
		.LoadSelect(LoadSelect),
		.Reset(reset)
		);
	assign ReadData=(HIT_DM)?DOUT:PrRD;//防止误读DM
	always @(posedge clk) begin
		if(reset|reset_W)begin
			W_WB<=0;
			W_RegWr=0;
			W_PC8<=0;
			W_newdatatype<=0;
			W_ALU_result<=0;
			W_DOUT<=0;
			//W_PC<=0;
			W_L_S_SL<=0;
			W_LoadSelect<=0;
			W_RegData<=0;
			W_jump_instr<=0;
		end
		else begin
			W_WB<=M_WB;
			W_RegWr=M_RegWr;
			W_PC8<=M_PC8;
			W_newdatatype<=M_newdatatype;
			W_ALU_result<=M_ALU_result;
			W_DOUT<=(M_CP0Read==1)?CP0_OUT:ReadData;
			//W_PC<=M_PC;
			W_L_S_SL<=M_L_S_SL;
			W_LoadSelect<=LoadSelect;
			W_RegData<=M_RegData;
			W_jump_instr<=M_jump_instr;
		end
	end
	//module LoadExt
	LoadExt LoadExt_uut(
		.mem_out(W_DOUT),
		.L_S_SL(W_L_S_SL),
		.DMAddr(W_LoadSelect),
		.EXT_data(EXT_data)
		);
	assign WrData=(W_RegData==`ALU_data)?W_ALU_result:
					  (W_RegData==`DM_data)?EXT_data:
					  (W_RegData==`PC_data)?W_PC8:
					  32'h00000000;
endmodule
