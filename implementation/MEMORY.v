`timescale 1ns/1ps

module MEMORY (
input [15:0] MEM_ADDRESS, 
input [15:0] MEM_DATA, 
input MEMWRITE,
input CLK,
output [15:0] MEM_OUT
);

reg [15:0] mem [0:499];
	always @ (posedge CLK) begin
		if (MEMWRITE) begin
			mem[MEM_ADDRESS] <= MEM_DATA;
		end
	end
	assign MEM_OUT = mem[MEM_ADDRESS];
endmodule
