//
// MDR Register:
// 16 bit shift register that has shift disabled and paralell loads:
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
// 16 bit shift register that has shift disabled and paralell loads:
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
// PC Register:
// 16 bit shift register that has shift disabled and paralell loads:
module PCR
(
	input  logic [15:0] DataIn,
	input  logic LDPC, Clk, Reset,
	output logic [15:0] DataOut
);

SixteenBitShiftRegister sr(.DataIn(DataIn),
								.Clk(Clk),
								.Reset(Reset), 
								.Load(LDPC),
								.ShiftEnable(1'b0), 
								.ShiftIn(1'b0),
								.DataOut(DataOut),
								.ShiftOut());

endmodule


//
// IR Register:
// 16 bit shift register that has shift disabled and paralell loads:
module IR
(
	input  logic [15:0] DataIn,
	input  logic LDIR, Clk, Reset,
	output logic [15:0] DataOut
);

SixteenBitShiftRegister sr(.DataIn(DataIn),
								.Clk(Clk),
								.Reset(Reset), 
								.Load(LDIR),
								.ShiftEnable(1'b0), 
								.ShiftIn(1'b0),
								.DataOut(DataOut),
								.ShiftOut());

endmodule

//
// PC incrementer
module PC_INC
(
	input logic [15:0] PC_cur,
	output logic [15:0] PC_inc
);

	SixteenBitRippleAdder SSR0(.A(PC_cur),.B(16'h0001),.Sum(PC_inc),.CO());

endmodule


//
// MIO Mux
// Selects which input is connected to the MDR:
module MIO_MUX
(
	input  logic [15:0] Data_CPU_Out,
	input  logic [15:0] DataPath,
	input  logic MIOEN,
	output logic [15:0] DataOut
);

always_comb
begin
if(~MIOEN)
begin
	DataOut = DataPath;
end
else
begin	
	DataOut = Data_CPU_Out;
end
end
endmodule


//
// PC MUX module
// Selects what input is connected to the pc based on the control logic:
module PC_MUX
(
	input logic [1:0] PCMUX, // From control logic
	input logic [15:0] DataPath, MARMUX_data, PC_inc,
	output logic [15:0] PC_data // goes into the PC register:
);

always_comb
begin
case (PCMUX)
	2'b00: PC_data = PC_inc;
	2'b01: PC_data = DataPath;
	2'b10: PC_data = MARMUX_data;
	2'b11: PC_data = 16'h0000;
endcase
end

endmodule
