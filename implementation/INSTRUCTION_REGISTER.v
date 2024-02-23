module INSTRUCTION_REGISTER(
    input clock,
		 input [15:0] INST_IN,
		 input IREN,
		 output reg [15:0] INST_OUT
);

    always @(posedge clock) begin
        if (IREN) begin
            INST_OUT <= INST_IN; // Jump to specific address
        end
    end
endmodule
