
module RegisterUnitIF2ID(clk, rst, freeze, flush, PCIn, instructionIn, PC, instruction);
	input wire clk, rst;
	input wire freeze, flush;
	input[31:0] PCIn, instructionIn;
	output reg [31:0] PC, instruction;

	always @(posedge clk) begin
		if (rst | flush) {PC, instruction} = 0;
		else if (!freeze) {PC, instruction} = {PCIn, instructionIn};
	end
endmodule
