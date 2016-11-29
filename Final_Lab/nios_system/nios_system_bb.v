
module nios_system (
	bullet1_en_export,
	bullet1_x_export,
	bullet1_y_export,
	bullet2_en_export,
	bullet2_x_export,
	bullet2_y_export,
	bullet3_en_export,
	bullet3_x_export,
	bullet3_y_export,
	clk_clk,
	explosion1_en_export,
	explosion1_x_export,
	explosion1_y_export,
	explosion2_en_export,
	explosion2_x_export,
	explosion2_y_export,
	explosion3_en_export,
	explosion3_x_export,
	explosion3_y_export,
	health_export,
	key_export,
	keycode_export,
	loss_en_export,
	monster1_en_export,
	monster1_x_export,
	monster1_y_export,
	monster2_en_export,
	monster2_x_export,
	monster2_y_export,
	monster3_en_export,
	monster3_x_export,
	monster3_y_export,
	otg_hpi_address_export,
	otg_hpi_cs_export,
	otg_hpi_data_in_port,
	otg_hpi_data_out_port,
	otg_hpi_r_export,
	otg_hpi_w_export,
	reset_reset_n,
	samus_dir_export,
	samus_en_export,
	samus_jump_export,
	samus_walk_export,
	samus_x_export,
	samus_y_export,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	title_en_export,
	win_en_export,
	scene_sel_export);	

	output		bullet1_en_export;
	output	[9:0]	bullet1_x_export;
	output	[9:0]	bullet1_y_export;
	output		bullet2_en_export;
	output	[9:0]	bullet2_x_export;
	output	[9:0]	bullet2_y_export;
	output		bullet3_en_export;
	output	[9:0]	bullet3_x_export;
	output	[9:0]	bullet3_y_export;
	input		clk_clk;
	output		explosion1_en_export;
	output	[9:0]	explosion1_x_export;
	output	[9:0]	explosion1_y_export;
	output		explosion2_en_export;
	output	[9:0]	explosion2_x_export;
	output	[9:0]	explosion2_y_export;
	output		explosion3_en_export;
	output	[9:0]	explosion3_x_export;
	output	[9:0]	explosion3_y_export;
	output	[1:0]	health_export;
	input	[1:0]	key_export;
	output	[15:0]	keycode_export;
	output		loss_en_export;
	output		monster1_en_export;
	output	[9:0]	monster1_x_export;
	output	[9:0]	monster1_y_export;
	output		monster2_en_export;
	output	[9:0]	monster2_x_export;
	output	[9:0]	monster2_y_export;
	output		monster3_en_export;
	output	[9:0]	monster3_x_export;
	output	[9:0]	monster3_y_export;
	output	[1:0]	otg_hpi_address_export;
	output		otg_hpi_cs_export;
	input	[15:0]	otg_hpi_data_in_port;
	output	[15:0]	otg_hpi_data_out_port;
	output		otg_hpi_r_export;
	output		otg_hpi_w_export;
	input		reset_reset_n;
	output		samus_dir_export;
	output		samus_en_export;
	output		samus_jump_export;
	output		samus_walk_export;
	output	[9:0]	samus_x_export;
	output	[9:0]	samus_y_export;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output		title_en_export;
	output		win_en_export;
	output	[2:0]	scene_sel_export;
endmodule
