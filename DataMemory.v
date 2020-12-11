
module DataMemory(clk, rst, memRead, memWrite, address, data, memOut);
	input wire clk, rst;
	input wire memRead, memWrite;
	input wire[31:0] address, data;
	output wire[31:0] memOut;

	reg[31:0] memory[0:63];

	wire[31:0] tempAddr;
	wire[5:0] addr;
	assign tempAddr = address - 1024;
	assign addr = tempAddr[7:2];

	always @(posedge clk) begin
		if (memWrite) begin
			memory[addr] = data;
		end
	end

	assign memOut = (memRead) ? memory[addr] : 0;

endmodule
