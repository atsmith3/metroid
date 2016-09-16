// Register file

module Reagisters(	input logic [7:0] Ain, Bin,
							input logic X, Clr_Ld, Shift, Clk, Reset, Add, Subtract,
							output logic [7:0] Aout, Bout,
							output logic M);
	
	logic ab, xa;
	EightBitShiftRegister RegA(.DataIn([7:0]Ain), 
										.DataOut([7:0]Aout), 
										.ShiftEnable(Shift), 
										.ShiftIn(xa), 
										.ShiftOut(ab), 
										.Clk(Clk), 
										.Reset(Reset | Clr_Ld), 
										.Load(Add | Subtract));
										
	EightBitShiftRegister RegB(.DataIn([7:0]Bin), 
										.DataOut([7:0]Bout), 
										.ShiftEnable(Shift), 
										.ShiftIn(ab), 
										.ShiftOut(M), 
										.Clk(Clk), 
										.Reset(Reset), 
										.Load(Clr_Ld));
										
	X_Flop RegX(.Xin(X),
					.Xout(xa),
					.Clk(Clk),
					.Clr_Ld(Clr_Ld)
					.Reset(Reset));
							
endmodule


// X D FLip Flop
module X_Flop(	input logic Xin, Clk, Clr_Ld, Reset,
					output logic Xout);

	always_ff @ (posedge Clk)
	begin
		if(Reset or Clr_Ld)
			Xout <= 1'b0;
		else
			Xout <= Xin;
	end

endmodule


// 8 bit register
module EightBitShiftRegister(	input logic [7:0] DataIn,
										input logic Clk, Reset, Load, ShiftEnable, ShiftIn
										output logic [7:0] DataOut,
										output logic ShiftOut);
										
	always_ff @ (posedge Clk)
	begin
		if(Reset)
			DataOut <= 8'b0;
		else if (Load)
			DataOut <= [7:0] DataIn;
		else if (shiftEnable)
			DataOut <= {ShiftIn, DataOut[7:1]};
	end
	
   always_comb
	begin
		assign ShiftOut = DataOut[0];		
	end	
endmodule