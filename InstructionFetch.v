
module InstructionFetch(clk, rst, freeze, branchTaken, branchAddress, PC, instruction);
	input wire clk, rst;
	input wire freeze, branchTaken;
	input wire[31:0] branchAddress;
	output wire[31:0] PC, instruction;

	wire[31:0] nextPC;
	PCCounter PCC(.clk(clk), .rst(rst), .in(nextPC), .freeze(freeze), .out(nextPC));
	assign PC = nextPC;
	
	
endmodule // IF
