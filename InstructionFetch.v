
module InstructionFetch(clk, rst, freeze, branchTaken, branchAddress, PC, instruction);
	input wire clk, rst;
	input wire freeze, branchTaken;
	input wire[31:0] branchAddress;
	output wire[31:0] PC, instruction;

	wire[31:0] PCIn, PCOut;
	MUX beforePCMux(.select(branchTaken), .in0(PC), .in1(branchAddress), .out(PCIn));
	PC PCRegister(.clk(clk), .rst(rst), .in(PCIn), .freeze(freeze), .out(PCOut));
	assign PC = 32'd4 + PCOut;

	instructionMemory instructionMemory(.address(PCOut), .instruction(instruction));

endmodule
