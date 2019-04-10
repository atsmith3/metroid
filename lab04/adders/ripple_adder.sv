module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

     wire Cn[3:0];

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  	four_ripple_adder FRA0(.a(A[3:0]), .b(B[3:0]), .c_in(1'b0), .s(Sum[3:0]), .c_out(Cn[0]));
		four_ripple_adder FRA1(.a(A[7:4]), .b(B[7:4]), .c_in(Cn[0]), .s(Sum[7:4]), .c_out(Cn[1]));
		four_ripple_adder FRA2(.a(A[11:8]), .b(B[11:8]), .c_in(Cn[1]), .s(Sum[11:8]), .c_out(Cn[2]));
		four_ripple_adder FRA3(.a(A[15:12]), .b(B[15:12]), .c_in(Cn[2]), .s(Sum[15:12]), .c_out(CO));
     
endmodule
