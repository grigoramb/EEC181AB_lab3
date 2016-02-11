module reg32(
input clock, 
input reset_n,
input [31:0] D,
input [3:0] byteenable,
output reg [31:0] Q
);
always @ (posedge clock or negedge reset_n) begin
	if(!reset_n)
		Q <= 32'h0;
	else begin
		case(byteenable)
			4'b1111: Q <= D;
			4'b0011: Q[15:0] <= D[15:0];
			4'b1100: Q[31:16] <= D[31:16];
			4'b0001: Q[7:0] <= D[7:0];
			4'b0010: Q[15:8] <= D[15:8];
			4'b0100: Q[23:16] <= D[23:16];
			4'b1000: Q[31:24] <= D[31:24];
			default: Q <= D;
		endcase
	end
end
endmodule
