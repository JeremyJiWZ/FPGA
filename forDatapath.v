`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:11:29 06/08/2015
// Design Name:   Datapath
// Module Name:   C:/Users/Apple/Desktop/Project3/project3.1/forDatapath.v
// Project Name:  project3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Datapath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module forDatapath;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] PCSource;
	reg lorD;
	reg [2:0] ALU_Control;
	reg ALUSrcA;
	reg RegWrite;
	reg [1:0] RegDst;
	reg IRWrite;
	reg [31:0] Data_in;
	reg [1:0] MemtoReg;
	reg MIO_ready;
	reg [1:0] ALUSrcB;
	reg PCWrite;
	reg PCWriteCond;
	reg Branch;
	reg S;

	// Outputs
	wire [31:0] PC_Current;
	wire [31:0] M_addr;
	wire [31:0] Data_out;
	wire overflow;
	wire zero;
	wire [31:0] inst;

	// Instantiate the Unit Under Test (UUT)
	Datapath uut (
		.clk(clk), 
		.rst(reset), 
		.PCSource(PCSource), 
		.lorD(lorD), 
		.ALU_Control(ALU_Control), 
		.ALUSrcA(ALUSrcA), 
		.RegWrite(RegWrite), 
		.RegDst(RegDst), 
		.IRWrite(IRWrite), 
		.Data_in(Data_in), 
		.MemtoReg(MemtoReg), 
		.MIO_ready(MIO_ready), 
		.ALUSrcB(ALUSrcB), 
		.PCWrite(PCWrite), 
		.PCWriteCond(PCWriteCond), 
		.Branch(Branch), 
		.S(S), 
		.PC_Current(PC_Current), 
		.M_addr(M_addr), 
		.Data_out(Data_out), 
		.overflow(overflow), 
		.zero(zero), 
		.inst(inst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		PCSource = 0;
		lorD = 0;
		ALU_Control = 0;
		ALUSrcA = 0;
		RegWrite = 0;
		RegDst = 0;
		IRWrite = 0;
		Data_in = 0;
		MemtoReg = 0;
		MIO_ready = 0;
		ALUSrcB = 0;
		PCWrite = 0;
		PCWriteCond = 0;
		Branch = 0;
		S = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=1;
		#100;
		reset=0;
		#100;
      Data_in=32'b00100000000010011111111111111111;
      //addi $t1,$zero,-1;  //$t1=ffffffff;
		#100;
		clk=1;
		#100;	
		IRWrite = 1'b1;
		PCWrite = 1'b1;
		ALUSrcB=2'b10;
		lorD = 1'b1;
		ALUSrcA=1;
		clk = 0;
		#100;
		clk=1;
		#100;	
		ALU_Control=3'b010;
		clk = 0;
		#100;
		clk=1;
		#100;	
		clk = 0;
		#100;
		clk=1;
		#100;	
		clk = 0;
		// Add stimulus here

	end
      
endmodule

