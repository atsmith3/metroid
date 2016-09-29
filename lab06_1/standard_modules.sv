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

//D FLip Flop
module FlipFlop(input logic in, Clk, Clr_Ld, Reset,
					 output logic out);

	always_ff @ (posedge Clk)
	begin
		if(Reset | Clr_Ld)
			out <= 1'b0;
		else
			out <= in;
	end

endmodule


// 16 bit register
module SixteenBitShiftRegister(	input logic [15:0] DataIn,
											          input logic         Clk, Reset, Load, ShiftEnable, ShiftIn,
											          output logic [15:0] DataOut,
											          output logic        ShiftOut);
										
	always_ff @ (posedge Clk)
	begin
		if(Reset)
			DataOut <= 16'b0;
		else if (Load)
			DataOut <= DataIn [15:0];
		else if (ShiftEnable)
			DataOut <= {ShiftIn, DataOut[15:1]};
		else
			DataOut = DataOut;
	end
	
   always_comb
	begin
		ShiftOut = DataOut[0];		
	end	
endmodule


// 16 Bit ripple adder
module SixteenBitRippleAdder
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


// 4 Bit Ripple Adder:
module four_ripple_adder
(
	input logic c_in,
	input logic [3:0] a, b,
	output logic c_out,
	output logic [3:0] s
);
	wire c_temp[2:0];
	
	FullAdder FA0(.x(a[0]), .y(b[0]), .z(c_in), .c(c_temp[0]), .s(s[0]));
	FullAdder FA1(.x(a[1]), .y(b[1]), .z(c_temp[0]), .c(c_temp[1]), .s(s[1]));
	FullAdder FA2(.x(a[2]), .y(b[2]), .z(c_temp[1]), .c(c_temp[2]), .s(s[2]));
	FullAdder FA3(.x(a[3]), .y(b[3]), .z(c_temp[2]), .c(c_out), .s(s[3]));

endmodule
