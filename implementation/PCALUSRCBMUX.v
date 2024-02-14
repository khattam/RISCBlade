`timescale 1ns/1ps

module PCALUSRCBMUX;
reg ALUOP;
reg CLOCK;
reg RESET;
reg PC_EN;
wire [15:0] pc;
wire [15:0] alu_out;
wire [15:0] src_b;
wire zero;
reg [15:0] mux_0;
reg [15:0] mux_1;
reg [15:0] mux_2;
reg [1:0] SRCB_SEL;


MUX_4_1 MUX_4_1_inst
(
	.A(mux_0) ,	// input [15:0] A_sig
	.B(mux_1) ,	// input [15:0] B_sig
	.C(mux_2) ,	// input [15:0] C_sig
	.sel(SRCB_SEL) ,	// input [1:0] sel_sig
	.MUX_OUT(src_b) 	// output [15:0] MUX_OUT_sig
);

ALU ALU_inst
(
	.SRCA(pc) ,	// input [15:0] SRCA_sig
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


initial begin
	CLOCK = 0;
end

always #5 CLOCK = ~CLOCK;

initial begin
	RESET = 1; #10;
	RESET = 0; #10;
	mux_0 = 2; SRCB_SEL = 0; ALUOP = 0; PC_EN = 1; #10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	#10;
	$display("PC VALUE is %d" , pc);
	$stop;
end

endmodule

