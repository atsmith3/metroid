module blitter(input logic [7:0] opCode,
					input logic [22:0] startAddress,
					input logic [22:0] endAddress,
					input logic clk, reset, draw_en,
					output logic draw_complete,
					
					
					/*** Flash Interface ***/
					input logic  [7:0] FL_DQ,
					output logic [22:0] FL_ADDR,
					output logic FL_CE_N, FL_OE_N, FL_WE_N, FL_RST_N, FL_WP_N, FL_RY
					
					/*** Sram Interface ***/
					output logic [15:0] SRAM_DQ,
					output logic [19:0] SRAM_ADDR,
					output logic SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N
					)
	
		logic [3:0] counter;
		logic []
		logic [19:0] clear_count;
		logic [9:0] blitter_x, tile_origin_x;
		logic [8:0] blitter_y, tile_origin_y;
		
		logic [0:191] sp_0, sp_1, sp_2, sp_3, sp_4, sp_5, sp_6, sp_7, sp_8, sp_9;
		
		enum logic [2:0] {WAIT, clr_black, draw_bkg, get_background_0, get_background_1, get_background_2, get_background_3, get_background_4, fetch_tile, draw_sprites} state, next_state;
		
		logic [19:0] address;
		logic [3:0] background_code;
		
		//spriteDecoder SD0(.spriteCode(background_code), .x, .y, .Color);
		
		/*** State Counters and Reset ***/
		always_ff @ (posedge clk, negedge reset) begin
			if (reset == 1'b0) begin
				state <= WAIT;
				counter <= 1'b0;
				clear_count <= 1'b0;
				address <= startAddress;
			end
			else begin
				state <= next_state;
				
				if (state == WAIT) begin
					counter <= 1'b0;
					clear_count <= 1'b0;
					address <= startAddress;
				end
				
				if (state == clr_black) begin
					clear_count <= clear_count + 1'b1;
				end
				
				if (state == draw_bkg) begin
					counter <= counter + 1'b1;
				end
				
				if (state == fetch_tile) begin
					counter <= 1'b0;
				end
				
				if (state == draw_sprites) begin
					/*** INSERT CODE HERE ***/
				end
		end
		
		/*** State Transitions ***/
		always_comb begin
			case(state)
				WAIT: begin
					if (draw_en == 1'b1) begin
						if (opcode == 2'b0) begin
							next_state = clr_black;
						end
						else if (opcode == 2'b1) begin
							next_state = get_background_0;
						end
						else if (opcode == 2'b2) begin
							next_state = draw_sprites;
						end
						else begin
							next_state = WAIT;
						end
					end
					else begin
						next_state = WAIT;
					end
				end
				clr_black: begin
					if (clear_count == 307199) begin
						next_state = WAIT;
					end
					else begin
						next_state = clr_black;
					end
				end
				draw_bkg: begin
					if (counter == 7) begin
						next_state = fetch_tile;
					end
					else begin
						next_state = draw_bkg;
					end
				end
				fetch_tile: begin
					if (address == endAddress) begin
						next_state = WAIT;
					end
					else begin
						next_state = draw_bkg;
					end
				end
			endcase
		end
		
		/*** State Logic ***/
		always_comb begin
		
		
		end
endmodule

/*			
module spriteDecoder(input logic spriteCode,
							input logic [9:0] x,
							input logic [8:0] y,
							output logic [5:0] Color)
							
					
			
endmodule
*/

/*
Get texture from memory
Load first pixel
...
Load sixth pixel
get new texture
*/