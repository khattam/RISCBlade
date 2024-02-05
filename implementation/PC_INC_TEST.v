`timescale 1ns/1ps

module PC_INC_TEST();

reg [15:0] SRCB_TEST;
reg ALU_OP;
reg [15:0] PC_IN_TEST;
reg CLOCK;
reg PC_RESET;
reg PC_EN;
wire ALU_ZERO_FLAG;
wire [15:0] ALU_OUT_TEST;


wire [15:0] connect;

//
//ProgramCounter uut1(CLOCK, PC_RESET, PC_IN_TEST, PC_EN, PC_OUT_TEST); //alternate module init
//
//
//
//ALU uut2(SRCA_TEST, SRCB_TEST, ALU_OP, ALU_OUT_TEST, ALU_ZERO_TEST);


ProgramCounter pc_test (
        .clock(CLOCK), 
        .reset(PC_RESET), 
        .jump_addr(ALU_OUT_TEST), 
        .jump_en(PC_EN), 
        .pc(connect)
    );

ALU ALU_inst
(
	.SRCA(connect) ,	// input [15:0] SRCA_sig
	.SRCB(SRCB_TEST) ,	// input [15:0] SRCB_sig
	.ALUOP(ALU_OP) ,	// input  ALUOP_sig
	.ALUOUT(ALU_OUT_TEST) ,	// output [15:0] ALUOUT_sig
	.ZERO(ALU_ZERO_FLAG) 	// output  ZERO_sig
);


	initial begin
		CLOCK = 0;
	end
	
	
	always #10 CLOCK = ~CLOCK;
	//finish tests here
	
	
	initial begin
		PC_RESET = 1; #10;
		PC_RESET = 0; #10;
		ALU_OP = 0; SRCB_TEST = 2; PC_EN = 0; #10;
		#100;
		$stop;
	end
endmodule
