
module MEMORY (
input [15:0] MEM_ADDRESS, 
input [15:0] MEM_DATA, 
input MEMWRITE,
output reg [15:0] MEM_OUT
);

reg [15:0] mem [0:65535];
	initial begin
		if (MEMWRITE) begin
			mem[MEM_ADDRESS] <= MEM_DATA;
		end
		MEM_OUT <= mem[MEM_ADDRESS];
	end
endmodule
