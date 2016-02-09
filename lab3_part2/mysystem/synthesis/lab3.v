module lab3(
    
    // FPGA Pins
    
    // Clock Pins
    CLOCK_50,
	 DRAM_CLK,
    
    // Seven Segment Displays
    HEX0,
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    
    // Pushbuttons
    KEY,
    SW, 
    // LEDs
    LEDR,
    

    
    // HPS Pins
    
    // DDR3_SDRAM
    HPS_DDR3_ADDR,
    HPS_DDR3_BA,
    HPS_DDR3_CAS_N,
    HPS_DDR3_CKE,
    HPS_DDR3_CK_N,
    HPS_DDR3_CK_P,
    HPS_DDR3_CS_N,
    HPS_DDR3_DM,
    HPS_DDR3_DQ,
    HPS_DDR3_DQS_N,
    HPS_DDR3_DQS_P,
    HPS_DDR3_ODT,
    HPS_DDR3_RAS_N,
    HPS_DDR3_RESET_N,
    HPS_DDR3_RZQ,
    HPS_DDR3_WE_N,
	 
	 
	 DRAM_ADDR,
	 DRAM_BA,
    DRAM_CAS_N,
    DRAM_CKE,
	 DRAM_CS_N,
    DRAM_DQ,
	 DRAM_UDQM, 
	 DRAM_LDQM,
    DRAM_RAS_N,
    DRAM_WE_N
	
);


    // ************************************
	// PORT declarations
    // ************************************

	
	// FPGA Pins
	//////////////////
	
	input CLOCK_50;
	output DRAM_CLK;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input [3:0] KEY;
	output [9:0] LEDR;
	input [4:0] SW;
	
	// HPS Pins
	/////////////////
	
	// DDR3 SDRAM
	output [14:0] HPS_DDR3_ADDR;
	output [2:0] HPS_DDR3_BA;
	output HPS_DDR3_CAS_N;
	output HPS_DDR3_CKE;
	output HPS_DDR3_CK_N;
	output HPS_DDR3_CK_P;
	output HPS_DDR3_CS_N;
	output [3:0] HPS_DDR3_DM;
	inout [31:0] HPS_DDR3_DQ;
	inout [3:0] HPS_DDR3_DQS_N;
	inout [3:0] HPS_DDR3_DQS_P;
	output HPS_DDR3_ODT;
	output HPS_DDR3_RAS_N;
	output HPS_DDR3_RESET_N;
	input HPS_DDR3_RZQ;
	output HPS_DDR3_WE_N;
	
	
	
	output [12:0]DRAM_ADDR;
   output [1:0] DRAM_BA;
   output DRAM_CAS_N;
   output DRAM_CKE;
   output DRAM_CS_N;
   inout [15:0]DRAM_DQ;
	output DRAM_UDQM; 
	output DRAM_LDQM;
   output DRAM_RAS_N;
   output DRAM_WE_N; 
		  
	
	// REG/WIRE declarations
	//////////////////////////////////
	
	wire [31:0] inputnum;
		
	hex_7seg hex0 (inputnum[3:0],HEX0);
	hex_7seg hex1 (inputnum[7:4],HEX1);
	hex_7seg hex2 (inputnum[11:8],HEX2);
	hex_7seg hex3 (inputnum[15:12],HEX3);
	hex_7seg hex4 (inputnum[19:16],HEX4);
	hex_7seg hex5 (inputnum[23:20],HEX5);
	assign LEDR[7:0] = inputnum[31:24];
	
	wire done; // done signal from sdram_master -> HPS
	wire ready_bit; // ready signal from HPS -> sdram_master
	
    mysystem u0 (
        .system_ref_clk_clk     (CLOCK_50),     			//   system_ref_clk.clk
        .system_ref_reset_reset (~KEY[0]), 					// system_ref_reset.reset
        .memory_mem_a       (HPS_DDR3_ADDR),       		//      memory.mem_a
        .memory_mem_ba      (HPS_DDR3_BA),      			//            .mem_ba
        .memory_mem_ck      (HPS_DDR3_CK_P),      			//            .mem_ck
        .memory_mem_ck_n    (HPS_DDR3_CK_N),    			//            .mem_ck_n
        .memory_mem_cke     (HPS_DDR3_CKE),     			//            .mem_cke
        .memory_mem_cs_n    (HPS_DDR3_CS_N),    			//            .mem_cs_n
        .memory_mem_ras_n   (HPS_DDR3_RAS_N),   			//            .mem_ras_n
        .memory_mem_cas_n   (HPS_DDR3_CAS_N),   			//            .mem_cas_n
        .memory_mem_we_n    (HPS_DDR3_WE_N),    			//            .mem_we_n
        .memory_mem_reset_n (HPS_DDR3_RESET_N), 			//            .mem_reset_n
        .memory_mem_dq      (HPS_DDR3_DQ),      			//            .mem_dq
        .memory_mem_dqs     (HPS_DDR3_DQS_P),     			//            .mem_dqs
        .memory_mem_dqs_n   (HPS_DDR3_DQS_N),   			//            .mem_dqs_n
        .memory_mem_odt     (HPS_DDR3_ODT),     			//            .mem_odt
        .memory_mem_dm      (HPS_DDR3_DM),      			//            .mem_dm
        .memory_oct_rzqin   (HPS_DDR3_RZQ),   				//            .oct_rzqin
        .sdram_clk_clk          (DRAM_CLK),       		   //        sdram_clk.clk
        .sdram_wire_addr        (DRAM_ADDR),        //       sdram_wire.addr
        .sdram_wire_ba          (DRAM_BA),          //                 .ba
        .sdram_wire_cas_n       (DRAM_CAS_N),       //                 .cas_n
        .sdram_wire_cke         (DRAM_CKE),         //                 .cke
        .sdram_wire_cs_n        (DRAM_CS_N),        //                 .cs_n
        .sdram_wire_dq          (DRAM_DQ),          //                 .dq
        .sdram_wire_dqm         ({DRAM_UDQM, DRAM_LDQM}),         //                 .dqm
        .sdram_wire_ras_n       (DRAM_RAS_N),       //                 .ras_n
        .sdram_wire_we_n        (DRAM_WE_N),         //                 .we_n
        .ready_bit_export       (ready_from_HPS),                            //              ready_bit.export
        .done_bit_export        (done_from_MASTER),                              //               done_bit.export		  
        //.sdram_master_0_conduit_done_out (done_from_MASTER), // sdram_master_0_conduit.done_out
        //.sdram_master_0_conduit_ready_in (ready_from_HPS), //                       .ready_in
        //.sdram_master_0_conduit_max_out  (),  //                       .max_out
        //.sdram_master_0_conduit_min_out  (),//                       .min_out
        .sdram_master_0_control_done_out    (done_from_MASTER),    // sdram_master_0_control.done_out
        .sdram_master_0_control_ready_in    (ready_from_HPS | ~KEY[3]),    //                       .ready_in
        .sdram_master_0_debug_max_out       (inputnum[31:16]),       //   sdram_master_0_debug.max_out
        .sdram_master_0_debug_min_out       (inputnum[15:0])       //                       .min_out
    );
	 
	wire done_from_MASTER;
	wire ready_from_HPS;
	assign LEDR[9] = done_from_MASTER;
	assign LEDR[8] = ready_from_HPS; 
	

	 
	 
endmodule
