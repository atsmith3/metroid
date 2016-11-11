module drawer(	/*** Basically a more powerful color mapper ***/
					logic input vgaX, vgaY, clk, vgaClkIn, vsync,
					logic output vgaClkOut,
					logic output red, green, blue,
					logic output finished_draw,
					
					// Handshake with the blitter:
					logic input enable,				// From blitter, tells the drawer to start drawing
					logic output acknowladge,		// Tells the blitter to got to the WAIT state
					logic input ackBack,				// Tells us blitter took over
					logic output blitterStart,		// Triggers the blitter (safe space required)
					logic output inControl,			// Couples the drawer to the SRAM
					
					/*** SRAM INTERFACE ***/
					input logic [15:0] SRAM_DQ,
					input logic [19:0] SRAM_ADDR,
					input logic SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N
  				 );

/*** This modules purpose is to iterate over the buffer in memory and determine the correct color for that pixel ***/
parameter [19:0] bufferStart = 0;

/*** Local signals ***/
logic [7:0] sdram_data;
logic [19:0] address;
logic [19:0] prev_address;
logic [7:0] new_data;
logic [7:0] hs_counter;		// When we horizontal sync twice, add to the address;
enum logic [2:0] {WAIT, RESET, INITIAL_0, INITIAL_1, output1_0, output1_1, output1_2, output1_3, output1_4, output2_0, output2_1, output2_3, output2_4} state, next_state;

/*** Synchronous logic ***/
always_ff @(posedge vgaClk) begin
	if (reset == 1'b0) begin
		state <= WAIT;
		address <= bufferStart;
	end
	else
		state <= next_state;
end

/*** Next State Logic ***/
always_comb begin
	case(state)
	WAIT: begin
		if(enable)
			next_state = INITIAL_0;
		else
			next_state = WAIT;
	end
	DONE: begin
		if(ackBack)
	end
	INITIAL_0: begin
		next_state = INITIAL_1;
	end
	INITIAL_1: begin
		next_state = output1_0;
	end
	RESET: begin
	
	end
	output1_0: begin
		next_state = output1_1;
	end
	output1_1: begin
		next_state = output1_2;
	end
	output1_2: begin
		next_state = output1_3;
	end
	output1_3: begin
		next_state = output1_4;
	end
	output1_4: begin
		next_state = output2_0;
	end
	output2_0: begin
		next_state = output2_1;
	end
	output2_1: begin
		next_state = output2_2;
	end
	output2_2: begin
		next_state = output2_3;
	end
	output2_3: begin
		next_state = output2_4;
	end
	output2_4: begin
	   if()
		next_state = output1_0;
	end
end

/*** State Logic ***/
always_comb begin

/*** Output Logic : Color Mapper ***/

/*** Looks Up from a Pallate ***/
always_comb begin
	case(sdram_data)
	/* Color 0 is black */
	4'h0: begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'h00;
	end
	/* Color 1 is royal blue */
	4'h1: begin
		red = 8'h00;
		green = 8'h80;
		blue = 8'hff;
	end
	/* Color 2 is dark blue */
	4'h2: begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'hff;
	end
	/* Color 3 is brick 2,3 outline */
	4'h3: begin
		red = 8'h00;
		green = 8'hff;
		blue = 8'hff;
	end
	/* Color 4 is grey */
	4'h4: begin
		red = 8'h66;
		green = 8'h66;
		blue = 8'h66;
	end
	/* Color 5 is moss */
	4'h5: begin
		red = 8'h00;
		green = 8'hff;
		blue = 8'h00;
	end
 	/* Color 6 is dark moss */
	4'h6: begin
		red = 8'h80;
		green = 8'h80;
		blue = 8'h00;
	end
	/* Color 7 is outside blue */
	4'h7: begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'h80;
	end
	/* Color 8 is outside green */
	4'h8: begin
		red = 8'h18;
		green = 8'hfa;
		blue = 8'h92;
	end
	/* Color 9 is white */
	4'h9: begin
		red = 8'hff;
		green = 8'hff;
		blue = 8'hff;
	end
	/* Color 10 is orange */
	4'ha: begin
		red = 8'hff;
		green = 8'h93;
		blue = 8'h00;
	end
	/* Color 11 is red */
	4'hb: begin
		red = 8'hff;
		green = 8'h00;
		blue = 8'h00;
	end
	/* Color 12 is blaster tip */
	4'hc: begin
		red = 8'h80;
		green = 8'hff;
		blue = 8'h00;
	end
	/* Color 13 is visor */
	4'hd: begin
		red = 8'hff;
		green = 8'hff;
		blue = 8'h00;
	end
	/* Color 14 is dark red */
	4'he: begin
		red = 8'h80;
		green = 8'h00;
		blue = 8'h00;
	end
	/* Color 15 is pink */
	4'hf: begin
		red = 8'hff;
		green = 8'h66;
		blue = 8'h66;
	end
	/* Default is Black */
	default: begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'h00;
	end
	endcase
end

endmodule