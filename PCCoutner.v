
module PCCounter(clk, rst, in, freeze, out);
	parameter REGISTER_SIZE = 32;
	input wire clk, rst;
	input wire freeze;
	input wire[REGISTER_SIZE-1:0] in;
	output reg[REGISTER_SIZE-1:0] out;

	always @(posedge clk) begin
		if (rst) out = 0;
		else out = freeze ? in : in + 4;
	end

endmodule
