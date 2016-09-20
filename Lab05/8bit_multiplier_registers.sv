// Register file

module Registers(	input logic [7:0] Ain, Bin,
							input logic X, Clr_Ld, Shift, Clk, Reset, Add, Subtract, Clear_A,
							output logic [7:0] Aout, Bout,
							output logic M);
	
	logic ab, xa;
	EightBitShiftRegister RegA(.DataIn(Ain [7:0]), 
										.DataOut(Aout [7:0]), 
										.ShiftEnable(Shift), 
										.ShiftIn(xa), 
										.ShiftOut(ab), 
										.Clk(Clk), 
										.Reset(Reset | Clr_Ld | Clear_A), 
										.Load(Add | Subtract));
										
	EightBitShiftRegister RegB(.DataIn(Bin [7:0]), 
										.DataOut(Bout [7:0]), 
										.ShiftEnable(Shift), 
										.ShiftIn(ab), 
										.ShiftOut(M), 
										.Clk(Clk), 
										.Reset(Reset), 
										.Load(Clr_Ld));
										
	X_Flop RegX(.Xin(X),
					.Xout(xa),
					.Clk(Clk),
					.Clr_Ld(Clr_Ld | Clear_A), 
					.Reset(Reset));
							
endmodule


// X D FLip Flop
module X_Flop(	input logic Xin, Clk, Clr_Ld, Reset,
					output logic Xout);

	always_ff @ (posedge Clk)
	begin
		if(Reset | Clr_Ld)
			Xout <= 1'b0;
		else
			Xout <= Xin;
	end

endmodule


// 8 bit register
module EightBitShiftRegister(	input logic [7:0] DataIn,
										input logic Clk, Reset, Load, ShiftEnable, ShiftIn,
										output logic [7:0] DataOut,
										output logic ShiftOut);
										
	always_ff @ (posedge Clk)
	begin
		if(Reset)
			DataOut <= 8'b0;
		else if (Load)
			DataOut <= DataIn [7:0];
		else if (ShiftEnable)
			DataOut <= {ShiftIn, DataOut[7:1]};
		else
			DataOut = DataOut;
	end
	
   always_comb
	begin
		ShiftOut = DataOut[0];		
	end	
endmodule