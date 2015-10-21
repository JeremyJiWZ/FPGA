`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:44:27 06/08/2015
// Design Name:   REG32
// Module Name:   C:/Users/Apple/Desktop/Project3/project3.1/forREG.v
// Project Name:  project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: REG32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module forREG;

	// Inputs
	reg clk;
	reg rst;
	reg CE;
	reg [31:0] D;

	// Outputs
	wire [31:0] Q;

	// Instantiate the Unit Under Test (UUT)
	REG32 uut (
		.clk(clk), 
		.rst(rst), 
		.CE(CE), 
		.D(D), 
		.Q(Q)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		CE = 0;
		D = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst=1;
		#100;
		rst=0;
		#100;
      D=1;
		CE=1;
		#100;
		clk=1;
		// Add stimulus here

	end
      
endmodule

