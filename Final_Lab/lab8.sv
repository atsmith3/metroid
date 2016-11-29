//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module  lab8 			( input         CLOCK_50,
                       input[3:0]    KEY, //bit 0 is set up as Reset
							  output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
							  //output [8:0]  LEDG,
							  //output [17:0] LEDR,
							  // VGA Interface 
                       output [7:0]  VGA_R,					//VGA Red
							                VGA_G,					//VGA Green
												 VGA_B,					//VGA Blue
							  output        VGA_CLK,				//VGA Clock
							                VGA_SYNC_N,			//VGA Sync signal
												 VGA_BLANK_N,			//VGA Blank signal
												 VGA_VS,					//VGA virtical sync signal	
												 VGA_HS,					//VGA horizontal sync signal
							  // CY7C67200 Interface
							  inout [15:0]  OTG_DATA,						//	CY7C67200 Data bus 16 Bits
							  output [1:0]  OTG_ADDR,						//	CY7C67200 Address 2 Bits
							  output        OTG_CS_N,						//	CY7C67200 Chip Select
												 OTG_RD_N,						//	CY7C67200 Write
												 OTG_WR_N,						//	CY7C67200 Read
												 OTG_RST_N,						//	CY7C67200 Reset
							  input			 OTG_INT,						//	CY7C67200 Interrupt
							  // SDRAM Interface for Nios II Software
							  output [12:0] DRAM_ADDR,				// SDRAM Address 13 Bits
							  inout [31:0]  DRAM_DQ,				// SDRAM Data 32 Bits
							  output [1:0]  DRAM_BA,				// SDRAM Bank Address 2 Bits
							  output [3:0]  DRAM_DQM,				// SDRAM Data Mast 4 Bits
							  output			 DRAM_RAS_N,			// SDRAM Row Address Strobe
							  output			 DRAM_CAS_N,			// SDRAM Column Address Strobe
							  output			 DRAM_CKE,				// SDRAM Clock Enable
							  output			 DRAM_WE_N,				// SDRAM Write Enable
							  output			 DRAM_CS_N,				// SDRAM Chip Select
							  output			 DRAM_CLK				// SDRAM Clock
											);
    
    logic Reset_h, vssig, Clk;
	 logic [15:0] keycode;
    
	 assign Clk = CLOCK_50;
    assign {Reset_h}=~ (KEY[0]);  // The push buttons are active low
	 
	 wire [1:0] hpi_addr;
	 wire [15:0] hpi_data_in, hpi_data_out;
	 wire hpi_r, hpi_w,hpi_cs;
	 
	 hpi_io_intf hpi_io_inst(   .from_sw_address(hpi_addr),
										 .from_sw_data_in(hpi_data_in),
										 .from_sw_data_out(hpi_data_out),
										 .from_sw_r(hpi_r),
										 .from_sw_w(hpi_w),
										 .from_sw_cs(hpi_cs),
		 								 .OTG_DATA(OTG_DATA),    
										 .OTG_ADDR(OTG_ADDR),    
										 .OTG_RD_N(OTG_RD_N),    
										 .OTG_WR_N(OTG_WR_N),    
										 .OTG_CS_N(OTG_CS_N),    
										 .OTG_RST_N(OTG_RST_N),   
										 .OTG_INT(OTG_INT),
										 .Clk(Clk),
										 .Reset(~KEY[1])	
	 );
	 
	 
	 //The connections for nios_system might be named different depending on how you set up Qsys
	 nios_system nios_system(	 .clk_clk(Clk),         
										 .reset_reset_n(KEY[0]),   
										 .sdram_wire_addr(DRAM_ADDR), 
										 .sdram_wire_ba(DRAM_BA),   
										 .sdram_wire_cas_n(DRAM_CAS_N),
										 .sdram_wire_cke(DRAM_CKE),  
										 .sdram_wire_cs_n(DRAM_CS_N), 
										 .sdram_wire_dq(DRAM_DQ),   
										 .sdram_wire_dqm(DRAM_DQM),  
										 .sdram_wire_ras_n(DRAM_RAS_N),
										 .sdram_wire_we_n(DRAM_WE_N), 
										 .sdram_clk_clk(DRAM_CLK),
										 .keycode_export(keycode),  
										 .otg_hpi_address_export(hpi_addr),
										 .otg_hpi_data_in_port(hpi_data_in),
										 .otg_hpi_data_out_port(hpi_data_out),
										 .otg_hpi_cs_export(hpi_cs),
										 .otg_hpi_r_export(hpi_r),
										 .otg_hpi_w_export(hpi_w));
	
	//Fill in the connections for the rest of the modules 
   vga_controller vgasync_instance(.*,.Reset(Reset_h),
													.hs(VGA_HS),    
													.vs(VGA_VS),        
													.pixel_clk(VGA_CLK), 
													.blank(VGA_BLANK_N),     
													.sync(VGA_SYNC_N),
												   .DrawX(drawxsig), 
								               .DrawY(drawysig));
	 	
	//--------------------------------------------------------------------------------------------
	// Sprite Mapper:
	//
	//		The sprite mapper is a glorified color mapper and it will draw the sprites with the 
	//		top left corner at the (x,y) coordinate. The background moves based on the position of
	//		samus. (She is in the middle on the screen)
	//
	//--------------------------------------------------------------------------------------------
	sprite_mapper sp1(.clk(Clk), .reset(Reset_h), .vgaX(drawxsig), .vgaY(drawysig), .red(VGA_R), .green(VGA_G), .blue(VGA_B), .vsync(VGA_VS)
							/*
							// Samus
							input logic enable, direction, walk, jump,
							input logic [9:0] samus_x, samus_y,

							// Background
							input logic scene_number,

							// GUI
							input logic title_en,
							input logic loss_en,
							input logic win_en,
							input logic [1:0] health,

							// Monster
							input logic monster1, monster2, monster3,
							input logic [9:0] monster1_x, monster1_y, monster2_x, monster2_y, monster3_x, monster3_y,

							// Explosion
							input logic exp1_en, exp2_en, exp3_en,
							input logic [9:0] exp1_x, exp1_y, exp2_x, exp2_y, exp3_x, exp3_y, 

							// Bullet
							input logic bullet1, bullet2, bullet3,
							input logic [9:0] b1_x, b1_y, b2_x, b2_y, b3_x, b3_y,
							*/);
							
	//--------------------------------------------------------------------------------------------
	// Sound Unit:
	//
	//		Interfaces with the GPIO Pins:
	//		This is a custom sound unit that will connect with a low pass filter and amp on a
	//		breadboard. Uses a 256 bit shift register to send a pwm signal to the filter / amp.
	//
	//--------------------------------------------------------------------------------------------
	//sound_controller sc1(	.clk(), 
	//								.enable(),
	//								.reset(),
	//								.soundNumber());

	// Hex drivers (for debug)
	HexDriver hex_inst_0 (keycode[3:0], HEX0);
	HexDriver hex_inst_1 (keycode[7:4], HEX1);
	HexDriver hex_inst_2 (hpi_data_in[3:0], HEX2);
	HexDriver hex_inst_3 (hpi_data_in[7:4], HEX3);
	HexDriver hex_inst_4 (hpi_data_in[11:8], HEX4);
	HexDriver hex_inst_5 (hpi_data_in[15:12], HEX5);
	HexDriver hex_inst_6 ({OTG_DATA[3:0]}, HEX6);
	HexDriver hex_inst_7 ({OTG_DATA[7:4]}, HEX7);
endmodule
