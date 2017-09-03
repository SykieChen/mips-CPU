module bridge(rst, HWInt, PrAddr, DIn, DOut, clk, BE, Wen, switch, swirq, ledinput32, led, ledds, tmrADD, tmrWE, tmrDATIn, tmrDATOut, tmrIRQ);
input [31:2] PrAddr;
input [3:0] BE;
input [31:0] DIn;
input Wen, rst, clk,swirq,tmrIRQ;
input [31:0] switch, ledinput32, tmrDATOut;
output [7:0] ledds;
output [6:0] led;
output reg [1:0] tmrADD;
output tmrWE;
output [31:0] tmrDATIn;
output [31:0] DOut;
output reg [7:2] HWInt;

//reg [31:0] buffer[4:0];

//'h1fc0 is the high 30 of 0x0000_7F00
assign tmrADD = PrAddr - 'h1fc0;
assign HWInt[2] = tmrIRQ;
always @(posedge clk or posedge rst) begin
	if (rst) begin
		// reset
		
	end
	else begin
		case(PrAddr - 'h1fc0)
		0: assign 
		
	end
end
endmodule