`timescale 1ns/1ps
module read_from_text;
reg PC_EN;
reg PC_RESET;
reg memwrite;
reg aluop;
reg [15:0] srcb;
reg clock;
wire zero;
wire [15:0] pcout;
wire [15:0] mem_out;
wire [15:0] alu_out;

MEMORY MEMORY_inst
(
	.MEM_ADDRESS(pcout) ,	// input [15:0] MEM_ADDRESS_sig
	.MEM_DATA(alu_out) ,	// input [15:0] MEM_DATA_sig
	.MEMWRITE(memwrite) ,	// input  MEMWRITE_sig
	.CLK(clock) ,	// input  CLK_sig
	.MEM_OUT(mem_out) 	// output [15:0] MEM_OUT_sig
);

ALU ALU_inst
(
	.SRCA(pcout) ,	// input [15:0] SRCA_sig
	.SRCB(srcb) ,	// input [15:0] SRCB_sig
	.ALUOP(aluop) ,	// input  ALUOP_sig
	.ALUOUT(alu_out) ,	// output [15:0] ALUOUT_sig
	.ZERO(zero) 	// output  ZERO_sig
);

ProgramCounter ProgramCounter_inst
(
	.clock(clock) ,	// input  clock_sig
	.reset(PC_RESET) ,	// input  reset_sig
	.jump_addr(alu_out) ,	// input [15:0] jump_addr_sig
	.jump_en(PC_EN) ,	// input  jump_en_sig
	.pc(pcout) 	// output [15:0] pc_sig
);


initial begin
	clock = 0;
end

always #5 clock = ~clock;

initial begin
	PC_RESET = 1; #10;
	PC_RESET = 0; #10;
	srcb = 2; aluop = 0; PC_EN = 1; memwrite = 0;
	$display("instruction: %d", mem_out);
	#10;
	$display("instruction: %d", mem_out);
	#10;
	$display("instruction: %d", mem_out);
	#10;
	$display("instruction: %d", mem_out);
	#10;
	$stop;
end
endmodule
