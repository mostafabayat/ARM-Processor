
module ForwardingUnit(src1, src2, writeBackEnMEM, destinationMEM, writeBackEnWB, destinationWB, selSrc1, selSrc2);
	input wire[3:0] src1, src2, destinationMEM, destinationWB;
	input wire writeBackEnMEM, writeBackEnWB;
	output wire[1:0] selSrc1, selSrc2;

	assign selSrc1 = ((writeBackEnMEM == 1'b1) && (destinationMEM == src1)) ? 2'b01 :
			((writeBackEnWB == 1'b1) && (destinationWB == src1)) ? 2'b10 : 2'b00;
	assign selSrc2 = ((writeBackEnMEM == 1'b1) &&	(destinationMEM == src2)) ? 2'b01 :
			((writeBackEnWB == 1'b1) && (destinationWB == src2)) ? 2'b10 :2'b00;

endmodule
