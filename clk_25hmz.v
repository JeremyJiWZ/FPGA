`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:16:56 08/27/2015 
// Design Name: 
// Module Name:    clk_25mhz 
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
module clk_25mhz(input clk_50mhz, output reg clk_25mhz);
reg cnt;
always@(posedge clk_50mhz) begin
	cnt=~cnt;
	if (cnt)
		clk_25mhz=~clk_25mhz;
end
endmodule
