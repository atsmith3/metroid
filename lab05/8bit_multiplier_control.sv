// Controller logic 8 bit multiplier

module Controller(	input logic ClearA_LoadB, Run, Reset, Clk, M,
							output logic Clr_Ld, Shift, Add, Sub, 
							output logic [3:0]currentState,
							output logic Clear_A);
							
	enum logic [3:0] {WAIT, A, B, C, D, E, F, G, H, I, ADD, SHIFT, CLEAR_A} StorageState, PreviousState, CurrentState, NextState, NextNextState;
	
	assign currentState = CurrentState;
	
	always_ff @ (posedge Clk)
	begin
		if(Reset)
			CurrentState <= WAIT;
		else
			begin
			   PreviousState <= CurrentState;
				CurrentState <= NextState;
				if(CurrentState == ADD)
					begin
						StorageState <= StorageState;
					end
				else
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
				Clear_A = 1'b0;
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
				Clear_A = 1'b0;
			end
		else if(CurrentState == SHIFT)
			begin
				Shift  = 1'b1;
				Add 	 = 1'b0;
				Sub    = 1'b0;
				Clr_Ld = 1'b0;
				Clear_A = 1'b0;
			end
		else if(CurrentState == CLEAR_A)
			begin
				Shift  = 1'b0;
				Add 	 = 1'b0;
				Sub    = 1'b0;
				Clr_Ld = 1'b0;
				Clear_A = 1'b1;
			end
		else
			begin
				Shift  = 1'b0;
				Add 	 = 1'b0;
				Sub    = 1'b0;
				Clr_Ld = 1'b0;
				Clear_A = 1'b0;
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
							NextState = CLEAR_A;
						else
							NextState = WAIT;
					end
			CLEAR_A:begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
				
					NextNextState = A;
					end
			A:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = B;
					end
			B:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = C;
					end
			C:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = D;
					end
			D:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = E;
					end
			E:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = F;
					end
			F:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = G;
					end
			G:		begin
					if(M)
						NextState = ADD;
					else
						NextState = SHIFT;
						
					NextNextState = H;
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
						NextState = SHIFT;
					end
			SHIFT:begin
						NextState = StorageState;
					end
			default: begin
						NextState = WAIT;
					end
		endcase
	end
							
endmodule


