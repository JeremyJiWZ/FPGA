`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:00 04/10/2015 
// Design Name: 
// Module Name:    ADC32 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ADC32(input [31:0]A,input [31:0]B,input C0,output [32:0]S
    );
	assign B0=C0^1'b0;
	assign S={1'b0,A}+{B0,B}+C0;

endmodule

