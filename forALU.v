`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:40:43 08/25/2015
// Design Name:   ALU
// Module Name:   D:/3130100658/poroject4/forALU.v
// Project Name:  project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module forALU;

	// Inputs
	reg [2:0] ALU_operation;
	reg [31:0] A;
	reg [31:0] B;

	// Outputs
	wire [31:0] res;
	wire zero;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.ALU_operation(ALU_operation), 
		.A(A), 
		.B(B), 
		.res(res), 
		.zero(zero), 
		.overflow(overflow)
	);

	initial begin
		// Initialize Inputs
		ALU_operation = 0;
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A=6;
		B=4;
		ALU_operation=7;
		#100;
		A=4;
		B=6;
		#100;
		A=32'hfffffff0;
		B=0;
		#100;
		A=64;
		B=576;
		#100;
		A=576;
		B=64;
		#100;
		A=0;//down
		B=416;
		#100;
		A=16;
		#100;
		A=32;
		#100;
		A=16;//right
		B=576;
		#100;
	end
      
endmodule

