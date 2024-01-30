`timescale 1ns/1ps

module MEM_TEST;
	reg [15:0] ADDR_TEST;
	reg [15:0] DATA_TEST;
	reg WRITE_TEST;
	reg CLK_TEST;
	reg RST_TEST;
	wire [15:0] MEMOUT_TEST;

	MEMORY uut(ADDR_TEST, DATA_TEST, WRITE_TEST, CLK_TEST, RST_TEST, MEMOUT_TEST);
	
	//clock setup
	initial begin
		CLK_TEST = 0;
		forever begin
			#10 CLK_TEST = ~CLK_TEST;
		end
	end
	
	//tests
	initial begin
		RST_TEST = 0;
		ADDR_TEST = 300; DATA_TEST = 300; WRITE_TEST = 1; #10;
		RST_TEST = 1;
		ADDR_TEST = 300; DATA_TEST = 300; WRITE_TEST = 1; #10;
		ADDR_TEST = 300; DATA_TEST = 1; WRITE_TEST = 0; #10;
		ADDR_TEST = 299; DATA_TEST = 1; WRITE_TEST = 1; #10;
		ADDR_TEST = 300; DATA_TEST = 1; WRITE_TEST = 0; #10;
		$stop;
	end
endmodule
		


