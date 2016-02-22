	component mysystem is
		port (
			average_to_hps_export        : in    std_logic_vector(15 downto 0) := (others => 'X'); -- export
			control_done                 : out   std_logic;                                        -- done
			control_length               : in    std_logic_vector(6 downto 0)  := (others => 'X'); -- length
			control_readaddress          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- readaddress
			control_ready                : in    std_logic                     := 'X';             -- ready
			control_state                : out   std_logic_vector(2 downto 0);                     -- state
			control_writeaddress         : in    std_logic_vector(31 downto 0) := (others => 'X'); -- writeaddress
			control_average              : out   std_logic_vector(15 downto 0);                    -- average
			done_bit_export              : in    std_logic                     := 'X';             -- export
			length_from_hps_export       : out   std_logic_vector(6 downto 0);                     -- export
			memory_mem_a                 : out   std_logic_vector(12 downto 0);                    -- mem_a
			memory_mem_ba                : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n              : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke               : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n              : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n             : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n             : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n              : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n           : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- mem_dq
			memory_mem_dqs               : inout std_logic                     := 'X';             -- mem_dqs
			memory_mem_dqs_n             : inout std_logic                     := 'X';             -- mem_dqs_n
			memory_mem_odt               : out   std_logic;                                        -- mem_odt
			memory_mem_dm                : out   std_logic;                                        -- mem_dm
			memory_oct_rzqin             : in    std_logic                     := 'X';             -- oct_rzqin
			ready_bit_export             : out   std_logic;                                        -- export
			sdram_clk_clk                : out   std_logic;                                        -- clk
			sdram_wire_addr              : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n             : out   std_logic;                                        -- cas_n
			sdram_wire_cke               : out   std_logic;                                        -- cke
			sdram_wire_cs_n              : out   std_logic;                                        -- cs_n
			sdram_wire_dq                : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm               : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n             : out   std_logic;                                        -- ras_n
			sdram_wire_we_n              : out   std_logic;                                        -- we_n
			system_ref_clk_clk           : in    std_logic                     := 'X';             -- clk
			system_ref_reset_reset       : in    std_logic                     := 'X';             -- reset
			readaddress_from_hps_export  : out   std_logic_vector(31 downto 0);                    -- export
			writeaddress_from_hps_export : out   std_logic_vector(31 downto 0)                     -- export
		);
	end component mysystem;

	u0 : component mysystem
		port map (
			average_to_hps_export        => CONNECTED_TO_average_to_hps_export,        --        average_to_hps.export
			control_done                 => CONNECTED_TO_control_done,                 --               control.done
			control_length               => CONNECTED_TO_control_length,               --                      .length
			control_readaddress          => CONNECTED_TO_control_readaddress,          --                      .readaddress
			control_ready                => CONNECTED_TO_control_ready,                --                      .ready
			control_state                => CONNECTED_TO_control_state,                --                      .state
			control_writeaddress         => CONNECTED_TO_control_writeaddress,         --                      .writeaddress
			control_average              => CONNECTED_TO_control_average,              --                      .average
			done_bit_export              => CONNECTED_TO_done_bit_export,              --              done_bit.export
			length_from_hps_export       => CONNECTED_TO_length_from_hps_export,       --       length_from_hps.export
			memory_mem_a                 => CONNECTED_TO_memory_mem_a,                 --                memory.mem_a
			memory_mem_ba                => CONNECTED_TO_memory_mem_ba,                --                      .mem_ba
			memory_mem_ck                => CONNECTED_TO_memory_mem_ck,                --                      .mem_ck
			memory_mem_ck_n              => CONNECTED_TO_memory_mem_ck_n,              --                      .mem_ck_n
			memory_mem_cke               => CONNECTED_TO_memory_mem_cke,               --                      .mem_cke
			memory_mem_cs_n              => CONNECTED_TO_memory_mem_cs_n,              --                      .mem_cs_n
			memory_mem_ras_n             => CONNECTED_TO_memory_mem_ras_n,             --                      .mem_ras_n
			memory_mem_cas_n             => CONNECTED_TO_memory_mem_cas_n,             --                      .mem_cas_n
			memory_mem_we_n              => CONNECTED_TO_memory_mem_we_n,              --                      .mem_we_n
			memory_mem_reset_n           => CONNECTED_TO_memory_mem_reset_n,           --                      .mem_reset_n
			memory_mem_dq                => CONNECTED_TO_memory_mem_dq,                --                      .mem_dq
			memory_mem_dqs               => CONNECTED_TO_memory_mem_dqs,               --                      .mem_dqs
			memory_mem_dqs_n             => CONNECTED_TO_memory_mem_dqs_n,             --                      .mem_dqs_n
			memory_mem_odt               => CONNECTED_TO_memory_mem_odt,               --                      .mem_odt
			memory_mem_dm                => CONNECTED_TO_memory_mem_dm,                --                      .mem_dm
			memory_oct_rzqin             => CONNECTED_TO_memory_oct_rzqin,             --                      .oct_rzqin
			ready_bit_export             => CONNECTED_TO_ready_bit_export,             --             ready_bit.export
			sdram_clk_clk                => CONNECTED_TO_sdram_clk_clk,                --             sdram_clk.clk
			sdram_wire_addr              => CONNECTED_TO_sdram_wire_addr,              --            sdram_wire.addr
			sdram_wire_ba                => CONNECTED_TO_sdram_wire_ba,                --                      .ba
			sdram_wire_cas_n             => CONNECTED_TO_sdram_wire_cas_n,             --                      .cas_n
			sdram_wire_cke               => CONNECTED_TO_sdram_wire_cke,               --                      .cke
			sdram_wire_cs_n              => CONNECTED_TO_sdram_wire_cs_n,              --                      .cs_n
			sdram_wire_dq                => CONNECTED_TO_sdram_wire_dq,                --                      .dq
			sdram_wire_dqm               => CONNECTED_TO_sdram_wire_dqm,               --                      .dqm
			sdram_wire_ras_n             => CONNECTED_TO_sdram_wire_ras_n,             --                      .ras_n
			sdram_wire_we_n              => CONNECTED_TO_sdram_wire_we_n,              --                      .we_n
			system_ref_clk_clk           => CONNECTED_TO_system_ref_clk_clk,           --        system_ref_clk.clk
			system_ref_reset_reset       => CONNECTED_TO_system_ref_reset_reset,       --      system_ref_reset.reset
			readaddress_from_hps_export  => CONNECTED_TO_readaddress_from_hps_export,  --  readaddress_from_hps.export
			writeaddress_from_hps_export => CONNECTED_TO_writeaddress_from_hps_export  -- writeaddress_from_hps.export
		);

