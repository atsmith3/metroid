//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//------------------------------------------------------------------------------


module ISDU
(				
	input	Clk, Reset, Run, Continue,
	input [3:0]Opcode,
	input IR_5,
	input IR_11,
	input	BEN,

	output logic 	LD_MAR,
						LD_MDR,
						LD_IR,
						LD_BEN,
						LD_CC,
						LD_REG,
						LD_PC,
						
	output logic GatePC,
					 GateMDR,
					 GateALU,
					 GateMARMUX,

	output logic [1:0] 	PCMUX,
								DRMUX,
								SR1MUX,
								
	output logic 	SR2MUX,
						ADDR1MUX,
						
	output logic [1:0] 	ADDR2MUX,

	output logic [1:0] 	ALUK,

	output logic 	Mem_CE,
						Mem_UB,
						Mem_LB,
						Mem_OE,
						Mem_WE
);

    enum logic [8:0] {Halted, PauseIR1, PauseIR2, S_18, S_33_1, S_33_2, S_35, S_32, S_01, S_05, S_09, S_15, S_28_0, S_28_1, S_28_2, S_30, S_14, S_10, S_24_0, S_24_1, S_24_2, S_06, S_02, S_26, S_25_0, S_25_1, S_25_2, S_27, S_11, S_29_0, S_29_1, S_29_2, S_07, S_31, S_03, S_23, S_16_0, S_16_1, S_16_2, S_00, S_22, S_12, S_04, S_21, S_20}   State, Next_state;   // Internal state logic

    always_ff @ (posedge Clk or posedge Reset )
    begin : Assign_Next_State
        if (Reset)
            State <= Halted;
        else
            State <= Next_state;
    end

	always_comb
    begin
	    Next_state  = State;
       unique case (State)
         Halted :
	         if (Run)
					Next_state <= S_18;
         S_18 :
            Next_state <= S_33_1;
         S_33_1 :
            Next_state <= S_33_2;
         S_33_2 :
            Next_state <= S_35;
         S_35 :
				Next_state <= S_32;
            //Next_state <= PauseIR1;
         PauseIR1 :
             if (~Continue) 
                 Next_state <= PauseIR1;
             else 
                 Next_state <= PauseIR2;
         PauseIR2 : 
             if (Continue) 
                 Next_state <= PauseIR2;
             else 
                 Next_state <= S_18;
         S_32 :
				begin
					unique case (Opcode)
						4'b0000:	Next_state <= S_00;		// BR
						4'b0001: Next_state <= S_01;		// ADD
						4'b0101: Next_state <= S_05;		// AND
						4'b1100: Next_state <= S_12;		// JMP
						4'b0100: Next_state <= S_04;		// JSR
						4'b0110: Next_state <= S_06;		// LDR
						4'b1001: Next_state <= S_09; 		// NOT
						4'b0111: Next_state <= S_07;  	// STR
						4'b1101: Next_state <= PauseIR1;	// PAUSE
					endcase
				end
			
			// Opcode ADD
			S_01:
				 Next_state <= S_18;
         
			// Opcode AND
			S_05:
				Next_state <= S_18;
         
			// Opcode NOT
			S_09:
				Next_state <= S_18;
         
			// Opcode TRAP : Unused
			S_15:
           Next_state <= S_28_0;
			S_28_0:
           Next_state <= S_28_1;
         S_28_1:
           Next_state <= S_28_2;
         S_28_2:
           Next_state <= S_30;
         S_30:
           Next_state <= S_18;
         
			// Opcode LEA : Unused
			S_14:
           Next_state <= S_18;
         
			// Opcode LD : Unused
			S_02:
           Next_state <= S_25_0;
         S_25_0:
           Next_state <= S_25_1;
         S_25_1:
           Next_state <= S_25_2;
         S_25_2:
           Next_state <= S_27;
         S_27:
				Next_state <= S_18;
         
			// Opcode LDR
			S_06:
           Next_state <= S_25_0;
         
			// Opcode LDI : Unused
			S_10:
           Next_state <= S_24_0;
         S_24_0:
           Next_state <= S_24_1;
         S_24_1:
           Next_state <= S_24_2;
         S_26:
           Next_state <= S_25_0;
         
			// Opcode STI : Unused
			S_11:
           Next_state <= S_29_0;
         S_29_0:
           Next_state <= S_29_1;
         S_29_1:
           Next_state <= S_29_2;
         S_29_2:
           Next_state <= S_31;
         S_31:
           Next_state <= S_23;
         S_23:
           Next_state <= S_16_0;
         S_16_0:
           Next_state <= S_16_1;
         S_16_1:
           Next_state <= S_16_2;
         S_16_2:
           Next_state <= S_18;
         
			// Opcode STR
			S_07:
           Next_state <= S_23;
         
			// Opcode ST : Unused
			S_03:
           Next_state <= S_23;
         
			// Opcode BR
			S_00:
				if(BEN)
					Next_state <= S_22;
				else
					Next_state <= S_18;
         S_22:
            Next_state <= S_18;
         
			// Opcode JMP
			S_12:
           Next_state <= S_18;
         
			// Opcode JSR
			S_04:
				//Only supports JSR
				Next_state <= S_21;
         S_21:
				Next_state <= S_18;
			default : ;
	     endcase
    end
   
    always_comb
    begin 
      //default controls signal values; within a process, these can be
      //overridden further down (in the case statement, in this case)
	   LD_MAR = 1'b0;
	   LD_MDR = 1'b0;
	   LD_IR = 1'b0;
	   LD_BEN = 1'b0;
	   LD_CC = 1'b0;
	   LD_REG = 1'b0;
	   LD_PC = 1'b0;
		
	   GatePC = 1'b0;
	   GateMDR = 1'b0;
	   GateALU = 1'b0;
	   GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
	   PCMUX = 2'b00;
	   DRMUX = 2'b00;
	   SR1MUX = 2'b00;
	   SR2MUX = 1'b0;
	   ADDR1MUX = 1'b0;
	   ADDR2MUX = 2'b00;
		
	   Mem_OE = 1'b1;
	   Mem_WE = 1'b1;
		 
	   case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
				end
			S_33_1 : 
				Mem_OE = 1'b0;
			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
            end
         S_35 : 
            begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
               end
         PauseIR1: ;
         PauseIR2: ;
         S_32 : 
               LD_BEN = 1'b1;
         // ADD
			S_01 :
            begin 
					SR2MUX = IR_5;
					ALUK = 2'b00;
					LD_REG = 1'b1;
					GateALU = 1'b1;
					SR1MUX = 1'b1;
					LD_CC = 1'b1;
               end
			// AND
			S_05 :
				begin
					SR1MUX = 1'b1;
					SR2MUX = IR_5;
					LD_REG = 1'b1;
					ALUK = 2'b01;
					GateALU = 1'b1;
					LD_CC = 1'b1;
				end
			// NOT
			S_09 :
				begin
					SR1MUX = 1'b1;
					ALUK = 2'b10;
					GateALU = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
			// LDR
			S_06 :
				begin
					SR1MUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b01;
					GateMARMUX = 1'b1;
					LD_MAR = 1'b1;
				end
			S_25_0 :
				begin
					Mem_OE = 1'b0;
				end
			S_25_1 : 
				begin
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_25_2 : 
				begin
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_27 :
				begin
					GateMDR = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
			// STR
			S_07 :
				begin
					SR1MUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b01;
					GateMARMUX = 1'b1;
					LD_MAR = 1'b1;
				end
			S_23 :
				begin
				   // Pass A
					ALUK = 2'b11;
					GateALU = 1'b1;
					LD_MDR = 1'b1;
				end
			S_16_0 :
				begin
					Mem_WE = 1'b0;
				end
			S_16_1 :
				begin
					Mem_WE = 1'b0;
				end
			S_16_2 :
				begin
					Mem_WE = 1'b0;
				end
			// JSR
			S_04 :
				begin
					GatePC = 1'b0;
					DRMUX = 2'b01;
					LD_REG = 1'b1;
				end
			S_21 :
				begin
					ADDR2MUX = 2'b11;
					PCMUX = 2'b10;
					LD_PC = 1'b1;
				end
			// JMP
			S_12 :
				begin
					SR1MUX = 1'b1;
					ALUK = 2'b11;
					GateALU = 1'b1;
					PCMUX = 2'b01;
					LD_PC = 1'b1;
				end
			// BR
			S_00 :
				begin
				end
			S_22 :
				begin
					ADDR2MUX = 2'b10;
					PCMUX = 2'b10;
					LD_PC = 1'b1;
				end
         default : ;
         endcase
       end 

	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
