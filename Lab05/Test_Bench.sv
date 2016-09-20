module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic Clk = 0;
logic [7:0] Switches;
logic Reset, Run, ClearA_LoadB;
logic [6:0] AhexU, AhexL, BhexU, BhexL;
logic [7:0] Aval, Bval;
logic X;

logic M;
logic Clr_Ld;
logic Shift;
logic Add;
logic Sub;
logic [7:0] Anew;
logic [3:0] currentState;
						
						
Controller 		LogicUnit(		.ClearA_LoadB(~ClearA_LoadB),
										.Run(~Run),
										.Reset(~Reset),
										.Clk(Clk),
										.M(M),
										.Clr_Ld(Clr_Ld),
										.Shift(Shift), 
										.Add(Add), 
										.Sub(Sub),
										.currentState(currentState));



Registers		RegisterUnit(	.Ain(Anew[7:0]), 
										.Bin(Switches[7:0]),
										.Bout(Bval[7:0]),
										.X(X),
										.Clr_Ld(Clr_Ld),
										.Shift(Shift),
										.Clk(Clk),
										.Reset(~Reset), 
										.Add(Add), 
										.Subtract(Sub),
										.Aout(Aval[7:0]), 
										.M(M));

NineBitAdder	AdderUnit(		.switches(Switches[7:0]),
										.Ain(Aval[7:0]),
										.Aout(Anew[7:0]),
										.Add(Add),
										.Sub(Sub),
										.X(X));

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
Reset = 1;
ClearA_LoadB = 1;
Run = 1;
Switches = 8'b11000101;

#2 Reset = 0;
#2 Reset = 1;

#2 ClearA_LoadB = 0;
#2 ClearA_LoadB = 1;

#2 Reset = 0;
#2 Reset = 1;

#2 ClearA_LoadB = 0;
#2 begin 
		ClearA_LoadB = 1;
		Switches = 8'b00000111;
	end
	
#2 Run = 0;
#2 Run = 1;

end
endmodule
