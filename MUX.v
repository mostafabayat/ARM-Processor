
module MUX(clk, rst, select, in, out);
	parameter DATA_SIZE = 32;
	parameter SELECT_SIZE = 1;
	input wire clk, rst;

	input wire[SELECT_SIZE-1:0] select;
	input wire[DATA_SIZE-1:0] in[2**SELECT_SIZE-1:0];
	output wire[DATA_SIZE-1:0] out;

	assign out = in[select];

endmodule // MUX
