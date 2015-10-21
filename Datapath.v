`timescale 1ns / 1ps

module Datapath( input clk,
                 input rst,
					  input [1:0]PCSource,
					  input lorD,
					  input [2:0]ALU_Control,
					  input ALUSrcA,
					  input RegWrite,
					  input [1:0]RegDst,
					  input IRWrite,
					  input [31:0]Data_in,
					  input [1:0]MemtoReg,
					  input MIO_ready,
					  input [1:0]ALUSrcB,
					  
					  input PCWrite,
					  input PCWriteCond,
					  input Branch,
					  input S,
					  
					  output [31:0]PC_Current,
					  output [31:0]M_addr,
					  output [31:0]Data_out,
					  
					  output overflow,
					  output zero,
					  output [31:0]inst
					  
    );
wire [31:0]A;
wire [31:0]B;
wire [31:0]res;
//U1
wire [4:0]Wt_addr;
wire [31:0]Wt_data;
wire [31:0]rdata_A;
//U2
wire [31:0]IR;
//IR
wire [31:0]MDR;
//MDR
wire CE;
wire [31:0]D;
//PC
wire [31:0]ALUOut;
//ALUOut
wire [31:0]lui;
//MUX2
wire [31:0]Imm_32;
//Ext_32
wire [31:0]Imm_32_2;
//MUX4
wire [31:0]Jump_addr;
//MUX5
wire [31:0]PC_CurrentOrSrl;
assign CE=MIO_ready&&(PCWrite||(PCWriteCond&&(Branch^zero)));   
assign lui={IR[15:0],16'h0000};
assign Imm_32_2=Imm_32<<2;
assign Jump_addr={PC_Current[31:28],IR[25:0],2'b00};
assign inst=IR;
assign PC_CurrentOrSrl = S?{27'h0000000,IR[10:6]}:PC_Current;
ALU U1(.A(A[31:0]),
       .B(B[31:0]),
		 .ALU_operation(ALU_Control),
		 .zero(zero),
		 .res(res[31:0]),
		 .overflow(overflow));
Regs U2(.clk(clk),
        .rst(rst),
		  .R_addr_A(IR[25:21]),
		  .R_addr_B(IR[20:16]),
		  .Wt_addr(Wt_addr[4:0]),
		  .Wt_data(Wt_data[31:0]),
		  .L_S(RegWrite),
		  .rdata_A(rdata_A[31:0]),
		  .rdata_B(Data_out[31:0]));
REG32 U3(.clk(clk),
         .rst(0),
			.CE(IRWrite),
			.D(Data_in[31:0]),
			.Q(IR[31:0]));
REG32 U4(.clk(clk),
          .rst(0),
			 .CE(1),
			 .D(Data_in[31:0]),
			 .Q(MDR[31:0]));
REG32 U5(.clk(clk),
         .rst(rst),
			.CE(CE),
			.D(D[31:0]),
			.Q(PC_Current[31:0]));
REG32 U6(.clk(clk),
             .rst(0),
			    .CE(1),
			    .D(res[31:0]),
		       .Q(ALUOut[31:0]));
mux4to1_5 MUX1(.sel(RegDst[1:0]),
               .a(IR[20:16]),
					.b(IR[15:11]),
					.c(5'b11111),
					.d(0),
					.o(Wt_addr[4:0]));
mux4to1_32 MUX2(.sel(MemtoReg[1:0]),
                .a(ALUOut[31:0]),
					 .b(MDR[31:0]),
					 .c(lui[31:0]),
					 .d(PC_Current[31:0]),
					 .o(Wt_data[31:0]));
Ext_32 Ext_32(.imm_16(IR[15:0]),
              .Imm_32(Imm_32[31:0]));
mux2to1_32 MUX3(.sel(ALUSrcA),
                .a(rdata_A[31:0]),
					 .b(PC_CurrentOrSrl[31:0]),
					 .o(A[31:0]));
mux4to1_32 MUX4(.sel(ALUSrcB[1:0]),
                .a(Data_out[31:0]),
					 .b(4),
					 .c(Imm_32[31:0]),
					 .d(Imm_32_2[31:0]),
					 .o(B[31:0]));
mux4to1_32 MUX5(.sel(PCSource[1:0]),
                .a(res[31:0]),
					 .b(ALUOut[31:0]),
					 .c(Jump_addr[31:0]),
					 .d(A[31:0]),
					 .o(D[31:0]));
mux2to1_32 MUX6(.sel(lorD),
                .a(ALUOut[31:0]),
					 .b(PC_Current[31:0]),
					 .o(M_addr[31:0]));



endmodule
