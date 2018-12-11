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
`define ALU_data 2'b00
`define DM_data 2'b01
`define RA_data 2'b10
//RegDst
`define rd 2'b00
`define rt 2'b01
`define ra 2'b10
//DM definition
`define L_S_B 3'b000
`define L_S_H 3'b001
`define L_S_W 3'b010

`define L_S_BU 3'b100
`define L_S_HU 3'b101
//CMP definition
`define BEQ 2'b00
`define BLEZ 2'b01
