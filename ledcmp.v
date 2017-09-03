module ledcmp(clk, rst, input32, led, ds);
input clk, rst;
input [31:0] input32;
output [6:0] led;
output [7:0] ds;
wire [2:0] sel;
wire [3:0] output4;
	scanner U_SCN(rst, clk, ds, sel);
	ledmux U_MUX(input32, sel, output4);
	led U_LED(output4, led);
endmodule