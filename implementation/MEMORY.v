
module MEMORY (
input [15:0] MEM_ADDRESS, 
input [15:0] MEM_DATA, 
input MEMWRITE,
input CLK,
input RST,
output reg [15:0] MEM_OUT
);

reg [15:0] mem [0:499];
integer i;
	always @ (posedge CLK) begin
		if(!RST) begin
			for(i = 0; i < 500; i = i + 1) begin
				mem[i] = 0;
			end
		end
		if (MEMWRITE) begin
			mem[MEM_ADDRESS] = MEM_DATA;
		end
		MEM_OUT <= mem[MEM_ADDRESS];
	end
endmodule
