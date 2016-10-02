module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic [15:0] S;
logic	Clk, Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data; //tristate buffers need to be of type wire

slc3 slc3test(.*);


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
Reset = 1'b1;
Run = 1'b1;
Continue = 1'b1;
S = 16'h000B;

#2 Reset = 1'b0;
#2 Reset = 1'b1;

#2 Run = 1'b0;
#2 Run = 1'b1;

#50 Continue = 1'b0;
#2 Continue = 1'b1;

#50 Continue = 1'b0;
#2 Continue = 1'b1;

#120 Continue = 1'b0;
#2 Continue = 1'b1;


end
endmodule