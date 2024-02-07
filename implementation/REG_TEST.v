`timescale 1ns/1ps

module REG_TEST;
reg [3:0] INPUT_ADDR_A;
reg [3:0] INPUT_ADDR_B;
reg [3:0] DEST_REG;
reg REGWRITE_TEST;
reg [15:0] REG_DATA;
reg CLOCK;
wire [15:0] REG_A_T;
wire [15:0] REG_B_T;


registerfile registerfile_inst
(
	.RS1(INPUT_ADDR_A) ,	// input [3:0] RS1_sig
	.RS2(INPUT_ADDR_B) ,	// input [3:0] RS2_sig
	.RD(DEST_REG) ,	// input [3:0] RD_sig
	.REGDATA(REG_DATA) ,	// input [15:0] REGDATA_sig
	.REGWRITE(REGWRITE_TEST) ,	// input  REGWRITE_sig
	.CLK(CLOCK) ,	// input  CLK_sig
	.REG_A(REG_A_T) ,	// output [15:0] REG_A_sig
	.REG_B(REG_B_T) 	// output [15:0] REG_B_sig
);


initial begin
	CLOCK = 0;
end

always #5 CLOCK = ~CLOCK;


initial begin

INPUT_ADDR_A = 8; INPUT_ADDR_B = 0;  DEST_REG = 1; REGWRITE_TEST = 1; REG_DATA = 50; #10
INPUT_ADDR_A = 8; INPUT_ADDR_B = 0;  DEST_REG = 1; REGWRITE_TEST = 0; REG_DATA = 50; #10
INPUT_ADDR_A = 1; INPUT_ADDR_B = 0;  DEST_REG = 0; REGWRITE_TEST = 1; REG_DATA = 75; #10
INPUT_ADDR_A = 1; INPUT_ADDR_B = 0;  DEST_REG = 0; REGWRITE_TEST = 0; REG_DATA = 75; #10
$stop;
end
endmodule


