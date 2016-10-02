//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 6 Given Code - SLC-3 top-level (External SRAM)
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//------------------------------------------------------------------------------


module slc3(
	//input logic [15:0] S,
	input logic	Clk, Reset, Run, Continue,
	input logic [15:0] S,
	output logic [11:0] LED,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3,
	output logic CE, UB, LB, OE, WE,
	output logic [19:0] ADDR,
	inout wire [15:0] Data //tristate buffers need to be of type wire
);

//Declaration of push button active high signals	
logic Reset_ah, Continue_ah, Run_ah;

assign Reset_ah = ~Reset;
assign Continue_ah = ~Continue;
assign Run_ah = ~Run;

// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX, MIO_EN;
logic BEN;
logic [1:0] PCMUX, DRMUX, SR1MUX, ADDR2MUX, ALUK;
logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR;
logic [15:0] Data_Mem_In, Data_Mem_Out;

//Our Internal Signals
logic [15:0] MDR_Mux_to_Reg;
logic [15:0] PC_Mux_to_Reg;

logic [15:0] PC_inc;
logic [15:0] DataBus;
logic [15:0] ALU_Data;
logic [15:0] PC_Data;
logic [15:0] MARMUX_Data;
logic [15:0] Mux1_to_Adder;
logic [15:0] Mux2_to_Adder;
logic [15:0] SR2_Data, SR1_Data;
logic [15:0] Mux_to_ALU;

// Connect LEDS to IR
assign LED = IR[11:0];


// An array of 4-bit wires to connect the hex_drivers efficiently to wherever we want
// For Lab 1, they will direclty be connected to the IR register through an always_comb circuit
// For Lab 2, they will be patched into the MEM2IO module so that Memory-mapped IO can take place
logic [3:0] hex_4[3:0]; 
HexDriver hex_driver0(.In0(hex_4[0]), .Out0(HEX0));
HexDriver hex_driver1(.In0(hex_4[1]), .Out0(HEX1));
HexDriver hex_driver2(.In0(hex_4[2]), .Out0(HEX2));
HexDriver hex_driver3(.In0(hex_4[3]), .Out0(HEX3));
// This works thanks to http://stackoverflow.com/questions/1378159/verilog-can-we-have-an-array-of-custom-modules

/*
HexDriver hex_driver0(.In0(IR[3:0]), .Out0(HEX0));
HexDriver hex_driver1(.In0(IR[7:4]), .Out0(HEX1));
HexDriver hex_driver2(.In0(IR[11:8]), .Out0(HEX2));
HexDriver hex_driver3(.In0(IR[15:12]), .Out0(HEX3));
*/

// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = { 4'b00, MAR }; //Note, our external SRAM chip is 1Mx16, but address space is only 64Kx16
assign MIO_EN = ~OE;

// Break the tri-state bus to the ram into input/outputs 
tristate #(.N(16)) tr0(
	.Clk(Clk), .OE(~WE), .In(Data_Mem_Out), .Out(Data_Mem_In), .Data(Data)
);


// Our SRAM and I/O controller (note, this plugs into MDR/MAR
Mem2IO memory_subsystem(
	.*, .Reset(Reset_ah), .A(ADDR), .Switches(S),
	.HEX0(hex_4[0]), .HEX1(hex_4[1]), .HEX2(hex_4[2]), .HEX3(hex_4[3]),
	.Data_CPU_In(MDR), .Data_CPU_Out(MDR_In)
);


test_memory SRAM(.Reset(Reset_ah), .I_O(Data),.A(ADDR), .*);

//DataPath 
/******* TODO: CHANGE ALU_data and MARMUX_Data for week 2 *******/
Datapath BUS(	.gateMDR(GateMDR),.gateALU(GateALU),.gatePC(GatePC),.gateMARMUX(GateMARMUX),
					.MDR_data(MDR),.ALU_data(ALU_Data),.PC_data(PC_Data),.MARMUX_data(MARMUX_Data),
					.Datapath(DataBus));
//Datapath BUS(	.gateMDR(GateMDR),.gateALU(GateALU),.gatePC(GatePC),.gateMARMUX(GateMARMUX),
//					.MDR_data(Data_Mem_Out),.ALU_data(ALU_Data),.PC_data(PC_Data),.MARMUX_data(MARMUX_Data),
//					.Datapath(DataBus));

//Our Memory Modules
MIO_MUX MM0(.Data_CPU_Out(MDR_In),.DataPath(DataBus),.MIOEN(MIO_EN),.DataOut(MDR_Mux_to_Reg));
MDR MDR0(.DataIn(MDR_Mux_to_Reg),.LDMDR(LD_MDR),.Clk(Clk),.Reset(Reset_ah),.DataOut(MDR));
MAR MAR0(.DataIn(DataBus),.LDMAR(LD_MAR),.Clk(Clk),.Reset(Reset_ah),.DataOut(MAR));
/******* Test Connections ********/
//MDR MDR0(.DataIn(MDR_Mux_to_Reg),.LDMDR(LD_MDR),.Clk(Clk),.Reset(Reset_ah),.DataOut(Data_Mem_Out));
//MIO_MUX MM0(.Data_CPU_Out(Data_Mem_In),.DataPath(DataBus),.MIOEN(MIO_EN),.DataOut(MDR_Mux_to_Reg));


//Our PC Modules
PCR PCR0(.DataIn(PC_Mux_to_Reg),.LDPC(LD_PC),.Clk(Clk),.Reset(Reset_ah),.DataOut(PC_Data));
PC_INC PCINC0(.PC_cur(PC_Data),.PC_inc(PC_inc));
PC_MUX PCMUX0(.PCMUX(PCMUX),.DataPath(DataBus),.MARMUX_data(MARMUX_Data),.PC_inc(PC_inc),.PC_data(PC_Mux_to_Reg));

//IR Module
IR IR0(.DataIn(DataBus),.LDIR(LD_IR),.Clk(Clk),.Reset(Reset_ah),.DataOut(IR));

// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset_ah), .Run(Run_ah), .Continue(Continue_ah),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
	.Mem_CE(CE), .Mem_UB(UB), .Mem_LB(LB), .Mem_OE(OE), .Mem_WE(WE)
);

// Adder2Mux:
ADDR2MUX A2M(.IR(IR), .ADDR2MUXK(ADDR2MUX), .Mux1_to_Adder(Mux1_to_Adder));

// Adder1Mux
ADDR1MUX A1M(.ADDR1MUXK(ADDR2MUX), .Mux2_to_Adder(Mux2_to_Adder), .SR1OUT(SR1_Data), .PCR_Data(PC_Data));

// Adder
Adder ADDR0(.Mux1_to_Adder(Mux1_to_Adder), .Mux2_to_Adder(Mux2_to_Adder), .MARMUX(MARMUX_Data));

// SR2MUX
SR2MUX SR2M(.IR(IR), .SR2OUT(SR2_Data), .SR2MUXK(SR2MUX), .Mux_to_ALU(Mux_to_ALU));

// ALU
ALU ALU1(.Mux_to_ALU(Mux_to_ALU), .SR1OUT(SR1_Data), .ALUK(ALUK), .ALU_Out(ALU_Data));

// Branch logic
BR_NZP BRO(.DataIn(DataBus), .IR(IR), .Clk(Clk), .Reset(Reset_ah), .LDCC(LD_CC), .LDBEN(LD_BEN), .BEN(BEN));

// Register File
Register_File RF1(.DataIn(DataBus), .IR(IR), .LDREG(LD_REG), .DR(DRMUX[0]), .SR1(SR1MUX[0]), .Clk(Clk), .Reset(Reset_ah), .SR2(IR[2:0]), .SR2out(SR2_Data), .SR1out(SR1_Data));

endmodule
