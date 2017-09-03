module alu(clk, rst, busa,busb,op,aluout,zero,overflow);
input [31:0] busa,busb;
input [1:0] op;
input clk, rst;
output reg [31:0] aluout;
output zero,overflow;
reg [32:0] total;
reg zero,overflow;

// always @(rst or aluout) begin
// 	if (rst) begin
// 		// reset
// 		slowaluout<=0;
// 	end
// 	else
// 		slowaluout<=aluout;
// end

always @ (op)
begin
	case (op)
		2'b00: //addu,addi,addiu,lw,sw,lui
		begin
			assign total={busa[31],busa}+{busb[31],busb};
			assign aluout = total[31:0];
		end
		2'b01: assign aluout = busa - busb; //subu,beq
		2'b10: assign aluout = busa | busb; //ori
		2'b11: //slt
		begin
			if((busa[31]&&~busb[31])|(busa<busb))
				assign aluout={31'b0,1'b1};
			else
				assign aluout=32'b0;
		end
		default: aluout = 32'b0; 
	endcase
	assign zero = (aluout==0)?1:0;
	assign overflow = (total[32]!=aluout[31])?1:0;
end
endmodule
