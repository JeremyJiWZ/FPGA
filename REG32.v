`timescale 1ns / 1ps
module REG32(input clk,input rst,input CE,input [31:0]D,output [31:0]Q
    );
reg [31:0]REG;
assign Q = REG;
always @(posedge clk or posedge rst) 
	 begin if(rst==1) REG<=0;
	       else if(CE==1) REG<=D;
	 end


endmodule
