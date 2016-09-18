// Controller logic 8 bit multiplier

module Controller(	input logic ClearA_LoadB, Run, Reset, Clk, M,
							output logic Clr_Ld, Shift, Add, Sub, 
							output logic [3:0]currentState);
							
	enum logic [3:0] {WAIT, A, B, C, D, E, F, G, H, I, ADD} StorageState, PreviousState, CurrentState, NextState, NextNextState;
	
	assign currentState = CurrentState;
	
	always_ff @ (posedge Clk)
	begin
		if(Reset)
			CurrentState <= WAIT;
		else
			begin
			   PreviousState <= CurrentState;
				CurrentState <= NextState;
				if(M)
					begin
						StorageState <= NextNextState;
					end
			end
	end
	
	
	// Combinational Output Logic
	always_comb
	begin
		if(CurrentState == WAIT)
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
		else if(CurrentState == ADD)
			begin
				if(PreviousState == G)
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
		else if(CurrentState == I)
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
		NextNextState = CurrentState;
		unique case (CurrentState)
			WAIT:	begin
						if(Run)
						begin
							if(M)
							begin
								NextState = ADD;
								NextNextState = A;
							end
							else
								NextState = A;
						end
						else
							NextState = WAIT;
					end
			A:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = B;
						end
					else	
						NextState = B;
					end
			B:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = C;
						end
					else	
						NextState = C;
					end
			C:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = D;
						end
					else	
						NextState = D;
					end
			D:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = E;
						end
					else	
						NextState = E;
					end
			E:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = F;
						end
					else	
						NextState = F;
					end
			F:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = G;
						end
					else	
						NextState = G;
					end
			G:		begin
					if(M)
						begin
							NextState = ADD;
							NextNextState = H;
						end
					else	
						NextState = H;
					end
			H:		begin
						NextState = I;
					end
			I:		begin
					if(~Run)
						NextState = WAIT;
					else
						NextState = I;
					end
			ADD:	begin
					NextState = StorageState;
					end
			default: begin
					NextState = WAIT;
					end
		endcase
	end
							
endmodule


