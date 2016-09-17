// Controller logic 8 bit multiplier

module Controller(	input logic ClearA_LoadB, Run, Reset, Clk, M,
							output logic Clr_Ld, Shift, Add, Sub);
							
	enum logic [3:0] {WAIT, A, B, C, D, E, F, G, H, I, ADD} PreviousState, CurrentState, NextState;
	
	always_ff @ (posedge Clk)
	begin
		if(Reset)
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
		begin
		   Shift = 1'b0;
			Add 	= 1'b0;
			Sub   = 1'b0;
			if(ClearA_LoadB)
			begin
				Clr_Ld = 1'b1;
			end
			else
			begin
				Clr_Ld = 1'b0;
			end
		end
		
		else if(ADD)
		begin
			if(PreviousState == H)
			begin
				Add 	 = 1'b0;
				Sub    = 1'b1;
			end
			else
			begin
				Add 	 = 1'b1;
				Sub    = 1'b0;
			end
			Shift  = 1'b0;
			Clr_Ld = 1'b0;
		end
		
		else if(I)
		begin
			Shift  = 1'b0;
			Add 	 = 1'b0;
			Sub    = 1'b0;
			Clr_Ld = 1'b0;
		end
		
		else
		begin
			Shift  = 1'b1;
			Add 	 = 1'b0;
			Sub    = 1'b0;
			Clr_Ld = 1'b0;
		end
	end
	
	// Combinational Next State Logic
	always_comb
	begin
		NextState = CurrentState;
		unique case (CurrentState)
			WAIT:	begin
						if(Run)
						begin
							if(M & PreviousState!=ADD)
							begin
								NextState = ADD;							
							end
							else
								NextState = A;
						end
						else
							NextState = WAIT;
					end
			A:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = B;
					end
			B:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = C;
					end
			C:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = D;
					end
			D:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = E;
					end
			E:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = F;
					end
			F:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = G;
					end
			G:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else	
						NextState = H;
					end
			H:		begin
					if(M & PreviousState!=ADD)
						NextState = ADD;
					else
						NextState = I;
					end
			I:		begin
					if(Run)
						NextState = I;
					else
						NextState = WAIT;
					end
			ADD:	begin
					NextState = PreviousState;
					end
		endcase
	end
							
endmodule


