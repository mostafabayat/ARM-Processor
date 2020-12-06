
module MUX(select, in0, in1, out);
	parameter DATA_SIZE = 32;

	input wire select;
	input wire[DATA_SIZE-1:0] in0, in1;
	output wire[DATA_SIZE-1:0] out;

	assign out = (select) ? in1 : in0 ;

endmodule
