
module Execution(clk, executeCommand, memRead, memWrite, PC, reg1Val, reg2Val,
		immediate, N, Z, C, V, shiftOperand, signedImmediate, ALUResult,
		branchAddress, NOut, ZOut, COut, VOut);
	input wire clk;
	input wire[3:0] executeCommand;
	input wire memRead, memWrite;
	input wire[31:0] PC;
	input wire[31:0] reg1Val, reg2Val;
	input wire immediate;
	input wire N, Z, C, V;
	input wire[11:0] shiftOperand;
	input wire[23:0] signedImmediate;
	output wire[31:0] ALUResult, branchAddress;
	output wire NOut, ZOut, COut, VOut;

	wire[31:0] aluIn2Val, extendedSignImmediate;
	ALU alu(.ALUOperation(executeCommand), .in1(reg1Val), .in2(aluIn2Val), .carry(C),
	 	.NOut(NOut), .ZOut(ZOut), .COut(COut), .VOut(VOut), .out(ALUResult));
	assign extendedSignImmediate = {{6{signedImmediate[23]}}, signedImmediate} << 2;
	assign branchAddress = PC + extendedSignImmediate;
	Val2Generator val2Generator(.reg2Val(reg2Val), .immediate(immediate),
	 	.shiftOperand(shiftOperand), .memEnable(memRead || memWrite), .aluIn2Val(aluIn2Val));


endmodule
