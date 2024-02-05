
module MUX(
	input [15:0] A, input[15:0] B, input select,
	output [15:0] MUX_OUT
);


assign MUX_OUT = (select == 0 ) ? A : B;

endmodule