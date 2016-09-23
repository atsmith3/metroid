//
// MDR Register:
module MDR
(
	input  logic [15:0] DataIn,
	input  logic LDMDR, Clk, Reset,
	output logic [15:0] DataOut
);

SixteenBitShiftRegister sr(.DataIn(DataIn),
								.Clk(Clk),
								.Reset(Reset), 
								.Load(LDMDR),
								.ShiftEnable(1'b0), 
								.ShiftIn(1'b0),
								.DataOut(DataOut),
								.ShiftOut());

endmodule


//
// MAR Register:
module MAR
(
	input  logic [15:0] DataIn,
	input  logic LDMAR, Clk, Reset,
	output logic [15:0] DataOut
);

SixteenBitShiftRegister sr(.DataIn(DataIn),
								.Clk(Clk),
								.Reset(Reset), 
								.Load(LDMAR),
								.ShiftEnable(1'b0), 
								.ShiftIn(1'b0),
								.DataOut(DataOut),
								.ShiftOut());

endmodule


//
// Zero Extender:
module ZEXT_16_20
(
	input logic  [15:0] DataIn,
	output logic [19:0] DataOut
);

assign DataOut [19:16] = 4'b0000;
assign DataOut [15:0]  = DataIn;

endmodule


//
// MIO Mux
module MIOMUX
(
	input  logic [15:0] Data_CPU_Out,
	input  logic [15:0] DataPath,
	input  logic MIOEN,
	output logic [15:0] DataOut
);

	four_2_1_mux F21M0(.Data_Path(DataPath[3:0]),.Data_CPU_Out(Data_CPU_Out[3:0]),.MIOEN(MIOEN),.DataOut(DataOut[3:0]));
	four_2_1_mux F21M1(.Data_Path(DataPath[7:4]),.Data_CPU_Out(Data_CPU_Out[7:4]),.MIOEN(MIOEN),.DataOut(DataOut[7:4]));
	four_2_1_mux F21M2(.Data_Path(DataPath[11:8]),.Data_CPU_Out(Data_CPU_Out[11:8]),.MIOEN(MIOEN),.DataOut(DataOut[11:8]));
	four_2_1_mux F21M3(.Data_Path(DataPath[15:12]),.Data_CPU_Out(Data_CPU_Out[15:12]),.MIOEN(MIOEN),.DataOut(DataOut[15:12]));

endmodule