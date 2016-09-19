module four_ripple_adder
(
 input logic c_in,
 input logic [3:0] a, b,
 output logic c_out,
 output logic [3:0] s
);
	wire c_temp[2:0];
	
	full_adder FA0(.x(a[0]), .y(b[0]), .z(c_in), .c(c_temp[0]), .s(s[0]));
	full_adder FA1(.x(a[1]), .y(b[1]), .z(c_temp[0]), .c(c_temp[1]), .s(s[1]));
	full_adder FA2(.x(a[2]), .y(b[2]), .z(c_temp[1]), .c(c_temp[2]), .s(s[2]));
	full_adder FA3(.x(a[3]), .y(b[3]), .z(c_temp[2]), .c(c_out), .s(s[3]));

endmodule

module LAAdder
(
	input logic x, y, z, 
	output logic s, p, g
);

		assign s = x^y^z;
		assign p = x^y;
		assign g = x&y;
	
endmodule

module Carry_four_Lookahead
(
	input logic [3:0] p,q,
	input logic	c_in,
	output logic [2:0] c_out,
	output logic Cn
);

	
		assign c_out[0] = q[0] | (c_in & p[0]);
		assign c_out[1] = q[1] | ((q[0] | (c_in & p[0])) & p[1]);
		assign c_out[2] = q[2] | ((q[1] | ((q[0] | (c_in & p[0])) & p[1])) & p[2]);
		assign Cn = q[3] | ((q[2] | ((q[1] | ((q[0] | (c_in & p[0])) & p[1])) & p[2])) & p[3]);
	
endmodule

module four_LAAdder
(
	input logic [3:0] A, B,
	input logic cin,
   output logic cout,
	output logic [3:0] Sum
);

   wire [3:0] p, q;
	wire [2:0] cint;

	LAAdder LA0(.x(A[0]), .y(B[0]), .z(cin), .s(Sum[0]), .p(p[0]), .g(q[0]));
	LAAdder LA1(.x(A[1]), .y(B[1]), .z(cint[0]), .s(Sum[1]), .p(p[1]), .g(q[1]));
	LAAdder LA2(.x(A[2]), .y(B[2]), .z(cint[1]), .s(Sum[2]), .p(p[2]), .g(q[2]));
	LAAdder LA3(.x(A[3]), .y(B[3]), .z(cint[2]), .s(Sum[3]), .p(p[3]), .g(q[3]));
	
	Carry_four_Lookahead C4LA1(.c_in(cin), .p(p[3:0]), .q(q[3:0]), .Cn(cout), .c_out(cint[2:0]));

endmodule

module C_S_Adder
(
	input logic cin, a, b,
	output logic cout, s
);

	wire s_internal[1:0], adder_internal[1:0];
	

	full_adder FA0(.x(a), .y(b), .z(1'b0), .s(s_internal[0]), .c(adder_internal[0]));
	full_adder FA1(.x(a), .y(b), .z(1'b1), .s(s_internal[1]), .c(adder_internal[1]));
	
	assign cout = (adder_internal[1] & cin) | adder_internal[0];
	
	two_input_mux MUX1(.a(s_internal[0]), .b(s_internal[1]), .select(cin), .out(s));
	
endmodule

module four_cs_adder
(
	input logic cin,
   input logic [3:0] a, b,
   output logic [3:0] s,
   output logic cout	
);

   wire c_int[2:0];

	C_S_Adder CS0(.cin(cin),      .a(a[0]), .b(b[0]), .s(s[0]), .cout(c_int[0]));
   C_S_Adder CS1(.cin(c_int[0]), .a(a[1]), .b(b[1]), .s(s[1]), .cout(c_int[1]));
	C_S_Adder CS2(.cin(c_int[1]), .a(a[2]), .b(b[2]), .s(s[2]), .cout(c_int[2]));
	C_S_Adder CS3(.cin(c_int[2]), .a(a[3]), .b(b[3]), .s(s[3]), .cout(cout));

endmodule













