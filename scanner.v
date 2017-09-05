module scanner(rst, clock, ds, sel);
input rst;
input clock;
output reg [7:0] ds;
output reg [2:0] sel;
always @(posedge clock or posedge rst) begin
	if (rst) begin
		// reset
		sel = 0;
		ds = 1;
	end
	else begin
		if (sel == 8) sel <=0;
		else sel <= sel + 1;
		case(sel)
			0:ds = 8'b00000001;
			1:ds = 8'b00000010;
			2:ds = 8'b00000100;
			3:ds = 8'b00001000;
			4:ds = 8'b00010000;
			5:ds = 8'b00100000;
			6:ds = 8'b01000000;
			7:ds = 8'b10000000;
		endcase
	end
end

endmodule
