
module HazardDetectionUnit(src1, src2, twoSrc, memReadEXE, destinationEXE, writeBackEnEXE, destinationMEM, writeBackEnMEM, forwardEn, hazardDetected);
	input wire[3:0] src1, src2, destinationEXE, destinationMEM;
	input wire memReadEXE, writeBackEnEXE, writeBackEnMEM, twoSrc, forwardEn;
	output wire hazardDetected;

	assign hazardDetected = (forwardEn) ?
		//when forwarding enable
	 	(memReadEXE && ((destinationEXE == src1) || (twoSrc && (destinationEXE == src2)))) :
		//when forwarding disable
	 	(((src1 == destinationEXE) && writeBackEnEXE) ||
		((src1 == destinationMEM) && writeBackEnMEM) ||
		(twoSrc && (src2 == destinationEXE) && writeBackEnEXE) ||
		(twoSrc && (src2 == destinationMEM) && writeBackEnMEM));
endmodule
