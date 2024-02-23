`timescale 1ns/1ps

module FINAL_PROCESSOR;
//controls 
wire ALUOP;
wire PC_EN;
wire iord;
wire memwrite;
wire regwrite;
wire RegDataSel;
wire [1:0] SRCB_SEL;
wire SRCA_SEL;
wire IREN;
wire branch;

//wires
wire [15:0] mem_out;
wire [15:0] mem_addr;
wire [15:0] pc;
wire [15:0] alu_out;
wire [15:0] aluout_out;
wire [15:0] src_b;
wire zero;
wire [15:0] src_a;
wire [15:0] regouta;
wire [15:0] regoutb;
wire [15:0] mdr_out;
wire [15:0] immediate;
wire [15:0] regdata;
wire [15:0] instruction;
//special snowflake how do i handle you
reg [15:0] PcIncInput; //its very funny that we need to use a 16bit bus for a hard coded 2
reg CLOCK;
reg RESET;

//instantiate 4:1 SRCB Multiplexer
MUX_4_1 MUX_4_1_inst
(
	.A(regoutb) ,	// input [15:0] A_sig
	.B(PcIncInput) ,	// input [15:0] B_sig
	.C(immediate) ,	// input [15:0] C_sig
	.sel(SRCB_SEL) ,	// input [1:0] sel_sig
	.MUX_OUT(src_b) 	// output [15:0] MUX_OUT_sig
);
//instantiate 2:1 SRCA multplexer
MUX SRCAMUX
(
	.A(pc) ,	// input [15:0] A_sig
	.B(regouta) ,	// input [15:0] B_sig
	.select(SRCA_SEL) ,	// input  select_sig
	.MUX_OUT(src_a) 	// output [15:0] MUX_OUT_sig
);

//instantiate 2:1 memory address multiplexer
MUX IORD
(
	.A(pc) ,	// input [15:0] A_sig
	.B(aluout_out) ,	// input [15:0] B_sig
	.select(iord) ,	// input  select_sig
	.MUX_OUT(mem_addr) 	// output [15:0] MUX_OUT_sig
);

MUX REGDATASEL
(
	.A(mdr_out),	// input [15:0] A_sig
	.B(aluout_out) ,	// input [15:0] B_sig
	.select(RegDataSel) ,	// input  select_sig
	.MUX_OUT(regdata) 	// output [15:0] MUX_OUT_sig
);

//instatiate memory module (uses a 16 bit address but only has 500 addresses because it would take years off my life to initialize ~65000 of them
MEMORY MEMORY_inst
(
	.MEM_ADDRESS(mem_addr) ,	// input [15:0] MEM_ADDRESS_sig
	.MEM_DATA(alu_out) ,	// input [15:0] MEM_DATA_sig
	.MEMWRITE(memwrite) ,	// input  MEMWRITE_sig
	.CLK(CLOCK) ,	// input  CLK_sig
	.MEM_OUT(mem_out) 	// output [15:0] MEM_OUT_sig
);

ALU ALU_inst
(
	.SRCA(src_a) ,	// input [15:0] SRCA_sig
	.SRCB(src_b) ,	// input [15:0] SRCB_sig
	.ALUOP(ALUOP) ,	// input  ALUOP_sig
	.ALUOUT(alu_out) ,	// output [15:0] ALUOUT_sig
	.ZERO(zero) 	// output  ZERO_sig
);

ProgramCounter ProgramCounter_inst
(
	.clock(CLOCK) ,	// input  clock_sig
	.reset(RESET) ,	// input  reset_sig
	.jump_addr(alu_out) ,	// input [15:0] jump_addr_sig
	.jump_en(PC_EN) ,	// input  jump_en_sig
	.pc(pc) 	// output [15:0] pc_sig
);

registerfile registerfile_inst
(
	.RS1(mem_out[11:8]) ,	// input [3:0] RS1_sig
	.RS2(mem_out[15:12]) ,	// input [3:0] RS2_sig
	.RD(mem_out[7:4]) ,	// input [3:0] RD_sig
	.REGDATA(regdata) ,	// input [15:0] REGDATA_sig
	.REGWRITE(regwrite) ,	// input  REGWRITE_sig
	.CLK(CLOCK) ,	// input  CLK_sig
	.REG_A(regouta) ,	// output [15:0] REG_A_sig
	.REG_B(regoutb)	// output [15:0] REG_B_sig
);

ControlUnit ControlUnit_inst
(
	.op(instruction[3:0]) ,	// input [3:0] op_sig
	.CLK(CLOCK) ,	// input  CLK_sig
	.reset(RESET) ,	// input  reset_sig
	.BranchOut(BranchOut_sig) ,	// output  BranchOut_sig
	.IorD(iord) ,	// output  IorD_sig
	.MemWrite(memwrite) ,	// output  MemWrite_sig
	.IR_EN(IREN) ,	// output  IR_EN_sig
	.RegDataSel(RegDataSel) ,	// output  RegDataSel_sig
	.RegWrite(regwrite) ,	// output  RegWrite_sig
	.SRCA(SRCA_SEL) ,	// output  SRCA_sig
	.SRCB(SRCB_SEL) ,	// output [1:0] SRCB_sig
	.ALUOp(ALUOP) 	// output  ALUOp_sig
);

defparam ControlUnit_inst.fetch = 0;
defparam ControlUnit_inst.decoder = 1;
defparam ControlUnit_inst.add = 2;
defparam ControlUnit_inst.sub = 3;
defparam ControlUnit_inst.A2 = 4;
defparam ControlUnit_inst.I1 = 5;
defparam ControlUnit_inst.I2 = 6;
defparam ControlUnit_inst.sw = 7;
defparam ControlUnit_inst.addi = 8;
defparam ControlUnit_inst.lw = 9;
defparam ControlUnit_inst.Branch = 10;
defparam ControlUnit_inst.JAL1 = 11;

GENERIC_REGISTER ALU_OUT_INST
(
	.clock(CLOCK) ,	// input  clock_sig
	.REG_IN(alu_out) ,	// input [15:0] REG_IN_sig
	.REG_OUT(aluout_out) 	// output [15:0] REG_OUT_sig
);

GENERIC_REGISTER MDR
(
	.clock(CLOCK) ,	// input  clock_sig
	.REG_IN(mem_out) ,	// input [15:0] REG_IN_sig
	.REG_OUT(mdr_out) 	// output [15:0] REG_OUT_sig
);

ImmGen ImmGen_inst
(
	.instruction(instruction) ,	// input [15:0] instruction_sig
	.immediate_out(immediate) 	// output [15:0] immediate_out_sig
);

INSTRUCTION_REGISTER INSTRUCTION_REGISTER_inst
(
	.clock(CLOCK) ,	// input  clock_sig
	.INST_IN(mem_out) ,	// input [15:0] INST_IN_sig
	.IREN(IREN) ,	// input  IREN_sig
	.INST_OUT(instruction) 	// output [15:0] INST_OUT_sig
);

and_2 and_2_inst
(
	.a(branch) ,	// input  a_sig
	.b(zero) ,	// input  b_sig
	.c(PC_EN) 	// output  c_sig
);

initial begin
	CLOCK = 0;
end

always #5 CLOCK = ~CLOCK;

initial begin
	RESET = 1; #10;
	RESET = 0; #10;
	#100;
	$stop;
end

endmodule

