`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:20:41 06/08/2015
// Design Name:   Muliti_CPU
// Module Name:   C:/Users/Apple/Desktop/Project3/project3.1/forMCPU.v
// Project Name:  project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Muliti_CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module forMCPU;

	// Inputs
	reg clk;
	reg reset;
	reg MIO_ready;
	reg [31:0] Data_in;
	reg INT;

	// Outputs
	wire [31:0] PC_out;
	wire [31:0] inst_out;
	wire mem_w;
	wire [31:0] Addr_out;
	wire [31:0] Data_out;
	wire CPU_MIO;
	wire [4:0] state;

	// Instantiate the Unit Under Test (UUT)
	Muliti_CPU uut (
		.clk(clk), 
		.reset(reset), 
		.MIO_ready(MIO_ready), 
		.PC_out(PC_out), 
		.inst_out(inst_out), 
		.mem_w(mem_w), 
		.Addr_out(Addr_out), 
		.Data_out(Data_out), 
		.Data_in(Data_in), 
		.CPU_MIO(CPU_MIO), 
		.INT(INT), 
		.state(state)
	);

initial begin
		clk = 1;
		reset = 0;
		Data_in = 0;
		MIO_ready = 0;
		INT = 0;
		#1;
		reset = 1;
		#1;
		reset = 0;
		#1;
		Data_in=32'b00001000000000000000000000000101; 
		//j next_pc=14
		repeat(3) begin
		#1;
		clk=1;
		#1;	
		clk = 0;
		end
		Data_in=32'b00001100000000000000000000000101;
		//jal next_pc=14
		repeat(4) begin
		#1;
		clk=1;
		#1;	
		clk = 0;
		end
		Data_in=32'b00000011111000000000000000001000;
		//jr $ra;  //next_pc=24
		repeat(3) begin
		#1;
		clk=1;
		#1;	
		clk = 0;
		end
		Data_in=32'b00000011111000000100100000001001;
		//jalr $ra,$t1;  //next_pc=24,$t1=28
		repeat(3) begin
		#1;
		clk=1;
		#1;	
		clk = 0;
		end
		Data_in=32'b00000001001000000000000000001000;
		//jr $t1;  //next_pc=28
		repeat(4) begin
		#1;
		clk=1;
		#1;	
		clk = 0;
		end 
end

  
endmodule

