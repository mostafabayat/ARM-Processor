
module RegisterUnitMEM2WB(clk, rst, writeBackEnIn, memReadIn, addressIn, memOutIn, destinationIn,
		writeBackEn, memRead, address, memOut, destination);
	input wire clk, rst;
	input wire writeBackEnIn, memReadIn;
	input wire[31:0] addressIn, memOutIn;
	input wire[3:0] destinationIn;
	output reg writeBackEn, memRead;
	output reg[31:0] address, memOut;
	output reg[3:0] destination;

	always @(posedge clk) begin
		{writeBackEn, memRead, address, memOut, destination} = (rst) ? 0 :
			{writeBackEnIn, memReadIn, addressIn, memOutIn, destinationIn};
	end


endmodule
