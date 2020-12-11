
module WriteBack(memRead, ALUResult, memOut, result);
	input wire memRead;
	input wire[31:0] ALUResult, memOut;
	output wire[31:0] result;
	MUX writeBackMUX(.select(memRead), .in0(ALUResult), .in1(memOut), .out(result));
endmodule
