//
// Datapath Mux:
module Datapath
(
	input logic gateMDR, gateALU, gatePC, gateMARMUX,
	input logic [15:0] MDR_data, ALU_data, PC_data, MARMUX_data,
	output logic [15:0] Datapath
);

always_comb
begin
	if(gateMDR)
		Datapath = MDR_data;
	else if(gateALU)
		Datapath = ALU_data;
	else if(gatePC)
		Datapath = PC_data;
	else if(gateMARMUX)
		Datapath = MARMUX_data;
	else Datapath = 16'h0000;
end

endmodule