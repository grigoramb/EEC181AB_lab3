// `define SDRAM_BASE 32'hC4000000
`define SDRAM_BASE 32'h0
`define SECOND 32'd50000000 // 50 million clock cycles = 1 second

module sdram_master (
input clk,
output reg read_n = 1'b1,
output reg write_n = 1'b1,
output reg chipselect = 1'b1,
input waitrequest,
output reg [31:0] address = `SDRAM_BASE,
output reg [1:0] byteenable = 2'b11,
input readdatavalid,
input [15:0] readdata,
output reg [15:0] writedata = 16'b0,
input reset_n,
// conduits for debuggings
output [31:0] maxmin,
input ready,
output reg done = 0
);

assign maxmin = {max,min};

reg [15:0] max = 16'h0;		// current max val
reg [15:0] min = 16'hFFFF;		// curent min val

reg [3:0] adr_index = 4'b0; 	// current number adr_index (index in array)


always @(posedge clk) begin
	if(~reset_n ||	(adr_index == 4'd15)) begin
		write_n <= 1'b1;				// disable write
		read_n <= 1'b1;				// disable read
		writedata <= 16'd0;		// data is 0
		address <= `SDRAM_BASE; 	// address of ready bit
		adr_index <= 4'b0;			// not adr_index data yet
		max <= 16'h0;				// current max value set to a minimum
		min <= 16'hFFFF;			// current min value set to a maximum
		done<= 0;	// hold done until ack from CPU (setting ready to 0)
	end
	else begin
		if(adr_index == 4'd12) begin // write min
			write_n <= 1'b0;		// enable write
			read_n <= 1'b1;		// disable read
			writedata <= min;
			address <= `SDRAM_BASE + 32'd2;  // Addr of min 
			adr_index <= !waitrequest ? 4'd13 : 4'd12; // wait for write to complete then go to next state
			max <= max;
			min <= min;
			done <= 0;
		end
		else if(adr_index == 4'd13) begin // write max
			write_n <= 1'b0;		// enable write
			read_n <= 1'b1;		// disable read
			writedata <= max;		
			address <= `SDRAM_BASE + 32'd4;  // Addr of max
			adr_index <= !waitrequest ? 4'd14 : 4'd13; // reset when done and cpu acks
			max <= max;
			min <= min;
			done <= 1;
		end
		else if(adr_index == 4'd14) begin // wait for cpu to acknowledge
			write_n <= 1'b1;
			read_n <= 1'b1;
			writedata <= 0;
			address <= 0;
			adr_index <= ready ? 14'd14 : 14'd15;  // go to reset state when ready is deasserted
			max <= max;
			min <= min;
			done <= 1;
		end
		else begin				// adr_index and polling states
			write_n <= 1'b1;		// don't need to write yet
			writedata <= 16'd0;
			done <= 0;	// hold done until CPU acks by setting ready to 0
			if(adr_index) begin  // adr_index the array
				read_n <= 1'b0; 				// enable read
				address <= `SDRAM_BASE + adr_index;
				adr_index <= (!waitrequest) ? adr_index + 4'd1: adr_index;
			//	// if read data is valid and larger, update max
			//	max <= ( (max >= readdata) & readdatavalid ) ? max : readdata;
			//	// if read data is valid and smaller, update min
			//	min <= ( (min <= readdata) & readdatavalid ) ? min : readdata;
				if(readdatavalid) begin
					max <= (max >= readdata) ? max : readdata;
					min <= (min <= readdata) ? min : readdata;
				end
				else begin
					max <= max;
					min <= min;
				end
			end
			else begin // polling the ready bit
				read_n <= ready && !done ? 0 : 1;     		// only enable read for new data set
				address <= `SDRAM_BASE;	// prepare to read from array
				adr_index <= ready && !done ? 4'b1 : 4'b0;	// if done == 1, then the CPU hasn't acked the last set
				max <= 16'h0000;
				min <= 16'hFFFF;
			end
		end
	end
end

/*
always @(posedge clk) begin
	if(~reset_n ||	(adr_index == 4'd15)) begin
		read_index <= 0;
		max <= 16'h0000;
		min <= 16'hFFFF;	
	end
	else
		if(readdatavalid) begin
			read_index <= read_index + 1;
			max <= (max >= readdata) ? max : readdata;
			min <= (min <= readdata) ? min : readdata;
		end
		else begin
			read_index <= read_index;
			max <= max;
			min <= min;
		end
	begin	
end */ 

endmodule
