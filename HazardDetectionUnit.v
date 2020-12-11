
module HazardDetectionUnit(src1, src2, twoSrc, destinationEXE, writeBackEnEXE, destinationMEM, writeBackEnMEM, hazardDetected);
	input wire[3:0] src1, src2, destinationEXE, destinationMEM;
	input wire writeBackEnEXE, writeBackEnMEM, twoSrc;
	output wire hazardDetected;

	assign hazardDetected = (((src1 == destinationEXE) && writeBackEnEXE) ||
		((src1 == destinationMEM) && writeBackEnMEM) ||
		(twoSrc && (src2 == destinationEXE) && writeBackEnEXE) ||
		(twoSrc && (src2 == destinationMEM) && writeBackEnMEM));
endmodule
