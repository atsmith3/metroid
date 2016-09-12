module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

     wire Cn[14:0];

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  	full_adder FA0(.x(A[0]), .y(B[0]), .z(1'b0), .s(Sum[0]), .c(Cn[0]));
		full_adder FA1(.x(A[1]), .y(B[1]), .z(Cn[0]), .s(Sum[1]), .c(Cn[1]));
		full_adder FA2(.x(A[2]), .y(B[2]), .z(Cn[1]), .s(Sum[2]), .c(Cn[2]));
		full_adder FA3(.x(A[3]), .y(B[3]), .z(Cn[2]), .s(Sum[3]), .c(Cn[3]));
		full_adder FA4(.x(A[4]), .y(B[4]), .z(Cn[3]), .s(Sum[4]), .c(Cn[4]));
		full_adder FA5(.x(A[5]), .y(B[5]), .z(Cn[4]), .s(Sum[5]), .c(Cn[5]));
		full_adder FA6(.x(A[6]), .y(B[6]), .z(Cn[5]), .s(Sum[6]), .c(Cn[6]));
		full_adder FA7(.x(A[7]), .y(B[7]), .z(Cn[6]), .s(Sum[7]), .c(Cn[7]));
		full_adder FA8(.x(A[8]), .y(B[8]), .z(Cn[7]), .s(Sum[8]), .c(Cn[8]));
		full_adder FA9(.x(A[9]), .y(B[9]), .z(Cn[8]), .s(Sum[9]), .c(Cn[9]));
		full_adder FA10(.x(A[10]), .y(B[10]), .z(Cn[9]), .s(Sum[10]), .c(Cn[10]));
		full_adder FA11(.x(A[11]), .y(B[11]), .z(Cn[10]), .s(Sum[11]), .c(Cn[11]));
		full_adder FA12(.x(A[12]), .y(B[12]), .z(Cn[11]), .s(Sum[12]), .c(Cn[12]));
		full_adder FA13(.x(A[13]), .y(B[13]), .z(Cn[12]), .s(Sum[13]), .c(Cn[13]));
		full_adder FA14(.x(A[14]), .y(B[14]), .z(Cn[13]), .s(Sum[14]), .c(Cn[14]));
		full_adder FA15(.x(A[15]), .y(B[15]), .z(Cn[14]), .s(Sum[15]), .c(CO));

     
endmodule
