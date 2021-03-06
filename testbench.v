module testbench();
reg rst,clk;
wire [6:0] led;
wire [7:0] ds;
reg [31:0] switch;
mini_machine MACH(clk,rst, led, ds, switch);
	initial
	begin
		#0 
		clk=0;
		rst=0;
		switch=0;
		#30
		rst=1;
		#50
		rst=0;
		#4000
		switch=1;
		#8000
		switch=2;
	end
	always #20 clk=~clk;
endmodule