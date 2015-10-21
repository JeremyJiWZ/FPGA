`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:11:18 09/02/2015
// Design Name:   Top
// Module Name:   D:/3130100658/poroject4/testfortop.v
// Project Name:  project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testfortop;

	// Inputs
	reg [3:0] BTN;
	reg [7:0] SW;
	reg clk_50mhz;
	reg PS2_Data;
	reg PS2_clk;

	// Outputs
	wire [3:0] AN;
	wire [7:0] SEGMENT;
	wire [7:0] LED;
	wire [2:0] Red;
	wire [2:0] Green;
	wire [1:0] Blue;
	wire vsync;
	wire hsync;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.BTN(BTN), 
		.SW(SW), 
		.clk_50mhz(clk_50mhz), 
		.PS2_Data(PS2_Data), 
		.PS2_clk(PS2_clk), 
		.AN(AN), 
		.SEGMENT(SEGMENT), 
		.LED(LED), 
		.Red(Red), 
		.Green(Green), 
		.Blue(Blue), 
		.vsync(vsync), 
		.hsync(hsync)
	);

	initial begin
		// Initialize Inputs
		BTN = 0;
		SW = 0;
		clk_50mhz = 0;
		PS2_Data = 0;
		PS2_clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
      
		// Add stimulus here

	end
	always begin
		clk_50mhz=~clk_50mhz;
		#10;
	end
      
endmodule

