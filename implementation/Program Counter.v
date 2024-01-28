module ProgramCounter(
    input clock,
    input reset,
		 input [15:0] jump_addr,
		 input jump_en,
		 output reg [15:0] pc
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            pc <= 0; // Reset PC to 0
        end
        else if (jump_en) begin
            pc <= jump_addr; // Jump to specific address
        end
        else begin
            pc <= pc + 2; // Increment PC by 2
        end
    end
endmodule
