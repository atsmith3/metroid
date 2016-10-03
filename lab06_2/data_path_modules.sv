module ADDR2MUX
  (
   input logic [15:0]  IR,
   input logic [1:0]   ADDR2MUXK,
   output logic [15:0] Mux1_to_Adder
   );

   always_comb
     begin
        case(ADDR2MUXK)
          2'b11:begin
				Mux1_to_Adder = {IR[10],IR[10],IR[10],IR[10],IR[10],IR[10],IR[9],IR[8],IR[7],IR[6], IR[5], IR[4], IR[3], IR[2], IR[1], IR[0]};
          end
          2'b10:begin
				Mux1_to_Adder = {IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[7],IR[6], IR[5], IR[4], IR[3], IR[2], IR[1], IR[0]};
          end
          2'b01:begin
				Mux1_to_Adder = {IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5], IR[5], IR[4], IR[3], IR[2], IR[1], IR[0]};
          end
          2'b00:Mux1_to_Adder=16'h0000;
        endcase // case (ADDR2MUXK)
     end // always_comb

endmodule // ADDR2MUX

module ADDR1MUX
  (
   input logic [15:0]  SR1OUT, PCR_Data,
   input logic         ADDR1MUXK,
   output logic [15:0] Mux2_to_Adder
   );

   always_comb
     begin
        case(ADDR1MUXK)
          1'b0: Mux2_to_Adder = PCR_Data;
          1'b1: Mux2_to_Adder = SR1OUT;
        endcase // case (ADDR1MUXK)
     end // always_comb

endmodule // ADDR1MUX

module Adder
  (
   input logic [15:0]  Mux1_to_Adder, Mux2_to_Adder,
   output logic [15:0] MARMUX
   );

   SixteenBitRippleAdder A0(.A(Mux1_to_Adder), .B(Mux2_to_Adder), .Sum(MARMUX), .CO());

endmodule // Adder

module SR2MUX
  (
  input logic [15:0]  IR, SR2OUT,
  input logic         SR2MUXK,
  output logic [15:0] Mux_to_ALU
   );

   always_comb
     begin
        case(SR2MUXK)
          1'b0:Mux_to_ALU=SR2OUT;
          1'b1:begin
				Mux_to_ALU = {IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4],IR[4], IR[4], IR[4], IR[3], IR[2], IR[1], IR[0]};
          end
        endcase // case (SR2MUXK)
     end

endmodule // SR2MUX

module ALU
(
  input logic [15:0]  Mux_to_ALU, SR1OUT,
  input logic [1:0]   ALUK,
  output logic [15:0] ALU_Out
);
   
	logic [15:0]adder_out;
	
	SixteenBitRippleAdder A0(.A(Mux_to_ALU),.B(SR1OUT),.Sum(adder_out), .CO());
	 
   always_comb
     begin
        case(ALUK)
          2'b00: ALU_Out = adder_out;
          2'b01: ALU_Out = Mux_to_ALU & SR1OUT;
          2'b10: ALU_Out = ~SR1OUT;
          2'b11: ALU_Out = SR1OUT;
        endcase // case (ALUK)
     end // always_comb

endmodule // ALU
