module FULL_INT_NO_CTRL;
//control signals
reg PCSel;
reg SRCASel;
reg [1:0] SRCBSel;
reg IorD;
reg ALUOP;
reg RegDataSel;
reg PC_RESET;
reg PC_EN;
reg MEMWRITE;
reg REGWRITE;
reg IREN;
//test inputs, since no imm gen yet
reg [15:0] IMMEDIATE;
reg [15:0] two; //hard coded 2, guess why its named that. why am i making this 16 bits? only god knows
//clock (is clock a control? surely not)
reg CLOCK;
//IR wires
wire [15:0] INST_OUT;
//generic register wires
wire [15:0] MDR_OUT;
wire [15:0] ALUOUT_REG;
wire [15:0] A_OUT;
wire [15:0] B_OUT;
//regfile wires
wire [15:0] RegA;
wire [15:0] RegB;
wire [15:0] RegData;
//memory wires
wire [15:0] mem_addr;
wire [15:0] mem_out;
wire [15:0] mem_data;
//alu wires
wire zero;
wire [15:0] ALUOut;
//pc wires
wire [15:0] PC_IN;
wire [15:0] PC_OUT;







//what follows sucks big time, but i dont think its possible to make it readable. at least, not without a few goats and an altar


ProgramCounter pc_test (
        .clock(CLOCK), 
        .reset(PC_RESET), 
        .jump_addr(PC_IN), 
        .jump_en(PC_EN), 
        .pc(PC_OUT)
    );
MUX PCSel
(
	.A(ALUOut) ,	// input [15:0] A_sig
	.B(ALUOUT_REG) ,	// input [15:0] B_sig
	.select(PCSel) ,	// input  select_sig
	.MUX_OUT(PC_IN) 	// output [15:0] MUX_OUT_sig
);

MUX SRCASel
(
	.A(PC_OUT) ,	// input [15:0] A_sig
	.B(A_OUT) ,	// input [15:0] B_sig
	.select(SRCASel) ,	// input  select_sig
	.MUX_OUT(SRCA) 	// output [15:0] MUX_OUT_sig
);
MUX_4_1 SRCBSel
(
	.A(B_OUT) ,	// input [15:0] A_sig
	.B(two) ,	// input [15:0] B_sig
	.C(IMMEDIATE);
	.D(IMMEDIATE); //if we somehow select this one something very wrong has happened. I'd like to leave it floating,
						//BUT i could also just stick the immediate here. whats the worst that could happen 
						
	.select(SRCBSel) ,	// input  select_sig
	.MUX_OUT(SRCB) 	// output [15:0] MUX_OUT_sig
);
MUX IorD
(
	.A(PC_OUT) ,	// input [15:0] A_sig
	.B(ALUOut) ,	// input [15:0] B_sig
	.select(IorD) ,	// input  select_sig
	.MUX_OUT(mem_addr) 	// output [15:0] MUX_OUT_sig
);
MUX RegDataSel
(
	.A(MDR_OUT) ,	// input [15:0] A_sig
	.B(ALUOUT_REG) ,	// input [15:0] B_sig
	.select(RegDataSel) ,	// input  select_sig
	.MUX_OUT(RegData) 	// output [15:0] MUX_OUT_sig
);
INSTRUCTION_REGISTER INSTRUCTION_REGISTER_inst
(
	.clock(CLOCK) ,	// input  clock_sig
	.INST_IN(mem_out) ,	// input [15:0] INST_IN_sig
	.IREN(IREN) ,	// input  IREN_sig
	.INST_OUT(INST_OUT) 	// output [15:0] INST_OUT_sig
);
GENERIC_REGISTER MDR
(
	.clock(CLOCK) ,	// input  clock_sig
	.REG_IN(mem_out) ,	// input [15:0] REG_IN_sig
	.REG_OUT(MDR_OUT) 	// output [15:0] REG_OUT_sig
);
GENERIC_REGISTER A
(
	.clock(CLOCK) ,	// input  clock_sig
	.REG_IN(RegA) ,	// input [15:0] REG_IN_sig
	.REG_OUT(A_OUT) 	// output [15:0] REG_OUT_sig
);
GENERIC_REGISTER B
(
	.clock(CLOCK) ,	// input  clock_sig
	.REG_IN(RegB) ,	// input [15:0] REG_IN_sig
	.REG_OUT(B_OUT) 	// output [15:0] REG_OUT_sig
);
GENERIC_REGISTER ALUOUTREG
(
	.clock(CLOCK) ,	// input  clock_sig
	.REG_IN(ALUOut) ,	// input [15:0] REG_IN_sig
	.REG_OUT(ALUOUT_REG) 	// output [15:0] REG_OUT_sig
);
ALU ALU_inst
(
	.SRCA(SRCA) ,	// input [15:0] SRCA_sig
	.SRCB(SRCB) ,	// input [15:0] SRCB_sig
	.ALUOP(ALU_OP) ,	// input  ALUOP_sig
	.ALUOUT(ALUOut) ,	// output [15:0] ALUOUT_sig
	.ZERO(ALU_ZERO_FLAG) 	// output  ZERO_sig
);
registerfile registerfile_inst
(
	.RS1(INST_OUT[11:8]) ,	// input [3:0] RS1_sig
	.RS2(INST_OUT[15:12]) ,	// input [3:0] RS2_sig
	.RD(INST_OUT[7:4]) ,	// input [3:0] RD_sig
	.REGDATA(RegData) ,	// input [15:0] REGDATA_sig
	.REGWRITE(REGWRITE) ,	// input  REGWRITE_sig
	.CLK(CLOCK) ,	// input  CLK_sig
	.REG_A(RegA) ,	// output [15:0] REG_A_sig
	.REG_B(RegB) 	// output [15:0] REG_B_sig
);
MEMORY MEMORY_inst
(
	.MEM_ADDRESS(mem_addr) ,	// input [15:0] MEM_ADDRESS_sig
	.MEM_DATA(RegB) ,	// input [15:0] MEM_DATA_sig
	.MEMWRITE(MEMWRITE) ,	// input  MEMWRITE_sig
	.CLK(CLOCK) ,	// input  CLK_sig
	.MEM_OUT(mem_out) 	// output [15:0] MEM_OUT_sig
);




//i cant do this by myself man
initial begin
	CLOCK = 0;
	two = 2;
end

always #5 CLOCK = ~CLOCK;

initial begin
	
	$stop;
end
endmodule
	




