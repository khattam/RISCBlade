`timescale 1ns/1ps

module PC_ALU_MEMORY_WITH_MUX;
reg ALUOP;
reg CLOCK;
reg RESET;
reg PC_EN;
reg iord;
reg memwrite;
wire [15:0] mem_out;
wire [15:0] mem_addr;
wire [15:0] pc;
wire [15:0] alu_out;
wire [15:0] src_b;
wire zero;
wire [15:0] src_a;
reg [15:0] Bmux_0;
reg [15:0] Bmux_1;
reg [15:0] Bmux_2;
reg [1:0] SRCB_SEL;
reg SRCA_SEL;


MUX_4_1 MUX_4_1_inst
(
	.A(Bmux_0) ,	// input [15:0] A_sig
	.B(Bmux_1) ,	// input [15:0] B_sig
	.C(Bmux_2) ,	// input [15:0] C_sig
	.sel(SRCB_SEL) ,	// input [1:0] sel_sig
	.MUX_OUT(src_b) 	// output [15:0] MUX_OUT_sig
);

MUX SRCAMUX
(
	.A(pc) ,	// input [15:0] A_sig
	.B(Amux_1) ,	// input [15:0] B_sig
	.select(SRCA_SEL) ,	// input  select_sig
	.MUX_OUT(src_a) 	// output [15:0] MUX_OUT_sig
);

MUX IORD
(
	.A(pc) ,	// input [15:0] A_sig
	.B(alu_out) ,	// input [15:0] B_sig
	.select(iord) ,	// input  select_sig
	.MUX_OUT(mem_addr) 	// output [15:0] MUX_OUT_sig
);

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


initial begin
	CLOCK = 0;
end

always #5 CLOCK = ~CLOCK;

initial begin
	RESET = 1; #10;
	RESET = 0; #10;
	Bmux_0 = 2; SRCB_SEL = 0; SRCA_SEL = 0; ALUOP = 0; PC_EN = 1; memwrite = 1; iord = 0; #10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	RESET = 1; iord = 0; #10;
	$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
	RESET = 0; #10;
		$display("PC VALUE is %d" , pc);
	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
		$display("PC VALUE is %d" , pc);

	$display("MEMOUT is %d" , mem_out);
	#10;
 	$stop;
end

endmodule

