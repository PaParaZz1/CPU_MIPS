`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:58 11/26/2017 
// Design Name: 
// Module Name:    decode 
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
module decode(
    input [31:0] instr,
    output [5:0] opcode,
    output [4:0] rd,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] shift,
    output [5:0] func,
    output [15:0] imm16,
    output [25:0] instr_index
    );
	 assign opcode=instr[31:26];
	 assign rs=instr[25:21];
	 assign rt=instr[20:16];
	 assign rd=instr[15:11];
	 assign shift=instr[10:6];
	 assign func=instr[5:0];
	 assign imm16=instr[15:0];
	 assign instr_index=instr[25:0];

endmodule
