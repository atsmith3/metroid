//--------------------------------------------------------------------------------------------
// Sprite Mapper:
//
//		The sprite mapper is a glorified color mapper and it will draw the sprites with the 
//		top left corner at the (x,y) coordinate. The background moves based on the position of
//		samus. (She is in the middle on the screen)
//
//--------------------------------------------------------------------------------------------
// Pallate: 55,111,207,255), (44,92,10,255),(248,146,56,255),(156,0,18,255), (0, 255, 128), (0,0,128), (0,128,255), (255,255,255), (0,0,0), (0,0,255), (102,102,102), (0,255,255),(0,255,0), (64,128,0),(255,0,0),(255,102,102),(128,0,0),(248,146,56),(232,146,41),(27,175,0),(19,137,13),(255,49,62),(234,228,94),(126,0,246),(47,151,209),(156,89,33),(82,105,250),(43,93,83),(13,65,63),(37,75,258),(148,148,118),(60,70,17),(63,71,73),(34,28,28),(4,35,248),(186,0,37),(126,0,246),(103,0,183)
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
	
	int BulletN [10][10];
	int BulletE [10][10];
	
	always_ff begin
	    BulletN = '{'{63,63,63,63,06,06,63,63,63,63},
		             '{63,63,06,06,06,06,06,06,63,63},
						 '{63,06,06,06,06,06,63,63,06,63},
						 '{63,06,06,06,06,06,63,63,06,63},
						 '{06,06,06,06,06,06,63,63,63,06},
						 '{06,06,06,06,06,06,63,63,63,06},
						 '{63,06,06,06,06,06,63,63,63,63},
						 '{63,06,63,06,06,06,63,63,63,63},
						 '{63,63,06,06,06,06,63,63,63,63},
						 '{63,63,63,63,06,06,63,63,63,63}};
		 BulletE = '{'{63,63,63,63,06,06,63,63,63,63},
		             '{63,63,06,06,06,06,06,06,63,63},
						 '{63,06,06,06,06,06,63,63,06,63},
						 '{63,06,06,06,06,06,63,63,06,63},
						 '{06,06,06,06,06,06,63,63,63,06},
						 '{06,06,06,06,06,06,63,63,63,06},
						 '{63,06,06,06,06,06,63,63,63,63},
						 '{63,06,63,06,06,06,63,63,63,63},
						 '{63,63,06,06,06,06,63,63,63,63},
						 '{63,63,63,63,06,06,63,63,63,63}};
	end
	
	// Monster Combinational Logic:
	always_comb begin
		// Make sure that the pointer is inside the normal bullet:
		if(vga_x > sprite1_x && vga_x < sprite1_x + width && vga_y > sprite1_y && vga_y < sprite1_y + height && enable1) begin
		   // If the color is not pink output draw:
			if(BulletN[vga_x - sprite1_x][vga_y - sprite1_y] != 63) begin
			    draw = 1'b1;
			    color = BulletN[vga_x - sprite1_x][vga_y - sprite1_y];
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
	logic [10:0] background_x, background_y; // Normalized background array pointers:
	logic [10:0] tile_x, tile_y; // Normalized tile coordinate pointers:
	
	// Sprites: 8 different backgrounds:
	int BG1 [40][40];
	int BG2 [40][40];
	int BG3 [40][40];
	int BG4 [40][40];
	int BG5 [40][40];
	int BG6 [40][40];
	int BG7 [40][40];
	int BG8 [40][40];
	int dummy [12][16];
	
	//-------------------------------------------------------------------------------------------------------------
	// Sprite arrays + dummy background array:
	//-------------------------------------------------------------------------------------------------------------
	always_ff begin
		dummy = '{'{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
		          '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,1,2,3,3,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,3,2,2,2,0,0,0,0,1},
					 '{1,0,0,0,0,1,1,1,1,0,3,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
					 '{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}};
		// All Black (08):
		BG1 = '{'{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
		        '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
		        '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8},
				  '{8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8}};
		// Brick 1:
		
		// Brick 2:
		
		// Brick 3:
		
		// Blue Door 1:
		
		// Blue Door 2:
		
		// Blue Door 3:
		
		// Blue Door 4:
		
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
	always_comb begin
	
	end
endmodule
