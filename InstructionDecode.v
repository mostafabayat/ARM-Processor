
module InstructionDecode(clk, rst, instruction, N, Z, C, V, destWB, resultWB, freeze,
	writeBackEnWB, pushEnWB, popEnWB, writeBackEn,
	pushEn, popEn, memRead, memWrite, executeCommand, s, branch,
	reg1Val, reg2Val, immediate, shiftOperand, signedImmediate, destination, src2);
	input wire clk, rst;
	input wire N, Z, C, V;
	input wire[31:0] instruction;
	input wire[3:0] destWB;
	input wire writeBackEnWB, pushEnWB, popEnWB;
	input wire[31:0] resultWB;
	input wire freeze;
	output wire writeBackEn, memRead, memWrite, s, branch, pushEn, popEn;
	output wire[3:0] executeCommand;
	output wire[31:0] reg1Val, reg2Val;
	output wire immediate;
	output wire[11:0] shiftOperand;
	output wire[23:0] signedImmediate;
	output wire[3:0] destination;
	output wire[3:0] src2;

	wire condCheckOut;
	wire[3:0] executeCommandTemp;
	wire[3:0] src1;
	wire memReadTemp, memWriteTemp, writeBackEnTemp, branchTemp, sOutTemp, pushEnTemp, popEnTemp;
	ConditionCheck condCheck(.condition(instruction[31:28]), .N(N), .Z(Z), .C(C), .V(V), .out(condCheckOut));
	ControlUnit controlUnit(.opCode(instruction[24:21]), .mode(instruction[27:26]),
	 		.s(instruction[20]), .executeCommand(executeCommandTemp), .memRead(memReadTemp),
			.memWrite(memWriteTemp), .writeBackEn(writeBackEnTemp), .branch(branchTemp), .sOut(sOutTemp), .pushEn(pushEnTemp), .popEn(popEnTemp));

	wire[3:0] src2Temp;
	MUX #(.DATA_SIZE(4)) beforeRegisterFileMux(.select(memWrite), .in0(instruction[3:0]), .in1(destination), .out(src2Temp));
	MUX #(.DATA_SIZE(4)) stackSrc1Mux(.select(pushEn || popEn), .in0(instruction[19:16]), .in1(4'd13), .out(src1));
	MUX #(.DATA_SIZE(4)) stackSrc2Mux(.select(pushEn || popEn), .in0(src2Temp), .in1(instruction[19:16]), .out(src2));
	RegisterFile registerFile(.clk(clk), .rst(rst), .src1(src1), .src2(src2), .destWB(destWB),
			.resultWB(resultWB), .writeBackEn(writeBackEnWB),
			.pushEn(pushEnWB), .popEn(popEnWB), .reg1(reg1Val), .reg2(reg2Val));


	MUX #(.DATA_SIZE(11)) afterControlUnitMux(.select(~condCheckOut || freeze),
	 		.in0({executeCommandTemp, memReadTemp, memWriteTemp, writeBackEnTemp, branchTemp, sOutTemp, pushEnTemp, popEnTemp}),
 			.in1(11'b0), .out({executeCommand, memRead, memWrite, writeBackEn, branch, s, pushEn, popEn}));

	assign immediate = instruction[25];
	assign shiftOperand = instruction[11:0];
	assign signedImmediate = instruction[23:0];
	assign destination = instruction[15:12];




endmodule
