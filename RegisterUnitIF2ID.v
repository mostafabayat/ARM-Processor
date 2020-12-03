
module RegisterUnitIF2ID(clk, rst, freeze, flush, PCIn, instructionIn, PC, instruction);
	input wire clk, rst;
	input wire freeze, flush;
	input[31:0] PCIn, instructionIn;
	output reg [31:0] PC, instruction;
endmodule // RegisterUnitIF2ID
