//
//
//
// Register File
//
// Holds the 8 registers of the Little Computer 3
// 
// Inputs: 	DR
//			[15:0]DataIn
//			[]
//
//
// Outputs:	SR1_out,
// 			SR2_out,
//
//
//-------------------------------------------------------------------------------------------------

module Register_File
(
	input logic 	[15:0] DataIn, IR,
	input logic 	LDREG, DR, SR1, Clk, Reset,
	input logic 	[3:0] SR2,
	output logic	[15:0] SR2out, SR1out
);

// Internal Wires:
logic [7:0][15:0] RegOut;
logic [7:0]	LDReg;
logic [3:0] DRMUXout, SR1MUXout;

	// DRMUX
	always_comb
	begin
		case (DR)
			1'b1 :	DRMUXout = 3'b111;
			1'b0 :	DRMUXout = IR[11:9];
		endcase
	end


	// SR1MUX
	always_comb
	begin
		case (SR1)
			1'b1 :	SR1MUXout = IR[8:6];
			1'b0 :	SR1MUXout = IR[11:9];
		endcase
	end


	// Load Decoder:
	always_comb
	begin
		case (DRMUXout)
			3'b000:	LDReg = 8'b00000001; 
			3'b001:	LDReg = 8'b00000010;
			3'b010:	LDReg = 8'b00000100;
			3'b011:	LDReg = 8'b00001000;
			3'b100:	LDReg = 8'b00010000;
			3'b101:	LDReg = 8'b00100000;
			3'b110:	LDReg = 8'b01000000;
			3'b111:	LDReg = 8'b10000000;
		endcase
	end

    
    // SR1 output Mux
    always_comb
    begin
    	case (SR1MUXout)
    		3'b000:	SR1out = RegOut[0][15:0]; 
			3'b001:	SR1out = RegOut[1][15:0];
			3'b010:	SR1out = RegOut[2][15:0];
			3'b011:	SR1out = RegOut[3][15:0];
			3'b100:	SR1out = RegOut[4][15:0];
			3'b101:	SR1out = RegOut[5][15:0];
			3'b110:	SR1out = RegOut[6][15:0];
			3'b111:	SR1out = RegOut[7][15:0];
    	endcase
    end


    // SR2 output Mux
    always_comb
    begin
    	case (SR2)
    		3'b000:	SR2out = RegOut[0][15:0]; 
			3'b001:	SR2out = RegOut[1][15:0];
			3'b010:	SR2out = RegOut[2][15:0];
			3'b011:	SR2out = RegOut[3][15:0];
			3'b100:	SR2out = RegOut[4][15:0];
			3'b101:	SR2out = RegOut[5][15:0];
			3'b110:	SR2out = RegOut[6][15:0];
			3'b111:	SR2out = RegOut[7][15:0];
    	endcase
    end


    // Register Instances:
	SixteenBitShiftRegister SR_0(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[0])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[0][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_1(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[1])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[1][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_2(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[2])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[2][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_3(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[3])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[3][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_4(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[4])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[4][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_5(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[5])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[5][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_6(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[6])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[6][15:0])
									.ShiftOut());
	SixteenBitShiftRegister SR_7(	.DataIn(DataIn[15:0]),
									.Clk(Clk),
									.Reset(Reset),
									.Load(LDReg[7])
									.ShiftEnable(1'b0),
									.shiftIn(1'b0),
									.DataOut(RegOut[7][15:0])
									.ShiftOut());


endmodule