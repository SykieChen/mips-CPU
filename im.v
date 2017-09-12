module im(addr,ins);
input [11:2] addr;
output [31:0] ins;
reg [31:0] imem[1024:0];
reg [31:0] iexp[1024:96];

assign ins=(addr<96)?imem[addr]:iexp[addr];
// 'h60
initial
begin
	$readmemh("code.txt",imem);
	$readmemh("exception.txt",iexp);
end

endmodule
