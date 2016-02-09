`define SDRAM_BASE 32'h0
`define SECOND 32'd50000000 // 50 million clock cycles = 1 second
`define IDLE 0
`define READ 1
`define WRITE 2
`define DONE 3

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

// control signals
input ready,
output reg done = 0,

// debugging
output reg [15:0] max = 16'h0000,
output reg [15:0] min = 16'hFFFF,
output reg [1:0] state = 2'b00
);

reg [3:0] numread = 0; // number of actually read
reg [3:0] read_index = 0;
reg [31:0] counter = 0;

always @(*) begin
	byteenable <= 2'b11;
	chipselect <= 1;
end

// STATE LOGIC
always @(posedge clk)
begin
	if(~reset_n) begin
		state <= `IDLE;
	end
	else begin
		case (state)
		`IDLE: state <= ready ? `READ : `IDLE; 
//		`READ: state <= ((read_index==10) & (numread==10)) ? `DONE : `READ;
		`READ: state <= ((address==10) & (numread==10)) ? `DONE : `READ;
//		`WRITE: state <= (write_index==2) ? `WRITE : `DONE;
		`DONE: state <= `DONE;
		default: state <= `IDLE;
		endcase
	end
end

always @(posedge clk) begin
    if(~reset_n) begin
        min <= 16'hFFFF;
        max <= 16'h0000;
        numread <= 0;       
    end
    else begin
        if(state == `READ) begin
            min <= (readdatavalid & (readdata < min)) ? readdata : min; // if new number valid and smaller
            max <= (readdatavalid & (readdata > max)) ? readdata : max; // if new number valid and larger
            numread <= readdatavalid & (numread < 10) ? numread+1 : numread;             // increment as each number is read
        end
        else begin
            min <= min;
            max <= max;
            numread <= 0;
        end
    end
end

always @(posedge clk) begin
    if(~reset_n) begin
        read_index <= 0;
    end
    else begin
        read_index <= ((state==`READ) & ~waitrequest & (read_index<10))? read_index + 1 : read_index;
    end
end

always @(posedge clk) begin
	if(~reset_n) begin
		write_n <= 1;
		address <= 0;
		writedata <= 16'hF00D;
	end
	else begin
		case (state)
		`IDLE:
			begin
				write_n <= 1;
				address <= 0;
				writedata = 16'hABCD;
			end	
		`WRITE: 
			begin
				write_n <= 0;
				address <= 0;		
				writedata = 16'hBCDE;
			end
		`READ:
			begin
				read_n <= (address < 9) ? 0 : 1;
				// address <= read_index;
                address <= ~waitrequest & (address<10) ? address + 1 : address;
				write_n <= 1;
				writedata <= 16'hEEEE; // to make sure it doesn't write
			end
		`DONE:
			begin	
				read_n <= 1;
				write_n <= 1;
				address <= 0;
				writedata = 16'hBEEF;
			end
		endcase
	end
end

/*
always @(posedge readdatavalid) begin
    
end
*/
endmodule
