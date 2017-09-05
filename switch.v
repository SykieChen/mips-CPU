module switch(clk, sin, sout, irq);
input [31:0] sin;
input clk;
output reg [31:0] sout;
output reg irq;
always @(posedge clk) begin
	if (sout == sin) irq = 0;
	else begin
		irq = 1;
		sout <= sin;
	end
end
endmodule;