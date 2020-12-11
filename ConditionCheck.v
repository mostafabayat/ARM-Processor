`define EQ	4'b0000
`define NE	4'b0001
`define CS_HS	4'b0010
`define CC_LO 	4'b0011
`define MI 	4'b0100
`define PL	4'b0101
`define VS	4'b0110
`define VC	4'b0111
`define HI	4'b1000
`define LS	4'b1001
`define GE	4'b1010
`define LT	4'b1011
`define GT	4'b1100
`define LE	4'b1101
`define AL	4'b1110


module ConditionCheck(condition, N, Z, C, V, out);
	input wire N, Z, C, V;
	input wire[3:0] condition;
	output reg out;
	
	always @(*)begin
	case(condition)
		`EQ: 	out <= Z;
		`NE:	out <= !Z;
		`CS_HS: out <= C;
		`CC_LO: out <= !C;
		`MI: 	out <= N;
		`PL: 	out <= !N;
		`VS: 	out <= V;
		`VC: 	out <= !V;
		`HI: 	out <= C && !Z;
		`LS: 	out <= !C || Z;
		`GE: 	out <= N == V;
		`LT: 	out <= N != V;
		`GT: 	out <= Z == 0 && N == V;
		`LE: 	out <= Z == 1 || N != V;
		`AL: 	out <= 1;
	endcase
end

endmodule
