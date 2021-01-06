
module RegisterUnitEXE2MEM(clk, rst, writeBackEnIn, memReadIn, memWriteIn, ALUResultIn,
		pushEnIn, popEnIn, pushEn, popEn,
		destinationIn, reg2ValIn, writeBackEn, memRead, memWrite, ALUResult, destination, reg2Val);
	input wire clk, rst;
	input wire writeBackEnIn, memReadIn, memWriteIn, pushEnIn, popEnIn;
	input wire[31:0] ALUResultIn, reg2ValIn;
	input wire[3:0] destinationIn;
	output reg writeBackEn, memRead, memWrite, pushEn, popEn;
	output reg[31:0] ALUResult, reg2Val;
	output reg[3:0] destination;

	always @(posedge clk) begin
		{writeBackEn, memRead, memWrite, ALUResult, destination, reg2Val, pushEn, popEn} = (rst) ? 0 :
			{writeBackEnIn, memReadIn, memWriteIn, ALUResultIn, destinationIn, reg2ValIn, pushEnIn, popEnIn};
	end


endmodule
