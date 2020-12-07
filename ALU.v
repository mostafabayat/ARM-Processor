
`define OP_MOV 4'b0001
`define OP_MVN 4'b1001
`define OP_ADD 4'b0010
`define OP_ADC 4'b0011
`define OP_SUB 4'b0100
`define OP_SBC 4'b0101
`define OP_AND 4'b0110
`define OP_ORR 4'b0111
`define OP_EOR 4'b1000
`define OP_CMP 4'b0100
`define OP_TST 4'b0110
`define OP_LDR 4'b0010
`define OP_STR 4'b0010

module ALU(ALUOperation, in1, in2, carry, out, NOut, ZOut, COut, VOut);
	input wire carry;
	input wire[3:0] ALUOperation;
	input wire[31:0] in1, in2;
	output reg[31:0] out;
	output wire NOut, ZOut;
	output reg COut, VOut;

	always @ ( * ) begin
		{COut, VOut} <= 2'b00;
		case (ALUOperation)
		`OP_MOV : begin
			out <= in2;
		end
		`OP_MVN : begin
			out <= ~in2;
		end
		`OP_ADD : begin
			{COut, out} <= in1 + in2;
			VOut <= (in1[31] == in2[31]) & (in1[31] != out[31]);
		end
		`OP_ADC : begin
			{COut, out} <= in1 + in2 + carry;
			// VOut <= (in1[31] == in2[31]) & (in1[31] != out[31]);
		end
		`OP_SUB : begin
			{COut, out} <= in1 - in2;
			VOut <= (in1[31] != in2[31]) & (in1[31] != out[31]);
		end
		`OP_SBC : begin
			{COut, out} <= in1 - in2 - 1;
		// VOut <= (in1[31] == in2[31]) & (in1[31] != out[31]);
		end
		`OP_AND : begin
			out <= in1 & in2;
		end
		`OP_ORR : begin
			out <= in1 | in2;
		end
		`OP_EOR : begin
			out <= in1 ^ in2;
		end
		`OP_CMP : begin
			out <= in1 - in2;
		end
		`OP_TST : begin
			out <= in1 & in2;
		end
		`OP_LDR : begin
			out <= in1 + in2;
		end
		`OP_STR : begin
			out <= in1 + in2;
		end
		default: begin
			out <= 32'bx;
		end
		endcase
	end
	assign NOut = out[31];
	assign ZOut = (out == 0) ? 1'b1 : 1'b0;

endmodule
