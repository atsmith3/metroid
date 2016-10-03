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

module BR_NZP
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
	if((IR[9] == 1'b1 & RegOut[0] == 1'b1) | (IR[10] == 1'b1 & RegOut[1] == 1'b1) | (IR[11] == 1'b1 & RegOut[2] == 1'b1))
		BENRegIn = 1'b1;
	else
		BENRegIn = 1'b0;
end


// Register Instances:
singleBitReg N(.In(RegIn[2]), .Load(LDCC), .Clk(Clk), .Reset(Reset), .Out(RegOut[2]));
singleBitReg Z(.In(RegIn[1]), .Load(LDCC), .Clk(Clk), .Reset(Reset), .Out(RegOut[1]));
singleBitReg P(.In(RegIn[0]), .Load(LDCC), .Clk(Clk), .Reset(Reset), .Out(RegOut[0]));
singleBitReg BreakEnableReg(.In(BENRegIn), .Load(LDBEN), .Clk(Clk), .Reset(Reset), .Out(BEN));


endmodule