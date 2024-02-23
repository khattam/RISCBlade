module GENERIC_REGISTER(
    input clock,
		 input [15:0] REG_IN,
		 output reg [15:0] REG_OUT
);

    always @(posedge clock) begin
            REG_OUT <= REG_IN; // Jump to specific address
    end
endmodule