/*module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic Clk = 0;
logic [15:0] DataIn;
logic [19:0] DataOut;


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
DataIn = 16'hF0F0;

#2 DataIn = 16'h0123;
#2 DataIn = 16'h3210;
#2 DataIn = 16'hAA55;


end
endmodule
*/