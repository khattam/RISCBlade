
module PC_INC_TEST;
reg [15:0] SRCA_TEST;
reg [15:0] SRCB_TEST;
reg ALU_OP
reg [15:0] PC_IN_TEST;
reg CLOCK;
reg PC_RESET;
reg PC_EN;
wire ALU_ZERO_FLAG;
wire [15:0] ALU_OUT_TEST;
wire [15:0] PC_OUT_TEST;

wire [15:0] connect;

//
//ProgramCounter uut1(CLOCK, PC_RESET, PC_IN_TEST, PC_EN, PC_OUT_TEST); //alternate module init
//
//
//
//ALU uut2(SRCA_TEST, SRCB_TEST, ALU_OP, ALU_OUT_TEST, ALU_ZERO_TEST);


ProgramCounter uut1(CLOCK, PC_RESET, connect, PC_EN, PC_OUT_TEST);



ALU uut2(SRCA_TEST, SRCB_TEST, ALU_OP, connect, ALU_ZERO_TEST);

	initial begin
		CLOCK = 0;
		forever begin
			#10; CLOCK = ~CLOCK;
		end
	end
	
	//finish tests here
