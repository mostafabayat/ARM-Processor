
module Register(clk, rst, in, out);
	// parameter REGISTER_SIZE = 32;
	input wire clk, rst;
	input wire[31:0] in;
	output reg[31:0] out;

	always @(posedge clk) begin
		if (rst) out = 0;
		else out = in;
	end

endmodule // Register
