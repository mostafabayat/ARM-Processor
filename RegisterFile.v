

module RegisterFile(clk, rst, src1, src2, destWB, resultWB, writeBackEn, reg1, reg2);
	input wire clk, rst;
	input wire[3:0] src1, src2, destWB;
	input wire[31:0] resultWB;
	input wire writeBackEn;
	output wire[31:0] reg1, reg2;

	reg[31:0] regs[0:14];
	assign reg1 = regs[src1];
	assign reg2 = regs[src2];

	integer i;
	always @(posedge clk) begin
		if (rst) begin
			for(i = 0; i < 15; i = i + 1) regs[i] = 32'b0;
		end
	end

	always @(negedge clk) begin
		if (writeBackEn) regs[destWB] <= resultWB;
		// regs[16'b0] = 0;
	end

endmodule
