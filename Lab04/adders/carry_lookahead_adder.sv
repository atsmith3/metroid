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
      wire Cn[14:0];
		wire p[15:0];
		wire q[15:0];
	  
		LAAdder LA0(.x(A[0]), .y(B[0]), .z(1'b0), .s(Sum[0]), .p(p[0]), .q(q[0]));
		LAAdder LA1(.x(A[1]), .y(B[1]), .z(Cn[0]), .s(Sum[1]), .p(p[1]), .q(q[1]));
		LAAdder LA2(.x(A[2]), .y(B[2]), .z(Cn[1]), .s(Sum[2]), .p(p[2]), .q(q[2]));
		LAAdder LA3(.x(A[3]), .y(B[3]), .z(Cn[2]), .s(Sum[3]), .p(p[3]), .q(q[3]));
		LAAdder LA4(.x(A[4]), .y(B[4]), .z(Cn[3]), .s(Sum[4]), .p(p[4]), .q(q[4]));
		LAAdder LA5(.x(A[5]), .y(B[5]), .z(Cn[4]), .s(Sum[5]), .p(p[5]), .q(q[5]));
		LAAdder LA6(.x(A[6]), .y(B[6]), .z(Cn[5]), .s(Sum[6]), .p(p[6]), .q(q[6]));
		LAAdder LA7(.x(A[7]), .y(B[7]), .z(Cn[6]), .s(Sum[7]), .p(p[7]), .q(q[7]));
		LAAdder LA8(.x(A[8]), .y(B[8]), .z(Cn[7]), .s(Sum[8]), .p(p[8]), .q(q[8]));
		LAAdder LA9(.x(A[9]), .y(B[9]), .z(Cn[8]), .s(Sum[9]), .p(p[9]), .q(q[9]));
		LAAdder LA10(.x(A[10]), .y(B[10]), .z(Cn[9]), .s(Sum[10]), .p(p[10]), .q(q[10]));
		LAAdder LA11(.x(A[11]), .y(B[11]), .z(Cn[10]), .s(Sum[11]), .p(p[11]), .q(q[11]));
		LAAdder LA12(.x(A[12]), .y(B[12]), .z(Cn[11]), .s(Sum[12]), .p(p[12]), .q(q[12]));
		LAAdder LA13(.x(A[13]), .y(B[13]), .z(Cn[12]), .s(Sum[13]), .p(p[13]), .q(q[13]));
		LAAdder lA14(.x(A[14]), .y(B[14]), .z(Cn[13]), .s(Sum[14]), .p(p[14]), .q(q[14]));
		LAAdder LA15(.x(A[15]), .y(B[15]), .z(Cn[14]), .s(Sum[15]), .p(p[15]), .q(q[15]));

		Carry_Lookahead CL0(.p(p[15:0]), .g(q[15:0]), .c_in(1'b0), .c_out(Cn[14:0]), .Cn(CO));
		
endmodule
