	mysystem u0 (
		.average_to_hps_export        (<connected-to-average_to_hps_export>),        //        average_to_hps.export
		.control_done                 (<connected-to-control_done>),                 //               control.done
		.control_length               (<connected-to-control_length>),               //                      .length
		.control_readaddress          (<connected-to-control_readaddress>),          //                      .readaddress
		.control_ready                (<connected-to-control_ready>),                //                      .ready
		.control_state                (<connected-to-control_state>),                //                      .state
		.control_writeaddress         (<connected-to-control_writeaddress>),         //                      .writeaddress
		.control_average              (<connected-to-control_average>),              //                      .average
		.done_bit_export              (<connected-to-done_bit_export>),              //              done_bit.export
		.length_from_hps_export       (<connected-to-length_from_hps_export>),       //       length_from_hps.export
		.memory_mem_a                 (<connected-to-memory_mem_a>),                 //                memory.mem_a
		.memory_mem_ba                (<connected-to-memory_mem_ba>),                //                      .mem_ba
		.memory_mem_ck                (<connected-to-memory_mem_ck>),                //                      .mem_ck
		.memory_mem_ck_n              (<connected-to-memory_mem_ck_n>),              //                      .mem_ck_n
		.memory_mem_cke               (<connected-to-memory_mem_cke>),               //                      .mem_cke
		.memory_mem_cs_n              (<connected-to-memory_mem_cs_n>),              //                      .mem_cs_n
		.memory_mem_ras_n             (<connected-to-memory_mem_ras_n>),             //                      .mem_ras_n
		.memory_mem_cas_n             (<connected-to-memory_mem_cas_n>),             //                      .mem_cas_n
		.memory_mem_we_n              (<connected-to-memory_mem_we_n>),              //                      .mem_we_n
		.memory_mem_reset_n           (<connected-to-memory_mem_reset_n>),           //                      .mem_reset_n
		.memory_mem_dq                (<connected-to-memory_mem_dq>),                //                      .mem_dq
		.memory_mem_dqs               (<connected-to-memory_mem_dqs>),               //                      .mem_dqs
		.memory_mem_dqs_n             (<connected-to-memory_mem_dqs_n>),             //                      .mem_dqs_n
		.memory_mem_odt               (<connected-to-memory_mem_odt>),               //                      .mem_odt
		.memory_mem_dm                (<connected-to-memory_mem_dm>),                //                      .mem_dm
		.memory_oct_rzqin             (<connected-to-memory_oct_rzqin>),             //                      .oct_rzqin
		.ready_bit_export             (<connected-to-ready_bit_export>),             //             ready_bit.export
		.sdram_clk_clk                (<connected-to-sdram_clk_clk>),                //             sdram_clk.clk
		.sdram_wire_addr              (<connected-to-sdram_wire_addr>),              //            sdram_wire.addr
		.sdram_wire_ba                (<connected-to-sdram_wire_ba>),                //                      .ba
		.sdram_wire_cas_n             (<connected-to-sdram_wire_cas_n>),             //                      .cas_n
		.sdram_wire_cke               (<connected-to-sdram_wire_cke>),               //                      .cke
		.sdram_wire_cs_n              (<connected-to-sdram_wire_cs_n>),              //                      .cs_n
		.sdram_wire_dq                (<connected-to-sdram_wire_dq>),                //                      .dq
		.sdram_wire_dqm               (<connected-to-sdram_wire_dqm>),               //                      .dqm
		.sdram_wire_ras_n             (<connected-to-sdram_wire_ras_n>),             //                      .ras_n
		.sdram_wire_we_n              (<connected-to-sdram_wire_we_n>),              //                      .we_n
		.system_ref_clk_clk           (<connected-to-system_ref_clk_clk>),           //        system_ref_clk.clk
		.system_ref_reset_reset       (<connected-to-system_ref_reset_reset>),       //      system_ref_reset.reset
		.readaddress_from_hps_export  (<connected-to-readaddress_from_hps_export>),  //  readaddress_from_hps.export
		.writeaddress_from_hps_export (<connected-to-writeaddress_from_hps_export>)  // writeaddress_from_hps.export
	);

