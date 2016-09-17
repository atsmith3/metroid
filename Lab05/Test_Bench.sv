module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic Clk = 0;
logic [7:0] switches, Ain;
logic Add, Sub;
logic [7:0] Aout;
logic X;

NineBitAdder AdderUnit(.*);

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
Ain = 8'b00001111;
switches = 8'b00010000;
Add = 0;
Sub = 0;

#2 Add = 1;
#2 Add = 0;

#4 Sub = 1;
#2 Sub = 0;

end
endmodule
