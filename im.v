module im(addr,ins);
input [11:2] addr;
output [31:0] ins;
reg [31:0] imem[1023:0];

assign ins=imem[addr];
initial
begin
	$readmemh("code.txt",imem);
end

endmodule
