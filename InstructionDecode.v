
module InstructionDecode(clk, rst, instruction, N, Z, C, V, destWB, resultWB, writeBackEnWB,
	writeBackEn, memRead, memWrite, executeCommand, s, branch, reg1Val, reg2Val,
	immediate, shiftOperand, signedImmediate, destination);
	input wire clk, rst;
	input wire N, Z, C, V;
	input wire[31:0] instruction;
	input wire[3:0] destWB;
	input wire writeBackEnWB;
	input wire[31:0] resultWB;
	output wire writeBackEn, memRead, memWrite, s, branch;
	output wire[3:0] executeCommand;
	output wire[31:0] reg1Val, reg2Val;
	output wire immediate;
	output wire[11:0] shiftOperand;
	output wire[23:0] signedImmediate;
	output wire[3:0] destination;

	wire condCheckOut;
	wire[3:0] executeCommandTemp;
	wire memReadTemp, memWriteTemp, writeBackEnTemp, branchTemp, sOutTemp;
	wire[3:0] src2;
	CondCheck condCheck(.cond(instruction[31:28]), .N(N), .Z(Z), .C(C), .V(V), .out(condCheckOut));
	ControlUnit controlUnit(.opCode(instruction[24:21]), .mode(instruction[27:26]),
	 					.s(instruction[20]), .executeCommand(executeCommandTemp), .memRead(memReadTemp),
						.memWrite(memWriteTemp), .writeBackEn(writeBackEnTemp), .branch(branchTemp), .sOut(sOutTemp));

	MUX #(.DATA_SIZE(4)) beforeRegisterFileMux(.select(memWrite), .in0(instruction[3:0]), .in1(instruction[15:12]), .out(src2));
	RegisterFile registerFile(.clk(clk), .rst(rst), .src1(instruction[19:16]), .src2(src2), .destWB(destWB),
	 					.resultWB(resultWB), .writeBackEn(writeBackEnWB), .reg1(reg1Val), .reg2(reg2Val));


	MUX #(.DATA_SIZE(9)) afterControlUnitMux(.select(condCheckOut), .in0(9'b0),
 						.in1({executeCommandTemp, memReadTemp, memWriteTemp, writeBackEnTemp, branchTemp, sOutTemp}),
						.out({executeCommand, memRead, memWrite, writeBackEn, branch, sOut}));

	assign immediate = instruction[25];
	assign shiftOperand = instruction[11:0];
	assign signedImmediate = instruction[23:0];



endmodule
