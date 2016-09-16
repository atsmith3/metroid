// Nine bit adder module

module NineBitAdder(	input logic [7:0] switches, Ain,
							input logic Add, Sub,
							output logic [7:0] Aout,
							output logic X);
	
	//Find 2's Comp of A and store it into Acomp
	logic cComp;
	logic outC;
	logic Acomp [7:0];
	logic Out [7:0];
	FourBitRippleCarryAdder AC0(.A(Ain[3:0]),.B(b'40001),.Cin(1'b0),.Cout[cComp]);
	FourBitRippleCarryAdder AC0(.A(Ain[7:4]),.B(b'40000),.Cin(cComp),.Cout[]);
	//Determine what goes into Adder
	BusSelector(.A(Ain[7:0]),.*}));
	//Find output of the NineBitAdder
	FourBitRippleCarryAdder FFA0(.A(Ain[3:0]),.B(Out[3:0]),.Cin(1'b0),.Sum(Aout[3:0]),.Cout(outC))
	FourBitRippleCarryAdder FFA1(.A(Ain[7:4]),.B(Out[7:4]),.Cin(outC),.Sum(Aout[3:0]),.Cout(X))
							
endmodule


// 4 bit adder module
module FourBitRippleCarryAdder(	logic input [3:0] A, B,
											logic input Cin
											logic output [3:0] Sum,
											logic output Cout);
											
	logic c [2:0];
											
	FullAdder FA0(.x(A[0]),.y(B[0]),.z(Cin),.s(Sum[0]),.c(c[0]));
	FullAdder FA1(.x(A[1]),.y(B[1]),.z(c[0]),.s(Sum[1]),.c(c[1]));
	FullAdder FA2(.x(A[2]),.y(B[2]),.z(c[1]),.s(Sum[2]),.c(c[2]));
	FullAdder FA3(.x(A[3]),.y(B[3]),.z(c[2]),.s(Sum[3]),.c(Cout));
	
endmodule

// Bus Selector
module BusSelector( 	logic input [7:0] A, Acomp,
							logic input Add, Sub,
							logic output [7:0] Out);
			
	logic [1:0] Select;
	
	always_comb
	begin
		if(Add)
			Select = 2'b01;
		else if(Sub)
			Select = 2'b10;
		else
			Select = 2'b00;
	end
	
	// Now couple the output with the proper bus:
			
	FourInputMux(.a(1'b0),.b(A[0]),.c(Acomp[0]),.d(1'b0),.select(Select[1:0]),.out(Out[0]));
							
endmodule