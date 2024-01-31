module registerfile(
    input [4:0]  Read1,
	 input [4:0]  Read2,
	 input [4:0]  Write,
	 input [15:0] WriteData,
	 input		  RegWrite,
	 input		  CLK,
    output reg [15:0] Out1,
    output reg [15:0] Out2,
    );

	reg [15] RF [15:0];
	
	assign Data1 = RF[Read1];
	assign Data2 = RF[Read2];
	
	always begin
		@(posedge CLK) if (RegWrite) RF[Write] <= WriteData;
	end

endmodule