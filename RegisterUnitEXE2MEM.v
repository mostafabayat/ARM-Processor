
module RegisterUnitEXE2MEM(clk, rst, writeBackEnIn, memReadIn, memWriteIn, ALUResultIn,
		destinationIn, reg2ValIn, writeBackEn, memRead, memWrite, ALUResult, destination, reg2Val);
	input wire clk, rst;
	input wire writeBackEnIn, memReadIn, memWriteIn;
	input wire[31:0] ALUResultIn, reg2ValIn;
	input wire[3:0] destinationIn;
	output reg writeBackEn, memRead, memWrite;
	output reg[31:0] ALUResult, reg2Val;
	output reg[3:0] destination;

	always @(posedge clk) begin
		{writeBackEn, memRead, memWrite, ALUResult, destination, reg2Val} = (rst) ? 0 :
			{writeBackEnIn, memReadIn, memWriteIn, ALUResultIn, destinationIn, reg2ValIn};
	end


endmodule
