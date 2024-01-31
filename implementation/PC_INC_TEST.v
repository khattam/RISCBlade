
module PC_INC_TEST;
reg SRCA_TEST;
reg SRCB_TEST;
reg ALU
reg PC_IN_TEST;
reg CLOCK;
reg PC_RESET;
reg PC_EN;
wire ALU_ZERO_FLAG;
wire ALU_OUT_TEST;
wire PC_OUT_TEST;


ProgramCounter uut1(CLOCK, PC_RESET, PC_IN_TEST, PC_EN, PC_OUT_TEST);
ALU uut2(SRCA_TEST, SRCB_TEST, ALUOP, ALU_OUT_TEST, ALU_ZERO_TEST);

	initial begin
		CLOCK = 0;
		forever begin
			#10; CLOCK = ~CLOCK;
		end
	end
	
	//finish tests here
