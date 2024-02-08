module MUX_4_1(
	input [15:0] A, input[15:0] B,input [15:0] C, input [15:0] D, input [1:0] select,
	output [15:0] MUX_OUT
);


assign MUX_OUT = (select == 'b00 ) ? A : (select == 'b01) ? B : (select == 'b10) ? C : (select == 'b11) ? D;

endmodule