module LAAdder
(
	input logic x, y, z, 
	output logic s, p, g
);

	always_comb
	begin: adder_logic
		assign s = x^y^z;
		assign p = x^y;
		assign g = x&y;
	end: adder_logic
	
endmodule

module Carry_Lookahead
(
	input logic [15:0] p,g,
	input logic	c_in,
	output logic [14:0] c_out,
	output logic Cn
);

	always_comb
	begin: lookahead_logic
		assign c_out[0] = g[0] | (c_in & p[0]);
		assign c_out[1] = g[1] | (c_out[0] & p[1]);
		assign c_out[2] = g[2] | (c_out[1] & p[2]);
		assign c_out[3] = g[3] | (c_out[2] & p[3]);
		assign c_out[4] = g[4] | (c_out[3] & p[4]);
		assign c_out[5] = g[5] | (c_out[4] & p[5]);
		assign c_out[6] = g[6] | (c_out[5] & p[6]);
		assign c_out[7] = g[7] | (c_out[6] & p[7]);
		assign c_out[8] = g[8] | (c_out[7] & p[8]);
		assign c_out[9] = g[9] | (c_out[8] & p[9]);
		assign c_out[10] = g[10] | (c_out[9] & p[10]);
		assign c_out[11] = g[11] | (c_out[10] & p[11]);
		assign c_out[12] = g[12] | (c_out[11] & p[12]);
		assign c_out[13] = g[13] | (c_out[12] & p[13]);
		assign c_out[14] = g[14] | (c_out[13] & p[14]);
		assign Cn = g[15] | (c_out[14] & p[15]);
	end: lookahead_logic
	
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
	
	two_input_mux(.a(s_internal[0]), .b(s_internal[1]), .select(cin), .out(s));
	
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













