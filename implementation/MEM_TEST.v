`timescale 1ns/1ps

module MEM_TEST;
	reg [15:0] ADDR_TEST;
	reg [15:0] DATA_TEST;
	reg WRITE_TEST;
	wire [15:0] MEMOUT_TEST;

	MEMORY uut(ADDR_TEST, DATA_TEST, WRITE_TEST, MEMOUT_TEST);
	
	initial begin
		ADDR_TEST = 40000; DATA_TEST = 40000; WRITE_TEST = 1; #10;
		ADDR_TEST = 40000; DATA_TEST = 1; WRITE_TEST = 0; #10;
		$stop;
	end
endmodule
		


