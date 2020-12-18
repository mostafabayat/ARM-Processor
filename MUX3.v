
module MUX3(select, in0, in1, in2, out);
	parameter DATA_SIZE = 32;

	input wire[1:0] select;
	input wire[DATA_SIZE-1:0] in0, in1, in2;
	output wire[DATA_SIZE-1:0] out;

	assign out = (select == 2'b00) ? in0 :
	 		(select == 2'b01) ? in1 :
			(select == 2'b10) ? in2 : {DATA_SIZE{1'bx}};

endmodule
