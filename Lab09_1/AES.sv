/*---------------------------------------------------------------------------
 --      AES.sv                                                           --
 --      Joe Meng                                                         --
 --      Fall 2013                                                        --
 --                                                                       --
 --      For use with ECE 298 Experiment 9                                --
 --      UIUC ECE Department                                              --
 ---------------------------------------------------------------------------*/

//AES module interface with all ports, commented for Week 1
  module  AES ( input logic [127:0]  Plaintext,
                                     Cipherkey,
                input logic         Clk, 
                                    Reset,
                                    Run,
                output logic [127:0] Ciphertext,
                output logic         Ready  );
					 
logic reset_n;
logic [0:1407] keyschedule;
reg [0:1407] keyS;
	
// Hold the keySq and Chipher Sq and we do manipulations on them:
reg [127:0] keySq, cypherSq;
// Module outputs that do manipulations on the keySqs
logic [127:0] InvSubBytes_Out, InvShiftRows_Out, InvMixColumns_Out, AddRoundKey_Out;

enum logic[7:0]    {InvShiftRows_1, InvSubBytes_1, AddRoundKey_1,
                    InvShiftRows_2, InvSubBytes_2, AddRoundKey_2,
                    InvShiftRows_3, InvSubBytes_3, AddRoundKey_3,
                    InvShiftRows_4, InvSubBytes_4, AddRoundKey_4,
                    InvShiftRows_5, InvSubBytes_5, AddRoundKey_5,
                    InvShiftRows_6, InvSubBytes_6, AddRoundKey_6,
                    InvShiftRows_7, InvSubBytes_7, AddRoundKey_7,
                    InvShiftRows_8, InvSubBytes_8, AddRoundKey_8,
                    InvShiftRows_9, InvSubBytes_9, AddRoundKey_9,
                    InvShiftRows_0, InvSubBytes_0, AddRoundKey_0,
						  AddRoundKey_10, InvMixColumns, WAIT, RESET, SETUP}
                    state, next_state, prev_state;

assign reset_n = ~Reset;	 
assign Ciphertext = cypherSq; 

//==============================================
//	Modules:
//==============================================
KeyExpansion keyexpansion_0(.*, .Cipherkey({Cipherkey_0, Cipherkey_1, Cipherkey_2, Cipherkey_3}), .KeySchedule(keyschedule));
	
InvAddRoundKey IARK(.in(cypherSq), .round_key(keySq), .out(AddRoundKey_Out));

InvShiftRows   ISR(.in(cypherSq), .out(InvShiftRows_Out));

// Column 1
InvSubBytes    ISB00(.Clk(Clk), .in(cypherSq[127:120]), .out(InvSubBytes_Out[127:120]));
InvSubBytes    ISB10(.Clk(Clk), .in(cypherSq[119:112]), .out(InvSubBytes_Out[119:112]));
InvSubBytes    ISB20(.Clk(Clk), .in(cypherSq[111:104]), .out(InvSubBytes_Out[111:104]));
InvSubBytes    ISB30(.Clk(Clk), .in(cypherSq[103:96]), .out(InvSubBytes_Out[103:96]));
// Column 2
InvSubBytes    ISB01(.Clk(Clk), .in(cypherSq[95:88]), .out(InvSubBytes_Out[95:88]));
InvSubBytes    ISB11(.Clk(Clk), .in(cypherSq[87:80]), .out(InvSubBytes_Out[87:80]));
InvSubBytes    ISB21(.Clk(Clk), .in(cypherSq[79:72]), .out(InvSubBytes_Out[79:72]));
InvSubBytes    ISB31(.Clk(Clk), .in(cypherSq[71:64]), .out(InvSubBytes_Out[71:64]));
// Column 3
InvSubBytes    ISB02(.Clk(Clk), .in(cypherSq[63:56]), .out(InvSubBytes_Out[63:56]));
InvSubBytes    ISB12(.Clk(Clk), .in(cypherSq[55:48]), .out(InvSubBytes_Out[55:48]));
InvSubBytes    ISB22(.Clk(Clk), .in(cypherSq[47:40]), .out(InvSubBytes_Out[47:40]));
InvSubBytes    ISB32(.Clk(Clk), .in(cypherSq[39:32]), .out(InvSubBytes_Out[39:32]));
// Column 4
InvSubBytes    ISB03(.Clk(Clk), .in(cypherSq[31:24]), .out(InvSubBytes_Out[31:24]));
InvSubBytes    ISB13(.Clk(Clk), .in(cypherSq[23:16]), .out(InvSubBytes_Out[23:16]));
InvSubBytes    ISB23(.Clk(Clk), .in(cypherSq[15:8]), .out(InvSubBytes_Out[15:8]));
InvSubBytes    ISB33(.Clk(Clk), .in(cypherSq[7:0]), .out(InvSubBytes_Out[7:0]));

InvMixColumns  IMC0(.in(cypherSq[127:96]), .out(InvMixColumns_Out[127:96]));
InvMixColumns  IMC1(.in(cypherSq[95:64]), .out(InvMixColumns_Out[95:64]));
InvMixColumns  IMC2(.in(cypherSq[63:32]), .out(InvMixColumns_Out[63:32]));
InvMixColumns  IMC3(.in(cypherSq[31:0]), .out(InvMixColumns_Out[31:0]));


// Next State Sequencer:	
   always @ (posedge Clk, negedge reset_n) begin
      if(reset_n == 1'b0) begin
         state <= RESET;
      end
      else begin
         prev_state <= state;
         state <= next_state;
      end
   end
	
// Next state logic and output logic:
   always_comb begin
	  // Defaults:
	  Ready = 0;
	  next_state = WAIT;
     case(state)
	    RESET: begin
		     Ready = 0;
			  next_state = WAIT;
		 end
	    WAIT: begin
		     // If we finished the decryption process set Ready = 1
			  // Else keep the Ready = 0
		     if(prev_state != RESET || prev_state != WAIT)
		         Ready = 1;
			  else
			      Ready = 0;
					
			  // If the input Run is high; start the decryption
			  if(Run == 1)
			      next_state = SETUP;
			  else
			      next_state = WAIT;
		 end
	    SETUP: begin
           Ready = 0;
			  next_state = AddRoundKey_0;
		 end
		 //===========================================================
       InvShiftRows_0: begin
           Ready = 0;
			  next_state = InvSubBytes_0;
       end
       InvShiftRows_1: begin
           Ready = 0;
		 	 next_state = InvSubBytes_1;
       end
       InvShiftRows_2: begin
           Ready = 0;
	 		 next_state = InvSubBytes_2;
       end
       InvShiftRows_3: begin
           Ready = 0;
	        next_state = InvSubBytes_3;
       end
       InvShiftRows_4: begin
           Ready = 0;
	        next_state = InvSubBytes_4;
       end
       InvShiftRows_5: begin
           Ready = 0;
	        next_state = InvSubBytes_5;
       end
       InvShiftRows_6: begin
           Ready = 0;
	        next_state = InvSubBytes_6;
       end
       InvShiftRows_7: begin
           Ready = 0;
	        next_state = InvSubBytes_7;
       end
       InvShiftRows_8: begin
           Ready = 0;
	        next_state = InvSubBytes_8;
       end
       InvShiftRows_9: begin
           Ready = 0;
	        next_state = InvSubBytes_9;
       end
       //===========================================================
       InvSubBytes_0: begin
           Ready = 0;
	        next_state = AddRoundKey_1;
       end
       InvSubBytes_1: begin
           Ready = 0;
	        next_state = AddRoundKey_2;
       end
       InvSubBytes_2: begin
           Ready = 0;
	        next_state = AddRoundKey_3;
       end
       InvSubBytes_3: begin
           Ready = 0;
	        next_state = AddRoundKey_4;
       end
       InvSubBytes_4: begin
           Ready = 0;
	        next_state = AddRoundKey_5;
       end
       InvSubBytes_5: begin
           Ready = 0;
	        next_state = AddRoundKey_6;
       end
       InvSubBytes_6: begin
           Ready = 0;
	        next_state = AddRoundKey_7;
       end
       InvSubBytes_7: begin
           Ready = 0;
	        next_state = AddRoundKey_8;
       end
       InvSubBytes_8: begin
           Ready = 0;
	        next_state = AddRoundKey_9;
       end
       InvSubBytes_9: begin
           Ready = 0;
	        next_state = AddRoundKey_10;
       end
       //===========================================================
       AddRoundKey_0: begin
           Ready = 0;
	        next_state = InvShiftRows_0;
       end
       AddRoundKey_1: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_2: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_3: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_4: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_5: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_6: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_7: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_8: begin
           Ready = 0;
	        next_state = InvMixColumns;
       end
       AddRoundKey_9: begin
           Ready = 0;
	        next_state = WAIT;
       end
       //===========================================================
       InvMixColumns: begin
           Ready = 0;
	        case(prev_state)
               AddRoundKey_1: next_state = InvShiftRows_1;
               AddRoundKey_2: next_state = InvShiftRows_2; 
					AddRoundKey_3: next_state = InvShiftRows_3;
               AddRoundKey_4: next_state = InvShiftRows_4;
					AddRoundKey_5: next_state = InvShiftRows_5;
					AddRoundKey_6: next_state = InvShiftRows_6;
					AddRoundKey_7: next_state = InvShiftRows_7;
               AddRoundKey_8: next_state = InvShiftRows_8;
					AddRoundKey_9: next_state = InvShiftRows_9;
					default: next_state = RESET;
            endcase
       end
		 default: begin
		     Ready = 0;
			  next_state = WAIT;
		 end
	  endcase
	end
		 
// During state logic:
always_ff @ (posedge Clk)
begin
    case(state)
	    RESET: begin
		 end
	    WAIT: begin
		 end
	    SETUP: begin
		     // Load the keySq with the first keySchedule:
           keySq[127:0] <= keyschedule[0:127];
			  // Load the cypher with the encrypted message:
			  cypherSq[127:0] <= Plaintext[127:0];
		 end
		 //===========================================================
		 // Load the cypherSq with the output of the InvShiftRows module
		 // Also load the keySq with the next key in the keyExpansion:
       InvShiftRows_0: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[128:255];
       end
       InvShiftRows_1: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[256:383];
       end
       InvShiftRows_2: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[384:511];
       end
       InvShiftRows_3: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[512:639];
       end
       InvShiftRows_4: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[640:767];
       end
       InvShiftRows_5: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[768:895];
       end
       InvShiftRows_6: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[896:1023];
       end
       InvShiftRows_7: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[1024:1151];
       end
       InvShiftRows_8: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[1152:1279];
       end
       InvShiftRows_9: begin
           cypherSq[127:0] <= InvShiftRows_Out[127:0];
			  keySq[127:0] <= keyS[1280:1407];
       end
       //===========================================================
		 // Load the cypherSq with the output of the InvSubBytes module
       InvSubBytes_0: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_1: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_2: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_3: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_4: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_5: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_6: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_7: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_8: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       InvSubBytes_9: begin
           cypherSq[127:0] <= InvSubBytes_Out[127:0];
       end
       //===========================================================
		 // Load the cypherSq with the output of the AddRoundKey module
       AddRoundKey_0: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
			  keyS[0:1407] <= keyschedule[0:1407];
       end
       AddRoundKey_1: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_2: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_3: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_4: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_5: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_6: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_7: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_8: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       AddRoundKey_9: begin
           cypherSq[127:0] <= AddRoundKey_Out[127:0];
       end
       //===========================================================
		 // Load the cypherSq with the output of the InvMixColumns module
       InvMixColumns: begin
           cypherSq[127:0] = InvMixColumns_Out[127:0];
       end
    endcase
end	
endmodule
