module im(addr,ins);
input [11:2] addr;
output [31:0] ins;
reg [31:0] imem[2047:0];
reg [31:0] iexp[5120:4192];

assign ins=(addr<2048)?imem[addr]:iexp[addr];
initial
begin
	$readmemh("code.txt",imem);
	$readmemh("exception.txt",iexp);
end

endmodule
