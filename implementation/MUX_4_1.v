module MUX_4_1( 
input [15:0] A, input [15:0] B, input [15:0] C, 
input [1:0] sel, 
output reg [15:0] MUX_OUT);

always @(A,B,C,sel) begin
	case(sel)
		2'b00 : MUX_OUT <= A;
		2'b01 : MUX_OUT <= B;
		2'b10 : MUX_OUT <= C;
		default : MUX_OUT <= 0;
	endcase
end

endmodule

