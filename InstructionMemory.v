

module instructionMemory(address, instruction);
	input wire[31:0] address;
	output reg[31:0] instruction;

	always @(*) begin
		case(address/4)
			32'd0: instruction <= 32'b1110_00_1_1101_0_0000_0000_000000010101;
			32'd1: instruction <= 32'b1110_00_1_1101_0_0000_0001_101000000001;
			32'd2: instruction <= 32'b1110_00_1_1101_0_0000_1101_110000000010;
			32'd3: instruction <= 32'b1110_01_0_1111_0_0000_0000_000000000000;
			32'd4: instruction <= 32'b1110_01_0_1111_0_0001_0000_000000000000;
			32'd5: instruction <= 32'b1110_01_0_1111_1_0000_0000_000000000000;
			32'd6: instruction <= 32'b1110_01_0_1111_1_0000_0001_000000000000;
			32'd7: instruction <= 32'b1110_10_1_0_111111111111111111111111;
			default: instruction <= 32'd0;
		endcase
	end

endmodule
