
module MUX(
	input [15:0] SRCA, input[15:0] SRCB, input select,
	output reg [15:0] Q
);


assign Q = (select == 0 ) ? SRCA : SRCB;

endmodule