module ledcmp(clk, rst, input32, led, ds, en);
input clk, rst, en;
input [31:0] input32;
output [6:0] led;
output [7:0] ds;
wire [2:0] sel;
wire [3:0] output4;
reg [31:0] data;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// reset
			data <= 0;
		end
		else if (en) begin
			data <= input32;
		end
	end
	scanner U_SCN(rst, clk, ds, sel);
	ledmux U_MUX(data, sel, output4);
	led U_LED(output4, led);
endmodule