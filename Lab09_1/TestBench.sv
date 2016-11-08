// Testbench for the AES controller module:
// Andrew Smith 11/7/16
// ECE 385

module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

//Inputs
logic clk;
logic reset_n;
logic [127:0] msg_en;
logic [127:0] key;
//Outputs
logic [127:0] msg_de;
logic aes_ready;
logic aes_begin;


AES aesp(.Clk(clk), .Plaintext(msg_en), .Cipherkey({key[127:96], key[95:64], key[63:32], key[31:0]}), .Run(aes_begin), .Ciphertext({msg_de[127:96], msg_de[95:64], msg_de[63:32], msg_de[31:0]}), .Ready(aes_complete));

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 clk = ~clk;
end

initial begin: CLOCK_INITIALIZATION
    clk = 0;
end 

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin: TEST_VECTORS
reset_n = 1'b1;
msg_en = 128'hdaec3055df058e1c39e814ea76f6747e;
key = 128'h000102030405060708090a0b0c0d0e0f;
aes_begin = 1'b0;

// Start the encryption process:
#2 reset_n = 1'b0;
#2 reset_n = 1'b1;
#2 aes_begin = 1'b1;


end
endmodule