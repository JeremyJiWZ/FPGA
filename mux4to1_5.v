`timescale 1ns / 1ps
module mux4to1_5(input  [1:0]sel,input  [4:0]a, input  [4:0]b,input [4:0]c,input [4:0]d, output reg [4:0]o);

    always @(*) begin
       case (sel)
		    2'b00 : begin o <= a; end
			 2'b01 : begin o <= b; end
			 2'b10 : begin o <= c; end
			 2'b11 : begin o <= d; end
       endcase
    end

endmodule
