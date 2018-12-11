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
`define ALU_ADDU 4'b0000
`define ALU_SUBU 4'b0001
`define ALU_AND 4'b0010
`define ALU_NOR 4'b0011
`define ALU_OR 4'b0100
`define ALU_XOR 4'b101
`define ALU_SLT 4'b0110
`define ALU_SLTU 4'b0111
`define ALU_SLL 4'b1000
`define ALU_SRL 4'b1001
`define ALU_SRA 4'b1010
`define ALU_EZ 4'b1011
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
`define MD_data 2'b00
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
`define MtoD_MD_RS 4'b0111
`define MtoD_PC_RS 4'b0110
`define MtoD_ALU_RS 4'b0101
`define WtoD_MD_RS 4'b0100
`define WtoD_PC_RS 4'b0011
`define WtoD_ALU_RS 4'b0010
`define WtoD_DM_RS 4'b0001
//rs1
`define MtoE_MD_RS 4'b0111
`define MtoE_PC_RS 4'b0110
`define MtoE_ALU_RS 4'b0101
`define WtoE_MD_RS 4'b0100
`define WtoE_PC_RS 4'b0011
`define WtoE_ALU_RS 4'b0010
`define WtoE_DM_RS 4'b0001
//rt0
`define EtoD_PC_RT 4'b1001
`define MtoD_MD_RT 4'b0111
`define MtoD_PC_RT 4'b0110
`define MtoD_ALU_RT 4'b0101
`define WtoD_MD_RT 4'b0100
`define WtoD_PC_RT 4'b0011
`define WtoD_ALU_RT 4'b0010
`define WtoD_DM_RT 4'b0001
//rt1
`define MtoE_MD_RT 4'b0111
`define MtoE_PC_RT 4'b0110
`define MtoE_ALU_RT 4'b0101
`define WtoE_MD_RT 4'b0100
`define WtoE_PC_RT 4'b0011
`define WtoE_ALU_RT 4'b0010
`define WtoE_DM_RT 4'b0001
//rt2
`define WtoM_MD_RT 4'b0100
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
// address allocate
`define DM_INIT 32'h00000000
`define DM_END 32'h00001FFF
`define IM_INIT 32'h00003000
`define IM_END 32'h00004FFF
`define PC_INIT 32'h00003000
`define EX_HANDLER 32'h00004180
`define TIMER1_INIT 32'h00007F00
`define TIMER1_END 32'h00007F0F
`define UART_BEGIN 32'h00007F10
`define UART_END 32'h00007F2B
`define SWITCH_BEGIN 32'h00007F2C
`define SWITCH_END 32'h00007F33
`define LED_BEGIN 32'h00007F34
`define LED_END 32'h00007F37
`define DIGIT_BEGIN 32'h00007F38
`define DIGIT_END 32'h00007F3F
`define BUTTON_BEGIN 32'h00007F40
`define BUTTON_END 32'h00007F43
//CP0
`define NYZ_ID 32'h00699294
`define SR_CODE 5'b01100
`define CAUSE_CODE 5'b01101
`define EPC_CODE 5'b01110
`define PRID_CODE 5'b01111
`define INT 5'b00000
`define ADEL 5'b00100
`define ADES 5'b00101
`define RI 5'b01010
`define OV 5'b01100
`define BEGIN 2'b01
`define END 2'b10
`define NORMAL 2'b00
`define NO_EXC 5'b11111