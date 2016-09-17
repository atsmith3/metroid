// Nine bit adder module

module NineBitAdder(	input logic [7:0] switches, Ain,
							input logic Add, Sub,
							output logic [7:0] Aout,
							output logic X);
	
	//Find 2's Comp of A and store it into Scomp
	logic cComp;
	logic outC;
	logic [7:0] Scomp;
	logic [7:0] Out;
	
	FourBitRippleCarryAdder AC0(.A(~switches[3:0]),.B(4'b0001),.Cin(1'b0),.Cout(cComp),.Sum(Scomp[3:0]));
	FourBitRippleCarryAdder AC1(.A(~switches[7:4]),.B(4'b0000),.Cin(cComp),.Cout(),.Sum(Scomp[7:4]));
	//Determine what goes into Adder
	BusSelector(.A(Ain[7:0]),.*);
	//Find output of the NineBitAdder
	FourBitRippleCarryAdder FFA0(.A(Ain[3:0]),.B(Out[3:0]),.Cin(1'b0),.Sum(Aout[3:0]),.Cout(outC));
	FourBitRippleCarryAdder FFA1(.A(Ain[7:4]),.B(Out[7:4]),.Cin(outC),.Sum(Aout[7:4]),.Cout(X));

	
endmodule


// 4 bit adder module
module FourBitRippleCarryAdder(	input logic [3:0] A, B,
											input logic Cin,
											output logic [3:0] Sum,
											output logic Cout);
											
	logic [2:0] c;
											
	FullAdder FA0(.x(A[0]),.y(B[0]),.z(Cin),.s(Sum[0]),.c(c[0]));
	FullAdder FA1(.x(A[1]),.y(B[1]),.z(c[0]),.s(Sum[1]),.c(c[1]));
	FullAdder FA2(.x(A[2]),.y(B[2]),.z(c[1]),.s(Sum[2]),.c(c[2]));
	FullAdder FA3(.x(A[3]),.y(B[3]),.z(c[2]),.s(Sum[3]),.c(Cout));
	
endmodule

// Bus Selector
module BusSelector( 	input logic [7:0] A, Scomp,
							input logic Add, Sub,
							output logic [7:0] Out);
	integer i;
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
	FourInputMux F0(.a(1'b0),.b(A[0]),.c(Scomp[0]),.d(1'b1),.select(Select[1:0]),.out(Out[0]));
	FourInputMux F1(.a(1'b0),.b(A[1]),.c(Scomp[1]),.d(1'b1),.select(Select[1:0]),.out(Out[1]));
	FourInputMux F2(.a(1'b0),.b(A[2]),.c(Scomp[2]),.d(1'b1),.select(Select[1:0]),.out(Out[2]));
	FourInputMux F3(.a(1'b0),.b(A[3]),.c(Scomp[3]),.d(1'b1),.select(Select[1:0]),.out(Out[3]));
	FourInputMux F4(.a(1'b0),.b(A[4]),.c(Scomp[4]),.d(1'b1),.select(Select[1:0]),.out(Out[4]));
	FourInputMux F5(.a(1'b0),.b(A[5]),.c(Scomp[5]),.d(1'b1),.select(Select[1:0]),.out(Out[5]));
	FourInputMux F6(.a(1'b0),.b(A[6]),.c(Scomp[6]),.d(1'b1),.select(Select[1:0]),.out(Out[6]));
	FourInputMux F7(.a(1'b0),.b(A[7]),.c(Scomp[7]),.d(1'b1),.select(Select[1:0]),.out(Out[7]));
								
endmodule