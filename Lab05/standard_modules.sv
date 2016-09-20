module TwoInputMux
(
	input logic a, b, select,
	output logic out
);

	assign out = (~select & a) | (select & b);
	
endmodule

module FourInputMux
(
	input logic a, b, c, d, 
	input logic [1:0] select,
	output logic out
);

	always_comb
	begin
		unique case (select)
			2'b00:	out = a;
			2'b01:	out = b;
			2'b10:	out = c;
			2'b11:	out = d;
			default  out = a;
		endcase
	end
	
endmodule

module FullAdder
(
	input logic x, y, z, 
	output logic s, c
);
		assign s = x^y^z;
		assign c = (x&y)|(x&z)|(z&y);

endmodule

