module timer(CLK_I, RST_I, ADD_I, WE_I, DAT_I, DAT_O, IRQ, tc0, tc1, tc2);
input CLK_I, RST_I, WE_I;
input [31:0] DAT_I;
input [3:2] ADD_I;
output IRQ;
output [31:0] DAT_O;
output [31:0] tc0, tc1, tc2;

reg [31:0] tc[2:0];	//tc[0]ctrl	tc[1]preset	tc[2]count
reg IRQ_buff=0;
assign tc0 = tc[0];
assign tc1=tc[1];
assign tc2=tc[2];

assign DAT_O = tc[ADD_I];
assign IRQ = IRQ_buff & tc[0][3];	//if IRQ disabled, keep IRQ negtive

always @(posedge CLK_I or posedge RST_I) begin
	if (RST_I) begin
		// reset
		tc[0]=0;
		tc[1]=0;
		tc[2]=0;
	end
	if (WE_I && ADD_I!=2) begin
			tc[ADD_I]=DAT_I;
			tc[2]=tc[1];
			IRQ_buff<=0;
	end
	else if (tc[0][0]) begin // if enabled
		if (tc[2]>0) tc[2]<=tc[2]-20;
		else begin //counter is 0
			if (tc[0][2:1]==0) begin
				IRQ_buff<=1; //mode=0 and IRQ allowed
				tc[0][0]=0;
			end
			else IRQ_buff<=0;
			if (tc[0][2:1]==1) tc[2]<=tc[1]; //mode=1
		end
	end
	else IRQ_buff<=0;
end
endmodule