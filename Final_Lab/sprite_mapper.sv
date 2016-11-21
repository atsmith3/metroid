//--------------------------------------------------------------------------------------------
// Sprite Mapper:
//
//		The sprite mapper is a glorified color mapper and it will draw the sprites with the 
//		top left corner at the (x,y) coordinate. The background moves based on the position of
//		samus. (She is in the middle on the screen)
//
//--------------------------------------------------------------------------------------------
module sprite_mapper(

	// This module acts as a mux on all of the different levels of sprites:


);

endmodule


//--------------------------------------------------------------------------------------------
// Samus:
//
//		If the vga pixel pointer is within the samus sprite, return a proper color:
//		Priority 1
//
//--------------------------------------------------------------------------------------------
module samus(
	input logic  			enable,
	input logic  [10:0] 	vga_x, vga_y, sprite_x, sprite_y,
	input logic  [1:0] 	sprite_num,
	output logic [5:0] 	color,
	output logic 			draw
);
	// Samus Sprites:
	parameter [9:0] height = 70;
	parameter [9:0] width = 45;
	
	// Samus Combinational Logic:
	always_comb begin
	   // Determine the width and height of the 
	   case(sprite_num)
		// SAMUS STAND:
		2b'00: begin
			// Output the "draw" signal:
			// Make sure that the pointer is inside the sprite:
			if(vga_x > sprite_x && vga_x < sprite_x + width && vga_y > sprite_y && vga_y < sprite_y + height) begin
				// If the color is not pink output draw:
				//if( != 63)
				draw = 1'b1;
				color = 6'b0;
			end
			else begin
				draw = 1'b0;
				color = 6'b0;
			end
		end
		// SAMUS WALK 1:
		2'b01: begin
			// Output the "draw" signal:
			// Make sure that the pointer is inside the sprite:
			if(vga_x > sprite_x && vga_x < sprite_x + width && vga_y > sprite_y && vga_y < sprite_y + height) begin
				// If the color is not pink output draw:
				//if( != 63)
				draw = 1'b1;
				color = 6'b0;
			end
			else begin
				draw = 1'b0;
				color = 6'b0;
			end
		end
		// SAMUS WALK 2:
		2'b10: begin
			// Output the "draw" signal:
			// Make sure that the pointer is inside the sprite:
			if(vga_x > sprite_x && vga_x < sprite_x + width && vga_y > sprite_y && vga_y < sprite_y + height) begin
				// If the color is not pink output draw:
				//if( != 63)
				draw = 1'b1;
				color = 6'b0;
			end
			else begin
				draw = 1'b0;
				color = 6'b0;
			end
		end
		// SAMUS WALK 3:
		2'b11: begin
			// Output the "draw" signal:
			// Make sure that the pointer is inside the sprite:
			if(vga_x > sprite_x && vga_x < sprite_x + width && vga_y > sprite_y && vga_y < sprite_y + height) begin
				// If the color is not pink output draw:
				//if( != 63)
				draw = 1'b1;
				color = 6'b0;
			end
			else begin
				draw = 1'b0;
				color = 6'b0;
			end
		end
		endcase
	end
endmodule


//--------------------------------------------------------------------------------------------
// Monster:
//
//		If the vga pixel pointer is within the monster(s), return a proper color:
//		Priority 2
//		
//--------------------------------------------------------------------------------------------
module monster(
	input logic  			enable1, enable2, enable3,
	input logic  [10:0] 	vga_x, vga_y, sprite1_x, sprite1_y, sprite2_x, sprite2_y, sprite3_x, sprite3_y,
	input logic  [1:0] 	sprite_num,
	output logic [5:0] 	color,
	output logic 			draw
);
	// Monster Sprites:
	parameter [9:0] height = 70;
	parameter [9:0] width = 45;
	
	// Monster Combinational Logic:
	always_comb begin
		// Make sure that the pointer is inside the MONSTER 1:
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable1) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
		// MONSTER 2
		if(vga_x > sprite2_x && vga_x < sprite2_x + width && vga_y > sprite2_y && vga_y < sprite2_y + height && enable2) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
		// MONSTER 3
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable3) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			// Chose the proper color:
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
	end
endmodule


//--------------------------------------------------------------------------------------------
// PowerUp:
//
//		If the vga pixel pointer is within the powerUp, return a proper color:
//		Priority 3
//		
//--------------------------------------------------------------------------------------------
module power_up(
	input logic  			enable1, enable2, enable3,
	input logic  [10:0] 	vga_x, vga_y, sprite1_x, sprite1_y, sprite2_x, sprite2_y, sprite3_x, sprite3_y,
	input logic  [1:0] 	sprite_num,
	output logic [5:0] 	color,
	output logic 			draw
);
// Mux the certain power up:
// powerUp Sprites:
	parameter [9:0] height = 70;
	parameter [9:0] width = 45;
	
	// Monster Combinational Logic:
	always_comb begin
		// Make sure that the pointer is inside the powerUp 1:
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable1) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
		// powerUp 2
		if(vga_x > sprite2_x && vga_x < sprite2_x + width && vga_y > sprite2_y && vga_y < sprite2_y + height && enable2) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
		// powerUp 3
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable3) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			// Chose the proper color:
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
	end
endmodule


//--------------------------------------------------------------------------------------------
// Bullet:
//
//		If the vga pixel pointer is within the bullet(s), return a proper color:
//		Priority 4
//		
//--------------------------------------------------------------------------------------------
module bullet(
	input logic  			enable1, enable2, enable3,
	input logic  [10:0] 	vga_x, vga_y, sprite1_x, sprite1_y, sprite2_x, sprite2_y, sprite3_x, sprite3_y,
	input logic  [1:0] 	sprite_num,
	output logic [5:0] 	color,
	output logic 			draw
);
// Mux the bullet instances:
// powerUp Sprites:
	parameter [9:0] height = 20;
	parameter [9:0] width = 20;
	
	// Monster Combinational Logic:
	always_comb begin
		// Make sure that the pointer is inside the powerUp 1:
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable1) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
		// powerUp 2
		if(vga_x > sprite2_x && vga_x < sprite2_x + width && vga_y > sprite2_y && vga_y < sprite2_y + height && enable2) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
		// powerUp 3
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable3) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
			// Chose the proper color:
			color = 6'b0;
		end
		else begin
			draw = 1'b0;
			color = 6'b0;
		end
	end
endmodule


//--------------------------------------------------------------------------------------------
// Background:
//
//		If the vga pixel pointer is within the proper background tile, return a proper color:
//		Priority 5
//		
//--------------------------------------------------------------------------------------------
module background(
   input logic  [10:0]	background_start_addr,
	input logic  [10:0] 	vga_x, vga_y,
	input logic  [1:0] 	sprite_num,
	output logic [5:0] 	color,
	output logic 			draw
);
	// Background Tile sizes:
	parameter [9:0] height = 40;
	parameter [9:0] width = 40;
	
	// Combinational math an returns 
	logic [10:0] background_x, background_y;
	
	
	// Sprites: 8 different backgrounds:
	int BG1 [40][40];
	int BG2 [40][40];
	int BG3 [40][40];
	int BG4 [40][40];
	int BG5 [40][40];
	int BG6 [40][40];
	int BG7 [40][40];
	int BG8 [40][40];
	
	//-------------------------------------------------------------------------------------------------------------
	// Sprite arrays:
	//-------------------------------------------------------------------------------------------------------------
	always_ff begin
		
	end
	
	
	always_comb begin
		// Determines the upper left corner of the tile sprite:
		if(vga_x >= 0 && vga_x < width) background_x = 0;
		if(vga_x >= width && vga_x < 2*width) background_x = width;
		if(vga_x >= 2*width && vga_x < 3*width) background_x = 2*width;
		if(vga_x >= 3*width && vga_x < 4*width) background_x = 3*width;
		if(vga_x >= 4*width && vga_x < 5*width) background_x = 4*width;
		if(vga_x >= 5*width && vga_x < 6*width) background_x = 5*width;
		if(vga_x >= 6*width && vga_x < 7*width) background_x = 6*width;
		if(vga_x >= 7*width && vga_x < 8*width) background_x = 7*width;
		if(vga_x >= 8*width && vga_x < 9*width) background_x = 8*width;
		if(vga_x >= 9*width && vga_x < 10*width) background_x = 9*width;
		if(vga_x >= 10*width && vga_x < 11*width) background_x = 10*width;
		if(vga_x >= 11*width && vga_x < 12*width) background_x = 11*width;
		if(vga_x >= 12*width && vga_x < 13*width) background_x = 12*width;
		if(vga_x >= 13*width && vga_x < 14*width) background_x = 13*width;
		if(vga_x >= 14*width && vga_x < 15*width) background_x = 14*width;
		if(vga_x >= 15*width && vga_x < 16*width) background_x = 15*width;
		
		if(vga_y >= 0 && vga_y < height) background_y = 0;
		if(vga_y >= height && vga_y < 2*height) background_y = height;
		if(vga_y >= 2*height && vga_y < 3*height) background_y = 2*height;
		if(vga_y >= 3*height && vga_y < 4*height) background_y = 3*height;
		if(vga_y >= 4*height && vga_y < 5*height) background_y = 4*height;
		if(vga_y >= 5*height && vga_y	< 6*height) background_y = 5*height;
		if(vga_y >= 6*height && vga_y < 7*height) background_y = 6*height;
		if(vga_y >= 7*height && vga_y < 8*height) background_y = 7*height;
		if(vga_y >= 8*height && vga_y < 9*height) background_y = 8*height;
		if(vga_y >= 9*height && vga_y < 10*height) background_y = 9*height;
		if(vga_y >= 10*height && vga_y < 11*height) background_y = 10*height;
		if(vga_y >= 11*height && vga_y < 12*height) background_y = 11*height;
	end
	
	// Select the correct background tile from the background tile array:
endmodule
