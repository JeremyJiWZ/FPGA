`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:21:41 09/04/2015
// Design Name:   MIO_BUS
// Module Name:   D:/3130100658/poroject4/forBUS.v
// Project Name:  project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MIO_BUS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module forBUS;

	// Inputs
	reg clk;
	reg rst;
	reg mem_w;
	reg counter0_out;
	reg counter1_out;
	reg counter2_out;
	reg [3:0] BTN;
	reg [7:0] SW;
	reg [7:0] led_out;
	reg [31:0] Cpu_data2bus;
	reg [31:0] ram_data_out;
	reg [31:0] addr_bus;
	reg [31:0] counter_out;
	reg ps2_ready;
	reg [7:0] ps2_data;
	reg vga_rdn;
	reg [9:0] vx;
	reg [9:0] vy;

	// Outputs
	wire data_ram_we;
	wire GPIOf0000000_we;
	wire GPIOe0000000_we;
	wire counter_we;
	wire vram_we;
	wire [11:0] ram_addr;
	wire [31:0] Cpu_data4bus;
	wire [31:0] ram_data_in;
	wire [31:0] Peripheral_in;
	wire [14:0] vram_addr;
	wire [7:0] vram_data_in;
	wire ps2_rdn;

	// Instantiate the Unit Under Test (UUT)
	MIO_BUS uut (
		.clk(clk), 
		.rst(rst), 
		.mem_w(mem_w), 
		.counter0_out(counter0_out), 
		.counter1_out(counter1_out), 
		.counter2_out(counter2_out), 
		.BTN(BTN), 
		.SW(SW), 
		.led_out(led_out), 
		.Cpu_data2bus(Cpu_data2bus), 
		.ram_data_out(ram_data_out), 
		.addr_bus(addr_bus), 
		.counter_out(counter_out), 
		.ps2_ready(ps2_ready), 
		.ps2_data(ps2_data), 
		.vga_rdn(vga_rdn), 
		.vx(vx), 
		.vy(vy), 
		.data_ram_we(data_ram_we), 
		.GPIOf0000000_we(GPIOf0000000_we), 
		.GPIOe0000000_we(GPIOe0000000_we), 
		.counter_we(counter_we), 
		.vram_we(vram_we), 
		.ram_addr(ram_addr), 
		.Cpu_data4bus(Cpu_data4bus), 
		.ram_data_in(ram_data_in), 
		.Peripheral_in(Peripheral_in), 
		.vram_addr(vram_addr), 
		.vram_data_in(vram_data_in), 
		.ps2_rdn(ps2_rdn)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		mem_w = 0;
		counter0_out = 0;
		counter1_out = 0;
		counter2_out = 0;
		BTN = 0;
		SW = 0;
		led_out = 0;
		Cpu_data2bus = 0;
		ram_data_out = 0;
		addr_bus = 0;
		counter_out = 0;
		ps2_ready = 0;
		ps2_data = 0;
		vga_rdn = 0;
		vx = 0;
		vy = 0;

		// Wait 100 ns for global reset to finish
		#100;
      ps2_ready = 1;
		ps2_data = 8'h1b;
		#100;
		// Add stimulus here
		addr_bus = 32'hd0000000;
		#10;
		ps2_data = 0;

	end
	always begin
		clk=~clk;
		#10;
	end
      
endmodule

