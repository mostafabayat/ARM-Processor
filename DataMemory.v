
module DataMemory(clk, rst, memRead, memWrite, address, data, memOut);
	input wire clk, rst;
	input wire memRead, memWrite;
	input wire[31:0] address, data;
	output reg[31:0] memOut;

	reg[31:0] memory[0:63];

	wire[31:0] tempAddr;
	wire[5:0] addr;
	assign tempAddr = address - 1024;
	assign addr = {tempAddr[5:2], 2'b00};



	always @(posedge clk) begin
		if (memWrite) begin
			memory[addr+0] = data[7:0];
			memory[addr+1] = data[15:8];
			memory[addr+2] = data[23:16];
			memory[addr+3] = data[31:24];
		end
	end

	assign memOut = memRead ? {memory[addr+3], memory[addr+2], memory[addr+1], memory[addr+0]} : 0;

endmodule
