
module StatusRegister(clk, rst, N, Z, C, V, s, NOut, ZOut, COut, VOut);
	input wire clk, rst;
	input wire s;
	input wire N, Z, C, V;
	output reg NOut, ZOut, COut, VOut;

	always @(negedge clk) begin
		if (rst) {NOut, ZOut, COut, VOut} = 0;
		else if (s) {NOut, ZOut, COut, VOut} = {N, Z, C, V};
	end

endmodule
