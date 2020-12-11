
module PC(clk, rst, in, freeze, out);
	input wire clk, rst;
	input wire freeze;
	input wire[31:0] in;
	output reg[31:0] out;

	always @(posedge clk) begin
		if (rst) out = 0;
		else if (!freeze) out = in;
	end

endmodule
