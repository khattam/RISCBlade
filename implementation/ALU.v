
module ALU(
input [15:0] SRCA, input [15:0] SRCB, input ALUOP,
output reg [15:0] ALUOUT, output ZERO
);

	assign ZERO = (ALUOUT == 0);
	always @(ALUOP, SRCA, SRCB) begin
		case (ALUOP)
			0: ALUOUT <= SRCA + SRCB;
			1: ALUOUT <= SRCA - SRCB;
			default: ALUOUT <= 0;	
		endcase
	end
endmodule
			

