
module Val2Generator(reg2Val, immediate, shiftOperand, memEnable, aluIn2Val);
	input wire[31:0] reg2Val;
	input wire immediate, memEnable;
	input wire[11:0] shiftOperand;
	output wire[31:0] aluIn2Val;

	wire[31:0] beforeShift;
	wire[1:0] shiftMode;
	wire[4:0] shiftAmount;
	wire[4:0] rotation;
	assign shiftMode = shiftOperand[6:5];
	assign shiftAmount = shiftOperand[11:7];
	assign rotation = {1'b0, shiftOperand[11:8]};
	assign beforeShift = {24'b0, shiftOperand[7:0]};

	wire[31:0] rotatedImmediate, rotatedValue;
	RightRotator rightRotator1(.in(beforeShift), .rotation(rotation << 1), .out(rotatedImmediate));
	RightRotator rightRotator2(.in(reg2Val), .rotation(shiftAmount), .out(rotatedValue));
	assign aluIn2Val = (memEnable) ? {{20{shiftOperand[11]}},shiftOperand} :
				(immediate) ? rotatedImmediate :
					(shiftOperand[4]) ? reg2Val :
						(shiftMode == 2'b00) ? reg2Val << shiftAmount :
						(shiftMode == 2'b01) ? reg2Val >> shiftAmount :
						(shiftMode == 2'b10) ? reg2Val >>> shiftAmount :
						(shiftMode == 2'b11) ? rotatedValue : 32'bx;


endmodule
