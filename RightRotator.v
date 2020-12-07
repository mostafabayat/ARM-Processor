
module RightRotator(in, rotation, out);
	input wire[31:0] in;
	input wire[5:0] rotation;
	output reg[31:0] out;

	integer r;
	integer i;
	always @ ( * ) begin
		r = rotation;
		out = in;
		for (i = 0; i < r; i = i + 1) begin
			out = {out[0], out[31:1]};
		end
	end

endmodule
