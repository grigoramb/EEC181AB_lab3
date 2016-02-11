
module mysystem (
	done_bit_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	ready_bit_export,
	sdram_clk_clk,
	sdram_master_0_control_done_out,
	sdram_master_0_control_ready_in,
	sdram_master_0_control_length_in,
	sdram_master_0_debug_max_out,
	sdram_master_0_debug_min_out,
	sdram_master_0_debug_state_out,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	system_ref_clk_clk,
	system_ref_reset_reset,
	length_from_hps_export);	

	input		done_bit_export;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[7:0]	memory_mem_dq;
	inout		memory_mem_dqs;
	inout		memory_mem_dqs_n;
	output		memory_mem_odt;
	output		memory_mem_dm;
	input		memory_oct_rzqin;
	output		ready_bit_export;
	output		sdram_clk_clk;
	output		sdram_master_0_control_done_out;
	input		sdram_master_0_control_ready_in;
	input	[5:0]	sdram_master_0_control_length_in;
	output	[15:0]	sdram_master_0_debug_max_out;
	output	[15:0]	sdram_master_0_debug_min_out;
	output	[2:0]	sdram_master_0_debug_state_out;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		system_ref_clk_clk;
	input		system_ref_reset_reset;
	output	[5:0]	length_from_hps_export;
endmodule
