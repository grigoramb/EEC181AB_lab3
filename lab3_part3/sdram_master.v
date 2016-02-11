`define SDRAM_BASE 32'h0
`define SECOND 32'd50000000 // 50 million clock cycles = 1 second
`define IDLE 0      // wait for ready signal
`define READ 1      // read in numbers and insert
`define SHIFT1 2    // shift max to position a
`define SHIFT2 3    // shift min to far right
`define WRITE 4     // start writing and shifting data out
`define DONE 5      // done, wait for ready to go to 0

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
output done,
input [5:0] length, // length of the array to sort from 0-32 
// debugging
output reg [15:0] max = 16'h0000,
output reg [15:0] min = 16'hFFFF,
output reg [2:0] state = 2'b00
);

assign done = (state == `DONE);

wire [15:0] a; // the number to the right of the insert position
wire [15:0] b; // the number to the left of the insert position
wire [15:0] head; // the front of the queue

//  from S0 -> S63 -> .... S32(b) -> insert logic -> S31(a) -> ...-> S1 -> S0 ->
//  ^------left shift register----^ ^------mux-----^ ^--right shift register---^
//  
//  final state before writing:
//  0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0 ---------------max-x-x-x-x-x-x-x-x-x-x-min
//

// shift registers
reg [15:0] leftSR[31:0];
reg [15:0] rightSR[31:0];

assign a = rightSR[31];
assign b = leftSR[0];
assign head = rightSR[0]; // the front of the queue

reg [15:0] num; // the current number being processed 
reg numvalid; // is the number valid?

reg [5:0] numread = 0; // number of actually read
reg [5:0] read_index = 0;
reg [5:0] counter = 0;

wire insert; // should the number be inserted between the two shift registers?

assign insert = (num >= a) && ( (b==0 & a==max) | (b >= num) ) & numvalid; // the number has to be valid
// the number is greater than a
//      the number is the new max
//          insert as new max
//      the number is b >= num >= a
//          insert between a and b
//


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
		`READ: state <= ((address == length) & (numread==length)) ? `SHIFT1 : `READ;
		`SHIFT1: state <= (a == max) ? `SHIFT2: `SHIFT1; // get the max to position a
		// 0-0--0-0-0-0-0-0-0-0-0-0-0-0-0-max-x-x-x-x-x-x-x-x-x-min-0-0-0-0-0-0-0-0-0-0
		`SHIFT2: state <= (counter == 0) ? `WRITE : `SHIFT2; // get the min far right
		// 0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-max-x-x-x-x-x-x-x-x-x-x-min
		`WRITE: state <= (address == length*2) ? `DONE : `WRITE;
		`DONE: state <= ~ready ? `IDLE : `DONE;
		default: state <= `IDLE;
		endcase
	end
end

always @(posedge clk) begin
    if(~reset_n | state == `IDLE) begin
        counter <= 0;
    end
    else if(state == `SHIFT1) begin
        counter <= 32-length-2; // how much to shift by to get the data where we want it
    end
    else if(state == `SHIFT2) begin
        counter <= (counter > 0) ?  counter - 1 : counter;
    end
    else begin
        counter <= counter;
    end
end

integer i;

/*
// LEFT SHIFT REGISTER
always @(posedge clk) begin
    if(~reset_n | state == `IDLE) begin
        for(i = 0; i < 32; i = i + 1) begin 
            leftSR[i] <= 16'h0000;
        end // reset shift register to all 0's
    end
    else begin
        case(state)
            `READ:
            begin
                if(~insert) begin
                    for(i = 0; i < 31; i = i + 1) begin
                        leftSR[i] = leftSR[i+1]; // shift right
                    end
                    leftSR[31] <= rightSR[0]; // loop around from other SR
                end
                else begin // a number is being inserted
                    for(i = 0; i < 32; i = i + 1) begin
                        leftSR[i] <= leftSR[i];
                    end
                end
            end
            default:
            begin
                for( i = 0; i < 32; i = i + 1) begin
                    leftSR[i] <= leftSR[i];
                end
            end
        endcase
    end
end
*/




// RIGHT SHIFT REGISTER
always @(posedge clk) begin
    if(~reset_n | state == `IDLE) begin
        for(i = 0; i < 32; i = i + 1) begin 
            rightSR[i] <= 16'h0000;
            leftSR[i] <= 16'h0000;
        end // reset shift register to all 0's
    end
    else begin
        case(state)
        `READ: // inserting values
        begin
            if(insert) begin // if a number is inserted, shift it in
                for(i = 0; i < 31; i = i + 1) begin
                    rightSR[i] <= rightSR[i+1];
                end
                rightSR[31] <= num;
                for(i = 0; i < 32; i = i + 1) begin
                    leftSR[i] <= leftSR[i];
                end
            end
            else begin // otherwise, shift in the output of leftSR
                for(i = 0; i < 31; i = i + 1) begin
                    rightSR[i] <= rightSR[i+1];
                end
                rightSR[31] <= leftSR[0];
                for(i = 0; i < 31; i = i + 1) begin
                    leftSR[i] = leftSR[i+1];
                end
                leftSR[31] <= rightSR[0];
            end
        end    
        `SHIFT1,`SHIFT2: // just keep shifting
        begin
            for(i = 0; i < 31; i = i + 1) begin
                rightSR[i] <= rightSR[i+1];
            end // shift in output from left SR
            rightSR[31] <= leftSR[0];
            for(i = 0; i < 31; i = i + 1) begin
                leftSR[i] <= leftSR[i+1];
            end // shift in output from right SR
            leftSR[31] <= rightSR[0];
        end
        `WRITE:
        begin
            if(~waitrequest) begin // the value has been written, shift
                for(i = 0; i < 31; i = i + 1) begin
                    rightSR[i] <= rightSR[i+1];
                end
                rightSR[31] <= leftSR[0];
            end
            else begin //value not written, don't shift
                for(i = 0; i < 32; i = i + 1) begin
                    rightSR[i] <= rightSR[i];
                end
            end
        end
        default:
            for(i = 0; i < 32; i = i + 1) begin
                rightSR[i] <= rightSR[i];
            end
        endcase
    end
end


/*
always @(posedge clk) begin
    if(~reset_n | state==`IDLE) begin
        min <= 16'hFFFF;
        max <= 16'h0000;
        numread <= 0;       
    end
    else begin
        if(state == `READ) begin
            if(numread < length) begin
                min <= (readdatavalid & (readdata < min)) ? readdata : min; // if new number valid and smaller
                max <= (readdatavalid & (readdata > max)) ? readdata : max; // if new number valid and larger
                numread <= readdatavalid ? numread+1 : numread;             // increment as each number is read
            end
            else begin
                min <= min;
                max <= max;
                numread <= numread;
            end
        end
        else begin
            min <= min;
            max <= max;
            numread <= 0;
        end
    end
end
*/




// keeping track of the max
// if the number is inserted and is the new max, update max
always @(posedge clk) begin
    if(~reset_n | state==`IDLE) begin
        max <= 16'h0000;
    end
    else if( (state == `READ) & insert & (b == 0)) begin
        max <= num; // the number is being inserted before a 0 so it is the max
    end
    else begin
        max <= max;
    end
end



// keep track if the num is currently valid or not
always @(posedge clk) begin
    if(~reset_n | state == `IDLE) begin
        numvalid <= 0;
        num <= 0;
        numread <= 0;
    end
    else begin
        if(insert) begin
            numvalid <= 0;
            num <= 0;
            numread <= numread + 1;
        end
        else if(~numvalid && readdatavalid && numread < length) begin
            numvalid <= 1; // new number came in so the number is now valid
            num <= readdata; // read in the number
            numread <= numread;
        end
        else begin
            numvalid <= numvalid;
            num <= num;
            numread <= numread;
        end
    end
end




always @(posedge clk) begin
	if(~reset_n | state == `IDLE) begin
		write_n <= 1;
		read_n <= 1;
		address <= 0;
		writedata <= 16'hF00D;
	end
	else begin
		case (state)
		`IDLE:
			begin
				write_n <= 1;
				read_n <= 1;
				address <= 0;
				writedata <= 16'hABCD;
			end	
		`READ:
		    begin
		        // read another number when the current number is invalid.
		        // stop the read request when waitrequest goes to 0
				read_n <= (address < length) && waitrequest && ~numvalid ? 0 : 1;
                // address <= ~waitrequest & (address<length) ? address + 1 : address;
                address <= insert ? address + 1 : address;
				write_n <= 1;
				writedata <= 16'hEEEE; // to make sure it doesn't write
			end
		`SHIFT1,`SHIFT2:
        begin
            // shifting register, no reading or writnig in this stage
            read_n <= 1;
            write_n <= 1;
            address <= length;
            writedata <= head;
        end
		`WRITE: 
			begin
			    write_n <= 0;
			    writedata <= head; // write the number at the front of the queue
			    // it gets shifted when wait request goes to 0
                address <= ~waitrequest & (address<length*2) ? address + 1 : address;
                read_n <= 1;
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
