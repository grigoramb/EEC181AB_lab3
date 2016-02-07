// `define SDRAM_BASE 32'hC4000000
`define SDRAM_BASE 32'h0
`define SECOND 32'd50000000 // 50 million clock cycles = 1 second
`define ADDR 2
`define DONE 1
`define IDLE 0

module sdram_master (
input clk,
input reset_n,
input waitrequest,
input readdatavalid,
input [15:0] readdata,
output reg read_n = 1'b1,
output reg write_n = 1'b1,
output reg chipselect = 1'b1,
output reg [31:0] address = `SDRAM_BASE,
output reg [1:0] byteenable = 2'b11,
output reg [15:0] writedata = 16'hBEEF,

// conduits for debuggings
input ready,
output [31:0] maxmin,
output reg done = 0
);

assign maxmin = {max,min};

reg [15:0] max = 16'h0;		// current max val
reg [15:0] min = 16'hFFFF;		// curent min val

reg [3:0] reading = 4'b0; 	// current number reading (index in array)
reg [31:0] counter = 32'b0;
reg [1:0] state = 0;

always @(*) begin
	byteenable <= 2'b11;
	chipselect <= 1;
end

always @(posedge clk)
begin
	case (state)
	`IDLE: state <= (counter > `SECOND) ? `ADDR : `IDLE;
	`ADDR: state <= (waitrequest) ? `ADDR : `DONE;
	`DONE: state <= `DONE;
	default: state <= state;
	endcase
end

always @(posedge clk) begin
	case (state)
	`IDLE:
	begin
		counter <= counter + 1;
		 write_n <= 1;
		 address <= 0;
		 writedata = 16'hABCD;



	end	
	`ADDR: 
	begin
		write_n <= 0;
		address <= 0;		
	 	writedata = 16'hBCDE;

	end
	`DONE:
	begin	
		write_n <= 1;
		address <= 0;
		writedata = 16'hBEEF;


	end
	endcase
//	if(timer < 32'd50000000) begin
//		write_n <= 1;
//		timer <= timer + 1;
//	end
//	else if(timer < 32'd70000000) begin
//		write_n <= 0;
//		timer <= timer + 1;
//	end
//	else begin
//		write_n <= 0;
//		timer <= 0;
//	end
//
//	write_n <= (!waitrequest) ? 0 : 1;
//	address <= 0;
//	writedata <= 16'hBEEF;
end



endmodule
