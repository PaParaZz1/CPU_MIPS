`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:32:34 12/29/2017 
// Design Name: 
// Module Name:    system 
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
    input clk_in,
    input sys_rstn,
	 input [7:0] user_key,
	 input [7:0] dip_switch0,
	 input [7:0] dip_switch1,
	 input [7:0] dip_switch2,
	 input [7:0] dip_switch3,
	 input [7:0] dip_switch4,
	 input [7:0] dip_switch5,
	 input [7:0] dip_switch6,
	 input [7:0] dip_switch7,
	 input uart_rxd,
	 output uart_txd,
	 output [31:0] led_light,
	 output [7:0] digital_tube0,
	 output [3:0] digital_tube_sel0,
	 output [7:0] digital_tube1,
	 output [3:0] digital_tube_sel1,
	 output [7:0] digital_tube2,
	 //input a,
	 output digital_tube_sel2
	 
    );
	 wire [31:0] PrRD,PrWD,DEV_WD,DEV_RD1,DEV_RD2,DEV_RD3,DEV_RD4,DEV_RD5,DEV_RD6;
	 wire [31:0] PrAddr;
	 wire [7:2] HWInt;
	 wire [3:0] PrBE;
	 wire [4:2] DEV_ADDR;
	 wire PrWe,DEV_WE1,DEV_WE2,DEV_WE4,DEV_WE5,clk_out1,clk_out2;
	 assign HWInt[7:4]=0;
	 //assign HWInt[3]=a;
	 IP clk_uut(
		.CLK_IN1(clk_in),
		.CLK_OUT1(clk_out1),
		.CLK_OUT2(clk_out2)
	   );
	 cpu cpu_uut(
		.clk(clk_out1),
		.clk2(clk_out2),
		.reset(sys_rstn),
		.PrRD(PrRD),
		.PrWD(PrWD),
		.HWInt(HWInt),
		.PrAddr(PrAddr),
		.PrWe(PrWe)
		);
	 bridge bridge_uut(
	   .PrWD(PrWD),
		.PrAddr(PrAddr),
		.PrWe(PrWe),
		.PrRD(PrRD),
		.DEV_RD1(DEV_RD1),
		.DEV_RD2(DEV_RD2),
		.DEV_RD3(DEV_RD3),
		.DEV_RD4(DEV_RD4),
		.DEV_RD5(DEV_RD5),
		.DEV_RD6(DEV_RD6),
		.DEV_WE1(DEV_WE1),
		.DEV_WE2(DEV_WE2),
		.DEV_WE4(DEV_WE4),
		.DEV_WE5(DEV_WE5),
		.DEV_ADDR(DEV_ADDR),
		.DEV_WD(DEV_WD)
		);
	 timer timer_uut1(
		.clk(clk_out1),
		.reset(sys_rstn),
		.PrAddr(DEV_ADDR[3:2]),
		.Wr_en(DEV_WE1),
		.Data_in(DEV_WD),
		.IRQ(HWInt[2]),
		.Data_out(DEV_RD1)
		);
	 UseKeys usekeys_uut(
		.clk(clk_out1),
		.reset(sys_rstn),
		.use_keys(user_key),
		.data_out(DEV_RD6)
		);
	 switch switch_uut(
		.clk(clk_out1),
		.reset(sys_rstn),
		.ReadAddr(DEV_ADDR),
		.dip_switch7(dip_switch7),
		.dip_switch6(dip_switch6),
		.dip_switch5(dip_switch5),
		.dip_switch4(dip_switch4),
		.dip_switch3(dip_switch3),
		.dip_switch2(dip_switch2),
		.dip_switch1(dip_switch1),
		.dip_switch0(dip_switch0),
		.data_out(DEV_RD3)
		);
	 LED LED_uut(
		.clk(clk_out1),
		.reset(sys_rstn),
		.enable(DEV_WE4),
		.data_in(DEV_WD),
		.led_lights(led_light),
		.data_return_cpu(DEV_RD4)
		);
	 digital digital_uut(
		.clk(clk_out1),
		.reset(sys_rstn),
		.data_in(DEV_WD),
		.Addr(DEV_ADDR),
		.enable(DEV_WE5),
		.data_return_cpu(DEV_RD5),
		.sel0(digital_tube_sel0),
		.sel1(digital_tube_sel1),
		.sel2(digital_tube_sel2),
		.code0(digital_tube0),
		.code1(digital_tube1),
		.code2(digital_tube2)
		);
	wire stb;
	wire [4:2] uart_addr;
	assign stb=1;
	assign uart_addr=DEV_ADDR-3'b100;
	MiniUART uart_uut(
		.CLK_I(clk_out1),
		.RST_I(sys_rstn),
		.RxD(uart_rxd),
		.TxD(uart_txd),
		.STB_I(stb),
		.DAT_I(DEV_WD),
		.DAT_O(DEV_RD2),
		.ADD_I(uart_addr),
		.IRQ(HWInt[3]),
		.WE_I(DEV_WE2)
		
	);


endmodule
