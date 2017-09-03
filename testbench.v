module testbench();
reg reset,clk;
mips U_MIPS(clk,reset);
	initial
	begin
		#0 
		clk=0;
		reset=0;
		#30
		reset=1;
		#50
		reset=0;
	end
	always #20 clk=~clk;
endmodule