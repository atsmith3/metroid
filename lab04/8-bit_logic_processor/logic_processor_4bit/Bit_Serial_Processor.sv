module Bit_Serial_Processor(
						input logic   Clk,     // Internal
                                Reset,   // Push button 0
                                LoadA,   // Push button 1
                                LoadB,   // Push button 2
                                Execute, // Push button 3
                  input  logic [7:0]  Din,     // input data
                  input  logic [2:0]  F,       // Function select
                  input  logic [1:0]  R,       // Routing select
                  output logic [3:0]  LED,     // DEBUG
                  output logic [7:0]  Aval,    // DEBUG
                                Bval,    // DEBUG
                  output logic [6:0]  AhexL,
                                AhexU,
                                BhexL,
                                BhexU);

										  
	  Processor main(.*);
		  
endmodule