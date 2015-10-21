`timescale 1ns / 1ps
module mux2to1_32(input  sel,input  [31:0]a, input  [31:0]b, output reg [31:0]o);

    always @(*) begin
       case (sel)
		    1'b0 : begin o <= b; end
			 1'b1 : begin o <= a; end
       endcase
    end

endmodule
