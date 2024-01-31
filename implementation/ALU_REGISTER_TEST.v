
module ALU_REGISTER_TEST;
reg CLOCK;
reg [3:0] REGADDR1;
reg [3:0] REGADDR2;
reg [3:0] REGDEST;
reg [15:0] REGDATA_TEST;
reg REGWRITE_TEST;
wire [15:0] REGOUT_A;
wire [15:0] REGOUT_B;

reg [15:0] SRCA;
reg [15:0] SRCB;
reg ALUOP_TEST;
wire ZERO_FLAG; 
wire [15:0] ALUOUT;

ALU uut1(SRCA, SRCB, ALUOP_TEST, ALUOUT_TEST, ZERO_FLAG);
registerfile uut2(REGADDR1, REGADDR2, REGDEST, REGDATA_TEST, REGWRITE_TEST, CLOCK, REGOUT_A, REGOUT_B);


initial begin
	CLOCK = 0;
	forever begin
		#10; CLOCK = ~CLOCK;
	end
end

//tests go here