module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
      wire Cn[2:0];
		
		four_LAAdder FLA0(.A(A[3:0]), .B(B[3:0]), .cin(1'b0), .cout(Cn[0]), .Sum(Sum[3:0]));
		four_LAAdder FLA1(.A(A[7:4]), .B(B[7:4]), .cin(Cn[0]), .cout(Cn[1]), .Sum(Sum[7:4]));
		four_LAAdder FLA2(.A(A[11:8]), .B(B[11:8]), .cin(Cn[1]), .cout(Cn[2]), .Sum(Sum[11:8]));
		four_LAAdder FLA3(.A(A[15:12]), .B(B[15:12]), .cin(Cn[2]), .cout(CO), .Sum(Sum[15:12]));
		
		
endmodule
