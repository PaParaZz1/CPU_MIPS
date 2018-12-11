`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:31 11/26/2017 
// Design Name: 
// Module Name:    head 
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
//ALU definition
`define ALU_ADDU 3'b000
`define ALU_SUBU 3'b001
`define ALU_OR 3'b010
`define ALU_SLL 3'b011
`define ALU_SLT 3'b100
`define ALU_SRAV 3'b101
`define ALU_XORI 3'b110
`define ALU_EZ 3'b111
//NPC definition
`define NPC_general 2'b00
`define NPC_B 2'b01
`define NPC_J 2'b10
`define NPC_JR 2'b11
//EXT definition
`define zero_ext 2'b00
`define sign_ext 2'b01
`define lui_ext 2'b10
//MUX definition
//RegData 
`define ALU_data 2'b01
`define DM_data 2'b10
`define PC_data 2'b11
//RegDst
`define rd 2'b00
`define rt 2'b01
`define ra 2'b10
//DM definition
`define L_S_B 3'b000
`define L_S_H 3'b001
`define L_S_W 3'b010
`define L_S_HU 3'b101
`define L_S_BU 3'b110
//J_WB definition
`define N_J_WB 2'b00
`define J_WB_JAL 2'b01
`define J_WB_JALR 2'b10
//CMP definition
`define beq 3'b000
`define bne 3'b001
`define blez 3'b010
`define bltz 3'b011
`define bgez 3'b100
`define bgtz 3'b101
//HAZARD definition
`define NEW_ALU 2'b01
`define NEW_DM 2'b10
`define NEW_PC 2'b11
`define NEW_NO 2'b00
//forwarding 
//rs0
`define EtoD_PC_RS 4'b1001
`define MtoD_PC_RS 4'b0110
`define MtoD_ALU_RS 4'b0101
`define WtoD_PC_RS 4'b0011
`define WtoD_ALU_RS 4'b0010
`define WtoD_DM_RS 4'b0001
//rs1
`define MtoE_PC_RS 4'b0110
`define MtoE_ALU_RS 4'b0101
`define WtoE_PC_RS 4'b0011
`define WtoE_ALU_RS 4'b0010
`define WtoE_DM_RS 4'b0001
//rt0
`define EtoD_PC_RT 4'b1001
`define MtoD_PC_RT 4'b0110
`define MtoD_ALU_RT 4'b0101
`define WtoD_PC_RT 4'b0011
`define WtoD_ALU_RT 4'b0010
`define WtoD_DM_RT 4'b0001
//rt1
`define MtoE_PC_RT 4'b0110
`define MtoE_ALU_RT 4'b0101
`define WtoE_PC_RT 4'b0011
`define WtoE_ALU_RT 4'b0010
`define WtoE_DM_RT 4'b0001
//rt2
`define WtoM_PC_RT 4'b0011
`define WtoM_ALU_RT 4'b0010
`define WtoM_DM_RT 4'b0001
//tuse
//rs
`define RS0 2'b00
`define RS1 2'b01
//rt
`define RT0 2'b00
`define RT1 2'b01
`define RT2 2'b10