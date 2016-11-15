//--------------------------------------------------------------------------------------------
// Sprite Mapper:
//
//		The sprite mapper is a glorified color mapper and it will draw the sprites with the 
//		top left corner at the (x,y) coordinate. The background moves based on the position of
//		samus. (She is in the middle on the screen)
//
//--------------------------------------------------------------------------------------------
module sprite_mapper(




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
	   case
		// Output the "draw" signal:
		// Make sure that the pointer is inside the sprite:
		if(vga_x > sprite_x && vga_x < sprite_x + width && vga_y > sprite_y && vga_y < sprite_y + height) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;	
		end
		else begin
			draw = 1'b0;
		end
	   
		// Chose the proper color:
		if(draw == 1'b1)
			color = 5;
		else
			color = 6'b0;
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
	   // Determine the width and height of the 
	   case(sprite_num)
		// Output the "draw" signal:
		
		// Make sure that the pointer is inside the sprite:
		if(vga_x > sprite_x && vga_x < sprite_x + width && vga_y > sprite_y && vga_y < sprite_y + height) begin
		   // If the color is not pink output draw:
			//if( != 63)
			draw = 1'b1;
		end
		else begin
			draw = 1'b0;
		end
	   
		// Chose the proper color:
		if(draw == 1'b1)
			color = 6'b111010;
		else
			color = 6'b0;
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


);

endmodule


//--------------------------------------------------------------------------------------------
// Bullet:
//
//		If the vga pixel pointer is within the bullet(s), return a proper color:
//		Priority 4
//		
//--------------------------------------------------------------------------------------------
module bullet(


);

endmodule


//--------------------------------------------------------------------------------------------
// Background:
//
//		If the vga pixel pointer is within the bullet(s), return a proper color:
//		Priority 5
//		
//--------------------------------------------------------------------------------------------
module background(


);

endmodule
