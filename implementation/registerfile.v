`timescale 1ns/1ps

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

	reg [15:0] RF [0:15];
	
	always begin
		REG_A <= RF[RS1];
		REG_B <= RF[RS2];
		@(posedge CLK) if (REGWRITE) RF[RD] <= REGDATA;
	end

endmodule
