
module ARM(clk, rst);
	input wire clk, rst;
	//InstructionFetch
	wire freeze, branchTaken;
	wire[31:0] branchAddress;
	wire[31:0] PCIF, instructionIF;
	InstructionFetch instructionFetch(.clk(clk), .rst(rst), .freeze(freeze),
	 					.branchTaken(branchTaken), .branchAddress(branchAddress), .PC(PCIF), .instruction(instructionIF));

	//Register Unit IF to ID
	wire flush;
	wire[31:0] PCID, instructionID;
	RegisterUnitIF2ID registerUnitIF2ID(.clk(clk), .rst(rst), .freeze(freeze), .flush(flush), .PCIn(PCIF), .instructionIn(instructionIF), .PC(PCID), .instruction(instructionID));

	//InstructionDecode
	wire NID, ZID, CID, VID;
	wire[3:0] destWBID;
	wire[31:0] resultWBID;
	wire writeBackEnWBID;
	wire writeBackEnID, memReadID, memWriteID, sID, branchID;
	wire[3:0] executeCommandID;
	wire[31:0] reg1ValID, reg2ValID;
	wire immediateID;
	wire[11:0] shiftOperandID;
	wire[23:0] signedImmediateID;
	wire[3:0] destinationID;
	InstructionDecode instructionDecode(.clk(clk), .rst(rst), .instruction(instructionID), .N(NID), .Z(ZID), .C(CID), .V(VID),
	 					.destWB(destWBID), .resultWB(resultWBID), .writeBackEnWB(writeBackEnWBID),
						.writeBackEn(writeBackEnID), .memRead(memReadID), .memWrite(memWriteID), .executeCommand(executeCommandID),
						.s(sID), .branch(branchID), .reg1Val(reg1ValID), .reg2Val(reg2ValID),
						.immediate(immediateID), .shiftOperand(shiftOperandID), .signedImmediate(signedImmediateID), .destination(destinationID));

	//Register Unit ID to EXE
	wire NEXE, ZEXE, CEXE, VEXE;
	wire[3:0] destWBEXE;
	wire[31:0] resultWBEXE;
	wire[31:0] PCEXE;
	wire writeBackEnWBEXE;
	wire writeBackEnEXE, memReadEXE, memWriteEXE, sEXE, branchEXE;
	wire[3:0] executeCommandEXE;
	wire[31:0] reg1ValEXE, reg2ValEXE;
	wire immediateEXE;
	wire[11:0] shiftOperandEXE;
	wire[23:0] signedImmediateEXE;
	wire[3:0] destinationEXE;
	RegisterUnitID2EXE registerUnitID2EXE(.clk(clk), .rst(rst), .flush(flush),
										.writeBackEnIn(writeBackEnID), .memReadIn(memReadID), .memWriteIn(memWriteID),
										.executeCommandIn(executeCommandID), .sIn(sID), .branchIn(branchID),
										.PCIn(PCID), .reg1ValIn(reg1ValID), .reg2ValIn(reg2ValID), .immediateIn(immediateID),
										.shiftOperandIn(shiftOperandID), .signedImmediateIn(signedImmediateID),
										.destinationIn(destinationID), .NIn(NID), .ZIn(ZID), .CIn(CID), .VIn(VID),
										.writeBackEn(writeBackEnEXE), .memRead(memReadEXE), .memWrite(memWriteEXE),
										.executeCommand(executeCommandEXE), .s(sEXE), .branch(branchEXE),
										.PC(PCEXE), .reg1Val(reg1ValEXE), .reg2Val(reg2ValEXE), .immediate(immediateEXE),
										.shiftOperand(shiftOperandEXE), .signedImmediate(signedImmediateEXE), .destination(destinationEXE),
										.N(NEXE), .Z(ZEXE), .C(CEXE), .V(VEXE));



endmodule // ARM
