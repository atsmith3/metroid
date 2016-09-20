module two_input_mux
(
	input logic a, b, select,
	output logic out
);

	assign out = (~select & a) | (select & b);
	
endmodule

module full_adder
(
	input logic x, y, z, 
	output logic s, c
);
		assign s = x^y^z;
		assign c = (x&y)|(x&z)|(z&y);

endmodule