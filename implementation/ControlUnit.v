module ControlUnit(
	input [3:0]			op,
	input 				CLK,
	input 				reset,
	output reg 			BranchOut,
	output reg 			PCReset,
	output reg 			IorD,
	output reg 			MemWrite,
	output reg 			IR_EN,
	output reg 			RegDataSel,
	output reg 			RegWrite,
	output reg 			SRCA,
	output reg [1:0]  SRCB,
	output reg 			ALUOp
);

reg op1, op2, op3, funct;
always @(op)
	{funct, op3, op2, op1} = op;
	
reg [2:0] opcode;
always @* begin
	opcode = op1 + op2 * 2 + op3 * 4;
end

// State flip-flops

reg [3:0] current_state;
reg [3:0] next_state;
	
// State definitions
parameter fetch 	= 0;
parameter decoder = 1;
parameter add 		= 2;
parameter sub 		= 3;
parameter A2 		= 4; // add/sub completion
parameter I1 		= 5; // addi/LW/SW
parameter I2 		= 6; // addi/LW state
parameter sw 		= 7; 
parameter addi 	= 8;
parameter lw 		= 9;
parameter Branch 	= 10;
parameter JAL1		= 11;
	

	
always @ (posedge CLK, posedge reset)
	begin
		if (reset)
			current_state = fetch;
      else 
			current_state = next_state;
	end
	
always @ (current_state)
	begin
		RegWrite = 0;
		MemWrite = 0;
		IR_EN = 0;
		BranchOut = 0;
		
		case (current_state)
			fetch: 
				begin
					IR_EN = 1;
					SRCA = 0;
					SRCB = 2'b01;
					ALUOp = 0;
					IorD = 0;
				end
			decoder:
				begin
					SRCA = 1;
					SRCB = 2'b10;
					ALUOp = 0;
				end
			add:
				begin
					ALUOp = 0;
					SRCA = 1;
					SRCB = 2'b00;
				end
			sub:
				begin
					ALUOp = 1;
					SRCA = 1;
					SRCB = 2'b00;					
				end
			A2:
				begin
					RegWrite = 1;
					RegDataSel = 1;
				end
			I1:
				begin
					ALUOp = 0;
					SRCA = 1;
					SRCB = 2'b10;
				end
			I2:
				begin	
					IorD = 1;
				end
			sw:
				begin
					MemWrite = 1;
					IorD = 1;
				end
			addi:
				begin
					RegDataSel = 1;
				end
			lw:
				begin
					RegDataSel = 0;
				end
			Branch:
				begin
					BranchOut = 1;
				end
			JAL1:
				begin
					RegWrite = 1;
					SRCA = 0;
					SRCB = 2'b01;
				end
			default:
				begin $display ("Not implemented"); end
		endcase
	end
	
always @ (current_state, next_state, opcode)
	begin
		case(current_state)
			fetch: 
				begin
					next_state = decoder;
				end
			decoder:
				begin
					case(opcode)
						3'b000 : // A-Type
							begin
								case(funct)
									1'b0 :
										begin
											next_state = add;
										end
									1'b1:
										begin
											next_state = sub;
										end
								endcase
							end
						3'b001 : // I-Type
							begin
								next_state = I1;
							end
						3'b010 : // S-Type
							begin
								next_state = I1;
							end
						3'b011 : // B-Type
							begin
								next_state = Branch;
							end
						3'b100 : // JAL-Type
							begin
								next_state = JAL1;
							end
						default:
							begin
								$display("invalid opcode, returning to fetch");
								next_state = fetch;
							end
					endcase
				end
			add:
				begin
					next_state = A2;
				end
			sub:
				begin
					next_state = A2;
				end
			A2:
				begin
					next_state = fetch;
				end
			I1:
				begin
					case(opcode)
						3'b001 : // I-Type
							begin
								next_state = I2;
							end
						3'b010 : // S-Type
							begin
								next_state = sw;
							end
						default :
							begin
								$display("Invalid opcode");
								next_state = fetch;
							end
					endcase
				end
			I2:
				begin
					case(funct)
						1'b0 : // addi
							begin
								next_state = addi;
							end
						1'b1 : // lw
							begin
								next_state = lw;
							end
						default:
							begin
								$display("Invalid funct");
								next_state = fetch;
							end
					endcase
				end
			sw:
				begin
					next_state = fetch;
				end
			addi:
				begin
					next_state = fetch;
				end
			lw:
				begin
					next_state = fetch;
				end
			Branch:
				begin
					next_state = fetch;
				end
			JAL1:
				begin
					next_state = fetch;
				end
			default:
				begin 
					$display ("Not implemented"); 
					next_state = fetch;
				end
		endcase
	end
	// $display("After the tests, the next_state is %d", next_state);
endmodule


















