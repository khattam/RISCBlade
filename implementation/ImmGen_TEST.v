`timescale 1ns/1ps

module ImmGen_TEST;
	reg [15:0] instruction_TEST;
	wire [15:0] immediate_TEST;
	ImmGen uut(instruction_TEST, immediate_TEST);
	
initial begin
	instruction_TEST = 16'b0001000000100000; #10; // add r2, r0, r1 	 (0)
	instruction_TEST = 16'b0011000100010001; #10; // addi r1, r1, 3 	 (3)
	instruction_TEST = 16'b1101000100010001; #10; // addi r1, r1, -3	 (-3)
	instruction_TEST = 16'b0111011001011001; #10; // lw x5, 7(x6)   	 (7)
	instruction_TEST = 16'b1001011001011001; #10; // lw x5, -7(x6)   	 (-7)
	instruction_TEST = 16'b0101011000010010; #10; // sw x5, 2(x6)   	 (2)
	instruction_TEST = 16'b0101011000011010; #10; // sw x5, 3(x6)   	 (3)
	instruction_TEST = 16'b0101011011010010; #10; // sw x5, -6(x6)   	 (-6)
	instruction_TEST = 16'b0101011011011010; #10; // sw x5, -5(x6)   	 (-5)
	instruction_TEST = 16'b0110010101100011; #10; // beq x5, x6, 6     (6)
	instruction_TEST = 16'b0110010110000011; #10; // beq x5, x6, -8    (-8)
	instruction_TEST = 16'b0110010101001011; #10; // bgt x5, x6, 4  	 (4)
	instruction_TEST = 16'b0110010111011011; #10; // bgt x5, x6, -3  	 (-3)
	instruction_TEST = 16'b0000000000011100; #10; // jal ra, -256	    (-256)
	instruction_TEST = 16'b1111111100010100; #10; // jal ra, 255	    (255)
	$stop;
	end
endmodule