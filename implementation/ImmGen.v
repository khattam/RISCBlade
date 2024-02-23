
module ImmGen (
	input [15:0] instruction,
	output reg [15:0] immediate_out
);

reg [3:0] opcode, part1, part2, part3; // 4 parts of instruction
always @(instruction)
   {part3, part2, part1, opcode} = instruction; // Splits instruction into 4 four-bit parts


reg opcode1, opcode2, opcode3, opcode4; // Creates 4 new opcode sections
always @(opcode)
	{opcode1, opcode2, opcode3, opcode4} = opcode; // Splits opcode into 4 one-bit parts
	
	
reg [4:0] sTemp;
reg [8:0] jalTemp;


always@(*)
	begin
		case (opcode)
			4'b0001 : immediate_out <= $signed(part3); // addi case
			4'b1001 : immediate_out <= $signed(part3); // lw case
			4'b1010 : sTemp 			<= part1*2 + opcode1; // sw case
			4'b0010 : sTemp		   <= part1*2 + opcode1; // sw case
			4'b0011 : immediate_out <= $signed(part1); // beq case
			4'b1011 : immediate_out <= $signed(part1); // bgt case
			4'b0100 : jalTemp 		<= part2 + part3*16 + opcode1*256; // jal case
			4'b1100 : jalTemp 		<= part2 + part3*16 + opcode1*256; // jal case 
			default : immediate_out <= 16'b0000000000000000;
		endcase
	end
	
always@* begin
	immediate_out = $signed(sTemp);
end

	
always@* begin
	immediate_out = $signed(jalTemp);
end

endmodule