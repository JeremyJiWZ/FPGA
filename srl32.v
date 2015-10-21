`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:34:30 04/10/2015 
// Design Name: 
// Module Name:    srl32 
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
module srl32(input [31:0]A,input [31:0]B,output [31:0]res
    );
assign res=B>>A;


endmodule
