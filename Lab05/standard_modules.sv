module TwoInputMux
(
	input logic a, b, select,
	output logic out
);

	assign out = (~select & a) | (select & b);
	
endmodule

module FourInputMux
(
	input logic a, b, c, d, [1:0] select,
	output logic out
);

	assign out = (~select[0] & ~select[1] & a) | (select[0] & ~select[1] & b) | (~select[0] & select[1] & c) | (select[0] & select[1] & d);
	
endmodule

module FullAdder
(
	input logic x, y, z, 
	output logic s, c
);
		assign s = x^y^z;
		assign c = (x&y)|(x&z)|(z&y);

endmodule

