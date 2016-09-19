module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk = 0;
logic CO;
logic [15:0] Sum;
logic [15:0] B;
logic [15:0] A;
logic correct;

// Instantiating the DUT
// Make sure the module and signal names match with those in your design
ripple_adder test(.*);

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
correct = 0;
A = 16'h0000;
B = 16'h0000;

#3 begin
		A = 16'hFA5;
		B = 16'hF5A;
	end
end
endmodule
