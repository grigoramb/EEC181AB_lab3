
module mysystem (
	average_to_hps_export,
	control_done,
	control_length,
	control_readaddress,
	control_ready,
	control_state,
	control_writeaddress,
	control_average,
	done_bit_export,
	length_from_hps_export,
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
	readaddress_from_hps_export,
	writeaddress_from_hps_export);	

	input	[15:0]	average_to_hps_export;
	output		control_done;
	input	[6:0]	control_length;
	input	[31:0]	control_readaddress;
	input		control_ready;
	output	[2:0]	control_state;
	input	[31:0]	control_writeaddress;
	output	[15:0]	control_average;
	input		done_bit_export;
	output	[6:0]	length_from_hps_export;
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
	output	[31:0]	readaddress_from_hps_export;
	output	[31:0]	writeaddress_from_hps_export;
endmodule
