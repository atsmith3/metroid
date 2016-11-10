module drawer(	/*** Basically a more powerful color mapper ***/
					logic input vgaX, vgaY, clk, enable, vgaClk,
					logic output red, green, blue,
					logic output finished_draw,
					
					/*** SRAM INTERFACE ***/
					
  				 );
/*** This modules purpose is to iterate over the buffer in memory and determine the correct color for that pixel ***/

parameter [23:0] bufferStart = 0;
parameter [23:0] bufferEnd = 0;

/*** Local signals ***/
logic [19:0] address;
logic [19:0] screenCounter;		// This counts up to 307199 which is the number of on screen pixels
logic [3:0] pixelCounter;			//	Each "memory pixel" is mapped to 5x5 "on screen" pixels
logic [7:0] sdram_data;
logic [7:0] new_data;
enum logic [2:0] {WAIT_1, CLEAR_1, RESET_1, set_address, get_data};
enum logic [2:0] {Wait_2, CLear_2, RESET_2, output1, output2};

/*** Synchronous logic ***/
always_ff @(posedge clk) begin

end

always_ff @()

/*** Next State Logic ***/

/*** State Logic ***/

/*** Output Logic : Color Mapper ***/
/*** Looks Up from a Pallate ***/
always_comb begin
	case(sdram_data)
	4'h0: begin
	
	end
	
	4'h1: begin
	
	end
	
	4'h2: begin
	
	end
	
	4'h3: begin
	
	end
	
	4'h4: begin
	
	end
	
	4'h5: begin
	
	end
 	
	4'h6: begin
	
	end
	
	4'h7: begin
	
	end
	
	4'h8: begin
	
	end
	
	4'h9: begin
	
	end
	
	4'ha: begin
	
	end
	
	4'hb: begin
	
	end
	
	4'hc: begin
	
	end
	
	4'hd: begin
	
	end
	
	4'he: begin
	
	end
	/* Color 15 is black */
	4'hf: begin
		red = 8'h00;
		green = 8'h00;
		blue = 8'h00;
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