
module PC_MEM_TEST;
reg CLOCK;
reg RST_TEST;
reg PC_EN;
reg [15:0] PC_IN;
wire [15:0] PC_OUT;
reg [15:0] MEM_ADDR_TEST;
wire [15:0] MEM_OUT_TEST;
reg [15:0] MEM_DATA_TEST;
reg MEMWRITE_TEST;


ProgramCounter uut1(CLOCK, RST, PC_IN, PC_EN, PC_OUT);
MEMORY uut2(MEM_ADDR_TEST, MEM_DATA_TEST, MEMWRITE_TEST, CLOCK, RST_TEST, MEM_OUT_TEST);

initial begin 
	CLOCK = 0;
	forever begin
		#10; CLOCK = ~CLOCK;
	end
end


//tests

