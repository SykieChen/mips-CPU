module dm(clk,addr,din,wren,dout);
input [11:2] addr;
input [31:0] din;
input wren;
input clk;
output [31:0] dout;
reg [31:0] dm[1023:0];
assign dout=dm[addr];
always@(posedge clk)
	if(wren==1)
		dm[addr]<=din;
endmodule
