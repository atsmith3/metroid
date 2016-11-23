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
	int BG1 [30][30];
	int BG2 [30][30];
	int BG3 [30][30];
	int BG4 [30][30];
	int BG5 [30][30];
	int BG6 [30][30];
	int BG7 [30][30];
	int BG8 [30][30];
	int dummy [16][22];
	
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
		BG1 = '{'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
		        '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33}};
		// BLue_brick1:
		BG2 = '{'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
		        '{33,33,33,33,33,33,33,28,33,28,33,28,33,28,33,28,33,28,33,28,33,28,33,28,33,28,33,33,33,33},
				  '{33,33,33,33,33,28,24,26,24,26,24,26,24,26,24,26,24,26,24,26,24,26,24,26,24,26,26,33,33,33},
				  '{33,33,28,28,28,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,29,33,33,33},
				  '{33,33,26,24,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,34,05,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,28,28,28,28,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,28,24,26,24,26,26,33,33,33},
				  '{33,33,28,27,27,27,27,27,27,27,27,27,27,27,27,27,27,27,33,33,33,28,26,26,29,29,34,33,33,33},
              '{33,33,26,24,26,24,26,24,26,24,26,24,26,24,26,24,26,26,33,33,33,28,24,29,34,34,34,33,33,33},
              '{33,33,26,26,29,34,29,34,34,29,34,34,29,34,34,29,34,34,33,33,26,29,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,26,26,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,33,33,24,29,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,5,5,33,33,26,26,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,33,33,33,33,26,26,34,34,34,34,34,33,33,33},
				  '{33,33,28,28,5,33,5,33,5,33,5,33,5,33,5,33,33,33,33,33,28,34,33,5,33,5,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,26,26,26,26,26,26,26,33,33,33,33,33,33,33,33,33,33,33,26,26,26,26,26,26,27,33,33,33},
				  '{33,33,26,24,26,24,26,24,26,33,33,33,33,33,33,33,33,33,33,33,26,24,26,24,26,24,26,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,26,26,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,26,26,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,26,26,34,34,34,34,34,34,34,34,34,34,34,34,34,34,24,26,34,34,34,34,34,34,34,33,33,33},
				  '{33,33,28,27,5,5,5,5,5,5,5,5,5,5,5,5,5,5,27,28,5,5,5,5,5,5,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
				  '{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33}};
		
		// Brick grey:
		BG3 =     '{'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,33,33},
						'{33,33,33,33,33,33,10,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,26,33,33},
						'{33,33,33,26,26,26,22,26,30,26,22,30,26,22,30,26,22,30,26,22,30,26,22,30,26,22,30,10,33,33},
						'{33,33,33,7,7,7,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,10,33,33},
						'{33,33,33,7,22,30,30,30,30,30,10,30,30,10,30,30,10,30,30,10,30,30,10,30,30,10,30,10,33,33},
						'{33,33,33,7,7,10,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,10,33,33},
						'{33,33,33,7,7,10,30,30,30,10,30,10,30,30,10,30,30,10,30,30,10,30,30,10,30,30,30,10,33,33},
						'{33,33,33,10,10,32,32,31,32,32,31,10,31,32,31,32,31,32,31,32,31,32,31,32,31,32,31,31,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,32,30,30,30,30,10,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,10,7,7,7,7,26,33,33},
						'{33,33,33,26,22,26,7,26,22,26,7,26,22,26,7,26,22,26,22,33,33,33,10,7,26,30,30,10,33,33},
						'{33,33,33,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,26,33,33,33,10,7,30,30,30,10,33,33},
						'{33,33,33,7,7,10,30,30,10,30,30,10,30,30,10,30,30,30,10,33,31,7,26,30,30,30,30,10,33,33},
						'{33,33,33,7,22,30,30,30,30,30,30,30,30,30,30,30,10,30,10,33,32,7,22,30,30,30,30,10,33,33},
						'{33,33,33,7,7,10,30,30,30,10,30,10,30,10,30,30,30,30,10,33,32,7,26,30,30,10,30,10,33,33},
						'{33,33,33,7,26,30,30,30,30,30,30,30,30,30,10,30,10,31,33,33,32,7,22,30,30,30,30,10,33,33},
						'{33,33,33,7,7,10,30,10,30,10,30,30,10,30,30,30,30,33,33,33,32,7,26,30,30,30,30,10,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,7,7,7,7,7,7,7,33,33,33,33,33,33,33,33,33,33,31,7,7,7,7,7,7,26,33,33},
						'{33,33,33,7,7,7,7,7,7,26,33,33,33,33,33,33,33,33,33,33,10,7,7,7,7,7,22,26,33,33},
						'{33,33,33,7,7,10,10,30,30,30,30,30,30,30,30,30,30,30,30,7,7,10,10,10,10,10,30,10,33,33},
						'{33,33,33,7,22,10,30,30,30,30,30,30,30,30,30,30,30,30,30,7,26,30,30,30,30,30,30,10,33,33},
						'{33,33,33,7,7,10,30,30,30,30,30,30,10,30,10,30,10,30,30,7,22,30,30,30,30,10,30,10,33,33},
						'{33,33,33,32,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,32,32,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33}};
		// Brick green:
		BG4 =     '{'{33,33,33,32,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,32,32,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,31,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,33,33,33},
						'{33,33,33,33,33,31,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,25,33,33,33},
						'{33,33,18,18,18,13,20,19,19,20,19,19,19,19,19,19,19,19,19,20,19,19,19,19,20,19,20,33,33,33},
						'{33,33,18,18,25,27,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,33,33,33},
						'{33,33,18,18,19,20,20,19,20,19,20,19,20,19,20,19,20,20,19,20,19,20,20,19,20,20,20,33,33,33},
						'{33,33,18,18,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,19,20,20,19,20,20,33,33,33},
						'{33,33,18,18,19,20,20,19,20,19,20,19,20,19,20,20,20,19,20,19,20,20,20,19,20,20,20,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,31,18,18,18,18,18,33,33,33},
						'{33,33,33,16,33,31,33,16,33,31,33,16,33,31,33,16,33,31,33,33,33,31,18,18,13,18,25,33,33,33},
						'{33,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,33,33,33,31,18,19,20,20,20,33,33,33},
						'{33,33,18,18,13,27,25,13,27,25,13,27,25,27,13,25,27,25,33,33,31,25,25,19,20,19,20,33,33,33},
						'{33,33,18,18,20,20,20,20,20,20,20,20,19,20,20,20,19,20,33,33,18,13,20,20,20,20,20,33,33,33},
						'{33,33,18,18,19,20,19,20,19,20,19,20,20,20,19,20,20,20,33,33,18,25,19,20,19,20,20,33,33,33},
						'{33,33,18,18,19,20,20,20,20,20,20,20,20,20,20,19,20,20,33,33,18,13,20,20,20,20,20,33,33,33},
						'{33,33,18,18,19,20,19,20,19,20,20,20,19,20,20,20,33,33,33,33,18,25,19,20,19,20,20,33,33,33},
						'{33,33,25,25,20,28,20,27,20,27,20,27,20,27,20,20,33,33,33,33,18,31,20,28,20,28,28,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,31,31,31,31,31,31,31,33,33,33,33,33,33,33,33,33,33,33,31,31,31,31,31,31,31,33,33,33},
						'{33,33,18,18,18,18,18,18,18,33,33,33,33,33,33,33,33,33,33,33,18,18,18,18,18,18,18,33,33,33},
						'{33,33,18,18,19,27,19,27,19,28,28,28,28,28,28,28,28,28,25,25,27,19,27,19,27,19,27,33,33,33},
						'{33,33,18,18,19,20,20,20,20,19,20,19,19,20,19,19,20,19,18,18,20,20,20,20,20,20,20,33,33,33},
						'{33,33,18,18,20,20,19,20,20,20,20,20,20,20,20,20,20,20,18,18,19,20,20,19,20,20,20,33,33,33},
						'{33,33,18,25,20,20,20,20,20,20,20,20,20,20,20,20,20,20,18,25,20,20,20,20,20,20,28,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33},
						'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33}};
		// Blue door bot mid 1:
		BG5 =     '{'{3,34,29,29,34,29,34,29,34,29,34,29,34,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{2,29,29,29,29,29,29,29,29,29,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{25,29,34,29,29,34,29,29,34,29,29,29,34,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,34,29,34,29,29,29,29,29,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,29,29,29,34,29,34,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,29,34,29,29,29,29,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,34,29,29,29,29,34,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,29,29,34,29,29,29,34,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,34,29,29,29,29,29,29,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,29,29,29,34,29,29,34,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,34,29,29,29,29,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,29,29,34,29,34,29,34,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,34,29,29,29,29,29,29,29,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,29,34,29,29,34,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{18,29,29,29,29,29,29,29,29,29,29,34,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{18,29,34,29,34,29,29,34,29,34,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,34,29,34,29,29,34,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,34,29,29,34,29,29,34,29,34,29,34,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,29,29,29,29,29,29,29,29,29,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{3,34,29,29,34,29,34,29,34,29,29,34,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{3,34,29,34,29,29,34,29,29,34,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,29,29,29,29,29,29,34,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{3,34,29,29,34,29,29,34,29,34,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{16,34,29,29,34,29,34,29,29,34,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
						'{21,29,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
		// Blue Door Bot Right:
		BG6 =  '{'{21,29,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{2,29,34,29,29,34,29,34,29,34,29,29,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,34,29,29,34,29,29,34,29,34,29,34,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,29,29,29,29,29,29,29,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,34,29,34,29,34,29,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,29,29,29,29,29,29,29,29,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,34,29,29,34,29,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,29,29,29,29,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,34,29,34,29,24,26,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,29,29,29,26,7,29,29,29,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,34,29,26,7,34,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,29,29,24,26,26,29,29,34,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,34,29,24,7,26,29,29,29,29,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,29,29,24,7,29,29,34,29,34,33,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{2,29,29,34,29,34,24,7,26,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,26,26,7,7,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,34,24,7,7,7,26,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,7,7,7,24,29,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,7,7,7,26,29,29,29,34,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,7,7,7,24,34,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,7,7,26,26,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,7,26,34,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,24,26,29,29,34,28,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,28,34,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
		// Blue Door bottop:
		BG7 =  '{'{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{31,28,5,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{2,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,34,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,7,26,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,7,26,24,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,7,7,7,24,29,34,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,7,7,7,26,29,29,34,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,7,7,7,24,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,24,7,7,7,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,26,7,7,7,26,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,34,29,24,7,26,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,29,34,24,7,26,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{2,29,34,29,29,29,24,7,29,29,29,34,29,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{25,34,29,29,34,29,26,26,24,24,34,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,29,29,26,7,29,29,29,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,34,29,29,26,7,29,34,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,29,29,26,7,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,34,29,29,29,34,29,29,34,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,34,29,29,29,29,29,34,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,34,29,29,29,34,29,34,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,29,29,29,29,29,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,34,29,34,29,29,34,29,34,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,34,29,29,29,29,29,29,29,29,29,29,29,34,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,34,29,29,34,29,29,34,29,29,34,29,29,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{16,29,29,29,29,29,29,29,29,29,29,29,29,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
					'{3,34,29,29,34,29,34,29,34,29,34,29,34,29,29,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
		// Blue Door left:
		BG8 =  '{'{33,21,21,21,25,21,21,25,21,21,25,21,21,21,21,21,21,21,21,25,21,21,25,21,21,21,25,21,21,29},
					'{16,18,2,2,2,2,2,2,2,2,2,2,2,18,2,18,2,18,2,2,2,2,2,2,2,2,2,2,2,29},
					'{33,2,10,29,24,29,24,29,29,24,29,24,29,16,16,2,30,29,24,29,29,24,29,24,29,29,24,32,16,29},
					'{16,2,24,29,29,29,29,29,29,29,29,29,24,16,16,2,30,29,29,29,29,29,29,29,29,24,29,33,16,29},
					'{33,2,10,29,33,16,16,16,16,16,16,28,29,16,16,18,30,29,28,16,16,16,16,16,16,28,29,28,16,34},
					'{16,2,24,29,16,16,32,33,32,16,16,26,29,16,16,2,30,29,28,16,16,28,32,16,16,10,24,33,16,34},
					'{33,2,24,29,33,16,29,29,24,26,2,24,29,16,16,2,30,29,28,16,29,29,29,24,2,10,29,28,16,29},
					'{16,2,10,29,16,16,29,24,29,24,2,24,29,16,16,2,10,29,28,16,29,24,29,24,18,10,29,31,16,34},
					'{33,2,24,29,33,16,29,29,24,26,2,24,29,16,16,2,30,29,28,16,28,29,29,24,18,10,24,28,16,29},
					'{16,2,24,29,16,16,30,30,30,18,2,26,29,16,16,2,30,29,28,16,25,30,30,18,2,26,29,28,16,34},
					'{33,2,10,29,28,16,2,18,2,2,2,24,29,16,16,2,10,29,28,16,2,2,2,2,2,10,29,28,16,29},
					'{16,2,24,29,29,24,29,29,29,24,29,29,24,16,16,2,30,29,24,29,29,29,29,24,29,24,29,28,16,34},
					'{33,18,10,29,29,28,29,29,29,28,29,29,29,16,16,18,25,29,29,29,29,27,29,29,29,34,29,16,16,29},
					'{33,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,34},
					'{33,21,16,25,16,25,16,25,16,25,16,25,3,25,21,16,25,3,25,16,25,16,25,3,25,16,25,21,16,29},
					'{33,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,18,2,2,29},
					'{16,2,10,26,26,24,26,24,26,24,26,24,26,25,16,2,18,24,26,24,26,24,26,24,26,24,24,10,16,29},
					'{33,2,10,29,24,29,29,29,24,29,29,29,24,16,3,2,30,29,29,24,29,29,29,24,29,29,29,31,16,34},
					'{16,2,24,29,28,16,16,16,16,33,16,29,29,16,16,18,30,29,28,16,33,16,16,16,33,28,29,28,16,34},
					'{33,2,24,29,16,16,16,16,16,16,16,28,29,16,16,2,30,29,28,16,16,16,16,16,3,32,29,31,16,29},
					'{16,2,10,29,33,16,29,29,24,26,2,24,29,16,16,2,10,29,28,16,29,29,29,24,18,10,24,28,16,34},
					'{33,2,24,29,16,16,24,29,29,24,2,26,29,16,16,2,30,29,28,16,29,24,29,24,2,26,29,28,16,29},
					'{16,2,24,29,28,16,29,24,29,24,2,24,29,16,16,2,30,29,28,16,28,29,24,29,2,10,29,28,16,34},
					'{33,2,10,29,16,16,10,26,10,30,18,24,29,16,16,2,10,29,28,16,10,10,26,10,2,10,24,28,16,29},
					'{16,2,24,29,33,16,2,2,2,2,2,26,29,16,16,2,30,29,28,16,21,2,2,2,2,10,29,28,16,34},
					'{33,2,24,29,29,29,26,24,26,26,24,29,24,16,16,18,30,29,29,29,26,24,26,24,29,24,29,28,16,29},
					'{16,2,10,29,24,29,29,29,24,29,29,24,29,16,16,2,10,24,29,24,29,29,29,24,29,29,24,33,16,34},
					'{33,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,29},
					'{33,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,34},
					'{33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33,33}};
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
