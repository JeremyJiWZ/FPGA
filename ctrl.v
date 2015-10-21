`timescale 1ns / 1ps

module ctrl(input clk,
            input reset,
			   input zero,
			   input overflow,
			   input MIO_ready,
			   input [31:0]inst_in,
			   output reg MemRead,
		   	output reg MemWrite,
			   output reg CPU_MIO,
			   output reg lorD,
			   output reg IRWrite,
			   output reg RegWrite,
			   output reg ALUSrcA,
			   output reg PCWrite,
			   output reg PCWriteCond,
			   output reg Branch,
			   output reg [1:0]RegDst,
			   output reg [1:0]MemtoReg,
			   output reg [1:0]ALUSrcB,
			   output reg [1:0]PCSource,
			   output reg [2:0]ALU_operation,
				output reg S,
			   output [4:0]state_out);
				
reg [4:0]state;

parameter IF = 5'b00000, ID=5'b00001, EX_R= 5'b00010, EX_Mem=5'b00011, EX_I= 5'b00100,
Lui_WB=5'b00101, EX_beq=5'b00110, EX_bne= 5'b00111, EX_jr= 5'b01000, EX_JAL=5'b01001,
Exe_J= 5'b01010, MEM_RD=5'b01011, MEM_WD= 5'b01100, WB_R= 5'b01101, WB_I=5'b01110, WB_LW=5'b01111, Error=11111,
EX_jalr=5'b10000;
parameter AND=3'b000, OR=3'b001, ADD=3'b010, SUB=3'b110,
NOR=3'b100, SLT=3'b111, XOR=3'b011, SRL=3'b101;


`define CPU_ctrl_signals {S,PCWrite,PCWriteCond, lorD, MemRead, MemWrite,IRWrite, MemtoReg,PCSource, ALUSrcB,ALUSrcA,RegWrite,RegDst,CPU_MIO}

assign state_out=state;

always @ (posedge clk or posedge reset) begin
if (reset==1) begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF; end
else begin
case (state)
IF: begin
    if(MIO_ready) begin `CPU_ctrl_signals <=18'h00060; ALU_operation<=ADD; state <= ID; end
    else begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF; end
    end
ID: begin 
    case(inst_in[31:26])
        6'h00: begin
		  case (inst_in[5:0])
            6'b100000: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= ADD; state <= EX_R;end
            6'b100010: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= SUB; state <= EX_R;end
            6'b100100: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= AND; state <= EX_R;end
            6'b100101: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= OR; state <= EX_R;end
            6'b100110: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= XOR; state <= EX_R;end
            6'b100111: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= NOR; state <= EX_R;end
            6'b101010: begin `CPU_ctrl_signals <= 18'h00010; ALU_operation<= SLT; state <= EX_R;end
            6'b000010: begin `CPU_ctrl_signals <= 18'h20000; ALU_operation<= SRL; state <= EX_R;end
            6'b001000: begin `CPU_ctrl_signals <= 18'h10190; state <= EX_jr; end//Jr
            6'b001001: begin `CPU_ctrl_signals <= 18'h1079a; ALU_operation<=ADD; state <= EX_jalr; end//Jalr
				default: begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
		  endcase
		  end
	     6'h08: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=ADD; state<= EX_I;end  //addi
	     6'h0C: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=AND; state<= EX_I;end  //andi
	     6'h0D: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=OR; state<= EX_I;end   //ori
	     6'h0E: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=XOR; state<= EX_I;end  //xori
	     6'h0F: begin `CPU_ctrl_signals<=18'h00408;state<= Lui_WB;end  //lui
		  6'h23: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=ADD; state<=EX_Mem;end  //lw
		  6'h2b: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=ADD; state<=EX_Mem;end  //sw
		  6'h04: begin `CPU_ctrl_signals<=18'h0a090;ALU_operation<=SUB; state<=EX_beq;Branch<=1;end  //beq
	     6'h05: begin `CPU_ctrl_signals<=18'h0a090;ALU_operation<=XOR; state<=EX_bne;Branch<=0;end  //bne
		  6'h0a: begin `CPU_ctrl_signals<=18'h00050;ALU_operation<=SLT; state<= EX_I;end  //slti
		  6'h02: begin `CPU_ctrl_signals<=18'h10100;state<= Exe_J;end  //j
		  6'h03: begin `CPU_ctrl_signals<=18'h0060c;state<= EX_JAL;end  //jal
		  endcase
	 end
EX_R:begin `CPU_ctrl_signals<=18'h0000a;state <= WB_R; end
EX_I:begin `CPU_ctrl_signals<=18'h00008;state <= WB_I; end


EX_Mem:begin
    if(inst_in[31:26]==6'h23) begin `CPU_ctrl_signals<=18'h06000;state <= MEM_RD;end  //lw
	 else begin `CPU_ctrl_signals<=18'h05000;state <= MEM_WD;end //sw
end
MEM_RD:begin `CPU_ctrl_signals<=18'h00208;state <=WB_LW ;end //lw
EX_JAL:begin `CPU_ctrl_signals<=18'h10100;state<= Exe_J;end 
WB_R:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
WB_I:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
EX_jr:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
EX_jalr:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
Lui_WB:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
WB_LW:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end
MEM_WD:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end   //sw
EX_beq:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end   //beq
EX_bne:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end   //bne
Exe_J:begin `CPU_ctrl_signals<=18'h12821;ALU_operation<=ADD;state <= IF;end   //j  
endcase
end
end

endmodule




