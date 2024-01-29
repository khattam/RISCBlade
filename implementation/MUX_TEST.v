`timescale 1ns/1ps

module MUX_TEST;
	reg [15:0] A_TEST
	reg [15:0] B_TEST
	reg select_TEST
	wire [15:0] OUT_TEST
	MUX uut(A_TEST, B_TEST, select_TEST, OUT_TEST);
	
	initial begin
	A_TEST = 11111; B_TEST = 00000; select_test = 0; #10;
	A_TEST = 11111; B_TEST = 00000; select_test = 1; #10;