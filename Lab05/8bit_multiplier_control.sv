// Controller logic 8 bit multiplier

module Controller(	input logic ClearA_LoadB, Run, Reset, Clk, M,
							output logic Clr_Ld, Shift, Add, Sub);
							
	enum logic [3:0] {WAIT, A, B, C, D, E, F, G, H, ADD} PreviousState, CurrentState, NextState;
	
	always_ff @ (posedge Clk)
	begin
		if(reset)
			CurrentState <= WAIT;
		else
			begin
			   PreviousState <= CurrentState;
				CurrentState <= NextState;
			end
	end
	
	
	// Combinational Output Logic
	always_comb
	begin
		if(WAIT)
		{
		   Shift = 1'b0;
			Add 	= 1'b0;
			Sub   = 1'b0;
			if(ClearA_LoadB)
			{
				Clr_Ld = 1'b1;
			}
			else
			{
				Clr_Ld = 1'b0;
			}
		else if(ADD)
		{
			if(PreviousState == H)
			{
				Add 	 = 1'b0;
				Sub    = 1'b1;
			}
			else
			{
				Add 	 = 1'b1;
				Sub    = 1'b0;
			}
			Shift  = 1'b0;
			Clr_Ld = 1'b0;
		}
		else
		{
			Shift  = 1'b1;
			Add 	 = 1'b0;
			Sub    = 1'b0;
			Clr_Ld = 1'b0;
		}
	end
	
	// Combinational Next State Logic
	always_comb
	begin
		NextState = CurrentState;
		unique case (CurrentState)
			WAIT:	begin
						if(Run)
						{
							if(M)
								NextState = ADD;
							else
								NextState = A;
						}
						else
							NextState = WAIT;
					end
			A:		if(M)
						NextState = ADD;
					else	
						NextState = B;
			B:		if(M)
						NextState = ADD;
					else	
						NextState = C;
			C:		if(M)
						NextState = ADD;
					else	
						NextState = D;
			D:		if(M)
						NextState = ADD;
					else	
						NextState = E;
			E:		if(M)
						NextState = ADD;
					else	
						NextState = F;
			F:		if(M)
						NextState = ADD;
					else	
						NextState = G;
			G:		if(M)
						NextState = ADD;
					else	
						NextState = H;
			H:		if(M)
						NextState = ADD;
					else	
						NextState = WAIT;
			ADD:	NextState = PreviousState;
		endcase
	end
							
endmodule


