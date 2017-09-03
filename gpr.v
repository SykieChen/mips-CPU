module gpr(clk,reset,rs,rt,rw,busw,regwr,busa,busb);
input clk,reset,regwr;
input [4:0] rs,rt,rw;
input [31:0] busw;
output reg [31:0] busa,busb;
reg [31:0] register[31:0];
integer i;

always @(posedge clk or posedge reset)
begin
	if(reset)
		for(i=0;i<32;i=i+1)
			register[i]<=32'b0; 
	else begin
		busa<=register[rs];
		busb<=register[rt];
		if(regwr && (rw!=5'b0))
			register[rw]<=busw;
	end
end
endmodule   
