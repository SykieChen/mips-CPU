module ext(imm16,ExtOp,Extout);
input [15:0] imm16;
input [1:0] ExtOp;
output [31:0] Extout;
reg [31:0] Extout;

always@(imm16,ExtOp)
begin
	case (ExtOp)
		2'b00:Extout={16'b0,imm16[15:0]};
		2'b01:Extout={{16{imm16[15]}},imm16[15:0]}; 
		2'b10:Extout=imm16<<16;
		default:Extout={16'b0,imm16[15:0]};    
	endcase
end
endmodule
