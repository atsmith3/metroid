module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

logic Clk = 0;
logic gateMDR, gateALU, gatePC, gateMARMUX;
logic [15:0] MDR_data, ALU_data, PC_data, MARMUX_data;
logic [15:0] DatapathIn, DatapathOut;
	
Datapath test(.*);		


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
MDR_data = 16'hF0F0;
ALU_data = 16'h0123;
PC_data = 16'h3210;
MARMUX_data = 16'hAA55;
DatapathIn = 16'hFFFF;
gateMDR = 1;
gateALU = 0;
gatePC = 0;
gateMARMUX = 0;

#2 begin
	gateMDR = 0;
	gateMARMUX = 1;
	end
#2 begin
	gateMARMUX = 0;
	gatePC = 1;
	end
#2 begin
	gatePC = 0;
	gateALU = 1;
	end
#2 gateALU = 0;


end
endmodule
