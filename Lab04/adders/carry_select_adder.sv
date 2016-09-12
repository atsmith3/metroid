module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
	  wire c_int[2:0];
	   
	  four_cs_adder FCS0(.cin(1'b0), .a(A[3:0]), .b(B[3:0]), .s(Sum[3:0]), .cout(c_int[0]));
	  four_cs_adder FCS1(.cin(c_int[0]), .a(A[7:4]), .b(B[7:4]), .s(Sum[7:4]), .cout(c_int[1]));
	  four_cs_adder FCS2(.cin(c_int[1]), .a(A[11:8]), .b(B[11:8]), .s(Sum[11:8]), .cout(c_int[2]));
	  four_cs_adder FCS3(.cin(c_int[2]), .a(A[15:12]), .b(B[15:12]), .s(Sum[15:12]), .cout(CO));
	  
endmodule
