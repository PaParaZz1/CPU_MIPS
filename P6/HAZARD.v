`timescale 1ns / 1ns
`include "head.v"
// Company: 
// Engineer: 
// 
// Create Date:    19:12:32 12/08/2017 
// Design Name: 
// Module Name:    HAZARD 
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
module HAZARD(
	input M_D_judge,
	input busy,
	input [2:0] E_newdata_type,
	input [2:0] M_newdata_type,
	input [2:0] W_newdata_type,
	input [1:0] rs_tuse,
	input [1:0] rt_tuse,
	input [4:0] rs,
	input [4:0] rt,
	input [4:0] WB,
	input [4:0] E_WB,
	input [4:0] M_WB,
	input [4:0] W_WB,
	input [4:0] E_RS,
	input [4:0] E_RT,
	input [4:0] M_RS,
	input [4:0] M_RT,
	input [4:0] W_RS,
	input [4:0] W_RT,
	output stall_pc,
	output stall_D,
	output stall_E,
	output stall_M,
	output stall_W,
	output stall_GRF,
	output stall_DM,
	output reset_E,
	output reset_D,
	output reset_M,
	output [3:0] D_RSdata,
	output [3:0] E_RSdata,
	output [3:0] D_RTdata,
	output [3:0] E_RTdata,
	output [3:0] M_RTdata
    );
	 //forwarding
	 //rs0
	 assign D_RSdata=((E_newdata_type==`NEW_PC)&(rs==E_WB)&(E_WB!=5'b00000))?`EtoD_PC_RS:
						  ((M_newdata_type==`NEW_PC)&(rs==M_WB)&(M_WB!=5'b00000))?`MtoD_PC_RS:
						  ((M_newdata_type==`NEW_ALU)&(rs==M_WB)&(M_WB!=5'b00000))?`MtoD_ALU_RS:
						  ((W_newdata_type==`NEW_PC)&(rs==W_WB)&(W_WB!=5'b00000))?`WtoD_PC_RS:
						  ((W_newdata_type==`NEW_ALU)&(rs==W_WB)&(W_WB!=5'b00000))?`WtoD_ALU_RS:
						  ((W_newdata_type==`NEW_DM)&(rs==W_WB)&(W_WB!=5'b00000))?`WtoD_DM_RS:0;
	 //rs1					  
	 assign E_RSdata=((M_newdata_type==`NEW_ALU)&(E_RS==M_WB)&(M_WB!=5'b00000))?`MtoE_ALU_RS:
						  ((M_newdata_type==`NEW_PC)&(E_RS==M_WB)&(M_WB!=5'b00000))?`MtoE_PC_RS:
						  ((W_newdata_type==`NEW_ALU)&(E_RS==W_WB)&(W_WB!=5'b00000))?`WtoE_ALU_RS://
						  ((W_newdata_type==`NEW_PC)&(E_RS==W_WB)&(W_WB!=5'b00000))?`WtoE_PC_RS:
						  ((W_newdata_type==`NEW_DM)&(E_RS==W_WB)&(W_WB!=5'b00000))?`WtoE_DM_RS:0;
	 //rt0
	 assign D_RTdata=((E_newdata_type==`NEW_PC)&(rt==E_WB)&(E_WB!=5'b00000))?`EtoD_PC_RT:
						  ((M_newdata_type==`NEW_PC)&(rt==M_WB)&(M_WB!=5'b00000))?`MtoD_PC_RT:
						  ((M_newdata_type==`NEW_ALU)&(rt==M_WB)&(M_WB!=5'b00000))?`MtoD_ALU_RT:
						  ((W_newdata_type==`NEW_PC)&(rt==W_WB)&(W_WB!=5'b00000))?`WtoD_PC_RT:
						  ((W_newdata_type==`NEW_ALU)&(rt==W_WB)&(W_WB!=5'b00000))?`WtoD_ALU_RT:
						  ((W_newdata_type==`NEW_DM)&(rt==W_WB)&(W_WB!=5'b00000))?`WtoD_DM_RT:0;
	 //rt1
	 assign E_RTdata=((M_newdata_type==`NEW_ALU)&(E_RT==M_WB)&(M_WB!=5'b00000))?`MtoE_ALU_RT:
						  ((M_newdata_type==`NEW_PC)&(E_RT==M_WB)&(M_WB!=5'b00000))?`MtoE_PC_RT:
						  ((W_newdata_type==`NEW_PC)&(E_RT==W_WB)&(W_WB!=5'b00000))?`WtoE_PC_RT:
						  ((W_newdata_type==`NEW_ALU)&(E_RT==W_WB)&(W_WB!=5'b00000))?`WtoE_ALU_RT://
						  ((W_newdata_type==`NEW_DM)&(E_RT==W_WB)&(W_WB!=5'b00000))?`WtoE_DM_RT:0;
	 //rt2
	 assign M_RTdata=((W_newdata_type==`NEW_PC)&(E_RT==W_WB)&(W_WB!=5'b00000))?`WtoM_PC_RT:
						  ((W_newdata_type==`NEW_ALU)&(M_RT==W_WB)&(W_WB!=5'b00000))?`WtoM_ALU_RT://
						  ((W_newdata_type==`NEW_DM)&(M_RT==W_WB)&(W_WB!=5'b00000))?`WtoM_DM_RT:0;//
	 
	 /*wire forw_rs0_e0,forw_rs0_m0,forw_rs0_w0,
			forw_rs1_e0,forw_rs1_e1,forw_rs1_m0,forw_rs1_m1,forw_rs1_w0,
			forw_rt0_e0,forw_rt0_m0,forw_rt0_w0,
			forw_rt1_e0,forw_rt1_e1,forw_rt1_m0,forw_rt1_m1,forw_rt1_w0,
			forw_rt2_e0,forw_rt2_e1,forw_rt2_e2,forw_rt2_m0,forw_rt2_m1,forw_rt2_w0;
		//rs
	 assign forw_rs0_e0=tuse_rs0
							  &(E_newdata_type==`NEW_PC)
							  &(rs==E_RS)
							  ?1:0;
	 assign forw_rs0_m0=tuse_rs0
							  &(M_newdata_type==`NEW_PC|`NEW_ALU)
							  &(rs==M_RS)
							  ?1:0;
	 assign forw_rs0_w0=tuse_rs0
							  &(W_newdata_type==`NEW_PC|`NEW_ALU|`NEW_DM)
							  &(rs==W_RS)
							  ?1:0;
							  
							  
	 assign forw_rs1_e0=tuse_rs1
							  &(E_newdata_type==`NEW_PC)
							  &(rs==E_RS)
							  ?1:0;
	 assign forw_rs1_e1=tuse_rs1
							  &(E_newdata_type==`NEW_ALU)
							  &(rs==E_RS)
							  ?1:0;				  
	 assign forw_rs1_m0=tuse_rs1
							  &(M_newdata_type==`NEW_PC|`NEW_ALU)
							  &(rs==M_RS)
							  ?1:0;
	 assign forw_rs1_m1=tuse_rs1
							  &(M_newdata_type==`NEW_DM)
							  &(rs==M_RS)
							  ?1:0;
	 assign forw_rs1_w0=tuse_rs1
							  &(W_newdata_type==`NEW_PC|`NEW_ALU|`NEW_DM)
							  &(rs==W_RS)
							  ?1:0;
		//rt
	 assign forw_rt0_e0=tuse_rt0
							  &(E_newdata_type==`NEW_PC)
							  &(rt==E_RT)
							  ?1:0;
	 assign forw_rt0_m0=tuse_rt0
							  &(M_newdata_type==`NEW_PC|`NEW_ALU)
							  &(rt==M_RT)
							  ?1:0;
	 assign forw_rt0_w0=tuse_rt0
							  &(W_newdata_type==`NEW_PC|`NEW_ALU|`NEW_DM)
							  &(rt==W_RT)
							  ?1:0;
							  
							  
	 assign forw_rt1_e0=tuse_rt1
							  &(E_newdata_type==`NEW_PC)
							  &(rt==E_RT)
							  ?1:0;
	 assign forw_rt1_e1=tuse_rt1
							  &(E_newdata_type==`NEW_ALU)
							  &(rt==E_RT)
							  ?1:0;				  
	 assign forw_rt1_m0=tuse_rt1
							  &(M_newdata_type==`NEW_PC|`NEW_ALU)
							  &(rt==M_RT)
							  ?1:0;
	 assign forw_rt1_m1=tuse_rt1
							  &(M_newdata_type==`NEW_DM)
							  &(rt==M_RT)
							  ?1:0;
	 assign forw_rt1_w0=tuse_rt1
							  &(W_newdata_type==`NEW_PC|`NEW_ALU|`NEW_DM)
							  &(rt==W_RT)
							  ?1:0;	 
					

	 assign forw_rt2_e0=tuse_rt2
							  &(E_newdata_type==`NEW_PC)
							  &(rt==E_RT)
							  ?1:0;
	 assign forw_rt2_e1=tuse_rt2
							  &(E_newdata_type==`NEW_ALU)
							  &(rt==E_RT)
							  ?1:0;	
	 assign forw_rt2_e2=tuse_rt2
	 						  &(E_newdata_type==`NEW_DM)
							  &(rt==E_RT)
							  ?1:0;	
	 assign forw_rt2_m0=tuse_rt2
							  &(M_newdata_type==`NEW_PC|`NEW_ALU)
							  &(rt==M_RT)
							  ?1:0;
	 assign forw_rt2_m1=tuse_rt2
							  &(M_newdata_type==`NEW_DM)
							  &(rt==M_RT)
							  ?1:0;
	 assign forw_rt2_w0=tuse_rt2
							  &(W_newdata_type==`NEW_PC|`NEW_ALU|`NEW_DM)
							  &(rt==W_RT)
							  ?1:0;	*/
	 //stall
	 wire stall_rs,stall_rt,stall_rs0_e1,stall_rs0_e2,stall_rs0_m1,stall_rs1_e2,
									stall_rt0_e1,stall_rt0_e2,stall_rt0_m1,stall_rt1_e2;
	 wire stall_MD;
	 assign stall_MD=M_D_judge&busy;
		assign stall=stall_rs|stall_rt;//|(M_D_judge&busy);
		//rs
		assign stall_rs0_e1=(rs_tuse==`RS0)
								  &(E_newdata_type==`NEW_ALU)
								  &(rs==E_WB)
								  &(E_WB!=5'b00000)
								  ?1:0;
		assign stall_rs0_e2=(rs_tuse==`RS0)
								  &(E_newdata_type==`NEW_DM)
								  &(rs==E_WB)
								  &(E_WB!=5'b00000)
								  ?1:0;
		assign stall_rs0_m1=(rs_tuse==`RS0)
								  &(M_newdata_type==`NEW_DM)
								  &(rs==M_WB)
								  &(M_WB!=5'b00000)
								  ?1:0;
		assign stall_rs1_e2=(rs_tuse==`RS1)
								  &(E_newdata_type==`NEW_DM)
								  &(rs==E_WB)
								  &(E_WB!=5'b00000)
								  ?1:0;	
		assign stall_rs=stall_rs0_e1|stall_rs0_e2|stall_rs0_m1|stall_rs1_e2;
		//rt
		assign stall_rt0_e1=(rt_tuse==`RT0)
								  &(E_newdata_type==`NEW_ALU)
								  &(rt==E_WB)
								  &(E_WB!=5'b00000)
								  ?1:0;
		assign stall_rt0_e2=(rt_tuse==`RT0)
								  &(E_newdata_type==`NEW_DM)
								  &(rt==E_WB)
								  &(E_WB!=5'b00000)
								  ?1:0;
		assign stall_rt0_m1=(rt_tuse==`RT0)
								  &(M_newdata_type==`NEW_DM)
								  &(rt==M_WB)
								  &(M_WB!=5'b00000)
								  ?1:0;
		assign stall_rt1_e2=(rt_tuse==`RT1)
								  &(E_newdata_type==`NEW_DM)
								  &(rt==E_WB)
								  &(E_WB!=5'b00000)
								  ?1:0;	
		assign stall_rt=stall_rt0_e1|stall_rt0_e2|stall_rt0_m1|stall_rt1_e2;
		
		
		// stall steps
		assign stall_pc=(stall==1|stall_MD==1)?1:0;
		assign stall_D=(stall==1|stall_MD==1)?1:0;
		assign stall_E=(stall_MD==1)?1:0;
		assign stall_M=(stall_MD==1)?1:0;
		assign stall_W=(stall_MD==1)?1:0;
		assign stall_GRF=(stall_MD==1)?1:0;
		assign stall_DM=(stall_MD==1)?1:0;
		assign reset_E=(stall==1)?1:0;
		assign reset_D=0;
		assign reset_M=0;
		assign reset_W=0;

endmodule
