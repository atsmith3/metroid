module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic Clk = 0;
logic Reset, Run, ClearA_LoadB;
logic M;
logic Clr_Ld;
logic Shift;
logic Add;
logic Sub;
logic [3:0] currentState;
logic Clear_A;

// Controller test(.*);
						


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
Reset = 0;
ClearA_LoadB = 0;
Run = 0;
M = 1;

#2 Reset = 1;
#2 Reset = 0;

#2 ClearA_LoadB = 1;
#2 ClearA_LoadB = 0;

#2 Reset = 1;
#2 Reset = 0;

#2 Run = 1;
#2 Run = 0;

#8 ClearA_LoadB = 1;
#2 ClearA_LoadB = 0;

#2 M = 0;
#8 M = 1;

#32 Run = 1;

end
endmodule
