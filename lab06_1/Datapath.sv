//
// Datapath Mux:
module Datapath
(
	input logic gateMDR, gateALU, gatePC, gateMARMUX,
	input logic [15:0] MDR_data, ALU_data, PC_data, MARMUX_data,
	input logic [15:0] DatapathIn,
	output logic [15:0] DatapathOut
);

always_comb
begin
	if(gateMDR)
		DatapathOut = MDR_data;
	else if(gateALU)
		DatapathOut = ALU_data;
	else if(gatePC)
		DatapathOut = PC_data;
	else if(gateMARMUX)
		DatapathOut = MARMUX_data;
	else DatapathOut = DatapathIn;
end

endmodule