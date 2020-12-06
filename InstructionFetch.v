
module InstructionFetch(clk, rst, freeze, branchTaken, branchAddress, PC, instruction);
	input wire clk, rst;
	input wire freeze, branchTaken;
	input wire[31:0] branchAddress;
	output wire[31:0] PC, instruction;

	wire[31:0] PCIn;
	wire[31:0] nextPC, PCOut;
	MUX beforePCMux(.select(branchTaken), .in0(nextPC), .in1(branchAddress), .out(PCIn));
	PC PCRegister(.clk(clk), .rst(rst), .in(PCIn), .freeze(freeze), .out(PCOut));
	Adder PCAdder(.in1(32'd4), .in2(PCOut), .out(nextPC));
	assign PC = nextPC;

	instructionMemory instructionMemory(.address(PCOut), .instruction(instruction));

endmodule
