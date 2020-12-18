
module ARM(clk, rst, forwardEn);
	input wire clk, rst, forwardEn;

	//InstructionFetch
	wire freeze, branchTaken;
	wire[31:0] branchAddress;
	wire[31:0] PCIF, instructionIF;
	InstructionFetch instructionFetch(.clk(clk), .rst(rst), .freeze(freeze),
	 		.branchTaken(branchTaken), .branchAddress(branchAddress), .PC(PCIF), .instruction(instructionIF));

	//Register Unit IF to ID
	wire flush;
	assign flush = branchTaken;
	wire[31:0] PCID, instructionID;
	RegisterUnitIF2ID registerUnitIF2ID(.clk(clk), .rst(rst), .freeze(freeze), .flush(flush),
			.PCIn(PCIF), .instructionIn(instructionIF), .PC(PCID), .instruction(instructionID));

	//InstructionDecode
	wire NID, ZID, CID, VID;
	wire[3:0] destinationWB;
	wire[31:0] resultWB;
	wire writeBackEnWB;
	wire writeBackEnID, memReadID, memWriteID, sID, branchID;
	wire[3:0] executeCommandID;
	wire[31:0] reg1ValID, reg2ValID;
	wire immediateID;
	wire[11:0] shiftOperandID;
	wire[23:0] signedImmediateID;
	wire[3:0] destinationID, src1ID, src2ID;
	assign src1ID = instructionID[19:16];
	InstructionDecode instructionDecode(.clk(clk), .rst(rst), .instruction(instructionID), .N(NID), .Z(ZID), .C(CID), .V(VID),
	 		.destWB(destinationWB), .resultWB(resultWB), .freeze(freeze), .writeBackEnWB(writeBackEnWB),
			.writeBackEn(writeBackEnID), .memRead(memReadID), .memWrite(memWriteID), .executeCommand(executeCommandID),
			.s(sID), .branch(branchID), .reg1Val(reg1ValID), .reg2Val(reg2ValID),
			.immediate(immediateID), .shiftOperand(shiftOperandID), .signedImmediate(signedImmediateID),
			.destination(destinationID), .src2(src2ID));

	//Register Unit ID to EXE
	wire NEXE, ZEXE, CEXE, VEXE;
	wire[31:0] PCEXE;
	wire writeBackEnEXE, memReadEXE, memWriteEXE, sEXE;
	wire[3:0] executeCommandEXE;
	wire[31:0] reg1ValEXE, reg2ValEXE;
	wire immediateEXE;
	wire[11:0] shiftOperandEXE;
	wire[23:0] signedImmediateEXE;
	wire[3:0] destinationEXE, src1EXE, src2EXE;
	RegisterUnitID2EXE registerUnitID2EXE(.clk(clk), .rst(rst), .flush(flush),
			.writeBackEnIn(writeBackEnID), .memReadIn(memReadID), .memWriteIn(memWriteID),
			.executeCommandIn(executeCommandID), .sIn(sID), .branchIn(branchID),
			.PCIn(PCID), .reg1ValIn(reg1ValID), .reg2ValIn(reg2ValID), .immediateIn(immediateID),
			.shiftOperandIn(shiftOperandID), .signedImmediateIn(signedImmediateID),
			.destinationIn(destinationID), .NIn(NID), .ZIn(ZID), .CIn(CID), .VIn(VID),
			.src1In(src1ID), .src2In(src2ID),
			.writeBackEn(writeBackEnEXE), .memRead(memReadEXE), .memWrite(memWriteEXE),
			.executeCommand(executeCommandEXE), .s(sEXE), .branch(branchTaken),
			.PC(PCEXE), .reg1Val(reg1ValEXE), .reg2Val(reg2ValEXE), .immediate(immediateEXE),
			.shiftOperand(shiftOperandEXE), .signedImmediate(signedImmediateEXE), .destination(destinationEXE),
			.N(NEXE), .Z(ZEXE), .C(CEXE), .V(VEXE), .src1(src1EXE), .src2(src2EXE));

	//Execution
	wire[31:0] ALUResultEXE;
	wire NOut, ZOut, COut, VOut;
	wire[1:0] selSrc1, selSrc2;
	wire[31:0] reg1ValMuxed, reg2ValMuxed;
	wire[31:0] ALUResultMEM;
	MUX3 MuxforReg1ValForwarding(.select(selSrc1), .in0(reg1ValEXE), .in1(ALUResultMEM), .in2(resultWB), .out(reg1ValMuxed));
	MUX3 MuxforReg2ValForwarding(.select(selSrc2), .in0(reg2ValEXE), .in1(ALUResultMEM), .in2(resultWB), .out(reg2ValMuxed));
	Execution execution(.executeCommand(executeCommandEXE), .memRead(memReadEXE), .memWrite(memWriteEXE),
	 		.PC(PCEXE), .reg1Val(reg1ValMuxed), .reg2Val(reg2ValMuxed),
			.immediate(immediateEXE), .N(NEXE), .Z(ZEXE), .C(CEXE), .V(VEXE), .shiftOperand(shiftOperandEXE),
			.signedImmediate(signedImmediateEXE), .ALUResult(ALUResultEXE),
			.branchAddress(branchAddress), .NOut(NOut), .ZOut(ZOut), .COut(COut), .VOut(VOut));

	//Status Register
	StatusRegister statusRegister(.clk(clk), .rst(rst), .N(NOut), .Z(ZOut), .C(COut), .V(VOut), .s(sEXE),
	 		.NOut(NID), .ZOut(ZID), .COut(CID), .VOut(VID));

	//Register Unit EXE to MEM
	wire writeBackEnMEM, memReadMEM, memWriteMEM;
	wire[31:0] reg2ValMEM;
	wire[3:0] destinationMEM;
	RegisterUnitEXE2MEM registerUnitEXE2MEM(.clk(clk), .rst(rst), .writeBackEnIn(writeBackEnEXE),
	 		.memReadIn(memReadEXE), .memWriteIn(memWriteEXE), .ALUResultIn(ALUResultEXE),
			.destinationIn(destinationEXE), .reg2ValIn(reg2ValMuxed),
			.writeBackEn(writeBackEnMEM), .memRead(memReadMEM), .memWrite(memWriteMEM),
			.ALUResult(ALUResultMEM), .destination(destinationMEM), .reg2Val(reg2ValMEM));

	//Data Memory
	wire[31:0] memOutMEM;
	DataMemory dataMemory(.clk(clk), .rst(rst), .memRead(memReadMEM), .memWrite(memWriteMEM),
	 		.address(ALUResultMEM), .data(reg2ValMEM), .memOut(memOutMEM));

	//Register Unit MEM to WB
	wire memReadWB;
	wire[31:0] addressWB, memOutWB;
	RegisterUnitMEM2WB registerUnitMEM2WB(.clk(clk), .rst(rst), .writeBackEnIn(writeBackEnMEM),
			.memReadIn(memReadMEM), .addressIn(ALUResultMEM), .memOutIn(memOutMEM), .destinationIn(destinationMEM),
			.writeBackEn(writeBackEnWB), .memRead(memReadWB), .address(addressWB),
			.memOut(memOutWB), .destination(destinationWB));

	//Write Back
	WriteBack writeBack(.memRead(memReadWB), .ALUResult(addressWB), .memOut(memOutWB), .result(resultWB));

	//Hazard Detection Unit
	HazardDetectionUnit hazardDetectionUnit(.src1(src1ID), .src2(src2ID),
	 		.twoSrc((~immediateID || memWriteID)), .destinationEXE(destinationEXE),
			.memReadEXE(memReadEXE),
			.writeBackEnEXE(writeBackEnEXE), .destinationMEM(destinationMEM),
			.writeBackEnMEM(writeBackEnMEM), .forwardEn(forwardEn), .hazardDetected(freeze));

	//Forwarding Unit
	ForwardingUnit forwardingUnit(.src1(src1EXE), .src2(src2EXE), .writeBackEnMEM(writeBackEnMEM),
	 		.destinationMEM(destinationMEM), .writeBackEnWB(writeBackEnWB), .destinationWB(destinationWB),
			.selSrc1(selSrc1), .selSrc2(selSrc2));

endmodule
