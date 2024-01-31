module registerfile(
    input [3:0]  RS1,
	 input [3:0]  RS2,
	 input [3:0]  RD,
	 input [15:0] REGDATA,
	 input		  REGWRITE,
	 input		  CLK,
    output reg [15:0] REG_A,
    output reg [15:0] REG_B
    );

	reg [15:0] RF [15:0];
	
	assign REG_A = RF[RS1];
	assign REG_B = RF[RS2];
	
	always begin
		@(posedge CLK) if (REGWRITE) RF[RD] <= REGWRITE;
	end

endmodule