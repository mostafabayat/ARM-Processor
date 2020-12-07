
module RegisterUnitEXE2MEM(clk, rst, writeBackEnIn, memReadIn, memWriteIn, ALUResultIn,
		destinationIn, writeBackEn, memRead, memWrite, ALUResult, destination);
	input wire clk, rst;
	input wire writeBackEnIn, memReadIn, memWriteIn;
	input wire[31:0] ALUResultIn;
	input wire[3:0] destinationIn;
	output reg writeBackEn, memRead, memWrite;
	output reg[31:0] ALUResult;
	output reg[3:0] destination;

	always @(posedge clk) begin
		{writeBackEn, memRead, memWrite, ALUResult, destination} = (rst) ? 0 :
			{writeBackEnIn, memReadIn, memWriteIn, ALUResultIn, destinationIn};
	end


endmodule
