// Top Level File for 8 bit multiplier
// Andrew Smith + Zach Gleason

module Multiplier(	input logic [7:0] Switches,
							input logic Clk, Reset, Run, ClearA_LoadB,
							output logic [6:0] AhexU, AhexL, BhexU, BhexL,
							output logic [7:0] Aval, Bval,
							output logic X);
							
	// Intermediate Logic Wires
	logic M;
	logic Clr_Ld;
	logic Shift;
	logic Add;
	logic Sub;
	logic [7:0] Aout;
							
							
	Controller 		LogicUnit(		.ClearA_LoadB(ClearA_LoadB),
											.Run(Run),
											.Reset(Reset),
											.Clk(Clk),
											.M(M),
											.Clr_Ld(Clr_Ld),
											.Shift(Shift), 
											.Add(Add), 
											.Sub(Sub));
	
	
	
   Registers		RegisterUnit(	.Ain(Aval[7:0]), 
											.Bin(Switches[7:0]),
											.Bout(Bval[7:0]),
											.X(X),
											.Clr_Ld(Clr_Ld),
											.Shift(Shift),
											.Clk(Clk),
											.Reset(Reset), 
											.Add(Add), 
											.Subtract(Sub),
											.Aout(Aout[7:0]), 
											.M(M));
	
	NineBitAdder	AdderUnit(		.switches(Switches[7:0]),
											.Ain(Aout[7:0]),
											.Aout(Aval[7:0]),
											.Add(Add),
											.Sub(Sub),
											.X(X));
											
	HexDriver		AUpper(	.In0(Aval[7:4]),.Out0(AhexU[6:0]));
	HexDriver		ALower(	.In0(Aval[3:0]),.Out0(AhexL[6:0]));
	HexDriver		BUpper(	.In0(Bval[7:4]),.Out0(BhexU[6:0]));
	HexDriver		BLower(	.In0(Bval[3:0]),.Out0(BhexL[6:0]));
							
endmodule