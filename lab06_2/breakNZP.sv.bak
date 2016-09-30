//
//
//
// Break NZP Module
//
// Logic and registers for break logic
//
// Inputs:
//
//
// Outputs:
//
//
//-------------------------------------------------------------------------------------------------

module BreakNZP
(
	input logic 	[15:0] DataIn, IR,
	input logic 	Clk, Reset, LDCC, LDBEN,
	output logic 	BEN
);

// Internal Signals:
logic [2:0] RegIn;  	// 2 <=> N : 1 <=> Z : 0 <=> P
logic [2:0] RegOut; 	// 2 <=> N : 1 <=> Z : 0 <=> P
logic BENRegIn;


// Input Logic:
always_comb
begin
	if(DataIn == 16'b0)
		RegIn = 3'b010;
	else if(DataIn[15] == 1'b1)
		RegIn = 3'b100;
	else
		RegIn = 3'b001;
end


// Output Logic:
always_comb
begin
	if(IR[9] == RegOut[0] | IR[10] == RegOut[1] | IR[11] == RegOut[2])
		BENRegOut = 1;
	else
		BENRegOut = 0;
end


// Register Instances:
FLipFLop N(.in(RegIn[2]), .Clk(Clk), .Reset(Reset), .out(RegOut[2]));
FLipFLop Z(.in(RegIn[1]), .Clk(Clk), .Reset(Reset), .out(RegOut[1]));
FLipFLop P(.in(RegIn[0]), .Clk(Clk), .Reset(Reset), .out(RegOut[0]));
FLipFLop BreakEnableReg(.in(BENRegIn), .Clk(Clk), .Reset(Reset), .out(BEN));


endmodule