module pc(clk,reset,npcout,pcout, PCWr);
input clk,reset,PCWr;
input [31:2] npcout;
output [31:2] pcout;
reg [31:2] pcreg=0;
assign pcout=pcreg;
always@(posedge PCWr or posedge reset)
begin
	if(reset)
		pcreg<=30'h00000c00;
	else
	    pcreg<=npcout;
end
endmodule

