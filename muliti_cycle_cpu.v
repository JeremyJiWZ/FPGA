`timescale 1ns / 1ps
module Muliti_CPU(input clk,							//muliti_CPU
						input reset,
						input MIO_ready,
								
						output[31:0] PC_out,		   	//TEST
						output[31:0] inst_out,			//TEST
						output mem_w,
						output[31:0] Addr_out,
						output[31:0] Data_out, 
						input [31:0] Data_in,
						output CPU_MIO,
						input INT,
						output[4:0]state					//Test
					  );
wire zero,overflow,MemRead,MemWrite;
wire lorD,IRWrite,RegWrite,ALUSrcA,PCWrite,PCWriteCond,Branch;
wire [1:0]RegDst;
wire [1:0]MemtoReg;
wire [1:0]ALUSrcB;
wire [1:0]PCSource;
wire [2:0]ALU_operation;
wire S;

assign mem_w=(~MemRead)&MemWrite;

ctrl U11(.clk(clk),
         .reset(reset),
			.zero(zero),
			.overflow(overflow),
			.MIO_ready(MIO_ready),
			.inst_in(inst_out[31:0]),
			.MemRead(MemRead),
			.MemWrite(MemWrite),
			.CPU_MIO(CPU_MIO),
			.lorD(lorD),
			.IRWrite(IRWrite),
			.RegWrite(RegWrite),
			.ALUSrcA(ALUSrcA),
			.PCWrite(PCWrite),
			.PCWriteCond(PCWriteCond),
			.Branch(Branch),
			.RegDst(RegDst[1:0]),
			.MemtoReg(MemtoReg[1:0]),
			.ALUSrcB(ALUSrcB[1:0]),
			.PCSource(PCSource[1:0]),
			.ALU_operation(ALU_operation[2:0]),
			.state_out(state[4:0]),
			.S(S));
Datapath U12(.clk(clk),
             .rst(reset),
				 .MIO_ready(MIO_ready),
				 .lorD(lorD),
				 .IRWrite(IRWrite),
				 .RegWrite(RegWrite),
			    .ALUSrcA(ALUSrcA),
			    .PCWrite(PCWrite),
		       .PCWriteCond(PCWriteCond),
			    .Branch(Branch),
			    .RegDst(RegDst[1:0]),
			    .MemtoReg(MemtoReg[1:0]),
			    .ALUSrcB(ALUSrcB[1:0]),
			    .PCSource(PCSource[1:0]),
			    .ALU_Control(ALU_operation[2:0]),
				 .Data_in(Data_in[31:0]),
				 .zero(zero),
				 .overflow(overflow),
				 .PC_Current(PC_out[31:0]),
				 .inst(inst_out[31:0]),
				 .Data_out(Data_out[31:0]),
				 .S(S),
				 .M_addr(Addr_out[31:0]));
endmodule




