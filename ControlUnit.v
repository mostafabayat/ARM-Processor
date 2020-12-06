// mode and opcode
//`define NOP		6'b00_0000
`define MOV		6'b00_1101
`define MVN		6'b00_1111
`define ADD		6'b00_0100
`define ADC		6'b00_0101
`define SUB		6'b00_0010
`define SBC		6'b00_0110
`define AND		6'b00_0000
`define ORR		6'b00_1100
`define EOR		6'b00_0001
`define CMP		6'b00_1010
`define TST		6'b00_1000
`define LDR		6'b01_0100
`define STR		6'b01_0100
//`define B		6'b00



// ALU command
`define ALU_MOV		4'b0001
`define ALU_MVN		4'b1001
`define ALU_ADD		4'b0010
`define ALU_ADC		4'b0011
`define ALU_SUB		4'b0100
`define ALU_SBC		4'b0101
`define ALU_AND		4'b0110
`define ALU_ORR		4'b0111
`define ALU_EOR		4'b1000
`define ALU_CMP		4'b0100
`define ALU_TST		4'b0110
`define ALU_LDR		4'b0010
`define ALU_STR		4'b0010
//`define B		6'b00


module Controller(opCode, mode, s, executeCommand, memRead, memWrite, writeBackEn, branch, sOut);
	input wire s;
	input wire[1:0] mode;
	input wire[3:0] opCode;
	output wire[3:0] executeCommand;
	output wire memRead, memWrite, writeBackEn, branch, sOut;

	wire[5:0] mop;

	assign mop = {mode, opCode};
	assign {executeCommand, memRead, memWrite, writeBackEn, branch, sOut} =
		(mop == `MOV) ? {`ALU_MOV, 2'b00, 1'b1, 1'b0, s} :
		(mop == `MVN) ? {`ALU_MVN, 2'b00, 1'b1, 1'b0, s} :
		(mop == `ADD) ? {`ALU_ADD, 2'b00, 1'b1, 1'b0, s} :
		(mop == `ADC) ? {`ALU_ADC, 2'b00, 1'b1, 1'b0, s} :
		(mop == `SUB) ? {`ALU_SUB, 2'b00, 1'b1, 1'b0, s} :
		(mop == `SBC) ? {`ALU_SBC, 2'b00, 1'b1, 1'b0, s} :
		(mop == `AND) ? {`ALU_AND, 2'b00, 1'b1, 1'b0, s} :
		(mop == `ORR) ? {`ALU_ORR, 2'b00, 1'b1, 1'b0, s} :
		(mop == `EOR) ? {`ALU_EOR, 2'b00, 1'b1, 1'b0, s} :
		(mop == `CMP) ? {`ALU_CMP, 2'b00, 1'b1, 1'b0, s} :
		(mop == `TST) ? {`ALU_TST, 2'b00, 1'b1, 1'b0, s} :
		(mop == `LDR) ? {`ALU_LDR, s, ~s, s,    1'b0, s} :
		(mop == `STR) ? {`ALU_STR, s, ~s, s,    1'b0, s} :
		({mode, opCode[3]} == 3'b100) ? 9'b0000_00_0_1_0 : 9'd0;


endmodule
