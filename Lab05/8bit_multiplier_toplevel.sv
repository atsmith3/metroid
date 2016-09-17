// Top Level File for 8 bit multiplier
// Andrew Smith + Zach Gleason

module Multiplier(	input logic [7:0] Switches,
							input logic Clk, Reset, Run, ClearA_LoadB,
							output logic [6:0] AhexU, AhexL, BhexU, BhexL,
							output logic [7:0] Aval, Bval,
							output logic X);
							
	// Intermediate Logic Wires
	logic M;
							
							
	Controller 		LogicUnit(		);
	
	NineBitAdder	AdderUnit(		.switches,
											.Ain,
											.Add,
											.Sub,
											.Aout,
											.X);
	
   Registers		RegisterUnit(	Ain, 
											Bin,
											X, 
											Clr_Ld, 
											Shift, 
											Clk, 
											Reset, 
											Add, 
											Subtract,
											Aout,
											Bout,
											M);
	

endmodule