module registerA(
    input [15:0] d,
    input rst,
    output reg [15:0] q,
    input CLK
    );

always @ (posedge(CLK))
begin
	if (rst != 1) begin 
		q = d;
	end else begin
		q = 0;
	end
end

endmodule