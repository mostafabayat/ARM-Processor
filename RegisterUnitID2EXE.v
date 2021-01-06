
module RegisterUnitID2EXE(clk, rst, flush,
		writeBackEnIn, memReadIn, memWriteIn,
		pushEnIn, popEnIn, pushEn, popEn,
		executeCommandIn, sIn, branchIn, PCIn, reg1ValIn, reg2ValIn, immediateIn,
		shiftOperandIn, signedImmediateIn, destinationIn, NIn, ZIn, CIn, VIn,
		writeBackEn, memRead, memWrite,
		executeCommand, s, branch, PC, reg1Val, reg2Val, immediate,
		shiftOperand, signedImmediate, destination, N, Z, C, V );
	input wire clk, rst;
	input wire flush;
	input wire writeBackEnIn, memReadIn, memWriteIn, sIn, branchIn, immediateIn, pushEnIn, popEnIn;
	input wire NIn, ZIn, CIn, VIn;
	input wire[3:0] executeCommandIn;
	input wire[31:0] PCIn, reg1ValIn, reg2ValIn;
	input wire[11:0] shiftOperandIn;
	input wire[23:0] signedImmediateIn;
	input wire[3:0] destinationIn;

	output reg writeBackEn, memRead, memWrite, s, branch, immediate, pushEn, popEn;
	output reg N, Z, C, V;
	output reg[3:0] executeCommand;
	output reg[31:0] PC, reg1Val, reg2Val;
	output reg[11:0] shiftOperand;
	output reg[23:0] signedImmediate;
	output reg[3:0] destination;

	always @(posedge clk) begin
		{writeBackEn, memRead, memWrite, executeCommand, s, branch, PC, reg1Val, reg2Val,
		 immediate, shiftOperand, signedImmediate, destination, N, Z, C, V, pushEn, popEn} =
		  (rst | flush) ? 0 :
			{writeBackEnIn, memReadIn, memWriteIn, executeCommandIn, sIn, branchIn, PCIn,
				reg1ValIn, reg2ValIn, immediateIn, shiftOperandIn, signedImmediateIn,
				 destinationIn, NIn, ZIn, CIn, VIn, pushEnIn, popEnIn};
	end


endmodule
