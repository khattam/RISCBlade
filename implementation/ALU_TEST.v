`timescale 1ns/1ps

module ALU_TEST;
	reg [15:0] SRCA_TEST; 
	reg [15:0] SRCB_TEST; 
	reg OP_TEST; 
	wire [15:0] OUT_TEST;
	wire ZERO_TEST;
	
	ALU uut(SRCA_TEST, SRCB_TEST, OP_TEST, OUT_TEST, ZERO_TEST);
	
	initial begin
		SRCA_TEST = 5; SRCB_TEST = 5; OP_TEST = 0; #10; //+, + and + OUT NZ
		SRCA_TEST = 5; SRCB_TEST = -3; OP_TEST = 0; #10; //+, + and - OUT NZ
		SRCA_TEST = -5; SRCB_TEST = -3; OP_TEST = 0; #10; //+, - and - OUT NZ
		SRCA_TEST = 5; SRCB_TEST = -4; OP_TEST = 1; #10; //-, + and + OUT NZ
		SRCA_TEST = 5; SRCB_TEST = -3; OP_TEST = 1; #10; // -, + and - OUT NZ
		SRCA_TEST = -5; SRCB_TEST = -3; OP_TEST = 0; #10; //-, - and - OUT NZ
		SRCA_TEST = 5; SRCB_TEST = -5; OP_TEST = 0; #10; //+, + and -, OUT Z
		SRCA_TEST = 5; SRCB_TEST = 5; OP_TEST = 1; #10; //-, + and +, OUT Z
		$stop;
	end
endmodule
