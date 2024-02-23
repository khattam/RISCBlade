`timescale 1ns/1ps

module ControlUnit_TEST;
	reg [3:0]	op_TEST;
	reg	 		CLK;
	reg	 		reset_TEST;
	wire 			BranchOut_TEST;
	wire 			PCReset_TEST;
	wire 			IorD_TEST;
	wire 			MemWrite_TEST;
	wire 			IR_EN_TEST;
	wire 			RegDataSel_TEST;
	wire 			RegWrite_TEST;
	wire 			SRCA_TEST;
	wire [1:0]  SRCB_TEST;
	wire 			ALUOp_TEST;
	ControlUnit uut(op_TEST, CLK, reset_TEST, 
						 BranchOut_TEST, PCReset_TEST, IorD_TEST, MemWrite_TEST, IR_EN_TEST, DataSel_TEST, Write_TEST, SRCA_TEST, SRCB_TEST, ALUOp_TEST);
						 
	initial begin
		CLK = 0;
	end
	
	always begin
		#10 CLK = ~CLK;
	end
	
	initial begin
		reset_TEST = 1; #20; // Reset test
		reset_TEST = 0; 
		op_TEST = 4'b0000; #80; // add test
		op_TEST = 4'b1000; #80; // sub test
		op_TEST = 4'b0001; #100; // addi test
		op_TEST = 4'b1001; #100; // lw test
		op_TEST = 4'b0010; #80; // sw test 1
		op_TEST = 4'b1010; #80; // sw test 2
		op_TEST = 4'b0011; #60; // branch test 1
		op_TEST = 4'b1011; #60; // branch test 2
		op_TEST = 4'b0100; #80; // JAL test 1
		op_TEST = 4'b1100; #80; // JAL test 2
		$stop;
	end
endmodule







		
						 
